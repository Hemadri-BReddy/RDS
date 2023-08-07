output "vpc_id" {
  value = module.vpc.vpc_id
}
output "database-subnet-ids" {
  value = module.vpc.database-subnet-ids
}
output "database_sg_id" {
  value = module.sg.database_sg_id
}
output "aurora_cluster_endpoint" {
  value = module.rds.aurora_cluster_endpoint
}
output "scretmanager_arn" {
  value = module.rds.scretmanager_arn
}
output "aurora-cluster_arn" {
  value = module.rds.aurora-cluster_arn
}
output "sns-topic-arn" {
  value = module.sns.sns-topic-arn
}
output "sns-topic-name" {
  value = module.sns.sns-topic-name
}
output "fallback-topic-arn" {
  value = module.sns.fallback-topic-arn
}


