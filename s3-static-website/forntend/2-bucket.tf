resource "random_pet" "bucket_name" {
    length    = 2
    prefix = "s3-hosting-"
}

resource "aws_s3_bucket" "bucket-name" {
    bucket = random_pet.bucket_name.id
    force_destroy = true
    tags = {
        Name = random_pet.bucket_name.id
    }
}

