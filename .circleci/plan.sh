install_tg_version() {
  VERSION="$1"
  V_VERSION="v$1"
  mkdir -p $HOME/.tgenv/versions/$VERSION
  curl -LO https://github.com/gruntwork-io/terragrunt/releases/download/$V_VERSION/terragrunt_linux_amd64
  mv terragrunt_linux_amd64 $HOME/.tgenv/versions/$VERSION/terragrunt
  chmod +x $HOME/.tgenv/versions/$VERSION/terragrunt
}

PATH="$HOME/.tfenv/bin:$HOME/.tgenv/bin:$PATH"
cd global/organizations/sandbox/eu-west-1/null-resource
TG_VERSION=$(cat .terragrunt-version)
install_tg_version $TG_VERSION
tgenv use $TG_VERSION

mkdir -p ~/repo/plans
ls -la ~/repo

# Remove colors from plan file
terragrunt plan -out="$(pwd)/tg.plan" | sed "s/\x1B\[[0-9;]*[mGKF]//g" | tee plan.txt

cp tg.plan ~/repo/plans
cp .terraform-version ~/repo/plans
cp .terragrunt-version ~/repo/plans
