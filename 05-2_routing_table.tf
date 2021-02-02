# 퍼블릭 라우팅 테이블
resource "aws_route_table" "RT_Public" {
  vpc_id = aws_vpc.VPC_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }

  tags = {
    Name = "RT_Public_${var.set_code}"
  }
}

# 프라이빗 라우팅 테이블
resource "aws_route_table" "RT_Private" {
  vpc_id = aws_vpc.VPC_01.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "RT_Private_${var.set_code}"
  }
}

# 퍼블릭 라우팅 테이블 이름 확인
# 서브넷 목록 리스트를 라이팅 테이블로 엮음
resource "aws_route_table_association" "Public_Subnet" {
  count          = length(local.public_subnets.name) # 00_locals.tf 쪽 확인
  subnet_id      = local.public_subnets.name[count.index].id
  route_table_id = aws_route_table.RT_Public.id
}

# 프라이빗 라우팅 테이블 이름 확인
resource "aws_route_table_association" "Private_Subnet" {
  count          = length(local.private_subnets.name) # 00_locals.tf 쪽 확인
  subnet_id      = local.private_subnets.name[count.index].id
  route_table_id = aws_route_table.RT_Private.id
}
