// packer {
//   required_plugins {
//     amazon = {
//       version = ">= 1.0.8"
//       source  = "github.com/hashicorp/amazon"
//     }
//   }
// }



source "amazon-ebs" "hvr" {
  ami_name      = "hvr-${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]

  }
  ssh_username = "ec2-user"
  ssh_interface        = "session_manager"
  communicator         = "ssh"
  iam_instance_profile = "packer_profile"
}

build {
  name = "hvr"
  sources = [
    "source.amazon-ebs.hvr"
  ]
}

