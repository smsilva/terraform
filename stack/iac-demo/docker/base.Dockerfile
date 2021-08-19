FROM hashicorp/terraform:1.0.5
ADD ./src /src
RUN terraform -chdir=/src init -backend=false
