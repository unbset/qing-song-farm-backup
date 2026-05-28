# Auxiliary Vision Configuration for Hermes

Enable image analysis (看图) in Hermes — both CLI and WebUI.

## Prerequisites

- `vision` toolset must be enabled: `hermes tools list | grep vision`
- If disabled: `hermes tools enable vision` → then `/reset` for a new session

## Quick Setup (OpenRouter)

```bash
# 1. Set auxiliary vision provider + model
hermes config set auxiliary.vision.provider openrouter
hermes config set auxiliary.vision.model openrouter/google/gemini-2.0-flash-exp

# 2. Add API key to ~/.hermes/.env
# OPENROUTER_API_KEY=sk-or-...
```

## What the Config Means

| Config Key | Value | Purpose |
|------------|-------|---------|
| `auxiliary.vision.provider` | `openrouter` | Which provider handles image analysis |
| `auxiliary.vision.model` | `openrouter/...` | Which specific vision-capable model |
| `image_input_mode` | `auto` | How image inputs are handled (default) |

The auxiliary vision model is used when the main conversation model (e.g. DeepSeek V4 Flash) doesn't support vision natively, or when Hermes's internal routing decides to delegate image analysis.

## Common Vision Models via OpenRouter

| Model | Quality | Speed | Cost |
|-------|---------|-------|------|
| `openrouter/google/gemini-2.0-flash-exp` | Good | Fast | Free tier |
| `openrouter/anthropic/claude-sonnet-4` | Excellent | Fast | Paid |
| `openrouter/openai/gpt-4o` | Excellent | Fast | Paid |
| `openrouter/google/gemini-2.5-pro-exp` | Best | Medium | Free tier |

## Using Vision

### In WebUI (http://localhost:8787)
Upload an image via the chat input box, then ask a question about it.

### In CLI (terminal)
Use `/image` or `/paste` slash command in a Hermes session to attach an image, then send your question.

## Troubleshooting

### "vision toolset is enabled but images don't work"
Most likely: the auxiliary vision provider has no API key configured.
- Check `hermes config | grep -A 5 auxiliary`
- Ensure `OPENROUTER_API_KEY` (or your provider's key) is in `~/.hermes/.env`

### "I see vision tool but image upload fails"
The auxiliary model may be unreachable or returning errors.
- Try a different model: `hermes config set auxiliary.vision.model openrouter/openai/gpt-4o`
- Check OpenRouter status: https://status.openrouter.ai

### Changes not taking effect
Config changes for toolsets and auxiliary models require a **new session** (`/reset` in CLI, or start a new conversation in WebUI). They do not apply mid-conversation.
