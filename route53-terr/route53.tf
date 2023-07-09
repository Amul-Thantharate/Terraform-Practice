resource "aws_route53_zone" "easy_aws" {
    name = "hop-ki-server.live"

    tags = {
    Environment = "dev"
    }
}

resource "aws_route53_record" "www" {
    zone_id = aws_route53_zone.easy_aws.zone_id
    name    = "www.hop-ki-server.live"
    type    = "A"
    ttl     = "300"
    records = [aws_eip.eip.public_ip]
}

output "name_server"{
    value=aws_route53_zone.easy_aws.name_servers
}