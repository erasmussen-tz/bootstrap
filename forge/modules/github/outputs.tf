output "repositories" {
  value = {
    for name, r in github_repository.this : name => {
      ssh_clone_url  = r.ssh_clone_url
      default_branch = github_branch_default.this[name].branch
    }
  }
}
