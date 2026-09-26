TOFU        ?= tofu
TF_BACKEND  ?= terraform-backend-git
PLAN_FILE   := tfplan
TF_SOURCES  := $(wildcard *.tf) $(wildcard modules/*/*.tf) $(wildcard config/*.yaml config/*/*.yaml)

# Provider auth. Override with a token scoped to the managed org.
GITHUB_TOKEN ?= $(shell gh auth token)
export GITHUB_TOKEN

# State is sops-encrypted by the backend before it is pushed to forge-state.
# Recipients are comma separated; age and ssh-ed25519 keys are both accepted.
export TF_BACKEND_HTTP_ENCRYPTION_PROVIDER := sops
export TF_BACKEND_HTTP_SOPS_AGE_RECIPIENTS := $(shell paste -sd, recipients.txt)

# Starts the git-backed HTTP backend (configured by terraform-backend-git.hcl),
# writes git_http_backend.auto.tf, then runs tofu with the remaining args.
WRAP := $(TF_BACKEND) git terraform --tf $(TOFU)

init: .terraform

.terraform: versions.tf terraform-backend-git.hcl
	$(WRAP) init

plan: $(PLAN_FILE)

$(PLAN_FILE): .terraform $(TF_SOURCES)
	$(WRAP) plan -out=$(PLAN_FILE)

apply: $(PLAN_FILE)
	$(WRAP) apply $(PLAN_FILE)
	rm -f $(PLAN_FILE)

validate:
	$(TOFU) init -backend=false
	$(TOFU) validate

update:
	nix flake update

check lint:
	nix flake check

format fmt:
	nix fmt

.PHONY: init plan apply validate update check lint format fmt
