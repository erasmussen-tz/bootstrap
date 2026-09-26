variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "visibility" {
  type    = string
  default = "private"
}

variable "has_projects" {
  type    = bool
  default = false
}

# github_branch_default requires `main` to exist, which an empty repo lacks.
variable "auto_init" {
  type    = bool
  default = false
}
