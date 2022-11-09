# Share Modules in Private Modules Registry

## Step-01: Introduction
- Create and version a GitHub repository for use in the private module registry
- Import a module into your organization's private module registry.
- Construct a root module to consume modules from the private registry.
- Over the process also learn about `terraform login` command

## Step-02: Create new github Repository for terraform-aws-ec2-module
### Step-02-01: Craete new Github Repository
- **URL:** github.com
- Click on **Create a new repository**
- Follow Naming Conventions for modules
  - terraform-PROVIDER-MODULE_NAME
  - **Sample:** terraform-aws-ec2-module
- **Repository Name:** terraform-aws-ec2-module
- **Description:** Terraform Modules to be shared in Private Registry
- **Repo Type:** Public / Private
- **Initialize this repository with:**
- **UN-CHECK** - Add a README file
- **CHECK** - Add .gitignore 
- **Select .gitignore Template:** Terraform
- **CHECK** - Choose a license
- **Select License:** Apache 2.0 License  (Optional)
- Click on **Create repository**
### Step-02-02: Create New Release Tag 1.0.0 in Repo
- Go to Right Navigation on github Repo -> Releases -> Create a new release
- **Tag Version:** 1.0.0
- **Release Title:** Release-1 terraform-aws-ec2-module
- **Write:** Terraform Module for Private Registry - terraform-aws-ec2-module
- Click on **Publish Release**


## Step-03: Clone Github Repository to Local Desktop
```t
# Clone Github Repo
git clone https://github.com/<YOUR_GITHUB_ID>/<YOUR_REPO>.git
```

## Step-04: Copy files from terraform-manifests to local repo & Check-In Code
- **Orignial Source Location:** DAY11-Terraform-Modules\11-01-Own-Modules\modules
- **Source Location from this section:** terraform-aws-ec2-module
- **Destination Location:** Newly cloned github repository folder in your local desktop `terraform-aws-ec2-module`
- Check-In code to Remote Repository
```t
# GIT Status
git status

# Git Local Commit
git add .
git commit -am "TF Module Files First Commit"

# Push to Remote Repository
git push

# Verify the same on Remote Repository
https://github.com/terraform-course/terraform-aws-ec2-module.git
```

## Step-05: Add VCS Provider as Github using OAuth App in Terraform Cloud 

### Step-05-01: Add VCS Provider as Github using OAuth App in Terraform Cloud
- Login to Terraform Cloud
- Click on Modules Tab -> Click on Add Module -> Select Github(Custom)
- Should redirect to URL: https://github.com/settings/applications/new in new browser tab
- **Application Name:** Terraform Cloud (hctaprep) 
- **Homepage URL:**	https://app.terraform.io 
- **Application description:**	Terraform Cloud Integration with Github using OAuth 
- **Authorization callback URL:**	https://app.terraform.io/auth/f53695b8-9733-40f0-9853-89cb5396610b/callback 
- Click on **Register Application**
- Make a note of Client ID: 97e5219d6edd8986817e (Sample for reference)
- Generate new Client Secret: abcdefghijklmnopqrstuvwxyx

### Step-05-02: Add the below in Terraform Cloud
- Name: github-terraform-modules
- Client ID: 97e5219d6edd8986817e
- Client Secret: abcdefghijklmnopqrstuvwxyx
- Click on **Connect and Continue**
- Authorize Terraform Cloud (hctaprep) - Click on **Authorize terraform-course**
- SSH Keypair (Optional): click on **Skip and Finish**

### Step-06: Import the Terraform Module from Github
- In above step, we have completed the VCS Setup with github
- Now lets go ahead and import the Terraform module from Github
- Login to Terraform Cloud
- Click on Modules Tab -> Click on Add Module -> Select Github(github-terraform-modules) (PRE-POPULATED) -> Select it
- **Choose a Repository:** terraform-aws-ec2-module
- Click on **Publish Module**

## Step-07: Review newly imported Module
- Login to Terraform Cloud -> Click on Modules Tab 
- Review the Module Tabs on Terraform Cloud
  - Readme
  - Inputs
  - Outputs
  - Dependencies
  - Resources
- Also review the following
  - Versions
  - Provision Instructions   

## Step-08: Create a configuration that uses the Private Registry module using Terraform CLI
- CreateTerraform Configuration in Root Module by calling the newly published module in Terraform Private Registry in main.tf
```t
module "ec2_module" {
  source  = "app.terraform.io/hctaprep/terraform-aws-ec2-module/aws"
  version = "1.0.0"
}
```
### Step-08-02: Execute Terraform Commands
```t
# Terraform Initialize
terraform init
Observation: 
1. Should fail with error due to cli not having access to Private module registry in Terraform Cloud

# Terraform Login
terraform login
Observation: 
1) Should see message |Success! Terraform has obtained and saved an API token.|
2) Verify Terraform credentials file
cat /Users/<YOUR_USER>/.terraform.d/credentials.tfrc.json
cat /Users/kdaida/.terraform.d/credentials.tfrc.json
Additional Reference:
https://www.terraform.io/docs/cli/config/config-file.html#credentials-1
https://www.terraform.io/docs/cloud/registry/using.html#configuration

# Terraform Initialize
terraform init
Observation: 
1. Should pass and download modules and providers

# Terraform Validate
terraform validate

# Terraform Format
terraform fmt

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

### Step-08-04: Destroy and Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*
```

## Step-10: VCS Providers & Terraform Cloud
- [Configuration-Free GitHub Usage](https://www.terraform.io/docs/cloud/vcs/github-app.html)
- [Configuring GitHub.com Access (OAuth)](https://www.terraform.io/docs/cloud/vcs/github.html)
- [Configuring GitHub Enterprise Access](https://www.terraform.io/docs/cloud/vcs/github-enterprise.html)
- [Other Supported VCS Providers](https://www.terraform.io/docs/cloud/vcs/index.html)

