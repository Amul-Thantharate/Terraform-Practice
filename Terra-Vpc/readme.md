\*\*\*\* PROJECT NAME: Deploying a website on ec2 instace using terraform \*\*\*\*
--> [ A ] Main Task

- [ 1 ] To Create Vpc
- [ 2 ] To Create Subnet (Public and Private)
- [ 3 ] To Create Security Group
- [ 4 ] To create elastic ip
- [ 5 ] To create Nat Gateway
- [ 6 ] To create Internet Gateway
- [ 7 ] To create Route Table
- [ 8 ] To create Route Table Association
- [ 9 ] Using Default key pair
- [ 10 ] To create ec2 instance
- [ 11 ] To create ebs volume
- [ 12 ] To attach ebs volume to ec2 instance
- [ 13 ] To Deploy website on ec2 instance using httpd server
- [ 14 ] To create snapshot of ec2 instance and create ami image of it and launch new ec2 instance using that ami image and copy ami image to another region using aws cli command and create new ec2 instance using that ami image
- [ 15 ] To create a bash script for to install httpd server and deploy website on ec2 instance using that bash script
  user_data = file("script.sh")
