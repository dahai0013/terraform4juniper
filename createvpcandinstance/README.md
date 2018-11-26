# terraform4juniper


Create and account on AWS ( to log into the AWS console )
create key-pair to log into the AWS instance ( VM)


1- clone the .git
2- cd createvpcandinstance
3- terraform init
4- terraform plan
5- terraform apply  ( enter "yes" )
6- get public IP@ and key-pai name ( should be known! )

.\terraform.exe show | grep public
  associate_public_ip_address = true
  public_dns = ec2-18-188-102-65.us-east-2.compute.amazonaws.com
  public_ip = 18.188.102.65
  map_public_ip_on_launch = false

.\terraform.exe show | grep key
  key_name = terraformkeypair_ohio

7- ssh ubuntu@<public IP@>  -i  terraformkeypair_ohio.perm
7- when finish:  terraform destroy  ( enter "yes" )

