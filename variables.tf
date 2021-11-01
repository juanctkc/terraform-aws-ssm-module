variable "parameters" {
  type = list(object({
    prefix = string
    parameters = list(object({
      name  = string
      value = string
    }))
  }))
  default = []
}

variable "tags" {
  description = "tags"
  type        = map(any)
}

variable "kms_key_id" {
  description = "KMS key id"
  type        = string
}

variable "overwrite" {
  description = "Overwrite an existing parameter."
  type        = bool
  default     = true
}

variable "ignore_changes" {
  description = "Set lifecycle behaviour"
  type        = bool
  default     = false
}
