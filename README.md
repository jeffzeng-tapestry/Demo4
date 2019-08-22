# Tapestry Terraform Template Repo

This repo is a template that contains a structured layout and sample TF code for Terraform repos.

Each Repository will consist of a single Terraform Root or Module.

## Code Layout

For a typical Terraform root the file and folder layout is below along with explanations of each file.
```
.
├── README.md
├── .gitignore
├── atlantis.yaml
├── environments
│   ├── nonprod-us-east-1.tfvars
│   └── prod-us-east-1.tfvars
├── main.tf
├── outputs.tf
├── variables.tf
├── makefile
├── tf-cloud-templaterepo.code-workspace
└── makefile
```

### README.md

Every repository needs a README file. Many git repositories (especially on Github) have adopted Markdown as a de facto standard format for README files. A good README file will include the following information:

Overview: A brief description of the infrastructure the repo builds. A high-level diagram is often an effective method of expressing this information. 
Pre-requisites: Installation instructions (or links thereto) for any software that must be installed before building or changing the code. For a majority of Tapestry Terraform Repos, Terraform will be the only requirement and that is for locally running a new deployment. 
It’s important that you do not neglect this basic documentation for two reasons (even if you think you’re the only one who will work on the codebase):

The obvious: Writing this critical information down in an easily viewable place makes it easier for all members of Tapestry to onboard onto your project and will prevent the need for a panicked knowledge transfer when projects change hands.
The not-so-obvious: The act of writing a description of the design clarifies your intent to yourself and will result in a cleaner design and a more coherent repository.

### .gitignore

Every repositories should have a .gitignore to tell Git not to commit certain file extensions. The one provided in this repo should suffice in most use cases for Terraform, but this can be modified if needed. 

### atlantis.yaml

This file tells Atlantis the file layout, projects, and workspaces to use in this repository.

In the below example, there are two projects, sampleapp-non-prod-us-east-1 with a workspace name of non-prod-us-east-1 and a prod version. The naming standard for projects is the "terraform root name"-"environment"-"region". The Environment will usually be the account or the environment, like qa, dev, test, nonprod, etc.

```
version: 3
projects:
- name: sampleapp-nonprod-us-east-1
  dir: .
  workflow: default
  workspace: nonprod-us-east-1
  terraform_version: v0.12.0
- name: sampleapp-prod-us-east-1
  dir: .
  workflow: default
  workspace: prod-us-east-1
  terraform_version: v0.12.0
```

### environments folder

This folder contains the different tfvars files for each environment. Each tfvars file will contain the answers for the variables.tf. In this app there are two, environment, prod and non prod and both are in the us-east-1 region.

### main.tf

This contains the terraform configuration, provider configuration, data sources, module calls and resources to be built. Typically this isn't split out into multiple files, but it can be if it will help with the code organization.

### outputs.tf

This contains the outputs of the root. This can then be consumed by other Terraform roots or output to the console

### variables.tf

This contains the variables that the main.tf will use. Typically there will not be any answers to variables in this file, but defaults can be provided that will be overridden if a tfvars file contains answers to the variable. 

### tf-cloud-templaterepo.code-workspace

This is a code-workspace file VScode uses to map a VSCode workspace to a set of folders and files. Custom workspace settings can be saved as well if needed. This is optional and VSCode doesn't require this, but it is nice to have

### makefile

What is Make? With Terraform we are using it like a Macro that takes X and does Y to get Z. Make is only used when running Terraform locally for initial development or testing.

With Terraform we are using it to automate certain actions and reduce the number of steps needed to build an environment. Make is primarily a *nix toolset that can be installed with your package manager of choice, install build-essential. There is also a Windows version, however this will have have issues as there are shell commands that won't work in Windows. We recommend installing [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about). With this and your distro of choice, Make can be installed. Also with VSCode, a WSL console can be added so it is super easy to use Make on Windows.

Make uses a file called makefile which is located in each terraform root.

## Running the Code

Atlantis will be used to plan and apply the code through GitHub Webhooks. The code can be run locally if you have CLI keys to AWS with permissions for development or testing.

### Running Terraform Locally with Make

When in a Terraform root, simply typing make will show what make can do when called with the following word. In this instance, there are the following:
```
apply                          Have terraform do the things. This will cost money.
destroy-target                 Destroy a specific resource. Caution though, this destroys chained resources.
destroy                        Destroy the things
plan-destroy                   Creates a destruction plan.
plan-target                    Shows what a plan looks like for applying a specific resource
plan                           Show what terraform thinks it will do
prep                           Prepare a new workspace (environment) if needed, configure the tfstate backend, update any modules, and switch to the workspace
```

There are some environmental variables that have to be set, when calling this makefile.
AWS_PROFILE - The AWS Profile used to connect to the state bucket. 
ENV - The Environment that is being built out. This will be combined with the REGION to match a specific tfvars file in the environments folder.
REGION - The environment that resources will be built in.

To call make these environmental vars need to be specified, otherwise an error message will appear.
The commands in Terraform like plan, apply, destroy are all matched in make

This is an example way to do a terraform plan, using a tfvars for the prod environment in us-east-1.
```shell
AWS_PROFILE=tpr-sharedservices-jmccollum ENV=prod REGION=us-east-1 make plan
```
To apply in the nonprod you would use: tpr-sharedservices-jmccollum ENV=nonprodprod REGION=us-east-1 make apply

### Running Terraform without Make

Requirements:
Terraform Version 0.12 and later
AWS CLI
CLI credentials to AWS with permissions to the state bucket, dynamo db table, and able to assume the terraform cross account role

This will initialize the root, download the provider and module

`terraform init`

Lists the workspaces

`terraform workspace list`

Selects the workspace to use

`terraform workspace select`

Creates a new workspace. Workspace names are always the "environment name"-"region"

`terraform workspace new "prod-us-east-1`

This will run Terraform plan and source a tfvars file for the answers

`terraform plan -var-file="environments/prod-us-east-1.tfvars"`

This will run Terraform Apply and source a tfvars file for the answers

`terraform apply -var-file="environments/prod-us-east-1.tfvars"`

This will run Terraform Destroy and source a tfvars file for the answers

`terraform destroy -var-file="environments/prod-us-east-1.tfvars"`