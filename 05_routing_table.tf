# 퍼블릭 라우팅 테이블
# 이름 확인 필수
resource "aws_route_table" "RT_Public_Prod" {
  vpc_id = local.vpc_id_value

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.IG.id
  }

  tags = {
    Name = "RT_Public_${var.set_code}"
  }
}

# 프라이빗 라우팅 테이블
# 이름 확인 필수
resource "aws_route_table" "RT_Private_Prod" {
  vpc_id = local.vpc_id_value

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = local.NAT.id
  }

  tags = {
    Name = "RT_Private_${var.set_code}"
  }
}

# 퍼블릭 라우팅 테이블 이름 확인
# 서브넷 목록 리스트를 라이팅 테이블로 엮음
resource "aws_route_table_association" "Public_Subnet" {
  count          = length(local.public_subnet.name) # 00_locals.tf 쪽 확인
  subnet_id      = local.public_subnet.name[count.index].id
  route_table_id = aws_route_table.RT_Public_Prod.id
}

# 프라이빗 라우팅 테이블 이름 확인
resource "aws_route_table_association" "Private_Subnet" {
  count          = length(local.private_subnet.name) # 00_locals.tf 쪽 확인
  subnet_id      = local.private_subnet.name[count.index].id
  route_table_id = aws_route_table.RT_Private_Prod.id
}
