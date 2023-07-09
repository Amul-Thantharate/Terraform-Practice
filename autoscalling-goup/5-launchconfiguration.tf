resource "aws_launch_configuration" "aws_autoscale_conf" {
    name = "web-config"
    image_id = var.aws_ami
    instance_type = var.aws_instance_type
    key_name = var.aws_key_name
    security_groups = [aws_security_group.allow_trafic.id]

}

resource "aws_autoscaling_group" "mygroup" {
    availability_zones = ["us-east-1a"]
    name = "autoscale-group"
    max_size = 2
    min_size = 1
    health_check_grace_period = 30
    health_check_type = "EC2"
    force_delete = true
    termination_policies = ["OldestInstance"]
    launch_configuration = aws_launch_configuration.aws_autoscale_conf.name
}

resource "aws_autoscaling_schedule" "mygroup_schedule" {

    scheduled_action_name = "autoscale-schedule"
    min_size = 1
    max_size = 2
    desired_capacity = 1
    start_time = "2023-07-10T12:00:00Z"
    autoscaling_group_name = aws_autoscaling_group.mygroup.name
}

resource "aws_autoscaling_policy" "mygroup_policy" {
    name = "autoscale-policy-name"
    scaling_adjustment = 2
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.mygroup.name

}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alaram" {
    alarm_name = "web-cpu-alaram"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = 10
    alarm_description = "This metric monitors ec2 cpu utilization"
    alarm_actions = [
        "${aws_autoscaling_policy.mygroup_policy.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.mygroup.name}"
    }

}
