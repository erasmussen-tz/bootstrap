# Keyed by repository name. Defaults match GitHub's defaults for a new
# repository, so an imported repository only lists what differs.
variable "repositories" {
  type = map(object({
    description    = optional(string, "")
    visibility     = optional(string, "private")
    topics         = optional(list(string), [])
    default_branch = optional(string, "main")
    archived       = optional(bool, false)

    features = optional(object({
      issues   = optional(bool, true)
      wiki     = optional(bool, true)
      projects = optional(bool, true)
    }), {})

    merge = optional(object({
      squash                 = optional(bool, true)
      merge                  = optional(bool, true)
      rebase                 = optional(bool, true)
      delete_branch_on_merge = optional(bool, false)
    }), {})

    github = optional(object({
      homepage_url    = optional(string)
      has_discussions = optional(bool, false)
      is_template     = optional(bool, false)
    }), {})
  }))

  validation {
    condition = alltrue([
      for r in values(var.repositories) : contains(["public", "private", "internal"], r.visibility)
    ])
    error_message = "visibility must be one of public, private, internal."
  }
}
