export ANSIBLE_HOST_KEY_CHECKING=False
export TF_LOG="DEBUG"
export TF_LOG_PATH="/tmp/terraform.log"

terraform init
terraform apply -auto-approve

