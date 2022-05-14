// For future use when the corresponding data source returns a list of replicas (as of 2022-05-13, it doesn't return a `replica` field)
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret
/*
variable "secret" {
  description = "Either the secret ARN, secret name, or secret resource (the `aws_secretsmanager_secret` resource itself) that you'd like to get the replica data for."
  type        = any
  validation {
    condition     = var.secret != null
    error_message = "The `secret` variable cannot be null."
  }
  validation {
    condition     = can(tostring(var.secret)) || (can(var.secret["arn"]) && can(var.secret["kms_key_id"]) && can(var.secret["replica"]))
    error_message = "The `secret` variable must be a secret ARN, a secret name, or a secret resource (the `aws_secretsmanager_secret` resource itself)."
  }
}
*/

variable "secret" {
  description = "The secret resource (the `aws_secretsmanager_secret` resource itself) that you'd like to get the replica data for."
  type = object({
    arn         = string
    name        = string
    kms_key_id  = string
    description = string
    replica = list(object({
      kms_key_id     = string
      region         = string
      status         = string
      status_message = string
    }))
    rotation_enabled = bool
    tags             = map(string)
    tags_all         = map(string)
  })
  validation {
    condition     = var.secret != null
    error_message = "The `secret` variable cannot be null."
  }
}

variable "include_original" {
  description = "Whether to include the original secret (the one which is replicated) in the output."
  type        = bool
  default     = true
}
