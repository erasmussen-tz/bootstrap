resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = true
  has_projects = var.has_projects
  has_wiki     = false
}
