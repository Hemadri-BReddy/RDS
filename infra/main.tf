module "rds" {
  source = "../terraform-modules-rds"
  aurora_cluster_sg = var.aurora_cluster_sg
  azs = var.azs
  
  tags = var.tags
  aurora_cluster_identifier = var.aurora_cluster_identifier
  aurora_engine = var.aurora_engine
  aurora_engine_version = var.aurora_engine_version
  database_name = var.database_name
  database_username = var.database_username
  database_retention_period = var.database_retention_period
  aurora_instance_identifier = var.aurora_instance_identifier
  db_instance_type = var.db_instance_type
  secret_name = var.secret_name
  db_subnet_group = var.db_subnet_group
  skip_snapshot = var.skip_snapshot
  #db_storage = var.db_storage
  db_deleetion_protection = var.db_deleetion_protection
  kmskey_description = var.kmskey_description
  kmskey_deletion_period = var.kmskey_deletion_period
  kmskey-alias = var.kmskey-alias
  
  depends_on = [ module.vpc,module.sg ]
}

module "vpc" {
  source = "../terraform-modules-vpc"
  vpc_cidr = var.vpc_cidr
  database_subnet_cidr = var.database_subnet_cidr
  database_subnet_names = var.database_subnet_names
  database_route_table_name = var.database_route_table_name
  db_subnet_group = var.db_subnet_group
  vpc-name = var.vpc-name
  azs = var.azs
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_names = var.public_subnet_names
  tags = var.tags
}
module "sg" {
  source = "../terraform-modules-security-group"
  aurora_cluster_sg = var.aurora_cluster_sg
  aurora_cluster_description = var.aurora_cluster_description
  aurora_cluster_cidr = var.aurora_cluster_cidr
  tags = var.tags
  vpc-name = var.vpc-name
  depends_on = [ module.vpc ]
}

module "sns" {
  source = "../terraform-modules-sns"
  sns-topic = var.sns-topic
  fallback-topic = var.fallback-topic
  has_email = var.has_email
  email = var.email
  has_http_endpoint = var.has_http_endpoint
  http_endpoint = var.http_endpoint
  has_https_endpoint = var.has_https_endpoint
  https_endpoint = var.https_endpoint
  has_fallback_email = var.has_fallback_email
  fallback_email = var.fallback_email
  cloudwatch-alarm = var.cloudwatch-alarm

  depends_on = [ module.rds ]
}