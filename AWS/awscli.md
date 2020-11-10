# Common AWS CLI commands

```shell
aws iam create-group --group-name kops
```

```json
{
    "Group": {
        "Path": "/",
        "GroupName": "kops",
        "GroupId": "xxxxxxxxx",
        "Arn": "arn:aws:iam::xxxxxxxxxx:group/kops",
        "CreateDate": "2020-11-10T13:19:16Z"
    }
}
```

```shell
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops
```

```shell
aws iam create-user --user-name kops
```

```json
{
    "User": {
        "Path": "/",
        "UserName": "kops",
        "UserId": "xxxxxxxxx",
        "Arn": "arn:aws:iam::xxxxxxxxx:user/kops",
        "CreateDate": "2020-11-10T13:38:52Z"
    }
}
```

```shell
aws iam create-access-key --user-name kops
```

```json
{
    "AccessKey": {
        "UserName": "kops",
        "AccessKeyId": "xxxxxxxxxx"
        "Status": "Active",
        "SecretAccessKey": "xxxxxxxxx"
        "CreateDate": "2020-11-10T13:41:05Z"
    }
}
```

```shell
aws iam list-users
aws configure
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
```

```shell
aws s3api create-bucket \
--bucket dev-k8s-cluster-kops \
--region eu-west-3 \
--create-bucket-configuration LocationConstraint=eu-west-3

aws s3api put-bucket-versioning \
--bucket dev-k8s-cluster-kops \
--versioning-configuration Status=Enabled
```

```shell
kops create cluster \  
--zones ${ZONES} \
--master-size t2.micro \
--master-volume-size 10 \
--master-zones eu-west-3a \
--master-count 1 \
--node-count 2 \
--node-size t2.micro \
--node-volume-size 10 \
--networking weave \
--topology private \
${NAME}
```

```shell
kops update cluster --name aws-k8s-cluster.k8s.local --yes
```

```shell
kops validate cluster --wait 10m

NSTANCE GROUPS
NAME			ROLE	MACHINETYPE	MIN	MAX	SUBNETS
master-eu-west-3a	Master	t2.micro	1	1	eu-west-3a
nodes			Node	t2.micro	2	2	eu-west-3a,eu-west-3b,eu-west-3c

NODE STATUS
NAME						ROLE	READY
ip-172-20-113-173.eu-west-3.compute.internal	node	True
ip-172-20-47-138.eu-west-3.compute.internal	node	True
ip-172-20-62-205.eu-west-3.compute.internal	master	True

Your cluster aws-k8s-cluster.k8s.local is ready
```

We can add a bastion in case we need to access via SSH to our nodes. 

We need bastion because our nodes are in private subnets.

