provider "aws" {
    region = var.region     
}

resource "aws_security_group" "web" {
    name_prefix = "web-sg"
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_launch_template" "server" {
    name_prefix = "web-lt"
    image_id = var.ami
    instance_type = var.instance_type

    block_device_mappings {
      device_name = "/dev/xvda"
        ebs {
          volume_size = 8
          volume_type = "gp2"
        }
    }
  
    user_data = base64encode(<<-EOF
                #!/bin/bash
                echo "Hello World" > index.html
                nohup python -m SimpleHTTPServer 80 &
                EOF
                )
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "server" {
    name_prefix = "web-asg"
    launch_template {
        id = aws_launch_template.server.id
        version = "$Latest"
    }
    min_size  = 2
    max_size = 4
    desired_capacity = 2
    vpc_zone_identifier = ["subnet-003890d780c6ce354"]

    tag {
        key = "Name"
        value = "Webserver"
        propagate_at_launch = true
    }
}

resource  "aws_elb" "server" {
    name = "web-elb"
    security_groups = [aws_security_group.web.id]
    availability_zones = ["us-west-2a"] 

    health_check {
        target = "HTTP:80/"
        interval = 30
        timeout = 5
        unhealthy_threshold = 5
        healthy_threshold   = 2
    }

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    instances = aws_instance.server.*.id

}

resource "aws_instance" "server" {
    ami = var.ami
    instance_type = var.instance_type
    count = aws_autoscaling_group.server.desired_capacity
}
