# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a DevOps learning repository containing coursework, assignments, and reference materials. The primary language of documentation and comments is Ukrainian.

## Structure

- `Assignments/` — Homework assignments organized by number (`homework1`–`homework8`, `homework_6`, `new_hw5`). Each homework directory follows a consistent layout:
  - `src/` — Source files (Bash scripts `.sh`, text answers `.txt`, Vagrantfiles)
  - `screens/` (or `screen/`) — Screenshots demonstrating results
- `CommandCheatList.txt` — Linux command reference (process management, permissions, logging, user/group admin, ACL, repositories).
- `tasks.md` — Exercise descriptions for Bash scripting and systemd service tasks.
- `hello.sh` — Simple Bash script example.
- `screens/` — Shared screenshot assets.

## Homework Topics

- **HW1–HW3**: Linux architecture fundamentals (kernel, libraries, system utilities), text-based answers.
- **HW4**: Nginx setup and systemd service management.
- **HW5 / new_hw5**: Bash scripting exercises (loops, arrays, file operations, error handling, string manipulation, systemd watcher service).
- **HW6**: SSH configuration, AWS connectivity, Bash quiz game.
- **HW7**: Crontab, disk monitoring script (`check_disk.sh`), monit, user/group management.
- **HW8**: Vagrant with VirtualBox — automated Nginx provisioning via `Vagrantfile`.

## Technologies Used

- **Bash** — Primary scripting language for all homework scripts.
- **Vagrant** (with VirtualBox provider) — VM provisioning (HW8). Base box: `ubuntu/jammy64`.
- **systemd** — Service management, journalctl logging.
- **crontab** — Scheduled task execution.
- **monit** — Process monitoring (Nginx).
- **SSH** — Remote access configuration (including custom ports, key-based auth).

## Git

- The `main` branch is the primary branch.
- `.gitignore` excludes: `code/`, `data_sources/`, `materials/`, `secrets/`, `.vagrant.d/`, `vagrant_test_windows/`, `*.rar`, `*.pem`, `*.key`, `*.gpg`, `*.sops.yaml`, `*.tfstate`, `*.tfstate.backup`, `.ssh/`, `*.md`, and `.gitignore` itself. `AGENTS.md` and `README.md` remain tracked because they were added before the `*.md` ignore rule.
- `tasks.md` is **not** tracked due to the `*.md` rule.
- `Assignments/` contains `.vagrant.d/` and `vagrant_test_windows/` directories (Vagrant artifacts) — these are gitignored.

## Notes

- There is no build system, test framework, or linter configured in this repository.
- Завдання можуть стосуватися середовищ Linux/WSL. При редагуванні скриптів у Windows для використання в WSL слід враховувати проблему закінчень рядків DOS (`\r\n` замість `\n`) — для виправлення використовуйте `sed -i 's/\r$//'`.
- Bash scripts use `#!/bin/bash` shebang and are designed to run on Linux/WSL, not directly in PowerShell.

