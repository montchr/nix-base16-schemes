# SPDX-FileCopyrightText: 2022-2023 Chris Montgomery <chris@cdom.io>
# SPDX-License-Identifier: GPL-3.0-or-later

###: https://just.systems/man/en/

prj-root := env_var('PRJ_ROOT')
cache-dir := env_var('PRJ_CACHE_HOME')
upstream-src-path := env_var('BASE16_SCHEMES_PATH')

# upstream-src-path := `nix eval --impure --expr "builtins.toString ((builtins.getFlake (builtins.toString $PRJ_ROOT)).inputs.base16-schemes)"`
json-dir := cache-dir / "json"
out-dir := prj-root / "src"

default:
  @just --list --unsorted --color=always | rg -v "\s*default"

fmt:
  treefmt src/*.nix

# yaml-to-json:
#   fd --type file --extension yaml . {{ upstream-src-path }} --exec \
#     sh -c 'yaml2json < "$1" > "$2"' \
#       sh '{}' '{{ cache-dir }}/json/{.}.json'

yaml-to-json file:
  yaml2json < {{ file }} > {{ cache-dir }}/json/{{ file_stem( file ) }}.json

json-to-nix file:
  nix eval --expr 'builtins.fromJSON (builtins.readFile {{file}})' --impure \
    > {{ out-dir / file_stem( file ) }}.nix

generate: prepare
  fd --type file --extension yaml . {{ upstream-src-path }} --exec \
    just yaml-to-json
  fd --type file --extension json . {{ json-dir }} --exec \
    just json-to-nix

prepare:
  mkdir -p {{ json-dir }} {{ out-dir }}

clean: prepare
  rm -rf {{ json-dir }} {{ out-dir }}
