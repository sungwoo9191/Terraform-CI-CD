/*
#DB 서브넷 그룹
resource "aws_db_subnet_group" "RDS_01" {
  name        = var.db_subnet_group_name
  description = "DBSubnet_Private_${var.set_code}_DB"
  subnet_ids  = [aws_subnet.Private_DB_AZ1_01.id, aws_subnet.Private_DB_AZ2_01.id]

  tags = {
    Name = "DBSubnet_Private_${var.set_code}_DB"
  }
}

# MySQL 전용 utf-8 파라미터
# MySQL 아니면 주석처리
resource "aws_db_parameter_group" "utf8" {
  name        = "${var.db_engine}-utf8"
  description = "${var.db_engine}-${var.db_version}-utf8"
  family      = "${var.db_engine}${var.db_version}"

  tags = {
    Name = "${var.db_engine}-${var.db_version}-utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
  parameter {
    name  = "character_set_connection"
    value = "utf8"
  }
  parameter {
    name  = "character_set_database"
    value = "utf8"
  }
  parameter {
    name  = "character_set_filesystem"
    value = "utf8"
  }
  parameter {
    name  = "character_set_results"
    value = "utf8"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
  parameter {
    name  = "collation_connection"
    value = "utf8_general_ci"
  }
  parameter {
    name  = "collation_server"
    value = "utf8_general_ci"
  }
}
*/