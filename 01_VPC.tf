# VPC 이름 변경
# cidr 확인

resource "aws_vpc" "VPC_01" {
  cidr_block                       = "10.0.0.0/16" # IPv4 CIDR 블록
  assign_generated_ipv6_cidr_block = "false"       # IPv6 CIDR 블록 여부: true or false
  instance_tenancy                 = "default"     # 테넌시

  tags = {
    Name = "VPC_${var.customer}_${var.set_code}" # 태그
  }
}

