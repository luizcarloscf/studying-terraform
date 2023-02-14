output "dev_instance_ip" {
  description = "Public IP of the EC2 instance"
  value = "${module.ec2_vpc_ssh.dev_instance_ip}"
}

output "dev_instance_id" {
  description = "ID of the EC2 instance"
  value       = "${module.ec2_vpc_ssh.dev_instance_id}"
}
