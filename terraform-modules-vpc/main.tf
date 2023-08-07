# module "cloudwatch" {
#   source = "../cloudwatch"

#   vpc-cloudwatch-group = var.vpc-cloudwatch-group
#   vpc-flowlog-role = var.vpc-flowlog-role
#   vpc-iam-role-policy = var.vpc-iam-role-policy
  
# }

# create VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = merge(var.tags, {"Name" = "${var.vpc-name}"})                     
}
# create internet gateway
 resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags) 
  depends_on = [aws_vpc.main]            
} 

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(var.tags,
              {"Name"= var.public_subnet_names[count.index]}
              ) 
}

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id
#   tags = merge(var.tags,
#                var.public_route_table_tags,
#                {"Name"= var.public_route_table_name}
#                )
# }

# resource "aws_route" "public" {
#   route_table_id = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id = aws_internet_gateway.main.id
# }

# # associate with public subnets. we will use "element" function

# resource "aws_route_table_association" "public" {
#   count = length(var.public_subnet_cidr)
#   subnet_id      = element(aws_subnet.public[*].id, count.index)
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_subnet" "private" {
#   count = length(var.private_subnet_cidr)
#   vpc_id     = aws_vpc.main.id
#   cidr_block = var.private_subnet_cidr[count.index]
#   availability_zone = var.azs[count.index]
#   tags = merge(var.tags,
#               var.private_subnet_tags,
#               {"Name"= var.private_subnet_names[count.index]}
#               ) 
# }

# # resource "aws_vpc_endpoint" "my_vpc_endpoint" {
# #   vpc_id = aws_vpc.main.id
# #   service_name = ""  # replace with the desired vpc link service name
# #   vpc_endpoint_type = var.vpc_endpoint_type   # interface
# #   subnet_ids = [aws_subnet.public[*].id,aws_subnet.private[*].id]

# # }

# create NAT gateway

resource "aws_eip" "main" {
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.tags)
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id
#   tags = merge(var.tags,
#                var.private_route_table_tags,
#                {"Name"= var.private_route_table_name}
#                )
# }

# resource "aws_route" "private" {
#   route_table_id = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.main.id
# }

# # associate with private subnets. we will use "element" function

# resource "aws_route_table_association" "private" {
#   count = length(var.private_subnet_cidr)
#   subnet_id      = element(aws_subnet.private[*].id, count.index)
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_flow_log" "vpc-log" {
#   iam_role_arn = data.aws_iam_role.vpc-flowlog.arn
#   #module.vpcflowlogs-iam-role.vpcflowlog-iam-role-arn
#   log_destination = data.aws_cloudwatch_log_group.vpc-cloudwatch-group.arn
#   #module.vpclogs-cloudwatch.vpc-cloudwatch-group-arn
#   traffic_type = "ALL"
#   vpc_id = aws_vpc.main.id
# }

# database 

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(var.tags,
              {"Name"= var.database_subnet_names[count.index]}
              ) 
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags,
               {"Name"= var.database_route_table_name}
               )
}

resource "aws_route" "database" {
  route_table_id = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}

resource "aws_db_subnet_group" "database" {
  name       = var.db_subnet_group  # if we dont give name, terraform will assign random name
  subnet_ids = aws_subnet.database[*].id

  tags = merge(var.tags,{"Name" = var.db_subnet_group})
}





