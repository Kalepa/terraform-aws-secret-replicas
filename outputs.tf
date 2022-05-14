output "secrets_by_region" {
  description = "A map of region names to the secret (original or replica) in that region."
  value       = var.include_original ? merge(local.original_secret, local.replica_secrets) : local.replica_secrets
}
