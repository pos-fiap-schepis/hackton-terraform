variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "ecr-hackton"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "image_scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "lifecycle_policy" {
  description = "Lifecycle policy JSON document for the repository"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the repository"
  type        = map(string)
  default = {
    Name = "ecr-fast-food-repo"
  }
}