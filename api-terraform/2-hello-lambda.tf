resource "aws_iam_role" "hello_lambda_exec" {
    name = "hello-lambda"
    assume_role_policy = <<EOF
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
EOF
}

resource "aws_iam_role_policy_attachment" "hello-lambda" {
    role = aws_iam_role.hello-lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "hello" {
    function_name = "hello"

    s3_bucket = aws_s3_bucket.lambda_bucket.id
    s3_key =  aws_s3_bucket.lambda_bucket.key 

    runtime = "nodejs12.x"
    handler = "function.handler"

    source_code_hash = data.archive_file.lambad_hello.output_base64sha256
    role = aws_iam_role.hello-lambda.arn
}