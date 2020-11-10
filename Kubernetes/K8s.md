# Create cluster from scratch

## Using kops

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

## From scratch 

- <https://www.linuxschoolonline.com/how-to-set-up-kubernetes-1-16-on-aws-from-scratch/>
- <https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04>

