# bootstrap
Bootstrapping for task automation, starting with Terraform-managed GitHub repos under `erasmussen-tz`.

## Terraform state and secrets

Terraform state and the GitHub token live in this repo, encrypted with [sops](https://getsops.io) using a native
age identity whose private key is stored as a Secure Note in 1Password (Employee vault, item `sops-age-key`).
Nothing ever touches disk in plaintext or gets committed unencrypted; `op` shells out to 1Password only at
decrypt time.

The age key isn't derived from an existing SSH key: 1Password exports SSH private keys in PKCS8 PEM format, which
`ssh-to-age` can't parse (it expects OpenSSH's own armored format), so a dedicated `age-keygen`-generated key is
used instead and stored directly.

### One-time setup (already done for this repo, documented for reference / re-setup on a new machine)

1. Sign in to the 1Password CLI: `op signin`.
2. `age-keygen`, store the private key line (`AGE-SECRET-KEY-1...`) as the `private key` field of a new Secure
   Note item named `sops-age-key` in the Employee vault. The public key (`age1...`) is already in `.sops.yaml`
   and isn't secret.
3. `.envrc` already sets `SOPS_AGE_KEY_CMD` to `op read "op://Employee/sops-age-key/private key"` — `direnv allow`
   after cloning.
4. Create a fine-grained GitHub PAT scoped to the `erasmussen-tz` org, then:
   ```
   sops secrets.enc.yaml
   ```
   and set `GITHUB_TOKEN: <pat>` in the editor that opens. Saving encrypts it in place.

### Day to day

- `make tf-init` — once, or after adding providers.
- `make tf-plan` / `make tf-apply` — decrypts state, runs terraform with `GITHUB_TOKEN` injected from
  `secrets.enc.yaml`, re-encrypts state afterward (`tf-apply` only; run `make tf-encrypt` by hand after a plan
  that changed nothing on disk but you still want re-encrypted, or after manually running `terraform` commands).
- Commit `terraform.tfstate.enc.json` and `secrets.enc.yaml` after they change. Plaintext `terraform/terraform.tfstate`
  is gitignored and only ever exists locally, transiently.
