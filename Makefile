build:
	nix build .#

update:
	nix flake update

check lint:
	nix flake check

format fmt:
	nix fmt

tf-init:
	cd terraform && terraform init

tf-decrypt:
	@if [ -f terraform.tfstate.enc.json ]; then \
		sops -d --input-type binary --output-type binary terraform.tfstate.enc.json > terraform/terraform.tfstate; \
	fi

tf-encrypt:
	sops -e --input-type binary --output-type binary terraform/terraform.tfstate > terraform.tfstate.enc.json

tf-plan: tf-decrypt
	sops exec-env secrets.enc.yaml 'terraform -chdir=terraform plan'

tf-apply: tf-decrypt
	sops exec-env secrets.enc.yaml 'terraform -chdir=terraform apply'
	$(MAKE) tf-encrypt
