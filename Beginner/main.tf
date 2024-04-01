terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.8"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-014992d032c40b60a"
  subnet_id     = "subnet-0cc5834c7961cc4ce"
  instance_type = "t2.micro"

  tags = {
    Name = "Batman"
  }
}