
#!/bin/sh

apk add --update openssl
apk add curl
# wget https://github.com/wata727/tflint/releases/download/v0.5.4/tflint_linux_amd64.zip
tflint_latest_url=$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")
wget $tflint_latest_url
unzip tflint_linux_amd64.zip
mkdir -p /usr/local/tflint/bin
export PATH=/usr/local/tflint/bin:$PATH
install tflint /usr/local/tflint/bin
tflint 

validate_failed="no"
TF_DIRS=$(find $(pwd) -type f -iname "*.tf*" -exec dirname '{}' \; | grep -v ".terraform" | sort | uniq | xargs echo)
for DIR in $TF_DIRS
do
    echo Processing $DIR
    lines=$(terraform validate -input=false -check-variables=false -no-color $DIR | wc -l | sed 's/[^0-9]//g')
    if [ ${lines} != "0" ]
    then
    echo "Please run terraform validate ${file}"
    validate_failed="yes"
    fi
done
if [ ${validate_failed} != "no" ]; then exit 1; fi
