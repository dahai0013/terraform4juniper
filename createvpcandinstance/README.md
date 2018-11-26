# terraform4juniper


Create and account on AWS ( to log into the AWS console )
create key-pair to log into the AWS instance ( VM)


1- clone the .git
2- cd createvpcandinstance
3- terraform init
4- terraform plan
5- terraform apply  ( enter "yes" )
6- terraform show | grep public
7- ssh ubuntu@<public IP@>
7- when finish:  terraform destroy  ( enter "yes" )

