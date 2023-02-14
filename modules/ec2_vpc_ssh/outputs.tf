output "dev_instance_ip" {
  description = "Public IP of the EC2 instance"
  value = "${aws_instance.dev_ec2_instance.public_ip}"
}

output "dev_instance_id" {
  description = "ID of the EC2 instance"
  value       = "${aws_instance.dev_ec2_instance.id}"
}
