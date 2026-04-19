#!/usr/bin/env bash
set -euo pipefail

# ─── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ─── Helpers ──────────────────────────────────────────────────────────────────
info()    { printf "${BLUE}ℹ${RESET}  %s\n" "$1"; }
ok()      { printf "${GREEN}✔${RESET}  %s\n" "$1"; }
warn()    { printf "${YELLOW}⚠${RESET}  %s\n" "$1"; }
fail()    { printf "${RED}✖${RESET}  %s\n" "$1"; }
section() { printf "\n${BOLD}${BLUE}── %s ──────────────────────────────────${RESET}\n" "$1"; }

cmd_exists()    { command -v "$1" &>/dev/null; }
brew_installed() { brew list "$1" &>/dev/null; }
npm_global()    { npm list -g "$1" &>/dev/null 2>&1; }

ask_install() {
  local label="$1"
  local install_cmd="$2"
  printf "\n${YELLOW}?${RESET}  ${BOLD}%s${RESET} is missing. Install it now? [Y/n] " "$label"
  read -r answer
  case "$(echo "$answer" | tr '[:upper:]' '[:lower:]')" in
    y|yes|"")
      printf "${DIM}  Running: %s${RESET}\n" "$install_cmd"
      eval "$install_cmd"
      if cmd_exists "$3" 2>/dev/null || brew_installed "$3" 2>/dev/null; then
        ok "$label installed successfully"
      else
        warn "$label may not have installed correctly — please verify manually"
      fi
      ;;
    *)
      printf "${DIM}  Skipped${RESET}\n"
      ;;
  esac
}

# ─── Track results ────────────────────────────────────────────────────────────
MISSING=()
INSTALLED=()
SKIPPED=()

check_and_install() {
  local label="$1"
  local check_cmd="$2"   # command to check for existence
  local check_type="$3"  # "cmd", "brew", or "npm"
  local install_cmd="$4"

  case "$check_type" in
    cmd)
      if cmd_exists "$check_cmd"; then
        ok "$label"
        return
      fi
      ;;
    brew)
      if brew_installed "$check_cmd"; then
        ok "$label"
        return
      fi
      ;;
    npm)
      if npm_global "$check_cmd"; then
        ok "$label"
        return
      fi
      ;;
  esac

  MISSING+=("$label")
  ask_install "$label" "$install_cmd" "$check_cmd"
  local code=$?
  # Re-check after install attempt
  case "$check_type" in
    cmd)
      if cmd_exists "$check_cmd"; then INSTALLED+=("$label"); else SKIPPED+=("$label"); fi
      ;;
    brew)
      if brew_installed "$check_cmd"; then INSTALLED+=("$label"); else SKIPPED+=("$label"); fi
      ;;
    npm)
      if npm_global "$check_cmd"; then INSTALLED+=("$label"); else SKIPPED+=("$label"); fi
      ;;
  esac
}

# ─── Header ────────────────────────────────────────────────────────────────────
printf "\n${BOLD}${BLUE}╔══════════════════════════════════════════════════╗${RESET}\n"
printf "${BOLD}${BLUE}║${RESET}  ${BOLD}Neovim Config Dependency Installer${RESET}              ${BOLD}${BLUE}║${RESET}\n"
printf "${BOLD}${BLUE}╚══════════════════════════════════════════════════╝${RESET}\n"

# ─── Core requirements ─────────────────────────────────────────────────────────
section "Core"

if cmd_exists nvim; then
  NVIM_VERSION=$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+')
  ok "Neovim $(nvim --version | head -1 | awk '{print $2}')"
  # Check for v0.12+ (vim.pack.add requires it)
  MAJOR=$(echo "$NVIM_VERSION" | cut -d. -f1)
  MINOR=$(echo "$NVIM_VERSION" | cut -d. -f2)
  if [ "$MAJOR" -lt 1 ] && [ "$MINOR" -lt 12 ]; then
    fail "Neovim 0.12+ is required for vim.pack.add (your config uses it). Please upgrade."
  fi
else
  fail "Neovim is not installed"
  ask_install "Neovim" "brew install neovim" "nvim"
fi

check_and_install "Git" git cmd "brew install git"
check_and_install "C compiler (cc)" cc cmd "xcode-select --install"

# ─── Search tools (fzf-lua) ───────────────────────────────────────────────────
section "Search tools (fzf-lua)"

check_and_install "ripgrep" rg cmd "brew install ripgrep"
check_and_install "fd" fd cmd "brew install fd"

# ─── Formatters (conform-nvim) ────────────────────────────────────────────────
section "Formatters (conform-nvim)"

check_and_install "Prettier" prettier npm "npm install -g prettier"
check_and_install "fixjson" fixjson npm "npm install -g fixjson"
check_and_install "StyLua" stylua cmd "brew install stylua"
check_and_install "shfmt" shfmt cmd "brew install shfmt"

# Language-specific formatters — skip if the language isn't installed
info "Language-specific formatters (only needed if you use the language):"

if cmd_exists go; then
  check_and_install "gofmt (Go)" gofmt cmd "brew install go"
else
  printf "${DIM}  ⊘  gofmt — skipped (Go not installed)${RESET}\n"
fi

if cmd_exists rustfmt; then
  ok "rustfmt (Rust)"
else
  printf "${DIM}  ⊘  rustfmt — skipped (Rust not installed)${RESET}\n"
fi

if cmd_exists zig; then
  check_and_install "zigfmt (Zig)" zigfmt cmd "brew install zig"
else
  printf "${DIM}  ⊘  zigfmt — skipped (Zig not installed)${RESET}\n"
fi

# ─── LSP servers (mason) ─────────────────────────────────────────────────────
section "LSP servers (via Mason)"

info "The following LSP servers are managed by Mason inside Neovim."
info "Run :MasonInstall <server> from within Neovim to install them."
info ""
info "  Servers in your config:"
info "    lua_ls (auto-installed by mason-lspconfig)"
info ""
info "You can also run :Mason to browse all available servers."

# ─── Extras ───────────────────────────────────────────────────────────────────
section "Optional"

check_and_install "Node.js" node cmd "brew install node"
check_and_install "npm" npm cmd "brew install node"

# ─── Mason-managed tools ──────────────────────────────────────────────────────
section "Mason-managed tools"

MASON_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason/packages"
MASON_BIN="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason/bin"

check_mason_pkg() {
  local label="$1"
  local pkg="$2"
  local bin="$3"

  if [ -d "$MASON_DIR/$pkg" ] || [ -f "$MASON_BIN/$bin" ]; then
    ok "$label (Mason)"
  else
    MISSING+=("$label")
    printf "\n${YELLOW}?${RESET}  ${BOLD}%s${RESET} is not installed via Mason. Open Neovim and run ${DIM}:MasonInstall %s${RESET}? [Y/n] " "$label" "$pkg"
    read -r answer
    case "$(echo "$answer" | tr '[:upper:]' '[:lower:]')" in
      y|yes|"")
        nvim -c "MasonInstall $pkg" -c "sleep 5" -c "q"
        INSTALLED+=("$label")
        ;;
      *)
        SKIPPED+=("$label")
        ;;
    esac
  fi
}

check_mason_pkg "StyLua (Mason)" stylua stylua
check_mason_pkg "shfmt (Mason)" shfmt shfmt
check_mason_pkg "lua_ls (Mason)" lua-language-server lua-language-server

# ─── Summary ──────────────────────────────────────────────────────────────────
section "Summary"

TOTAL=$(( ${#MISSING[@]} ))
FIXED=$(( ${#INSTALLED[@]} ))
LEFT=$(( ${#SKIPPED[@]} ))

if [ "$TOTAL" -eq 0 ]; then
  printf "\n${GREEN}${BOLD}All dependencies satisfied! 🎉${RESET}\n\n"
else
  printf "\n"
  if [ "$FIXED" -gt 0 ]; then
    printf "${GREEN}Installed (${FIXED}):${RESET}\n"
    for item in "${INSTALLED[@]}"; do printf "  ${GREEN}✔${RESET} %s\n" "$item"; done
  fi
  if [ "$LEFT" -gt 0 ]; then
    printf "${YELLOW}Skipped (${LEFT}):${RESET}\n"
    for item in "${SKIPPED[@]}"; do printf "  ${YELLOW}⊘${RESET} %s\n" "$item"; done
    printf "\n${DIM}Run this script again anytime to install skipped items.${RESET}\n"
  fi
  printf "\n"
fi