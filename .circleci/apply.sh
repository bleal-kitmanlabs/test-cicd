install_tg_version() {
  VERSION="$1"
  V_VERSION="v$1"
  mkdir -p $HOME/.tgenv/versions/$VERSION
  curl -LO https://github.com/gruntwork-io/terragrunt/releases/download/$V_VERSION/terragrunt_linux_amd64
  mv terragrunt_linux_amd64 $HOME/.tgenv/versions/$VERSION/terragrunt
  chmod +x $HOME/.tgenv/versions/$VERSION/terragrunt
}

cd /workspace/global/organizations/sandbox/eu-west-1/null-resource

PATH="$HOME/.tfenv/bin:$HOME/.tgenv/bin:$PATH"
TG_VERSION=$(cat .terragrunt-version)

echo "TG_VERSION env var: $TG_VERSION | version in the file: $(cat .terragrunt-version)"

install_tg_version $TG_VERSION
tgenv use $TG_VERSION

terragrunt apply -auto-approve tg.plan | tee apply.txt
