resource "aws_rds_cluster" "main" {
    cluster_identifier = "main"
    database_name = "maindb"
    master_username = local.secret.username
    master_password = local.secret.password
    port = 5432
    engine = "aurora-postgresql"
    engine_version = "14.6"
    skip_final_snapshot = true
    tags = {
        Name = "main"
    }
}

resource "aws_rds_cluster_instance" "main" {
    identifier = "main"
    cluster_identifier = aws_rds_cluster.main.id
    instance_class = "db.t3.medium"
    engine = "aurora-postgresql"
    engine_version = "14.6"
    publicly_accessible = true
    tags = {
        Name = "main"
    }
}

