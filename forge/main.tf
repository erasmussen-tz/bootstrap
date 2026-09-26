locals {
  org = yamldecode(file("${path.module}/config/org.yaml"))

  repositories = {
    for f in fileset("${path.module}/config/repos", "*.yaml") :
    trimsuffix(f, ".yaml") => yamldecode(file("${path.module}/config/repos/${f}"))
  }
}

check "platform" {
  assert {
    condition     = local.org.platform == "github"
    error_message = "config/org.yaml platform \"${local.org.platform}\" has no module; only \"github\" is implemented."
  }
}

module "github" {
  source       = "./modules/github"
  repositories = local.repositories
}
