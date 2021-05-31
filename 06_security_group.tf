# WEB to WEB, WAS to WAS 같은 것은 추후 직접 추가해야됨.
/*해당페이지는
  
  SG_(고객사)_(set_code)_Bastion
  SG_(고객사)_(set_code)_ALB
  SG_(고객사)_(set_code)_WEB
  SG_(고객사)_(set_code)_WAS
  SG_(고객사)_(set_code)_DB
  
  를 사용하면, 수정이 필요없음.
  # 인풋, 아웃풋 포트 확인
  # ip 확인(현재 183.98.156.109/32)
  # DB 포트 확인 (현재 3306)
  */


#SG_Starlabs_Prod_Bastion
#SG_*_*_Bastion 양식이면 수정x
#인풋, 아웃풋 포트 확인
resource "aws_security_group" "Bastion" {
  name        = "SG_${var.customer}_${var.set_code}_Bastion"
  description = "SG_${var.customer}_${var.set_code}_Bastion"
  vpc_id      = aws_vpc.VPC_01.id

  ingress {
    description = "${var.customer} to Bastion SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["183.98.156.109/32"]
  }
  ingress {
    description = "${var.customer} to EC2 SSH"
    from_port   = 2201
    to_port     = 2204
    protocol    = "tcp"
    cidr_blocks = ["183.98.156.109/32"]
  }
  ingress {
    description = "${var.customer} to Bastion RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["183.98.156.109/32"]
  }

  egress {
    description = "External Connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_${var.customer}_${var.set_code}_Bastion"
  }
}

#SG_Starlabs_Prod_ALB
#SG_*_*_ALB 양식이면 수정x
#인풋, 아웃풋 포트만 확인
resource "aws_security_group" "ALB" {
  name        = "SG_${var.customer}_${var.set_code}_ALB"
  description = "SG_${var.customer}_${var.set_code}_ALB"
  vpc_id      = aws_vpc.VPC_01.id

  ingress {
    description = "Customer to HTTP Service"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Customer to HTTPS Service"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "External Connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_${var.customer}_${var.set_code}_ALB"
  }
}

#SG_Starlabs_Prod_WEB
#SG_*_*_WEB 양식이면 수정x
#인풋, 아웃풋 포트만 확인
resource "aws_security_group" "WEB" {
  name        = "SG_${var.customer}_${var.set_code}_WEB"
  description = "SG_${var.customer}_${var.set_code}_WEB"
  vpc_id      = aws_vpc.VPC_01.id

  ingress {
    description     = "Bastion to SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.Bastion.id]
  }
  ingress {
    description     = "ALB to HTTP Service"
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.ALB.id]
  }
  /*
  ingress {
    description     = "ALB to HTTPs Service"
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    security_groups = [aws_security_group.ALB.id]
  }
  */
  egress {
    description = "External Connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_${var.customer}_${var.set_code}_WEB"
  }
}

#SG_Starlabs_Prod_WAS
#SG_*_*_WAS 양식이면 수정x
#인풋, 아웃풋 포트만 확인
resource "aws_security_group" "WAS" {
  name        = "SG_${var.customer}_${var.set_code}_WAS"
  description = "SG_${var.customer}_${var.set_code}_WAS"
  vpc_id      = aws_vpc.VPC_01.id

  ingress {
    description     = "Bastion to SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.Bastion.id]
  }
  /*
  ingress {
    description     = "WEB to WAS"
    from_port       = var.private_port
    to_port         = var.private_port
    protocol        = "TCP"
    security_groups = [aws_security_group.WEB.id]
  }
  */
  ingress {
    description = "NLB to WAS"
    from_port   = var.private_port
    to_port     = var.private_port
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "External Connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_${var.customer}_${var.set_code}_WAS"
  }
}

#SG_Starlabs_Prod_DB
#SG_*_*_DB 양식이면 수정x
#DB 포트 확인
resource "aws_security_group" "DB" {
  name        = "SG_${var.customer}_${var.set_code}_DB"
  description = "SG_${var.customer}_${var.set_code}_DB"
  vpc_id      = aws_vpc.VPC_01.id

  ingress {
    description     = "WAS to DB"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "TCP"
    security_groups = [aws_security_group.WAS.id]
  }

  tags = {
    Name = "SG_${var.customer}_${var.set_code}_DB"
  }
}