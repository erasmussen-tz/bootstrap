output "full_name" {
  value = github_repository.this.full_name
}

output "ssh_clone_url" {
  value = github_repository.this.ssh_clone_url
}

output "default_branch" {
  value = github_branch_default.this.branch
}
