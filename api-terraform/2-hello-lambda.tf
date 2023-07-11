resource "aws_iam_role" "hello_lambda_exec" {
    name = "hello-lambda"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "hello_lambda_exec" {
    role       = aws_iam_role.hello_lambda_exec.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "hello" {
    function_name = "hello"
    s3_bucket = aws_s3_bucket.lambda_bucket.id
    s3_key = aws_s3_bucket_object.lambda_bucket.key
    handler = "function.handler"
    runtime = "nodejs14.x"
    role = aws_iam_role.hello_lambda_exec.arn

    source_code_hash = data.archive_file.lambda_hello.output_base64sha256
}

resource "aws_cloudwatch_log_group" "hello_lambda" {
    name = "/aws/lambda/${aws_lambda_function.hello.function_name}"
    retention_in_days = 14
}

data "archive_file" "lambda_hello" {
    type = "zip"
    source_dir = "${path.module}/hello"
    output_path = "${path.module}/hello.zip"
}

resource "aws_s3_bucket_object" "lambda_bucket" {
    bucket = aws_s3_bucket.lambda_bucket.id
    key = "hello.zip"
    source = data.archive_file.lambda_hello.output_path
    etag = filemd5(data.archive_file.lambda_hello.output_path)
}
