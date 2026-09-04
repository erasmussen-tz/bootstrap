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
