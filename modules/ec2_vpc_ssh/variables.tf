variable "region" {
  description = "Define what region the instance will be deployed"
  default = "us-east-1"
}

variable "zone" {
  description = "Define what zone the instance will be deployed"
  default = "us-east-1a"
}

variable "name" {
  description = "Name of the Application"
  default = "server-1"
}

variable "ami" {
  description = "AWS AMI to be used "
  default = "ami-0557a15b87f6559cf"
}

variable "ami_key_name" {
  description = "Key pair name present on given aws-region to associate with instance."
  default = "test"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default = "t2.micro"
}