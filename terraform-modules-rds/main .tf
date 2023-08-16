resource "aws_rds_cluster" "aurora_cluster" {
  #allocated_storage = var.db_storage
  cluster_identifier = var.aurora_cluster_identifier
  engine = var.aurora_engine
  engine_version = var.aurora_engine_version
  database_name = var.database_name 
  master_username = var.database_username
  master_password = random_password.password.result   # if wenat the manual password, we can set (create variable)
  backup_retention_period = var.database_retention_period
  #preferred_backup_window = var.backup_time  #  # Preferred time window for automated backups
  skip_final_snapshot = var.skip_snapshot # set true to skip snapshot before deletion
  vpc_security_group_ids = data.aws_security_groups.database_sg_id.ids
  availability_zones = var.azs
  deletion_protection = var.db_deleetion_protection # set true if need prevents from deletion
  db_subnet_group_name = data.aws_db_subnet_group.existing_db_subnet_group.name
  # Use KMS Key for RDS storage encryption
  storage_encrypted = true
  kms_key_id = aws_kms_key.main.arn
  #storage_type = "io1"
  depends_on = [ aws_kms_key.main ]

  tags = merge(var.tags, {Owner = data.aws_caller_identity.current.account_id})
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier = var.aurora_instance_identifier
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class = var.db_instance_type
  engine = var.aurora_engine
  engine_version = var.aurora_engine_version
  publicly_accessible = false   # Set to true if you want the instance to be publicly accessible
  
  depends_on = [ aws_kms_key.main ]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# store the password in secret manager
resource "aws_secretsmanager_secret" "rds_aurora" {
  name = "${var.aurora_cluster_identifier}_secret"
  tags = merge(var.tags, {"Name" = var.secret_name})
}

# we will create the secret outside of terraform, but we store the value in through terraform
# data "aws_secretsmanager_secret" "by-arn" {
#   arn = var.rds_secret_arn

# }

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_aurora.id
  secret_string = jsonencode(
    {
    
    db_password = "${random_password.password.result}"
    db_user = "${aws_rds_cluster.aurora_cluster.master_username}"
    db_endpoint = "${aws_rds_cluster.aurora_cluster.endpoint}"
  
  }
  )

  
}
# resource "aws_secretsmanager_secret_version" "rds_username" {
#   secret_id = aws_secretsmanager_secret.rds_aurora.id
#   secret_string = aws_rds_cluster.aurora_cluster.master_username
# }

# resource "aws_secretsmanager_secret_version" "rds_endpoint" {
#   secret_id = aws_secretsmanager_secret.rds_aurora.id
#   secret_string = aws_rds_cluster.aurora_cluster.endpoint
# }
# resource "aws_secretsmanager_secret_version" "rds_" {
#   secret_id = aws_secretsmanager_secret.rds_aurora.id
#   secret_string = aws_rds_cluster.aurora_cluster.master_username
# }

resource "aws_kms_key" "main" {
  description = var.kmskey_description
  deletion_window_in_days = var.kmskey_deletion_period
}

resource "aws_kms_key_policy" "kms-policy" {
  key_id = aws_kms_key.main.id
  policy = jsonencode({
    Id = "admin-policy", # or user-policy (any value)
    Statement = [
        {
        Action = "kms:*",
        Effect = "Allow",
        Principal = {
            AWS = "*",
        }

        Resource = "*",
        Sid = "Enable IAM User Permissions",

        },
    ],
    Version = "2012-10-17",
  })
}

resource "aws_kms_alias" "kms-aliases" {
  name = var.kmskey-alias
  target_key_id = aws_kms_key.main.key_id
}



# resource "aws_db_instance" "main" {
#   allocated_storage = var.allocated_storage
#   db_name = var.db_name
#   identifier = var.identifier
#   engine = var.engine
#   engine_version_actual = var.engine_version
#   instance_class = var.instance_type
#   username = var.username
#   db_subnet_group_name = var.db_subnet_group_name
#   password = random_password.password.result
#   vpc_security_group_ids = var.vpc_security_group_ids
#   tags = merge(var.tags,
#                 var.rds_tags)
# }

# resource "random_password" "password" {
#   length           = 16
#   special          = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

# store the password in secret manager
# resource "aws_secretsmanager_secret" "rds" {
#   name = var.secret_name
#   tags = merge(var.tags,
#                 var.rds_tags)
# }

# # we will create the secret outside of terraform, but we store the value in through terraform
# data "aws_secretsmanager_secret" "by-arn" {
#   arn = var.rds_secret_arn

# }

# resource "aws_secretsmanager_secret_version" "rds" {
#   secret_id     = data.aws_secretsmanager_secret.by-arn.id
#   secret_string = random_password.password.result     # tags is not required here cause it is just value 
# }
