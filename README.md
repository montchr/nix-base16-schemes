# nix-base16-schemes

All Base16 color schemes from <https://github.com/tinted-theming/base16-schemes>
converted from the original YAML to JSON to Nix.

Because it's really not worth my time to do anything more complex just for some
hex color strings. These color values never change, and the upstream repo is not
updated frequently unless new schemes are added. So why waste the energy doing
such conversions on the fly every time you change your Nix configs?

## Licensing

TL;DR Everything in `src/` retains the original MIT license.

Most other code here is licensed under the GNU General Public License version 3 or later,
unless otherwise stated in its header or in `.reuse/dep5`.

Copyright (c) 2023 Chris Montgomery and the nix-base16-schemes contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.

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
