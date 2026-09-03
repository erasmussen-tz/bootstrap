resource "github_repository" "bootstrap" {
  name        = "bootstrap"
  description = "Bootstrapping for task automation"
  visibility  = "public"

  has_issues   = true
  has_projects = false
  has_wiki     = false
}
