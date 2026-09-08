resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  has_issues   = true
  has_projects = var.has_projects
  has_wiki     = false

  allow_merge_commit = false
  allow_rebase_merge = false
  allow_squash_merge = true
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}
