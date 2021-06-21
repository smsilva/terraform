terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "0.0.9"
    }
  }
}

provider "env0" {
}

resource "env0_project" "example" {
  name        = "example"
  description = "Example project"
}

resource "env0_template" "example" {
  name        = "mytemplate"
  description = "Example template"
  repository  = "https://github.com/env0/templates"
  path        = "aws/hello-world"
}

resource "env0_template_project_assignment" "assignment" {
  template_id = env0_template.example.id
  project_id  = env0_project.example.id
}
