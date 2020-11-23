aws iam create-group --group-name devops
aws iam create-access-key --user-name devops
aws iam create-login-profile --user-name devops --password aStrongPassword!
aws iam create-virtual-mfa-device --virtual-mfa-device-name devops --outfile QRCode.png --bootstrap-method QRCodePNG
aws iam list-virtual-mfa-devices
aws iam enable-mfa-device --user-name devops --serial-number arn:aws:iam::xxxxx:mfa/devops --authentication-code1 123456 --authentication-code2 321654
aws ec2 create-key-pair --key-name devops

echo "-----BEGIN RSA PRIVATE KEY ..... \n-----END RSA PRIVATE KEY-----" > ~/.ssh/devops.pem
chmod 600 ~/.ssh/devops.pem

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSCodeDeployFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess --group-name devops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AutoScalingFullAccess --group-name devops

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name devops

```
An error occurred (LimitExceeded) when calling the AttachGroupPolicy operation: Cannot exceed quota for PoliciesPerGroup: 10

```

aws iam create-group --group-name devops-extension-1
aws iam add-user-to-group --user-name devops --group-name devops-extension-1

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name devops-extension-1
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonECS_FullAccess --group-name devops-extension-1

export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(aws configure get region)
echo "export ACCOUNT_ID=${ACCOUNT_ID}"
echo "export AWS_REGION=${AWS_REGION}"

brew update && brew install jq
brew install aws-iam-authenticator
brew install npm
npm install -g aws-cdk@1.30.0 --force
npm install -g typescript@latest

mkdir -p ~/aws/hands-on/
cd ~/aws/hands-on/
curl -O https://awsdemoworkshops.s3.us-east-2.amazonaws.com/cicd-eks-alb-bg-cdk-workshop/Downloads/archive-eks-alb-bg.tar.gz
tar -xzvf archive-eks-alb-bg.tar.gz



