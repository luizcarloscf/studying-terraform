module "ec2_vpc_ssh" {
  source        = "../../modules/ec2_vpc_ssh"
  region        = "${var.region}"
  zone          = "${var.zone}"
  instance_type = "${var.instance_type}"
  name          = "${var.name}"
  ami           = "${var.ami}"
  ami_key_name  = "${var.ami_key_name}"
}