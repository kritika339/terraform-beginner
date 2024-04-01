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
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-014992d032c40b60a"
  subnet_id     = "subnet-0cc5834c7961cc4ce"
  instance_type = "t2.micro"

  tags = {
    Name = "Robin"
  }
}
  
resource "aws_s3_bucket" "firstbucket"{
	bucket ="test-kritika3345677"
	acl = "private"
	tags ={
	name ="first bucket"
	}
	versioning {
	enabled = true
	}
}

data "archive_file" "lambda"{
type = "zip"
source_file = "${path.module}/src/lambda.py"
output_path = "lambda_function_src.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_src.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"
	handler       = "lambda_handler"

  environment {
    variables = {
      foo = "bar"
    }
  }
}