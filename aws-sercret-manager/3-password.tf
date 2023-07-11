resource "random_password" "password" {
    length = 8 
    special = true
    override_special = "_%@"
}


resource "aws_secretsmanager_secret" "secretmasaterdb" {
    name = "secretmaster"
}

resource "aws_secretsmanager_secret_version" "sversion" {
    secret_id = aws_secretsmanager_secret.secretmasaterdb.id
    secret_string = <<EOF
    {
        "username": "masteruser",
        "password": "${random_password.password.result}"
    }
    EOF
}

data "aws_secretsmanager_secret_version" "creds" {
    secret_id = data.aws_secretsmanager_secret.secretmasaterdb.arn
}

data "aws_secretsmanager_secret" "secretmasaterdb" {
    arn = aws_secretsmanager_secret.secretmasaterdb.arn
}

locals {
    secret = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}
