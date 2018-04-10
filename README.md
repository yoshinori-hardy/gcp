## Hashicorp Terraform Google Cloud DEVOPS Platform

This repo provides the base network infrastructure and security requirements to
support the deployment of a devops automation platform and its subsequent
services.  The IaC is built using Terraform, full documentation can be found here:

https://www.terraform.io/docs/index.html

![alt text](https://raw.githubusercontent.com/yoshinori-hardy/gcp-dop/master/docs/images/GCPDEVOPSPLATFORM.pdf)

## Installation

Follow the guide on the Hashicorp site to either install the binary or
build from source for your distribution.

Building from source is for advanced users and may require additional
packages to be installed.

When using the pre-built binary, place it in a suitable location and ensure it
is in your $PATH.  Installation can be verified using

$ terraform --version

## Usage

Clone the repository from git and set up your account authentication (see below).  
Update project specific variables in the relevant files.  Note the repo uses
modules so most variables will be passedto the modules from the main.tf file.

For initial setup the terraform must be run from a suitable location with the
relevant privileged access.  For example after initial account set up an
authentication file can be downlaoded and referenced.  Instructions for
completing this can be found on the Hashicorp web site:

https://www.terraform.io/docs/providers/google/index.html#credentials

Prior to running please ensure that you execute an init command.  Also, Please
ensure you take advantage of the plan feature before building!!!

to do, considerations for saving your state file.  

## Support

See Hashicorp docs from above link.
Repo Author - Yoshinori Hardy <yoshinori.v.hardy@accenture.com>

## License
to do, find out if there's an official Accenture license policy to be inserted
 here.

## Contribution

Please contribute using gitflow or some other sensible branching strategy.
Do not push to master directly.  Create experimental branches and submit
pull requests.  Thanks!
