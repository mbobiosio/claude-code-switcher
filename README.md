# Claude Code Switcher

Dead-simple shell configs to switch between **DeepSeek API**, **Anthropic API**, and **Claude Native** from the terminal. No dependencies, no build steps, just source and go.

## Why

Claude Code supports multiple backends, but switching between them means remembering env vars, base URLs, and model mappings. This project wraps all of that into short, memorable commands.

## What You Get

| Command | Backend | Billing | Example |
|---------|---------|---------|---------|
| `cc-ds` | DeepSeek API | Pay per token | `cc-ds` |
| `cc-api-sonnet` | Anthropic API | Pay per token | `cc-api-sonnet 4-6` |
| `cc-api-opus` | Anthropic API | Pay per token | `cc-api-opus 4-7` |
| `cc-api-haiku` | Anthropic API | Pay per token | `cc-api-haiku` |
| `cc-sonnet` | Claude Native | Subscription | `cc-sonnet 4-5` |
| `cc-opus` | Claude Native | Subscription | `cc-opus` |
| `cc-haiku` | Claude Native | Subscription | `cc-haiku` |

Version argument is optional. Omit it to use the latest stable version.

## Install

### Fish Shell

Add this line to `~/.config/fish/config.fish`:

```fish
source /path/to/claude-code-switcher/fish.config.fish
```

Then reload:

```fish
source ~/.config/fish/config.fish
```

### Bash / Zsh

Add this line to `~/.bashrc` or `~/.zshrc`:

```bash
source /path/to/claude-code-switcher/bash.config.sh
```

Then reload:

```bash
source ~/.bashrc
```

## Setup

1. Open the config file for your shell
2. Replace the placeholder API keys with your real ones
3. Save and reload

**Fish:**
```fish
set -gx DEEPSEEK_AUTH_TOKEN "sk-your-real-key"
set -gx ANTHROPIC_KEY "sk-ant-your-real-key"
```

**Bash:**
```bash
export DEEPSEEK_AUTH_TOKEN="sk-your-real-key"
export ANTHROPIC_KEY="sk-ant-your-real-key"
```

## How It Works

```
Global Environment (set once)
├── DEEPSEEK_AUTH_TOKEN
├── ANTHROPIC_KEY
├── ANTHROPIC_DEFAULT_SONNET_MODEL
├── ANTHROPIC_DEFAULT_OPUS_MODEL
├── CLAUDE_CODE_EFFORT_LEVEL
└── ...other model mappings

Commands (just pick one)
├── cc-ds          → DeepSeek API (overrides base URL)
├── cc-api-sonnet  → Anthropic API (explicitly passes key)
├── cc-api-opus    → Anthropic API (explicitly passes key)
├── cc-sonnet      → Claude Native (clears all API keys)
└── cc-opus        → Claude Native (clears all API keys)
```

Each command only sets what it needs. Everything else is inherited from the global environment.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed (`claude` command)
- A [DeepSeek API key](https://platform.deepseek.com) (starts with `sk-`)
- An [Anthropic API key](https://console.anthropic.com) (optional, starts with `sk-ant-`)
- Claude Pro/Max subscription for native mode (optional)


## Troubleshooting

### DeepSeek returns "Retrying... attempt X/10"

This is a known `user_id` validation bug on DeepSeek's side. The config already includes `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1` which fixes it.

### Native commands show "API Usage Billing"

Something is leaking an Anthropic API key into your environment. Common causes:

- A `.env` file in your current directory
- A universal variable in Fish (`set -eU ANTHROPIC_AUTH_TOKEN`)

Quick fix:
```bash
echo ".env" > .claudeignore
```

### Context window shows 200K instead of 1M

The `[1m]` suffix on DeepSeek model names tells Claude Code to use the full 1M token context window. If missing, verify:
```bash
ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro[1m]"
```

### Command not found after install

Make sure you sourced the file in the correct shell config:
- Fish: `~/.config/fish/config.fish`
- Bash: `~/.bashrc`
- Zsh: `~/.zshrc`

Then reload with `source` or restart your terminal.

## Files

```
claude-code-switcher/
├── README.md
├── fish.config.fish    # Fish shell config
├── bash.config.sh      # Bash/Zsh config
└── .gitignore
```

## License

MIT — do whatever you want with it.
