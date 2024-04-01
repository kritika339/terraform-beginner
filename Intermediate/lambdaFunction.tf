
data "archive_file" "lambda"{
type = "zip"
source_file = "${path.module}/src/lambda.py"
output_path = "lambda_function_src.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_src.zip"
  function_name = "Terraform_lab_intermediate_usecase"
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