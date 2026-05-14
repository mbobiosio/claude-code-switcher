# ============================================
# Claude Code Switcher — Bash / Zsh
# ============================================
# Source this file in ~/.bashrc or ~/.zshrc:
#   source /path/to/claude-code-switcher/bash.config.sh
# ============================================

# ----- API Keys (replace with your own) -----
export DEEPSEEK_AUTH_TOKEN="sk-your-deepseek-key-here"
export ANTHROPIC_KEY="sk-ant-your-anthropic-key-here"

# ----- DeepSeek Model Mapping (official docs) -----
export ANTHROPIC_MODEL="deepseek-v4-pro[1m]"
export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro[1m]"
export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro[1m]"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_EFFORT_LEVEL="max"

# ============================================
# DeepSeek API
# ============================================
alias cc-ds='ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic" \
  ANTHROPIC_AUTH_TOKEN="$DEEPSEEK_AUTH_TOKEN" \
  CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
  claude --model sonnet'

# ============================================
# Anthropic API (pay per token)
# ============================================
cc-api-sonnet() {
    unset ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_KEY" claude --model "claude-sonnet-${1:-4-6}"
}

cc-api-opus() {
    unset ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_KEY" claude --model "claude-opus-${1:-4-6}"
}

cc-api-haiku() {
    unset ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_KEY" claude --model "claude-haiku-${1:-4-5}"
}

# ============================================
# Claude Native (subscription)
# ============================================
cc-sonnet() {
    unset ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" claude --model "claude-sonnet-${1:-4-6}"
}

cc-opus() {
    unset ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" claude --model "claude-opus-${1:-4-6}"
}

cc-haiku() {
    unset ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" claude --model "claude-haiku-${1:-4-5}"
}
