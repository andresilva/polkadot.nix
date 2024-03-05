<p align="center">
  <img width="320" src="img/nix-polkadot.png" alt="nix-polkadot logo">
</p>

**polkadot.nix** is a collection of Nix packages related to the [**Polkadot**](https://polkadot.network/) ecosystem.

## Packages

- [polkadot](https://github.com/paritytech/polkadot-sdk/tree/master/polkadot)
- [srtool-cli](https://github.com/chevdor/srtool-cli)
- [subalfred](https://github.com/hack-ink/subalfred)
- [subkey](https://github.com/paritytech/polkadot-sdk/tree/master/substrate/bin/utils/subkey)
- [subrpc](https://github.com/chevdor/subrpc)
- [subwasm](https://github.com/chevdor/subwasm)
- [subxt-cli](https://github.com/paritytech/subxt/tree/master/cli)
- [zepter](https://github.com/ggwpez/zepter)
- [zombienet](https://github.com/paritytech/zombienet)

## Development shell

A shell derivation is included that provides a development environment with all the requirements necessary to build
[polkadot-sdk](https://github.com/paritytech/polkadot-sdk).

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
