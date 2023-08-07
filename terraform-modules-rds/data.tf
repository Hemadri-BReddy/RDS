data "aws_security_groups" "database_sg_id" {
  filter {
    name = "group-name"
    values = [ var.aurora_cluster_sg]
  }
}
data "aws_db_subnet_group" "existing_db_subnet_group" {
  name = var.db_subnet_group
}
data "aws_caller_identity" "current" {}
