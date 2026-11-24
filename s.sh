#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=false
for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

# Catalog format: "id|Display Name|check_cmd|install_cmd"
TOOLS=(
  "1|Git|git|sudo apt-get update && sudo apt-get install -y git"
  "2|Docker|docker|curl -fsSL https://get.docker.com | sh"
  "3|Node.js (nvm)|nvm|curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash"
  "4|Python 3 + pip|python3|sudo apt-get install -y python3 python3-pip python3-venv"
  "5|jq & ripgrep|jq|sudo apt-get install -y jq ripgrep"
  "6|Ollama|ollama|curl -fsSL https://ollama.com/install.sh | sh"
)

is_installed() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    return 0
  fi
  # Fallback for nvm if sourced in user profile
  if [[ "$cmd" == "nvm" && -s "${NVM_DIR:-$HOME/.nvm}/nvm.sh" ]]; then
    return 0
  fi
  return 1
}

run_cmd() {
  if $DRY_RUN; then
    echo "[DRY-RUN] $*"
  else
    eval "$*"
  fi
}

echo "=== Startup Environment Check ==="
for entry in "${TOOLS[@]}"; do
  IFS='|' read -r id name check_cmd _ <<< "$entry"
  if is_installed "$check_cmd"; then
    printf "  [%s] %-22s -> INSTALLED\n" "$id" "$name"
  else
    printf "  [%s] %-22s -> missing\n" "$id" "$name"
  fi
done

echo ""
echo "Enter numbers separated by spaces (e.g. '1 2 5'), 'missing' for all missing, or 'q' to quit:"
read -r -p "> " selection

[[ -z "${selection// }" || "$selection" == "q" ]] && exit 0

selected_ids=()
if [[ "$selection" == "missing" ]]; then
  for entry in "${TOOLS[@]}"; do
    IFS='|' read -r id _ check_cmd _ <<< "$entry"
    is_installed "$check_cmd" || selected_ids+=("$id")
  done
else
  read -r -a selected_ids <<< "$selection"
fi

for target_id in "${selected_ids[@]}"; do
  for entry in "${TOOLS[@]}"; do
    IFS='|' read -r id name check_cmd install_cmd <<< "$entry"
    if [[ "$id" == "$target_id" ]]; then
      if is_installed "$check_cmd"; then
        echo "Skipping $name (already installed)."
      else
        echo "Installing $name..."
        run_cmd "$install_cmd"
      fi
    fi
  done
done

echo "Done."
