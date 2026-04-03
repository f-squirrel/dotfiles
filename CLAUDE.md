# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Overview

This is a dotfiles repository currently in early stages. The only script
present is `setup.sh`, which bootstraps a Nix installation using the
daemon install method.

## Bootstrap

```sh
sh setup.sh
```

This runs the official Nix installer with `--daemon` (multi-user install)
over HTTPS.
