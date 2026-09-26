# No backend block: terraform-backend-git writes git_http_backend.auto.tf.
terraform {
  required_version = ">= 1.10"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.13"
    }
  }
}
