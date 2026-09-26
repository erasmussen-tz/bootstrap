# forge

OpenTofu management of version control platforms.
It manages the TractorZoom GitHub organization, and the configuration under `config/` is platform-neutral (see `docs/data-model.md`).

## State

State lives in the private `erasmussen-tz/forge-state` repo via [terraform-backend-git](https://github.com/plumber-cd/terraform-backend-git), configured in `terraform-backend-git.hcl`.
Locks are `locks/*` branches in that repo.
The backend encrypts state with sops before pushing it, to every recipient in `recipients.txt` (age public keys or `ssh-ed25519` public keys, one per line).
Decryption uses the usual sops sources: `SOPS_AGE_KEY_FILE`, `SOPS_AGE_KEY_CMD`, or `~/.ssh/id_ed25519`.

Adding a recipient means adding a line to `recipients.txt`; the next `make apply` writes state encrypted to the new list.

## Usage

Inside `nix develop`:

- `make init` once, or after changing providers or the backend config.
- `make plan` writes `tfplan`; `make apply` applies exactly that file.
- `make validate` runs `tofu validate` without touching the backend, as CI does.

`GITHUB_TOKEN` defaults to `gh auth token`.
Set it to a token with admin access to the organization in `config/org.yaml` to apply changes.
