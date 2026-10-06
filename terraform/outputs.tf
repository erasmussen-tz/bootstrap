output "repos" {
  value = {
    bootstrap = {
      ssh_clone_url  = module.bootstrap.ssh_clone_url
      default_branch = module.bootstrap.default_branch
    }
    forge = {
      ssh_clone_url  = module.forge.ssh_clone_url
      default_branch = module.forge.default_branch
    }
    forge-state = {
      ssh_clone_url  = module.forge-state.ssh_clone_url
      default_branch = module.forge-state.default_branch
    }
  }
}
