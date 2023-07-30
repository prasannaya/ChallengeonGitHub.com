variable "region" {
    type = string
    default = "us-west-2"
}

variable "ami" {
    type = string
    default = "ami-03f65b8614a860c29"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "azs" {
    type = list(string)
    default = ["us-west-2a"] 
}

