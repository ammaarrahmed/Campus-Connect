# Scripts

Store repeatable local and CI helper scripts in this directory.

Recommended conventions:

- Use executable shell scripts (`.sh`) for Linux/macOS CI steps.
- Keep scripts idempotent and non-interactive.
- Add usage examples at the top of each script.
- Prefer scripts for complex multi-step commands reused in CI.
