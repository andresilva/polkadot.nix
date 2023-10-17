<p align="center">
  <img width="320" src="img/nix-polkadot.png" alt="nix-polkadot logo">
</p>

**polkadot.nix** is a collection of Nix packages related to the [**Polkadot**](https://polkadot.network/) ecosystem.

## Packages

- polkadot
- srtool-cli
- subkey
- subwasm
- subxt-cli

## Development shell

A shell derivation is included that provides a development environment with all the requirements necessary to build
[substrate][substrate], [polkadot][polkadot] and [cumulus][cumulus].

[substrate]: https://github.com/paritytech/substrate
[polkadot]: https://github.com/paritytech/polkadot
[cumulus]: https://github.com/paritytech/cumulus

## Usage

You need to enable flakes support (https://nixos.wiki/wiki/Flakes#Enable_flakes).

### Run packages

```
nix run ".#polkadot"
```

### Development shell

```
nix develop
```
