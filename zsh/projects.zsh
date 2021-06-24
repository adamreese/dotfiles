# zsh projects
# -----------------------------------------------------------------------------

# Helm
# -----------------------------------------------------------------------------
path[1,0]=${GOPATH}/src/helm.sh/helm/bin

alias helm2="${GOPATH}/src/k8s.io/helm/bin/helm"

# HL global alias
# example: `helm get HL`
alias -g HL='$(helm last)'

helm() {
  unfunction "$0"
  source <(command helm completion zsh)
  $0 "$@"
}

# Brigade
# -----------------------------------------------------------------------------
path[1,0]=${GOPATH}/src/github.com/Azure/brigade/bin

# Wagi
# -----------------------------------------------------------------------------
path[1,0]=${HOME}/p/go/src/github.com/deislabs/wagi/target/debug

# Bindle
# -----------------------------------------------------------------------------
path[1,0]=${HOME}/p/go/src/github.com/deislabs/bindle/target/debug

# Hippofactory
# -----------------------------------------------------------------------------
path[1,0]=${HOME}/p/go/src/github.com/deislabs/hippofactory/target/debug
export BINDLE_SERVER_URL='http://127.0.0.1:8080/v1'
