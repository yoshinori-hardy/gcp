## Hashicorp Terraform Google Cloud Environment

This is a POC I used to start learning google cloud, and messed around with some interpolations.

This repo provides the base network infrastructure and some security to
support the deployment of a devops automation platform and its subsequent
services.  The IaC is built using Terraform, full documentation can be found here:

https://www.terraform.io/docs/index.html

GCP is moving fast at the moment and there's no ongoing support for this, but feel free 
to use it if you're just playing/learning.

##todo refactor tf modules to use count on child blocks once TF0.12 is released

## Installation

Follow the guide on the Hashicorp site to either install the binary or
build from source for your distribution.

Building from source is for advanced users and may require additional
packages to be installed.

When using the pre-built binary, place it in a suitable location and ensure it
is in your $PATH.  Installation can be verified using

$ terraform --version

## Usage

Clone the repository from git and set up your account authentication.  
Update project specific variables in the relevant files.  Note the repo uses
modules so most variables will be passed to the modules from the main.tf file. 

Prior to running please ensure that you execute an init command.  Also, Please
ensure you take advantage of the plan feature before building!!!

to do, considerations for saving your state file.
