# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a DevOps learning repository containing coursework, assignments, and reference materials. The primary language of documentation is Ukrainian.

## Structure

- `Assignments/` — Homework assignments (text and images). HW answers are written directly in `.txt` files.
- `code/` — Placeholder for homework code submissions (gitignored).
- `data_sources/` — Supplementary data files (gitignored).
- `materials/` — Reference materials and images (gitignored).
- `CommandCheatList.txt` — Linux command reference covering process management, signals, permissions (`chmod`, ACL, SGID, sticky bit), user/group administration, logging (`journalctl`, `/var/log/`), and package repositories.

## Git

- The `main` branch is the primary branch.
- `.gitignore` excludes `code/`, `data_sources/`, `materials/`, and `.gitignore` itself. Only `Assignments/` and `CommandCheatList.txt` are tracked.
- When working with files in gitignored directories, note that changes there will not be committed.

## Notes

- There is no build system, test framework, or linter configured in this repository.
- Завдання можуть стосуватися середовищ Linux/WSL. При редагуванні скриптів у Windows для використання в WSL слід враховувати проблему закінчень рядків DOS (`\r\n` замість `\n`) — для виправлення використовуйте `sed -i 's/\r$//'`.

