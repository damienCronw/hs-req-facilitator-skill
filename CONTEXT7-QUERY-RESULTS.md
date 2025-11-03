# Context7 MCP 查询 Claude Code Hooks - 结果示例

> 以下是使用 Context7 MCP 查询 Claude Code hooks 官方文档的示例结果

---

## 📋 查询与结果

### 查询 1: Claude Code Hooks 概述

**查询内容**:
```
Explain Claude Code hooks and how they work in automation workflows.
Include the 5 types: SessionStart, PreToolUse, PostToolUse, Notification, SessionEnd.
Provide configuration examples and best practices.
use context7
```

**Context7 返回结果** (示例):

---

# Claude Code Hooks: Complete Guide

Claude Code hooks are automated commands that execute at key points in the Claude Code lifecycle, enabling deterministic behavior and advanced automation.

## 🎯 Core Concept

Hooks are **user-defined shell commands** that run automatically at specific lifecycle events. They make Claude Code's behavior predictable rather than relying on model decisions.

## 📊 The 5 Hook Types

### 1. SessionStart
**Trigger**: When a session starts or resumes
**Purpose**: Initialize environment, install dependencies, load recent changes
**Common Uses**:
```bash
npm ci && git fetch -p && git log -n 5 --oneline > .recent_changes
```

### 2. PreToolUse
**Trigger**: Before Claude generates tool parameters
**Purpose**: Validate parameters, complete configs, prevent dangerous operations
**Common Uses**:
```bash
# Validate paths before dangerous operations
if [[ "$PATH" == *"protected"* ]]; then
  echo "Blocked: Protected directory"
  exit 1
fi
```

### 3. PostToolUse
**Trigger**: Immediately after a tool succeeds
**Purpose**: Process results, archive outputs, send notifications
**Common Uses**:
```bash
# Archive session logs
jq . < session.jsonl > readable-output.json
```

### 4. Notification
**Trigger**: When Claude Code sends notifications
**Purpose**: Forward to external systems (Slack, Teams, email)
**Common Uses**:
```bash
curl -X POST $SLACK_WEBHOOK \
  -d "{\"text\":\"Claude Code: $NOTIFICATION_TYPE - $MESSAGE\"}"
```

### 5. SessionEnd
**Trigger**: When session ends
**Purpose**: Clean temp files, gather stats, persist state
**Common Uses**:
```bash
tar czf session-archive.tar.gz .cache/ important-files/
rm -rf tmp/
```

## ⚙️ Configuration

### Basic Structure
```json
{
  "hooks": {
    "SessionStart": {
      "enabled": true,
      "matchers": { "always": true },
      "commands": [
        {
          "name": "init",
          "shell": "bash",
          "args": ["-c", "your-command"],
          "async": true
        }
      ]
    }
  }
}
```

### Advanced Matching
```json
"matchers": {
  "toolNames": ["Bash", "Write"],
  "patterns": ["deploy", "commit"],
  "eventTypes": ["error", "success"]
}
```

## 🔒 Security Best Practices

1. **Audit All Commands**
   - Review all hook commands
   - Use trusted sources only

2. **Restrict Permissions**
   - Use minimal privileges
   - Isolate in controlled directories

3. **Validate Inputs**
   - Check paths before deletion
   - Sanitize user inputs

4. **Log Everything**
   ```bash
   echo "[$(date)] $ACTION" >> hooks.log
   ```

## 🚀 Example Workflow

```bash
# 1. SessionStart - Setup
SessionStart → Load env vars → Check git status

# 2. PreToolUse - Validate
PreToolUse → Validate parameters → Allow/block operation

# 3. PostToolUse - Process
PostToolUse → Archive results → Update status

# 4. Notification - Alert
Notification → Send to Slack → Log event

# 5. SessionEnd - Cleanup
SessionEnd → Archive logs → Remove temp files
```

## 📚 Reference Links
- Full Docs: https://docs.claude.com/hooks
- Examples: https://github.com/anthropic/claude-code-examples
- Best Practices: https://docs.claude.com/hooks-guide

---

### 查询 2: SessionStart Hook 配置

**查询内容**:
```
How to use SessionStart hook to initialize a development environment?
Show practical examples for loading environment variables and checking git status.
use context7
```

**Context7 返回结果** (示例):

---

# SessionStart Hook: Development Environment Initialization

## 🎯 Purpose
SessionStart runs automatically when Claude Code starts, ensuring your development environment is always ready.

## ⚙️ Configuration

### Basic Setup
```json
{
  "SessionStart": {
    "enabled": true,
    "matchers": { "always": true },
    "commands": [
      {
        "name": "env-init",
        "shell": "bash",
        "args": [
          "-c",
          "source ~/.bashrc && export PATH=$HOME/.npm-global/bin:$PATH"
        ]
      },
      {
        "name": "git-status",
        "shell": "bash",
        "args": ["-c", "git status --short > /tmp/git-status.txt"]
      }
    ]
  }
}
```

## 💻 Practical Examples

### Example 1: Load Environment Variables
```bash
# In hooks.json
{
  "SessionStart": {
    "commands": [
      {
        "name": "load-env",
        "shell": "bash",
        "args": [
          "-c",
          "if [ -f .env ]; then source .env; fi && echo 'Environment loaded'"
        ]
      }
    ]
  }
}
```

### Example 2: Check Git Status
```bash
{
  "commands": [
    {
      "name": "git-check",
      "shell": "bash",
      "args": [
        "-c",
        "cd $CLAUDE_WORKSPACE && git fetch && git status --short"
      ]
    }
  ]
}
```

### Example 3: Install Dependencies
```bash
{
  "commands": [
    {
      "name": "install-deps",
      "shell": "bash",
      "args": [
        "-c",
        "npm ci && npm run build"
      ],
      "async": true
    }
  ]
}
```

### Example 4: Load API Keys
```bash
{
  "commands": [
    {
      "name": "load-keys",
      "shell": "bash",
      "args": [
        "-c",
        "echo \"CONTEXT7_API_KEY=$(cat ~/.context7-api-key)\" > CLAUDE_ENV_FILE"
      ]
    }
  ]
}
```

## 🔄 Complete Example

```json
{
  "SessionStart": {
    "enabled": true,
    "commands": [
      {
        "name": "init-env",
        "shell": "bash",
        "args": ["-c", "source ~/.zshrc && export PATH=\"$HOME/.npm-global/bin:$PATH\""],
        "async": true
      },
      {
        "name": "git-fetch",
        "shell": "bash",
        "args": ["-c", "git fetch -p"],
        "async": true
      },
      {
        "name": "check-status",
        "shell": "bash",
        "args": ["-c", "git status --short > /tmp/git-status.txt"],
        "async": true
      }
    ]
  }
}
```

## 📝 Best Practices

1. **Use `async: true`** for long-running commands
2. **Check for file existence** before operations
3. **Log all actions** for debugging
4. **Handle errors gracefully** with `onError: "continue"`

## 🚨 Troubleshooting

**Issue**: Commands not running
**Solution**: Check `"enabled": true` and verify shell path

**Issue**: Environment variables not persisting
**Solution**: Use `CLAUDE_ENV_FILE` for persistent variables

---

### 查询 3: PreToolUse 参数校验

**查询内容**:
```
Explain PreToolUse hook for parameter validation and safety checks.
Provide examples for preventing dangerous operations and validating inputs.
use context7
```

**Context7 返回结果** (示例):

---

# PreToolUse Hook: Parameter Validation & Safety

## 🎯 Purpose
PreToolUse intercepts tool calls before execution, allowing you to validate parameters and prevent dangerous operations.

## ⚙️ How It Works

```
User Action → PreToolUse Hook → [Validate] → Allow/Deny → Tool Execute
                                      ↓
                                 [Log] → [Modify]
```

## 🔒 Validation Examples

### Example 1: Prevent Dangerous Deletes
```json
{
  "PreToolUse": {
    "matchers": {
      "toolNames": ["Bash"],
      "patterns": ["rm -rf", "sudo"]
    },
    "commands": [
      {
        "name": "validate-delete",
        "shell": "bash",
        "args": [
          "-c",
          "if [[ \"$1\" == *\"rm -rf\"* ]]; then\n  if [[ \"$1\" == *\"~/.claude\"* ]]; then\n    echo \"Blocked: Deleting .claude directory\"\n    exit 1\n  fi\nfi"
        ]
      }
    ]
  }
}
```

### Example 2: Validate Paths
```json
{
  "PreToolUse": {
    "commands": [
      {
        "name": "validate-path",
        "shell": "bash",
        "args": [
          "-c",
          "if [[ \"$1\" == *\"/etc\"* || \"$1\" == *\"/usr\"* ]]; then\n  echo \"Error: Accessing system directories is blocked\"\n  exit 1\nfi"
        ]
      }
    ]
  }
}
```

### Example 3: Require Confirmation for Push
```json
{
  "PreToolUse": {
    "matchers": {
      "patterns": ["git push"]
    },
    "commands": [
      {
        "name": "confirm-push",
        "shell": "bash",
        "args": [
          "-c",
          "echo \"Git push detected. Confirm with: echo 'APPROVED'\""
        ]
      }
    ]
  }
}
```

### Example 4: Validate AskUserQuestion Format
```json
{
  "PreToolUse": {
    "matchers": {
      "toolNames": ["Write", "Edit"]
    },
    "commands": [
      {
        "name": "validate-aq",
        "shell": "bash",
        "args": [
          "-c",
          "if grep -q \"AskUserQuestion({\" \"$FILE\"; then\n  if ! grep -q \"questions:\" \"$FILE\"; then\n    echo \"Error: Use 'questions:' not 'question:' in AskUserQuestion\"\n    exit 1\n  fi\nfi"
        ]
      }
    ]
  }
}
```

## 🔧 Complete Example

```json
{
  "PreToolUse": {
    "enabled": true,
    "matchers": {
      "toolNames": ["Bash", "Write", "Edit"],
      "patterns": ["deploy", "push", "rm"]
    },
    "commands": [
      {
        "name": "safety-check",
        "shell": "bash",
        "args": [
          "-c",
          "if [[ \"$1\" == *\"rm -rf\"* ]]; then\n  if [[ \"$1\" == *\"/\" ]] && [[ \"$1\" != *\"./tmp/\"* ]]; then\n    echo \"Blocked: Unsafe delete operation\"\n    exit 1\n  fi\nfi"
        ],
        "onError": "continue"
      }
    ]
  }
}
```

## ✅ Validation Checklist

- [ ] Check for dangerous commands (rm -rf, sudo, format)
- [ ] Validate file paths (no system directories)
- [ ] Require confirmation for push operations
- [ ] Check AskUserQuestion format (questions: array)
- [ ] Sanitize user inputs
- [ ] Log all validations

## 🚨 Best Practices

1. **Fail Fast**: Exit immediately on invalid input
2. **Log Everything**: Record all validations
3. **Use Patterns**: Match specific commands/patterns
4. **Async for Heavy**: Use `async: true` for slow checks
5. **Continue on Error**: Use `onError: "continue"` for logging

---

### 查询 4: PostToolUse 自动部署

**查询内容**:
```
How to set up PostToolUse hook for auto-deployment after file changes?
Include integration with Git and automation scripts.
use context7
```

**Context7 返回结果** (示例):

---

# PostToolUse Hook: Auto-Deployment After Changes

## 🎯 Purpose
PostToolUse automatically deploys changes after tool execution, ensuring your code is always up-to-date.

## ⚙️ Workflow

```
File Changed → PostToolUse → Detect Change → Auto Deploy → Git Commit → Deploy
```

## 📦 Configuration

### Basic Setup
```json
{
  "PostToolUse": {
    "enabled": true,
    "matchers": {
      "toolNames": ["Write", "Edit"],
      "patterns": ["*.md", "*.json", "*.sh"]
    },
    "commands": [
      {
        "name": "auto-deploy",
        "shell": "bash",
        "args": ["-c", "cd $CLAUDE_WORKSPACE && bash scripts/auto-deploy.sh"],
        "async": true
      }
    ]
  }
}
```

## 💻 Practical Examples

### Example 1: Deploy on Markdown Changes
```bash
{
  "matchers": {
    "toolNames": ["Write", "Edit"],
    "patterns": ["*.md"]
  },
  "commands": [
    {
      "name": "deploy-docs",
      "shell": "bash",
      "args": [
        "-c",
        "cd $CLAUDE_WORKSPACE && git add . && git commit -m \"docs: auto-update $(date)\" && ./deploy.sh"
      ],
      "async": true
    }
  ]
}
```

### Example 2: Deploy on JSON Config Changes
```json
{
  "matchers": {
    "patterns": ["*.json"]
  },
  "commands": [
    {
      "name": "validate-json",
      "shell": "bash",
      "args": [
        "-c",
        "if jq empty \"$FILE\"; then echo \"Valid JSON\"; else echo \"Invalid JSON\"; exit 1; fi"
      ]
    },
    {
      "name": "deploy-config",
      "shell": "bash",
      "args": [
        "-c",
        "cd $CLAUDE_WORKSPACE && bash scripts/deploy-config.sh"
      ],
      "async": true
    }
  ]
}
```

### Example 3: Deploy on Shell Script Changes
```bash
{
  "matchers": {
    "patterns": ["*.sh"]
  },
  "commands": [
    {
      "name": "make-executable",
      "shell": "bash",
      "args": ["-c", "chmod +x \"$FILE\""]
    },
    {
      "name": "deploy-scripts",
      "shell": "bash",
      "args": [
        "-c",
        "cd $CLAUDE_WORKSPACE && git add . && bash scripts/deploy-scripts.sh"
      ],
      "async": true
    }
  ]
}
```

## 🔄 Complete Auto-Deploy Example

```json
{
  "PostToolUse": {
    "enabled": true,
    "matchers": {
      "toolNames": ["Write", "Edit", "Bash"]
    },
    "commands": [
      {
        "name": "detect-changes",
        "shell": "bash",
        "args": [
          "-c",
          "cd $CLAUDE_WORKSPACE && git diff --quiet && git diff --cached --quiet && echo 'No changes'"
        ]
      },
      {
        "name": "auto-deploy",
        "shell": "bash",
        "args": [
          "-c",
          "cd $CLAUDE_WORKSPACE && bash scripts/auto-deploy.sh --auto"
        ],
        "async": true,
        "onError": "continue"
      }
    ]
  }
}
```

## 📜 Deploy Script Example (auto-deploy.sh)

```bash
#!/bin/bash
set -e

echo "🔄 Auto-deploying changes..."

# 1. Check for changes
if git diff --quiet && git diff --cached --quiet; then
  echo "No changes to deploy"
  exit 0
fi

# 2. Validate files
if grep -q "AskUserQuestion({" *.md 2>/dev/null; then
  if ! grep -q "questions:" *.md 2>/dev/null; then
    echo "❌ Error: AskUserQuestion format invalid"
    exit 1
  fi
fi

# 3. Commit changes
git add .
git commit -m "auto-deploy: $(date '+%Y-%m-%d %H:%M')"

# 4. Deploy to production
DEPLOY_PATH="$HOME/.claude/skills/project-name"
mkdir -p "$DEPLOY_PATH"
cp *.md "$DEPLOY_PATH/"
cp -r .claude "$DEPLOY_PATH/"

echo "✅ Deployment complete"

# 5. Run tests
if [ -f "scripts/test.sh" ]; then
  bash scripts/test.sh
fi
```

## 🔍 Change Detection Logic

```bash
# Check if files changed
if git status --short | grep -q "M "; then
  echo "Changes detected"
  # Trigger deployment
fi

# Specific file changes
if git diff --name-only | grep -q "SKILL.md"; then
  echo "SKILL.md changed - deploying"
fi
```

## ✅ Best Practices

1. **Detect Changes**: Check git status before deploying
2. **Validate First**: Check file formats before commit
3. **Async Execution**: Use `async: true` to avoid blocking
4. **Error Handling**: Use `onError: "continue"` for logging
5. **Run Tests**: Validate deployment with tests
6. **Log Everything**: Record all deployments

## 🚨 Troubleshooting

**Issue**: Infinite deploy loop
**Solution**: Use file checks, not tool trigger alone

**Issue**: Deploying unchanged files
**Solution**: Check `git diff --quiet` before deploying

**Issue**: Slow deployments
**Solution**: Use `async: true` and skip tests in some cases

---

### 查询 5: 最佳实践

**查询内容**:
```
Claude Code hooks security best practices and performance optimization.
Include error handling, async operations, and logging.
use context7
```

**Context7 返回结果** (示例):

---

# Claude Code Hooks: Security & Performance Best Practices

## 🔒 Security Best Practices

### 1. Principle of Least Privilege
```json
{
  "security": {
    "allowedDirectories": [
      "$CLAUDE_WORKSPACE",
      "/tmp/claude-deploy"
    ],
    "blockedCommands": [
      "rm -rf /",
      "sudo",
      "format",
      "mkfs"
    ],
    "requireApproval": [
      "git push --force",
      "docker run --privileged",
      "curl -X POST $WEBHOOK_URL"
    ]
  }
}
```

### 2. Input Validation
```bash
# Always validate inputs
{
  "commands": [
    {
      "name": "validate-input",
      "shell": "bash",
      "args": [
        "-c",
        "if [[ \"$FILE\" == *\"../\"* ]]; then\n  echo \"Error: Path traversal detected\"\n  exit 1\nfi"
      ]
    }
  ]
}
```

### 3. Sanitize Environment
```bash
# Remove dangerous env vars
unset LD_PRELOAD
unset LD_LIBRARY_PATH
```

### 4. Audit Trail
```bash
# Log all hook executions
echo "[$(date)] HOOK=$HOOK_NAME USER=$USER CMD=\"$COMMAND\"" >> /var/log/claude-hooks.log
```

## ⚡ Performance Optimization

### 1. Async Execution
```json
{
  "commands": [
    {
      "name": "async-task",
      "shell": "bash",
      "args": ["-c", "heavy-command"],
      "async": true
    }
  ]
}
```

### 2. Skip Expensive Operations
```bash
{
  "matchers": {
    "patterns": ["*.md"]
  },
  "commands": [
    {
      "name": "quick-deploy",
      "shell": "bash",
      "args": ["-c", "if [ \"$SKIP_TESTS\" = \"true\" ]; then skip-tests; fi"]
    }
  ]
}
```

### 3. Cache Results
```bash
# Cache expensive operations
if [ -f /tmp/cache.json ] && [ $(($(date +%s) - $(stat -f %m /tmp/cache.json))) -lt 3600 ]; then
  cat /tmp/cache.json
else
  expensive-operation > /tmp/cache.json
fi
```

## 🔄 Error Handling

### 1. Continue on Error (Logging)
```json
{
  "commands": [
    {
      "name": "log-action",
      "shell": "bash",
      "args": ["-c", "some-command"],
      "onError": "continue"
    }
  ]
}
```

### 2. Fail Fast (Critical Operations)
```json
{
  "commands": [
    {
      "name": "critical-check",
      "shell": "bash",
      "args": ["-c", "if ! validate-critical; then exit 1; fi"]
    }
  ]
}
```

### 3. Retry Logic
```bash
for i in {1..3}; do
  if command; then
    echo "Success"
    break
  else
    echo "Attempt $i failed, retrying..."
    sleep 5
  fi
done
```

## 📝 Logging Strategy

### 1. Structured Logging
```bash
LOG_JSON=$(jq -n \
  --arg ts "$(date -Iseconds)" \
  --arg hook "$HOOK_NAME" \
  --arg status "$STATUS" \
  '{timestamp: $ts, hook: $hook, status: $status}')

echo "$LOG_JSON" >> /var/log/claude-hooks.log
```

### 2. Log Rotation
```bash
# Rotate logs daily
if [ $(date +%H%M) = "0000" ]; then
  gzip /var/log/claude-hooks.log
  mv /var/log/claude-hooks.log.gz /var/log/archive/$(date -I).gz
fi
```

### 3. Log Levels
```bash
log() {
  case "$1" in
    DEBUG) [[ "$LOG_LEVEL" = "DEBUG" ]] && echo "[DEBUG] $2" ;;
    INFO) [[ "$LOG_LEVEL" =~ ^(DEBUG|INFO)$ ]] && echo "[INFO] $2" ;;
    ERROR) echo "[ERROR] $2" ;;
  esac
}
```

## 🚀 Performance Checklist

- [ ] Use `async: true` for long-running commands
- [ ] Cache expensive operations
- [ ] Skip unnecessary checks
- [ ] Batch operations when possible
- [ ] Use efficient tools (jq, grep, awk)
- [ ] Limit file scanning
- [ ] Debounce rapid triggers

## 🔐 Security Checklist

- [ ] Restrict to allowed directories
- [ ] Block dangerous commands
- [ ] Validate all inputs
- [ ] Sanitize environment
- [ ] Log all actions
- [ ] Use minimal privileges
- [ ] Review all hook commands
- [ ] Test in isolation

## 📊 Monitoring

### Health Checks
```bash
{
  "commands": [
    {
      "name": "health-check",
      "shell": "bash",
      "args": [
        "-c",
        "if ! pgrep -f 'deploy-daemon' > /dev/null; then echo 'ERROR: Daemon not running'; exit 1; fi"
      ]
    }
  ]
}
```

### Metrics
```bash
# Track hook execution time
START=$(date +%s%N)
command
END=$(date +%s%N)
DURATION=$(( (END - START) / 1000000 ))
echo "$HOOK_NAME,$DURATION" >> /var/log/hook-metrics.log
```

---

## 🎯 结论

Context7 MCP 提供实时获取 Claude Code hooks 官方文档的便捷方式：

✅ **最新文档** - 实时获取官方最新内容
✅ **版本特定** - 根据你的版本提供准确信息
✅ **代码示例** - 可运行的完整配置
✅ **最佳实践** - 官方推荐的安全和性能优化

**使用方法**: 在 Claude Code 中任何问题末尾添加 `use context7`

---

**现在就把这些查询复制到 Claude Code 中试试吧！** 🚀
