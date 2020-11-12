# Create cluster from scratch

## 1- Using kops

Kops, or Kubernetes CLI for Operations, is used to manage and maintain k8s clusters.  
By manage, I mean: create, update and delete clusters.  
By maintain, I mean regoular operations, such as upgrading, that are required to keep k8s cluster operational in a production environemnt.  
By creating a cluster, I mean provision the underlying services (compute, network, storage ..etc) required for a k8s cluster to operate.  
By updating a cluster, I mean changing services characteristics and applying it to an existing (running or not) cluster.  
It offers of course other capabilities, but in this document, I will describe the basics.  

### AWS

Kops officially supports AWS.
The steps we will follow are described here:

- <https://kops.sigs.k8s.io/getting_started/aws/>
- <https://zero-to-jupyterhub.readthedocs.io/en/latest/kubernetes/amazon/step-zero-aws.html>

#### Set up environment

- Install AWS CLI

```shell
sudo apt install awscli
```

Make sure to enable autocomplete, which is of a great help. Add commands to profile (for example at the end of ~/.zshrc and source it.)

```shell
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
```

- Install KOPS

```shell
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-darwin-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/
```

- Install kubectl

```shell
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/
```

- Provide credentials and default region

```shell
export AWS_ACCESS_KEY_ID=<ACCESS KEY>
export AWS_SECRET_ACCESS_KEY=<SECRET>
export AWS_DEFAULT_REGION=<Default region>
```

- Create IAM group named kops

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

- Give IAM group kops full access on required services

```shell
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops
```

- Create IAM user named kops and add it to kops group

```shell
aws iam create-user --user-name kops
aws iam add-user-to-group --user-name kops --group-name kops
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

- Generate access key for kops user 

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

- Use kops accees key
  
```shell
aws iam list-users
aws configure
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
```

- Create a versioned bucket to hold state of the cluster

```shell
aws s3api create-bucket \
--bucket dev-k8s-cluster-kops \
--region eu-west-3 \
--create-bucket-configuration LocationConstraint=eu-west-3

aws s3api put-bucket-versioning \
--bucket dev-k8s-cluster-kops \
--versioning-configuration Status=Enabled

export KOPS_STATE_STORE=s3://dev-k8s-cluster-kops
```

- Define name and zones of the cluster as environment variables

```shell
export ZONES="eu-west-3a,eu-west-3b,eu-west-3c"
export NAME="aws-k8s-cluster.k8s.local"
```

- Create the cluster configuration 

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

- Build the cluster, which actually will call to AWS and creates all resources 

```shell
kops update cluster --name aws-k8s-cluster.k8s.local --yes
```

- Validate the cluster creation

```shell
kops validate cluster --wait 10m
```

INSTANCE GROUPS

| Name | Role | MachineType | Max | Min | Subnets |
|------|:------:|:-------------:|:-----:|:-----:|---------|
| master-eu-west-3a | Master | t2.micro | 1 | 1 | eu-west-3a |
| nodes | Node | t2.micro | 2 | 2 | eu-west-3a,eu-west-3b,eu-west-3c |

NODE STATUS

| NAME | ROLE | READY |
|------|:------:|:-------:|
| ip-172-20-113-173.eu-west-3.compute.internal | node | True |
| ip-172-20-47-138.eu-west-3.compute.internal | node | True |
| ip-172-20-62-205.eu-west-3.compute.internal | master | True |

Your cluster aws-k8s-cluster.k8s.local is ready

- Use the cluster

```shell
kubectl get nodes
kubectl get pods --all-namespaces
kubectl -n kube-system get po
kubectl cluster-info
```

We may add a bastion in case we need to access via SSH to our nodes.  
We need bastion because our nodes are in private subnets.  

## 2- From scratch

- <https://www.linuxschoolonline.com/how-to-set-up-kubernetes-1-16-on-aws-from-scratch/>
- <https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04>
