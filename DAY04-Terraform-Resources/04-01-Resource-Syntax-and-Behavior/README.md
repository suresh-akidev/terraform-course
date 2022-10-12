# Terraform Resource Syntax & Behavior

## Step-01: Introduction
- Understand Resource Syntax
- Understand Resource Behavior
- Understanding Terraform State File
  - terraform.tfstate
- Understanding Desired and Current States (High Level Only)

## Step-02: Understand Resource Syntax
- We are going to understand about below concepts from Resource Syntax perspective
- Resource Block
- Resource Type
- Resource Local Name
- Resource Arguments
- Resource Meta-Arguments

## Step-03: Understand Resource Behavior
- We are going to understand resource behavior in combination with Terraform State
  - Create Resource
  - Update in-place Resources
  - Destroy and Re-create Resources
  - Destroy Resource  


## Step-04: Resource: Create Resource: Create EC2 Instance
```
# Initialize Terraform
terraform init

Observation: 
1) Successfully downloaded providers in .terraform folder
2) Created lock file named ".terraform.lock.hcl"

# Validate Terraform configuration files
terraform validate
Observation: No files changed / added in current working directory

# Format Terraform configuration files
terraform fmt
Observations: *.tf files will change to format them if any format changes exists

# Review the terraform plan
terraform plan 
Observation-1: Nothing happens during the first run from terraform state perspective
Observation-2: From Resource Behavior perspective you can see "+ create", we are creating 

# Create Resources 
terraform apply -auto-approve
Observation: 
1) Creates terraform.tfstate file in local working directory
2) Creates actual resource in AWS Cloud
```
- **Important Note:** Here we have seen example for **Create Resource**



## Step-05: Resource: Update In-Place: Make changes by adding new tag to EC2 Instance 
- Add a new tag in `c2-ec2-instance.tf`
```
# Add this for EC2 Instance tags
    "tag1" = "Update-test-1"
```
- Review Terraform Plan
```
# Review the terraform plan
terraform plan 
Observation: You should see "~ update in-place" 
"Plan: 0 to add, 1 to change, 0 to destroy."

# Create / Update Resources 
terraform apply -auto-approve
Observation: "Apply complete! Resources: 0 added, 1 changed, 0 destroyed."
```
- **Important Note:** Here we have seen example for **update in-place**


## Step-06: Resource: Destroy and Re-create Resources: Update Availability Zone
- This will destroy the EC2 Instance in 1 AZ and re-creates in other AZ
```
# Before
  availability_zone = "us-east-1a"

# After
  availability_zone = "us-east-1b"  
```
```
# Review the terraform plan
terraform plan 
Observation: 
1) -/+ destroy and then create replacement
2) # aws_instance.my-ec2-vm must be "replaced"
3) # aws_instance.my-ec2-vm must be "replaced" - This parameter forces replacement
4) "Plan: 1 to add, 0 to change, 1 to destroy."

# Create / Update Resources 
terraform apply -auto-approve
Observation: "Apply complete! Resources: 1 added, 0 changed, 1 destroyed."
```


## Step-07: Resource: Destroy Resource
```
# Destroy Resource
terraform destroy 
Observation: 
1) - destroy
2) # aws_instance.my-ec2-vm will be destroyed
3) Plan: 0 to add, 0 to change, 1 to destroy
4) Destroy complete! Resources: 1 destroyed
```

## Step-08: Clean-Up
```
# Destroy Resource
terraform destroy -auto-approve 

# Remove Terraform Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
