# dtic-sample-infra
![packer-logo](https://i.pinimg.com/originals/f4/54/15/f45415270449af33c39dcb1e8af5a62a.png)

Project with terraform modules requested by [dtic-sample-app](https://github.com/aleroxac/dtic-sample-app)



## Resources
- [x] A complete VPC on AWS; with public and private subnets and a NAT Gateway
- [x] Random Passwords for PostgreSQL and Redis
- [x] Secrets on AWS Secrets Manager for PostgreSQL and Redis passwords
- [x] Security Groups for PostgreSQL and Redis
- [x] One Elasticache Redis instance
- [x] One RDS PostgreSQL instance
- [x] One S3 bucket
- [x] IAM Roles for the EKS cluster and EKS node groups
- [x] One EKS cluster
- [x] Two EKS node groups
- [x] Helmcharts for ingress-nginx and cert-manager
- [x] Kubernetes manifests for the cert-manager ClusterIssuers



## What do you need to do before use the modules?
* Create an [AWS account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html)
* Create an [AWS IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console) and download the CSV with your credentials
* Create a [S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html) to store your [statefile](https://www.terraform.io/docs/language/settings/backends/s3.html)



## Setup to run manually
``` shell
## Installing the requirements
PKGMAN=$([[ "${OS_TYPE}" == "linux" ]] && echo "sudo apt" || echo brew)
${PKGMAN} install wget unzip graphviz

## Downloading and installing the terraform locally
TF_VERSION="1.12.2"
OS_TYPE=$(uname -s | tr "[A-Z]" "[a-z]")
OS_ARCH=$([[ $(uname -m) =~ "x86_64" ]] && echo "amd64" || echo "${OS_ARCH}")
wget -P /tmp "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${OS_TYPE}_${OS_ARCH}.zip"
unzip /tmp/terraform*.zip
sudo mv /tmp/terraform /usr/local/bin

## Installing python3, pip3 and awscli
PKGMAN=$([[ "${OS_TYPE}" == "linux" ]] && echo "sudo apt" || echo brew)
${PKGMAN} install python3 python3-pip graphviz
sudo pip install awscli

## Setting up the awscli - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html
aws configure

## IMPORTANT: Please, read the README.md files on each terraform modules before run the commands bellow.
## Running the terraform code; without makefile
terraform init
terraform fmt
terraform validate
terraform workspace new dev
terraform workspace select dev
terraform plan -out plan.out
terraform apply plan.out

## IMPORTANT: Please, read the README.md files on each terraform modules before run the commands bellow.
## Running the terraform code; with makefile
export TF_VERSION="1.12.2"
export TF_DOCKER="false"
export ENV="dev"
make install
make init
make fmt
make validate
make ws-create
make ws-select
make plan
make apply
```


## Setup to run via docker
``` shell
export TF_VERSION="1.12.2"
export TF_DOCKER="true"
export ENV="dev"

## IMPORTANT: Please, read the README.md files on each terraform modules before run the commands bellow.
make install
make init
make fmt
make validate
make ws-create
make ws-select
make plan
make apply
```



## Modules
* [vpc](terraform/modules/aws/vpc)
* [random_password](terraform/modules/random_password)
* [secrets_manager](terraform/modules/aws/secrets_manager)
* [sg](terraform/modules/aws/sg)
* [elasticache](terraform/modules/aws/elasticache)
* [rds](terraform/modules/aws/rds)
* [s3](terraform/modules/aws/s3)
* [iam](terraform/modules/aws/iam)
* [eks](terraform/modules/aws/vpc)
* [helm](terraform/modules/helm)
* [k8s_manifest](terraform/modules/k8s_manifest)
