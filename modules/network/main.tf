data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    var.az_count
  )

  public_subnet_cidrs = [
    "10.0.0.0/20",
    "10.0.16.0/20",
    "10.0.32.0/20"
  ]

  private_app_subnet_cidrs = [
    "10.0.64.0/20",
    "10.0.96.0/20",
    "10.0.128.0/20"
  ]

  private_db_subnet_cidrs = [
    "10.0.160.0/20",
    "10.0.176.0/20",
    "10.0.192.0/20"
  ]

  nat_gateway_count = var.single_nat_gateway ? 1 : var.az_count

  common_tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# ---------------------------------------------------------
# VPC
# ---------------------------------------------------------

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpc"
    }
  )
}

# ---------------------------------------------------------
# Internet Gateway
# ---------------------------------------------------------

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-igw"
    }
  )
}

# ---------------------------------------------------------
# Public Subnets
# ---------------------------------------------------------

resource "aws_subnet" "public" {
  count = var.az_count

  vpc_id                  = aws_vpc.this.id
  availability_zone       = local.availability_zones[count.index]
  cidr_block              = local.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-public-${count.index + 1}"
      Tier = "public"
    }
  )
}

# ---------------------------------------------------------
# Private Application Subnets
# ---------------------------------------------------------

resource "aws_subnet" "private_app" {
  count = var.az_count

  vpc_id            = aws_vpc.this.id
  availability_zone = local.availability_zones[count.index]
  cidr_block        = local.private_app_subnet_cidrs[count.index]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-app-${count.index + 1}"
      Tier = "private-app"
    }
  )
}

# ---------------------------------------------------------
# Private Database Subnets
# ---------------------------------------------------------

resource "aws_subnet" "private_db" {
  count = var.az_count

  vpc_id            = aws_vpc.this.id
  availability_zone = local.availability_zones[count.index]
  cidr_block        = local.private_db_subnet_cidrs[count.index]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-db-${count.index + 1}"
      Tier = "private-db"
    }
  )
}

# ---------------------------------------------------------
# Public Route Table
# ---------------------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-public-rt"
    }
  )
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = var.az_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ---------------------------------------------------------
# Elastic IPs for NAT Gateways
# ---------------------------------------------------------

resource "aws_eip" "nat" {
  count = local.nat_gateway_count

  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-nat-eip-${count.index + 1}"
    }
  )
}

# ---------------------------------------------------------
# NAT Gateways
# ---------------------------------------------------------

resource "aws_nat_gateway" "this" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[var.single_nat_gateway ? 0 : count.index].id

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-nat-${count.index + 1}"
    }
  )
}

# ---------------------------------------------------------
# Private Application Route Tables
# ---------------------------------------------------------

resource "aws_route_table" "private_app" {
  count = var.az_count

  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-app-rt-${count.index + 1}"
    }
  )
}

resource "aws_route" "private_app_nat" {
  count = var.az_count

  route_table_id         = aws_route_table.private_app[count.index].id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.this[
    var.single_nat_gateway ? 0 : count.index
  ].id
}

resource "aws_route_table_association" "private_app" {
  count = var.az_count

  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app[count.index].id
}

# ---------------------------------------------------------
# Private Database Route Tables
# ---------------------------------------------------------

resource "aws_route_table" "private_db" {
  count = var.az_count

  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-db-rt-${count.index + 1}"
    }
  )
}

resource "aws_route_table_association" "private_db" {
  count = var.az_count

  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db[count.index].id
}