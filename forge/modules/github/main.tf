resource "github_repository" "this" {
  for_each = var.repositories

  name         = each.key
  description  = each.value.description
  visibility   = each.value.visibility
  topics       = each.value.topics
  archived     = each.value.archived
  homepage_url = each.value.github.homepage_url
  is_template  = each.value.github.is_template

  has_issues      = each.value.features.issues
  has_wiki        = each.value.features.wiki
  has_projects    = each.value.features.projects
  has_discussions = each.value.github.has_discussions

  allow_squash_merge     = each.value.merge.squash
  allow_merge_commit     = each.value.merge.merge
  allow_rebase_merge     = each.value.merge.rebase
  delete_branch_on_merge = each.value.merge.delete_branch_on_merge

  # Removing a repository from config archives it on GitHub instead of deleting it.
  archive_on_destroy = true
}

resource "github_branch_default" "this" {
  for_each = var.repositories

  repository = github_repository.this[each.key].name
  branch     = each.value.default_branch
}
