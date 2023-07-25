# ChallengeonGitHub.com
I Created two Linux Virtual Machines (2 EC2 instances in AWS,) one for Ansible Control Node and one for Node1. 

Created devops user on both EC2 instances with password. 

Ansible control Node: 

Node1: 

Ensure the devops user has sudo permissions in both VM’s. 

Created a ssh-keypair on Ansible control Node. 

Copied the public key from Ansible control node to Node1 and logged in into Node1 from ansible control node without password. 


Install ansible on Ansible Control Node: 

Created an inventory with one node i.e. (private ip of Node1) 

I wrote the ansible playbook to install Apache webserver and I can access the webserver.  

With Apache webserver, I will not be able create a secure webserver because I can't add SSL certificate. So, moving on to nginx webserver which has ability to provide https server capabilities with more stability and performance. 
 

I used a self-signed SSL certificate for testing purposes, and I can access nginx webserver through https.  
 

I wrote automated test cases for HealthCheck, Security check and Performance check.  

Health check: 

Whether my web server is up and running and giving desired output Hello-world.  

I used self-signed SSL Certificate that’s why I got below output  

so kept validate_certs: no 

Security check: 

Testing whether my webserver is redirecting from http to https:  

Performance check: 

Checking time to response from the webserver. 

I also use auto scaling and load balancing for high availability and scalability of web server, and I prefer Terraform for creating auto scaling groups Load balancers. 
