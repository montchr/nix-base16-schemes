# SPDX-FileCopyrightText: 2022-2023 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later

###: https://just.systems/man/en/

prj-root := env_var('PRJ_ROOT')
cache-dir := env_var('PRJ_CACHE_HOME')
upstream-src-path := env_var('BASE16_SCHEMES_PATH')

out-dir := prj-root / "src"
json-dir := cache-dir / "json"

repo-copyright := 'Chris Montgomery <chris@cdom.io>'
repo-license := 'GPL-3.0-or-later'
docs-license := 'CC-BY-SA-4.0'
upstream-license := 'MIT'

###: GENERAL =================================================================

default:
  @just --list --unsorted --color=always | rg -v "\s*default"

fmt:
  treefmt src/*.nix


###: WORKFLOW =================================================================

generate: prepare && license fmt
  fd --type file --extension yaml . {{ upstream-src-path }} --exec \
    just yaml-to-json
  fd --type file --extension json . {{ json-dir }} --exec \
    just json-to-nix

yaml-to-json file:
  yaml2json < {{ file }} > {{ cache-dir }}/json/{{ file_stem( file ) }}.json

json-to-nix file:
  nix eval --expr 'builtins.fromJSON (builtins.readFile {{file}})' --impure \
    > {{ out-dir / file_stem( file ) }}.nix

prepare:
  mkdir -p {{ json-dir }} {{ out-dir }}

clean: prepare
  rm -rf {{ json-dir }} {{ out-dir }}


###: LICENSING =================================================================

license-template := "--template compact"

# <- Update license annotations
license: (license-upstream "src") && fmt license-check

# <- Validate the project's licensing and copyright info
license-check:
  reuse lint

# <- Annotate the specified files with the default code license
license-repo +FILES:
  reuse annotate --recursive {{ license-template }} \
    --license '{{ repo-license }}' \
    --copyright '{{ repo-copyright }}' \
    {{ FILES }}

# <- Annotate the specified files with the upstream license
license-upstream +FILES:
  reuse annotate --recursive {{ license-template }} \
    --license '{{ upstream-license }}' \
    --copyright 'Chris Kempson and contributors' \
    --year '2012-2022' \
    {{ FILES }}
  reuse annotate --recursive {{ license-template }} \
    --license '{{ upstream-license }}' \
    --copyright 'Tinted Theming (https://github.com/tinted-theming)' \
    --year '2022' \
    {{ FILES }}

# <- Annotate the specified files with the default docs license
license-docs +FILES:
  reuse annotate --recursive {{ license-template }} \
    --license '{{ docs-license }}' \
    --copyright '{{ repo-copyright }}' \
    {{ FILES }}

