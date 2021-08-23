Deploy EKS with Terraform
1. Be sure to install all pre-requisites for the required tools in the workspace.
   AWS-cli, aws-iam-cli, terraform, kubectl, eks module, awscli, wget, helm, docker
   # make sure you have AWS account and vpc created for this test cluster
   # configure aws cli tool and kubectl


2.  Deploy Terraform EKS Configuration files with commands:
    Terraform fmt -recursive #format
    terraform init # to download all modules
    terraform plan #shows what it will create
    Terraform apply  #run plan first, then deploy

3.  aws eks --region us-east-1 update-kubeconfig --name one-eks
    # lists nodes created, to verify

Deploy Hello world app to EKS Cluster

1.  there are 3 files for the flask application to deploy
    - requirements.txt, dockerfile.dockerfile, helloworldapp.py

2.  Can use CodeCommit/Jenkins (using helm) to deploy to the EKS Cluster
    # codecommit information:  https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up.html

