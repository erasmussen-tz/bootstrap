# AGENTS.md

OpenTofu configuration that manages version control platforms, starting with the TractorZoom GitHub organization.

- Run everything through `make` inside `nix develop`. `make plan` / `make apply` wrap `tofu` with `terraform-backend-git`, which stores sops-encrypted state in `erasmussen-tz/forge-state`.
- Keep `config/` platform-neutral. Platform-specific settings go under a key named for the platform (`github:`). See `docs/data-model.md`.
- Bring existing resources under management with `import` blocks in `imports.tf`, and iterate until `make plan` shows imports with zero changes before applying.
- Never run `tofu apply` without a reviewed plan file, and never add a backend block: the wrapper generates `git_http_backend.auto.tf`.
