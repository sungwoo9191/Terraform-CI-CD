# subnet 이름 변경 필수
# 리전 cidr_block 확인

#ALB 2개
resource "aws_subnet" "Subnet_Public_Prod_ALB_AZ1_01" {
  vpc_id            = local.vpc_id_value # VPC
  cidr_block        = "10.0.1.0/25"      # IPv4 CIDR 블록
  availability_zone = "${var.region}a"   # 가용지역

  tags = {
    Name = "Subnet_Public_${var.set_code}_ALB_AZ1_01"
  }
}
resource "aws_subnet" "Subnet_Public_Prod_ALB_AZ2_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.1.128/25"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Subnet_Public_${var.set_code}_ALB_AZ2_01"
  }
}

#Bastion 1개
resource "aws_subnet" "Subnet_Public_Prod_Bastion_AZ1_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.2.0/25"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Subnet_Public_${var.set_code}_Bastion_AZ1_01"
  }
}


#NLB 2개
resource "aws_subnet" "Subnet_Private_Prod_NLB_AZ1_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.11.0/25"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Subnet_Private_${var.set_code}_NLB_AZ1_01"
  }
}
resource "aws_subnet" "Subnet_Private_Prod_NLB_AZ2_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.11.128/25"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Subnet_Private_${var.set_code}_NLB_AZ2_01"
  }
}


#WEB 2개
resource "aws_subnet" "Subnet_Private_Prod_WEB_AZ1_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.13.0/25"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Subnet_Private_${var.set_code}_WEB_AZ1_01"
  }
}
resource "aws_subnet" "Subnet_Private_Prod_WEB_AZ2_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.13.128/25"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Subnet_Private_${var.set_code}_WEB_AZ2_01"
  }
}


#WAS 2개
resource "aws_subnet" "Subnet_Private_Prod_WAS_AZ1_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.14.0/25"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Subnet_Private_${var.set_code}_WAS_AZ1_01"
  }
}
resource "aws_subnet" "Subnet_Private_Prod_WAS_AZ2_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.14.128/25"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Subnet_Private_${var.set_code}_WAS_AZ2_01"
  }
}



#DB 2개
resource "aws_subnet" "Subnet_Private_Prod_DB_AZ1_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.15.0/25"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Subnet_Private_${var.set_code}_DB_AZ1_01"
  }
}
resource "aws_subnet" "Subnet_Private_Prod_DB_AZ2_01" {
  vpc_id            = local.vpc_id_value
  cidr_block        = "10.0.15.128/25"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Subnet_Private_${var.set_code}_DB_AZ2_01"
  }
}

