<p align="center">
  <img width="320" src="img/nix-polkadot.png" alt="nix-polkadot logo">
</p>

**polkadot.nix** is a collection of Nix packages related to the [**Polkadot**](https://polkadot.network/) ecosystem.

## Packages

- [graypaper](https://github.com/gavofyork/graypaper)
- [polkadot-sdk](https://github.com/paritytech/polkadot-sdk)
  - [polkadot](https://github.com/paritytech/polkadot-sdk/tree/master/polkadot)
  - [polkadot-omni-node](https://github.com/paritytech/polkadot-sdk/tree/master/cumulus/polkadot-omni-node)
  - [polkadot-parachain](https://github.com/paritytech/polkadot-sdk/tree/master/cumulus/polkadot-parachain)
  - [chain-spec-builder](https://github.com/paritytech/polkadot-sdk/tree/master/substrate/bin/utils/chain-spec-builder)
  - [frame-omni-bencher](https://github.com/paritytech/polkadot-sdk/tree/master/substrate/utils/frame/omni-bencher)
  - [subkey](https://github.com/paritytech/polkadot-sdk/tree/master/substrate/bin/utils/subkey)
- [psvm](https://github.com/paritytech/psvm)
- [srtool-cli](https://github.com/chevdor/srtool-cli)
- [subalfred](https://github.com/hack-ink/subalfred)
- [subrpc](https://github.com/chevdor/subrpc)
- [subwasm](https://github.com/chevdor/subwasm)
- [subxt-cli](https://github.com/paritytech/subxt/tree/master/cli)
- [try-runtime-cli](https://github.com/paritytech/try-runtime-cli)
- [zepter](https://github.com/ggwpez/zepter)
- [zombienet](https://github.com/paritytech/zombienet)

## Usage

You need to [enable](https://nixos.wiki/wiki/Flakes#Enable_flakes) flakes support.

You can use polkadot.nix as a standalone flake or integrate it into your existing nix flake project.

### Running directly via `nix run`

```sh
nix run "github:andresilva/polkadot.nix#polkadot"
```

This will build and run the polkadot package from the flake. Check all available outputs with:

```sh
nix flake show "github:andresilva/polkadot.nix"
```

### Integrate into existing flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    polkadot.url = "github:andresilva/polkadot.nix";
    polkadot.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { nixpkgs, polkadot, ... }:
    let
      system = "x86_64-linux";
    in
    {
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = [ polkadot.packages.${system}.polkadot ];
      };
    };
}
```

## Overlay

You can use polkadot.nix as an overlay to seamlessly integrate all Polkadot packages into your existing nixpkgs environment.

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    polkadot.url = "github:andresilva/polkadot.nix";
    polkadot.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { nixpkgs, polkadot, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ polkadot.overlays.default ];
      };
    in
    {
      packages.${system}.default = pkgs.polkadot;
    };
}
```

## Cachix

Use Cachix to speed up builds by fetching pre-built binaries from a remote cache, reducing compilation times and improving overall efficiency.

```sh
cachix use polkadot
```

## Development shell

A shell derivation is included that provides a development environment with all the requirements necessary to build
[polkadot-sdk](https://github.com/paritytech/polkadot-sdk).

You can run it directly with:

```sh
nix develop "github:andresilva/polkadot.nix"
```

You can also integrate it into a flake and override it with more packages:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    polkadot.url = "github:andresilva/polkadot.nix";
    polkadot.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { nixpkgs, polkadot, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ polkadot.overlays.default ];
      };
    in
    {
      devShells.${system}.default = polkadot.devShells.${system}.default.overrideAttrs (attrs: {
        nativeBuildInputs = with pkgs; attrs.nativeBuildInputs ++ [ zombienet ];
      });
    };
}
```
