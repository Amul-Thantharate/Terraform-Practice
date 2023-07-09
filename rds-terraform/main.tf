resource "aws_default_vpc" "default" {
    tags = {
        Name = "Default VPC"
    }
}

data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_default_subnet" "subnet_az1" {
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_default_subnet" "subnet_az2" {
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_default_subnet" "subnet_az3" {
    availability_zone = "${data.aws_availability_zones.available.names[2]}"
}

resource "aws_security_group" "web-server" {
    name = "web-server"
    description = "Allow inbound traffic"
    vpc_id = aws_default_vpc.default.id
    dynamic "ingress" {
        for_each = var.ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
    }
}
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "web-server"
    }
}

resource "aws_security_group" "data-base" {
    name  = "data-base"
    description = "Allow inbound traffic"
    vpc_id = aws_default_vpc.default.id
    dynamic "ingress" {
        for_each = var.ports_database
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
}
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "data-base"
    }
}

resource "aws_db_subnet_group" "database_subnet_group" {
    name         =  "database_subnet_group"
    subnet_ids   =  [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id, aws_default_subnet.subnet_az3.id]
    description  =  "database_subnet_group"
    tags   = {
        Name = "database_subnet_group"
    }
}


resource "aws_db_instance" "database" {
    allocated_storage    = 100
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0.31"
    instance_class       = "db.t2.micro"
    identifier           = "terraform-database-rds"
    username             = "admin"
    password             = "admin123"
    multi_az = false
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
    vpc_security_group_ids = [aws_security_group.data-base.id]
    skip_final_snapshot = true
    tags = {
        Name = "database"
    }
}