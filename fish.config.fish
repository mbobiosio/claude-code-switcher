# ============================================
# Claude Code Switcher — Fish Shell
# ============================================
# Source this file in ~/.config/fish/config.fish:
#   source /path/to/claude-code-switcher/fish.config.fish
# ============================================

# ----- API Keys (replace with your own) -----
set -gx DEEPSEEK_AUTH_TOKEN "sk-your-deepseek-key-here"
set -gx ANTHROPIC_KEY "sk-ant-your-anthropic-key-here"

# ----- DeepSeek Model Mapping (official docs) -----
set -gx ANTHROPIC_MODEL "deepseek-v4-pro[1m]"
set -gx ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro[1m]"
set -gx ANTHROPIC_DEFAULT_SONNET_MODEL "deepseek-v4-pro[1m]"
set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL "deepseek-v4-flash"
set -gx CLAUDE_CODE_SUBAGENT_MODEL "deepseek-v4-flash"
set -gx CLAUDE_CODE_EFFORT_LEVEL "max"

# ============================================
# DeepSeek API
# ============================================
alias cc-ds 'ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic" \
  ANTHROPIC_AUTH_TOKEN="$DEEPSEEK_AUTH_TOKEN" \
  CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
  claude --model sonnet'

# ============================================
# Anthropic API (pay per token)
# ============================================
function cc-api-sonnet
    set ver $argv[1]
    test -z "$ver"; and set ver "4-6"
    set -e ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_KEY" claude --model "claude-sonnet-$ver"
end

function cc-api-opus
    set ver $argv[1]
    test -z "$ver"; and set ver "4-6"
    set -e ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_KEY" claude --model "claude-opus-$ver"
end

function cc-api-haiku
    set ver $argv[1]
    test -z "$ver"; and set ver "4-5"
    set -e ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_KEY" claude --model "claude-haiku-$ver"
end

# ============================================
# Claude Native (subscription)
# ============================================
function cc-sonnet
    set ver $argv[1]
    test -z "$ver"; and set ver "4-6"
    set -e ANTHROPIC_AUTH_TOKEN
    set -e ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" claude --model "claude-sonnet-$ver"
end

function cc-opus
    set ver $argv[1]
    test -z "$ver"; and set ver "4-6"
    set -e ANTHROPIC_AUTH_TOKEN
    set -e ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" claude --model "claude-opus-$ver"
end

function cc-haiku
    set ver $argv[1]
    test -z "$ver"; and set ver "4-5"
    set -e ANTHROPIC_AUTH_TOKEN
    set -e ANTHROPIC_API_KEY
    ANTHROPIC_BASE_URL="" claude --model "claude-haiku-$ver"
end
