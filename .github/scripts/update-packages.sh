#!/usr/bin/env bash
# Updates flake packages with nix-update, creating one commit per updated package.
#
# Usage: ./update-packages.sh [package...]
#
# Updates all packages when none are given.

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

# failed updates are rolled back with `git checkout -- pkgs`, so don't run on top
# of local changes.
if ! git diff --quiet HEAD -- pkgs; then
  echo "pkgs/ has uncommitted changes, refusing to run" >&2
  exit 1
fi

if (($# > 0)); then
  packages=("$@")
else
  system=$(nix eval --raw --impure --expr builtins.currentSystem)
  read -ra packages <<<"$(nix eval --raw ".#packages.$system" --apply 'ps: toString (builtins.attrNames ps)')"
fi

msg=$(mktemp)
trap 'rm -f "$msg"' EXIT
failed=()

for pkg in "${packages[@]}"; do
  args=()
  prefix=$pkg

  case $pkg in
  # all polkadot-sdk packages share pkgs/polkadot-sdk/generic.nix, so they're
  # updated once through polkadot.
  chain-spec-builder | frame-omni-bencher | polkadot-omni-node | polkadot-parachain | subkey)
    echo "skipping $pkg (updated through polkadot)"
    continue
    ;;
  polkadot)
    prefix=polkadot-sdk
    # nix-update's tag prefix detection breaks when already up to date, and the
    # atom feed only lists the last 10 releases (mostly older branches).
    args+=(--version-regex 'polkadot-stable(.*)' --use-github-releases)
    ;;
  esac

  # packages tracking a branch rather than tagged releases
  if [[ $(nix eval --raw ".#$pkg.version") == *unstable* ]]; then
    args+=(--version=branch)
  fi

  echo "updating $pkg"
  if ! nix-update --flake --write-commit-message "$msg" "${args[@]}" "$pkg"; then
    echo "::error::failed to update $pkg"
    failed+=("$pkg")
    git checkout -- pkgs
    continue
  fi

  if [[ -n $(git status --porcelain -- pkgs) ]]; then
    # nix-update's message starts with "<pkg>: <old> -> <new>"
    content=$(<"$msg")
    git add pkgs
    git commit --quiet --file - <<<"$prefix${content#"$pkg"}"
    git log -1 --format='committed: %s'
  fi
done

if ((${#failed[@]} > 0)); then
  echo "failed to update: ${failed[*]}" >&2
  exit 1
fi
