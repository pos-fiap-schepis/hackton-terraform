variable "name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
  default     = "data.aws_iam_role.lab_role.arn"
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS worker nodes"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnets for the EKS cluster"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity of the EKS node group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity of the EKS node group"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity of the EKS node group"
  type        = number
}

variable "instance_types" {
  description = "Instance type of node group"
  type = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}