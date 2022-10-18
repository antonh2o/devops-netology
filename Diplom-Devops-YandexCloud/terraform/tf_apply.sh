export ANSIBLE_HOST_KEY_CHECKING=False
export TF_LOG="DEBUG"
export TF_LOG_PATH="/tmp/terraform.log"

ssh-keygen -f "/root/.ssh/known_hosts" -R "antonh2o.ru"
terraform init
terraform apply -auto-approve

