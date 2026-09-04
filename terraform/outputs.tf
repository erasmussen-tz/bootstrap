output "repos" {
  value = {
    bootstrap = {
      ssh_clone_url  = module.bootstrap.ssh_clone_url
      default_branch = module.bootstrap.default_branch
    }
    notes = {
      ssh_clone_url  = module.notes.ssh_clone_url
      default_branch = module.notes.default_branch
    }
    glossary = {
      ssh_clone_url  = module.glossary.ssh_clone_url
      default_branch = module.glossary.default_branch
    }
    dotfiles = {
      ssh_clone_url  = module.dotfiles.ssh_clone_url
      default_branch = module.dotfiles.default_branch
    }
    model = {
      ssh_clone_url  = module.model.ssh_clone_url
      default_branch = module.model.default_branch
    }
  }
}
