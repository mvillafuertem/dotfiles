# AGENTS.md

This file provides guidance to coding agents (Claude Code, and other models/tools) when working with code in this repository.

## What this is

A Nix flake managing dotfiles and system configuration across multiple machines (macOS via nix-darwin, Linux via standalone home-manager). One flake drives every host; per-host files pick which modules to load.

## Commands

```sh
# Apply config on macOS (nix-darwin) — run from anywhere, flake path is fixed
sudo darwin-rebuild switch --flake ~/.dotfiles

# First-time bootstrap (no darwin-rebuild on PATH yet)
sudo nix --extra-experimental-features "nix-command flakes" \
  run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles

# Apply config on Linux (standalone home-manager)
home-manager switch --flake .#<hostname>      # e.g. .#raspberrypi

# Build without activating (validate changes)
darwin-rebuild build --flake .#<hostname>

# Enter a dev shell (globally available)
nix develop ~/.dotfiles#devops    # also: #rust #scala #scala212 #default
# or with direnv: echo "use flake ~/.dotfiles#devops" > .envrc && direnv allow

# Format Nix
nixfmt <file.nix>
```

There is no test suite. "Does it work" = `darwin-rebuild build` succeeds and then `switch` applies cleanly.

## Architecture

The flake fans out from a single `users` list in `flake.nix`. Each entry is `{ user, hostname, system }`. From that list the flake builds:

- `darwinConfigurations.<hostname>` — for `*-darwin` systems, via `mkDarwinConfig`
- `homeConfigurations.<hostname>` — for `*-linux` systems, via `mkHomeConfig`
- `devShells.<system>.*` — re-exported from the sub-flakes in `flakes/`

To add a machine: append to `users` in `flake.nix` and create `system/<system>/<hostname>.nix`.

### Layering (outermost to innermost)

1. **`flake.nix`** — entrypoint. Defines `users`, builds pkgs per system (`mkPkgs` applies every `overlays/*.nix` and the unfree allowlist), wires darwin + home-manager.
2. **`darwin.nix`** — shared nix-darwin base for ALL Macs (login shell → Nix bash via `dscl`, Touch ID for sudo, nix GC, global dock defaults). It `imports = [ ./system/${system}/${hostname}.nix ]`.
3. **`system/<system>/<hostname>.nix`** — the per-host manifest. This is where each machine chooses its `darwinModules` and `homeManagerModules` (as lists of module names mapped to paths), declares Homebrew casks, host-specific sudoers, and the `home.packages` list. **This is usually the file you edit to add/remove a tool.**
4. **`system/common.nix`** — home-manager config shared across all hosts (xdg, fonts, stateVersion). Imported by each host's `home-manager.users.<user>`.
5. **`modules/`** — the actual program configs, one directory per tool.

### Modules pattern (`modules/`)

- `modules/darwin/*` — nix-darwin modules (macOS system prefs, homebrew, window managers like aerospace/yabai/skhd, sketchybar).
- `modules/home-manager/*` — per-tool home-manager modules (bash, git, tmux, nvim, starship, k9s, wezterm, direnv, eza, claude, …).

Each module `default.nix` either uses a `programs.<x>` home-manager option, or ships raw config files via `xdg.configFile."<x>" = { source = ./config; recursive = true; }`. When a config file needs a Nix value interpolated (e.g. a `/nix/store` path), the module reads the file with `builtins.readFile` into `.text` and appends the interpolation instead of using `source` — see `modules/home-manager/tmux/default.nix` for the canonical example. Editable raw config lives under each module's `config/` subdir.

Modules are NOT auto-imported. A module only takes effect if its name appears in the host file's `darwinModules` / `homeManagerModules` list.

### overlays/

Every `.nix` in `overlays/` is auto-applied to nixpkgs by `mkPkgs`. Used to pin/patch specific package versions (e.g. colima, karabiner-elements). `self: super: {}` is the empty no-op form.

### flakes/

Self-contained sub-flakes providing dev shells, consumed as inputs of the root flake and re-exported under `devShells`:
- `devops` — terraform (pinned), helm/helmfile, argo, crossplane, istioctl, pyenv.
- `scala`, `scala212` — Scala toolchains. Note these pin a custom Zulu JDK and bake a corporate (GBG `inv.gbgplc.com`) CA cert into the JDK truststore + sbt.
- `rust` — Rust toolchain.

### pkgs/

Local derivations not in nixpkgs (e.g. `whichspace`), referenced from darwin modules.

## Conventions

- Most inline comments and `NOTA:` blocks are in Spanish; match that when editing existing comments.
- Host files carry important load-bearing context in comments (e.g. macbookpro's sudoers NOPASSWD is required for Homebrew casks under a corporate restricted sudoers; declarative hostname is intentionally disabled because JAMF/MDM manages it). Read those comments before changing host config.
- Secrets are gitignored aggressively (`*.pem`, `*.key`, `id_*`, `.aws/`, `.kube/config`, …) — keep them out of tracked files.
