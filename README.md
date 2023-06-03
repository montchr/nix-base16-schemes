# nix-base16-schemes

## Contributing

### Prerequisites

You need [nix](https://nixos.org/download.html) and [direnv](https://direnv.net/).

### Enter Contribution Environment

```console
direnv allow
```

### Change Contribution Environment

```console
$EDITOR ./nix/repo/config.nix
direnv reload
```

### Preview Documentation

You need to be inside the Contribution Environment.

```console
mdbook build -o
```
