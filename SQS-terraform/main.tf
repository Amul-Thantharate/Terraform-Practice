resource "aws_sqs_queue" "terraform_queue" {
    name = "s3-event-notification-queue"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "sqs:SendMessage",
        "Resource": "arn:aws:sqs:*:*:s3-event-notification-queue",
        "Condition": {
            "ArnEquals": { "aws:SourceArn": "${aws_s3_bucket.bucket.arn}" }
        }
        }
    ]
}
POLICY
}

resource "random_string" "id" {
    length = "5"
    special = false
    upper  = false
}

resource "aws_s3_bucket" "bucket" {
    bucket = "mybucket-s3-g2-${random_string.id.result}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
    count = "${var.event_type  ? 1 : 0}"
    bucket  = "${aws_s3_bucket.bucket.id}"

    queue {
        queue_arn = "${aws_sqs_queue.terraform_queue.arn}"
        events = ["s3:ObjectCreated:*"]
    }
}