terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}


# 프로필 변경
provider "aws" {
  #profile = "default" # 사용자폴더/.aws/credentials 수정필
  region     = var.region
}