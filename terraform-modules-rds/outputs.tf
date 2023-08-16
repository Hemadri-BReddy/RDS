output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}
output "scretmanager_arn" {
  value = aws_secretsmanager_secret.rds_aurora.arn
}
output "aurora-cluster_arn" {
  value = aws_rds_cluster.aurora_cluster.arn
}
output "kms-key-id" {
  value = aws_kms_key.main.id
}
output "kms-key-arn" {
  value = aws_kms_key.main.arn
}


