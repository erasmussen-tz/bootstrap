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
