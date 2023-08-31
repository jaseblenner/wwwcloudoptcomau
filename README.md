# wwwcloudoptcomau

## Intro

This repo is used to manage serverless infrastructure and application codebases for the [www.cloudopt.com.au](https://www.cloudopt.com.au) landing page

This repo is intended to showcase a simple example of how both web app and serverless infrastructure codebases can be housed together and managed from a single repository.

The services deployed and managed by this repo (eg. in GitHub, Terraform Cloud and Cloudflare) incur no cost - they are free to run.


## Overview

Our (web) application codebase is housed in the `./app/` folder. This is based on the [astro](https://astro.build/) framework. To get started with astro, check out their [tutorials here](https://docs.astro.build/en/tutorial/0-introduction/)

Any changes to the codebase on the `main` branch will trigger a production deployment against the Cloudflare Pages Project named `wwwcloudoptcomau` - for this reason, the `main` branch has branch protection enabled.

In addition to this, Cloudflare automatically invokes deployment checks prior to a PR being marked available to merge.

*Note*: Cloudflare Pages in conjunction with our custom domain provides transparent management and automation of SSL/TLS certificates removing a large chunk of management overhead if managing certs ourselves.

Any changes made to **any** other branch will trigger a **development** deployment against the same Cloudflare Pages Project

Our infrastructure code is housed in the root (top level) of the repository. Any changes to this codebase on the `main` branch will trigger a speculative terraform plan against the Terraform Cloud workspace of the same name as a VCS connection has been configured on the Terraform Cloud Workspace. Note that all changes to `main` must be merged by way of an approved PR.

Locally, basic pre-commit and linting checks (mainly for terraform) have been configured in the `.pre-commit-config.yaml` file - note that there is a dependency to have the required pre-commit linters and dependencies installed locally for these to run successfully. These are intended to be used a a starting point only.
A better way to perform these checks would be to leverage [GitHub Actions](https://github.com/features/actions) to invoke these.

The `./.github/CODEOWNERS` file is used to define individuals or teams that are responsible for code in a repository.

## Providers & Authentication used

We have to authenticate to Cloudflare to manage the serverless infra (Cloudflare Pages). To achieve this we store a secure auth key in Terraform Cloud as a sensitive variable.

Cloudflare pages also has to be able to authenticate to our GitHub repo. In the event that the repository is set to private, auth to the GitHub org/repo should be configured in the CloudFlare Pages console - in future we should use a secrets management tool to facilitate this.

This allows terraform to read the variable securely and auth to Cloudflare at runtime.

## References

- [Astro Framework](https://docs.astro.build/en/tutorial/0-introduction/)
- [Terraform Workspaces / VCS](https://developer.hashicorp.com/terraform/cloud-docs/vcs)
- [Cloudflare Pages](https://pages.cloudflare.com/)
- [Cloudflare DNS](https://developers.cloudflare.com/dns/)
- [GitHub pre-commit](https://github.com/pre-commit/pre-commit)
- [GitHub CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
