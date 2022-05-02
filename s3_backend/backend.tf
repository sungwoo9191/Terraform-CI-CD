variable "region" {
  default     = "ap-northeast-1"
  description = "버킷 생성 지역 입력"
}
# 대문자, 언더라인 안됨
variable "s3_state" {
  default     = "sw-tc-t"
  description = "sw-tc-t"
}

variable "s3_state_logs" {
  default     = "sw-tc-t-log"
  description = "ssw-tc-t-log"
}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# 프로필 변경
provider "aws" {
  #profile = "default" # 사용자폴더/.aws/credentials 수정필
  region = var.region
}

# terrafrom state 파일용 lock 테이블
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "TerraformStateLock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Terraform state 저장용 S3 버킷
resource "aws_s3_bucket" "terraform-state" {
  bucket = var.s3_state
  acl    = "private"
  versioning {
    enabled = true
  }

  tags = {
    Name = var.s3_state
  }
  
  lifecycle {
    prevent_destroy = true
  }

  logging {
    target_bucket = aws_s3_bucket.logs.id
    target_prefix = "log/"
  }
}

# 로그 저장용 버킷
resource "aws_s3_bucket" "logs" {
  bucket = var.s3_state_logs
  acl    = "log-delivery-write"
  tags = {
    Name = var.s3_state_logs
  }
}