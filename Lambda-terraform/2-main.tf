provider "archive" {}

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file = "welcome.py"
    output_path = "welcome.zip"
}
data "aws_iam_policy_document" "policy" {
    statement {
        sid    = ""
        effect = "Allow"
        principals {
        identifiers = ["lambda.amazonaws.com"]
        type        = "Service"
        }
        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "lambda_role" {
    name               = "lambda_role"
    assume_role_policy = data.aws_iam_policy_document.policy.json
}


resource "aws_lambda_function" "lambda" {
    function_name    = "test-function"
    filename         = data.archive_file.lambda_zip.output_path
    source_code_hash = data.archive_file.lambda_zip.output_base64sha256
    role            = aws_iam_role.lambda_role.arn
    handler         = "main.lambda_handler"
    runtime         = "python3.8"
}

