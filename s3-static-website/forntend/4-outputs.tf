output "bucket_arn" {
    value = aws_s3_bucket.bucket-name.arn
}

output "bucket_domain_name" {
    value = aws_s3_bucket.bucket-name.bucket_domain_name
}

output "bucket_regional_domain_name" {
    value = aws_s3_bucket.bucket-name.bucket_regional_domain_name
}

output "website_url" {
    description = "URL of the website"
    value = aws_s3_bucket_website_configuration.bucket-website.website_endpoint
}




