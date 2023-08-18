
  tags = {
  Name        = "rds-vpc"
  Environment = "DEV"
  terraform   = true
}
  aurora_cluster_identifier = "aurora-db"
  aurora_engine = "aurora-mysql"
  aurora_engine_version = "5.7.mysql_aurora.2.11.3"
  database_name = "dbAurora"
  database_username = "xanadu"
  database_retention_period = 7
  aurora_instance_identifier = "db-aurora-instance"
  db_instance_type = "db.r5.large"
  secret_name = "aurora-secret-39"
  db_subnet_group = "rds-subnet-group"
  aurora_cluster_sg = "rds-sg"
  azs = ["ca-central-1a", "ca-central-1b"]
  vpc_cidr = "10.0.0.0/16"
  database_subnet_cidr = ["10.0.21.0/24", "10.0.22.0/24"]
  database_subnet_names = ["rds-db-1a", "rds-db-1b"]
  database_route_table_name = "rds-db-rt"
  vpc-name = "rds-vpc"
  aurora_cluster_description = "rds-aurora-database-creation"
  aurora_cluster_cidr = [
  {
    from_port   = "3306"
    to_port     = "3306"
    cidr_block  = "0.0.0.0/0"
    description = "opening  to internet"
    protocol    = "TCP"
  },
  ]
  public_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_names   = ["public-1a", "public-1b"]
  skip_snapshot = true
  #db_storage = 1
  db_deleetion_protection = false
  kmskey_description = "KMSkeyforRDS"
  kmskey_deletion_period = 30
  kmskey-alias = "alias/kmskeyrds"
  sns-topic = "Topic1"
  fallback-topic = "Topic2"
  fallback_email = "sudheerbrv@gmail.com"
  email = "sudheerbrv@gmail.com"
  has_email = false
  has_http_endpoint = false
  http_endpoint = ""
  has_https_endpoint = false
  https_endpoint = ""
  has_fallback_email = true
  cloudwatch-alarm = "Alarm1"
  aws_access_key = "AKIAREAXEJE62VPL6W4T"
  aws_secret_key = "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"
