# AWS + Terraform + CircleCI 연동

```
Infrastructure as Code, 즉 IaC로 AWS 클라우드를 코드로 관리합니다.
```

## 테라폼 AWS 자동화 구축 CI/CD 파이프라인 적용

![top](https://user-images.githubusercontent.com/62891711/106543968-1dfc6e80-654a-11eb-9ea3-1ba4a96f6494.png)

테라폼으로 AWS의 VPC, EIP, EC2 WEB 2개, WAS 2개, DB 1개, NLB, ALB등을 구축하여 간단한 웹서버를 자동화하는 DevOps를 구현해보았습니다.

## S3 백엔드

![22](https://user-images.githubusercontent.com/62891711/114357129-55237780-9bac-11eb-9ec5-0e997dd4edd3.png)

만에 하나 여러 사람이 테라폼 적용을 동시에 하게 되어도 dynamodb Lock 테이블로 tfstate 파일에 접근을 제한하여 Terraform으로 인한 오류를 미연에 방지합니다.

## 구성도

![33](https://user-images.githubusercontent.com/62891711/114353416-f4923b80-9ba7-11eb-91cc-c8bad7e69e5f.png)
