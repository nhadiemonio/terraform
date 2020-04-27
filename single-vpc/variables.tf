variable "key-pairs-vars" {
  type = map
  default = {
    user1 = {
      key_name = "user1"
      pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0k4xVUwlk9I+ZxHb4w1YJVxgMgpuWyB57ReZQ7Q15si0jQ63zxlVBg3LSOi/jy1P2HEKA4v6v8zkLpAKa0LA8+MmS7sik5ShYx1vNelGsaUv30JwiJDR0NMWYR9H9JfyopbJ0lcqDETvQEUnseriycx8WyC1Q9uUJAl0sYdseG7dtrXBUWviqYCoKLEer7nQ5FP4eDUQWBLxV4ys4CVdvkqRSeXgslQHaBnTUP4ReUC8iSyAHFAo26UT0JuMdmVNhsydqEedwNBBjWxJTrjCX/EvcZDIkstvW9IVo7xBmUOBp/DNQbFWw/Lt/x1BrR1CyGnGNpV9wwHLECspTrGUl user1"
    }
  }
}

variable "dev-vpc-vars" {
  default = {
    cidr = "10.128.0.0/16"
    name = "public-vpc"
  }
}

variable "public-subnet-vars" {
  default = {
    subnet = "10.128.254.0/24"
    az = "ap-southeast-2a"
    name = "public-subnet-a"
  }
}

variable "frontend-subnet-vars" {
  default = {
      subnet = "10.128.128.0/24"
      az = "ap-southeast-2a"
      name = "frontend-subnet-a"
  }
}

variable "bastion-host" {
  default = {
    internal_ip = "10.128.254.254"
    ami_id = "ami-0a1a4d97d4af3009b"
    instance_type = "t2.micro"
    key_name = "user1"
  }
}

variable "web-host" {
  default = {
    ami_id = "ami-0a1a4d97d4af3009b"
    instance_type = "t2.micro"
    key_name = "user1"
  }
}
