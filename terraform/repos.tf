module "bootstrap" {
  source      = "./modules/repo"
  name        = "bootstrap"
  description = "Bootstrapping for task automation"
  visibility  = "public"
}

module "notes" {
  source      = "./modules/repo"
  name        = "notes"
  description = "Notes"
}

module "glossary" {
  source      = "./modules/repo"
  name        = "glossary"
  description = "Glossary"
}

module "dotfiles" {
  source       = "./modules/repo"
  name         = "dotfiles"
  description  = "Nix home configuration"
  has_projects = true
}

module "model" {
  source      = "./modules/repo"
  name        = "model"
  description = "Domain modeling"
}

moved {
  from = github_repository.bootstrap
  to   = module.bootstrap.github_repository.this
}

moved {
  from = github_repository.notes
  to   = module.notes.github_repository.this
}

moved {
  from = github_repository.glossary
  to   = module.glossary.github_repository.this
}

moved {
  from = github_repository.dotfiles
  to   = module.dotfiles.github_repository.this
}

moved {
  from = github_repository.model
  to   = module.model.github_repository.this
}
