module "template_file" {
    source = "hashicorp/dir/template"
    base_dir = "D:\\Lambda\\s3-static-website\\www"    
}


resource "aws_s3_bucket_public_access_block" "bucket-public" {
    bucket = aws_s3_bucket.bucket-name.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
    bucket = aws_s3_bucket.bucket-name.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid = "PublicReadGetObject"
                Effect = "Allow"
                Principal = "*"
                Action = [
                    "s3:GetObject"
                ]
                Resource = [
                    "${aws_s3_bucket.bucket-name.arn}/*"
                ]
            }
        ]
    })
}

resource "aws_s3_bucket_website_configuration" "bucket-website" {
    bucket = aws_s3_bucket.bucket-name.id

    index_document {
        suffix = "index.html"
        
    }
}

resource "aws_s3_bucket_object" "hosting_bucket" {
    bucket = aws_s3_bucket.bucket-name.id
    for_each = module.template_file.files

    key = each.key
    content_type = each.value.content_type

    source = each.value.source_path
    content = each.value.content

    etag = each.value.digests.md5
}



