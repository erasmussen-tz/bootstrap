module "bootstrap" {
  source      = "./modules/repo"
  name        = "bootstrap"
  description = "Bootstrapping for task automation"
  visibility  = "public"
}

module "forge" {
  source      = "./modules/repo"
  name        = "forge"
  description = "OpenTofu management of version control platforms"
  auto_init   = true
}

module "forge-state" {
  source      = "./modules/repo"
  name        = "forge-state"
  description = "Encrypted OpenTofu state for forge"
  auto_init   = true
}
