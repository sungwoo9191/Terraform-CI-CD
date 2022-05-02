# 백엔드 리전 꼭 확인
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "sw-tc-t" # 백엔드 S3 이름 ./s3_backend/backend.tf 참고
    key            = "path/terraform.tfstate"     # 키 저장소
    region         = "ap-northeast-1"             # S3 저장소 리전 ./s3_backend/backend.tf 참고
    encrypt        = true                         # 암호화
    dynamodb_table = "TerraformStateLock"         # 중복 접근 제어 ./s3_backend/backend.tf 참고
  }
}

# 프로필 변경
provider "aws" {
  profile = "default" # 사용자폴더/.aws/credentials 수정필
  region  = var.region
}