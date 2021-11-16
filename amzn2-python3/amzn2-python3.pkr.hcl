packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "instance_type" {
  type    = string
  default = "amzn2-python3"
}

variable "ami_prefix" {
  type    = string
  default = "amzn2-python3"
}

variable "architecture" {
  type    = string
  default = "arm64"
}

variable "region" {
  type    = string
  default = "us-west-2"
}

source "amazon-ebs" "amzn2" {
  profile = "varokas-chuladb-admin"
  ami_name      = "${var.ami_prefix}-${var.architecture}-${var.region}"
  instance_type = "t4g.micro"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name           = "amzn2-ami-hvm-*"
      architecture   = "${var.architecture}"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"
}

build {
  name    = "amzn2"
  sources = [
    "source.amazon-ebs.amzn2"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum groupinstall -y \"Development Tools\"",
      "sudo yum install -y python3",
      "sudo yum install -y python3-devel",
      "sudo amazon-linux-extras install -y docker",
    ]
  }

  provisioner "shell" {
    inline = ["echo This provisioner runs last"]
  }
}
