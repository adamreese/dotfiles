# zsh projects
# -----------------------------------------------------------------------------

# Helm
# -----------------------------------------------------------------------------
path[1,0]=${PROJECTS}/helm.sh/helm/bin

alias helm2="${PROJECTS}/k8s.io/helm/bin/helm"

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
path[1,0]=${PROJECTS}/github.com/brigadecore/brigade/bin

# Wagi
# -----------------------------------------------------------------------------
path[1,0]=${PROJECTS}/github.com/deislabs/wagi/target/release

# Bindle
# -----------------------------------------------------------------------------
path[1,0]="${PROJECTS}/github.com/deislabs/bindle/target/release"

export BINDLE_IP_ADDRESS_PORT='127.0.0.1:8080'
export BINDLE_URL="http://${BINDLE_IP_ADDRESS_PORT}/v1"
export BINDLE_DIRECTORY="${XDG_DATA_HOME}/bindle"

bindle-server() {
  RUST_LOG=error,warp=info,bindle=debug command bindle-server --unauthenticated "$@"
}

# Hippo
# -----------------------------------------------------------------------------
path[1,0]=${PROJECTS}/github.com/deislabs/hippo-cli/target/debug

# Spin
# -----------------------------------------------------------------------------
path[1,0]=${PROJECTS}/github.com/fermyon/spin/target/release
