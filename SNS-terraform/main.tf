resource "aws_sns_topic" "test_topic" {
    name = "test_topic"
    tags = {
        Name = "test_topic"
    }
}


resource "aws_sns_topic_subscription" "test_topic_subscription" {
    topic_arn = aws_sns_topic.test_topic.arn
    protocol  = "email"
    endpoint  = "dockerdevopa@gmail.com"
}

output "topic_arn" {
    value = aws_sns_topic.test_topic.arn
}