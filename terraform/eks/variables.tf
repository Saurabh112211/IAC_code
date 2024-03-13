variable "namespace" {
  type = string
  default = "test"
}

variable "name" {
  type = string
  default = "eks"
}

variable "stage" {
  type = string
  default = "poc"
}

variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "kubernetes_version" {
  type        = number
  default     = "1.28"
  description = "EKS kubernetes version"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = <<-EOT
    Instance types to use for this node group (up to 20). Defaults to ["t3.medium"].
    Must be empty if the launch template configured by launch_template_id specifies an instance type.
    EOT
  validation {
    condition = (
      length(var.instance_types) <= 20
    )
    error_message = "Per the EKS API, no more than 20 instance types may be specified."
  }
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes"
  default     = "1"
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes"
  default     = "1"
}

variable "desired_size" {
  type        = number
  description = "Initial desired number of worker nodes (external changes ignored)"
  default     = "1"
}

variable "autoscaling_policies_enabled" {
  type        = bool
  description = "Enable the Kubernetes cluster auto-scaler to find the auto-scaling group"
  default     = true
}

variable "map_additional_iam_users" {
  type        = list(object({
    userarn   = string
    username  = string
    groups    = list(string)
  }))
  description = "Additional IAM users to add to config-map-aws-auth ConfigMap"
  default     = []
}