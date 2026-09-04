STATE_ENC := terraform.tfstate.enc.json
STATE_PLAIN := terraform/terraform.tfstate

tf-plan: terraform/.terraform $(if $(wildcard $(STATE_ENC)),$(STATE_PLAIN))
	sops exec-env secrets.enc.yaml 'terraform -chdir=terraform plan'

tf-apply: terraform/.terraform $(if $(wildcard $(STATE_ENC)),$(STATE_PLAIN))
	sops exec-env secrets.enc.yaml 'terraform -chdir=terraform apply'
	$(MAKE) tf-encrypt

# Decrypt is a file target (only reruns when the committed encrypted state
# is newer than the local plaintext copy). Encrypt stays a plain action,
# triggered after apply, not by file staleness in the other direction --
# making both directions file targets creates a circular dependency.
$(STATE_PLAIN): $(STATE_ENC)
	sops -d --input-type binary --output-type binary $< > $@

tf-encrypt:
	sops -e --input-type binary --output-type binary $(STATE_PLAIN) > $(STATE_ENC)

# .terraform/ is the local, gitignored marker that init has actually run in
# this checkout (unlike the committed .terraform.lock.hcl, which doesn't
# change on a fresh clone).
terraform/.terraform: terraform/versions.tf
	cd terraform && terraform init

tf-init: terraform/.terraform

update:
	nix flake update

check lint:
	nix flake check

format fmt:
	nix fmt

.PHONY: tf-plan tf-apply tf-encrypt tf-init update check lint format fmt
