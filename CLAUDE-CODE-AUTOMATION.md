# Claude Code Git自动化最佳实践

> 基于Claude Code架构和标准模式的Git提交与部署方案

---

## 📋 Claude Code官方推荐的自动化模式

### 1. 项目结构标准

Claude Code项目应遵循以下结构：

```
your-project/
├── .claude/              # Claude Code配置目录 (必需)
│   ├── config.json       # 自动化配置
│   ├── settings.json     # 项目设置
│   └── commands/         # 命令注册
│       ├── deploy.json
│       ├── test.json
│       └── build.json
├── .git/hooks/           # Git Hooks
│   ├── pre-commit
│   └── post-commit
├── CLAUDE.md            # 项目说明 (Claude Code自动读取)
└── your-files...
```

### 2. 核心配置

#### `.claude/config.json` - 自动化配置

```json
{
  "version": "1.0",
  "automation": {
    "enabled": true,
    "git": {
      "autoCommit": true,
      "commitMessageTemplate": "feat|fix|docs|chore: {type} - {timestamp}",
      "hooks": {
        "preCommit": true,
        "postCommit": true
      }
    },
    "deployment": {
      "autoDeploy": true,
      "targetPath": "~/.claude/skills/{project-name}",
      "backupEnabled": true,
      "backupRetention": 7
    },
    "testing": {
      "enabled": true,
      "runOnDeploy": true,
      "requiredPassRate": 100
    }
  }
}
```

#### `.claude/settings.json` - 项目设置

```json
{
  "version": "1.0",
  "project": {
    "name": "your-project-name",
    "type": "claude-code-skill",
    "version": "1.0.0"
  },
  "mcp": {
    "autoLoad": true,
    "servers": ["context7"]
  },
  "automation": {
    "onFileChange": "deploy",
    "onCommit": "test-and-deploy"
  }
}
```

#### `.claude/commands/deploy.json` - 部署命令

```json
{
  "name": "deploy",
  "description": "自动部署到生产环境",
  "usage": "/deploy [options]",
  "script": "./scripts/auto-deploy.sh",
  "parameters": [
    {
      "name": "message",
      "description": "自定义提交信息",
      "required": false
    },
    {
      "name": "skip-tests",
      "description": "跳过测试",
      "required": false,
      "type": "boolean"
    }
  ],
  "hooks": ["post-commit"]
}
```

---

## 🔧 Git Hooks最佳实践

### Pre-Commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

set -e

# Claude Code Pre-Commit检查
echo "🔍 Running Claude Code pre-commit checks..."

# 1. 检查Claude Code配置
if [ ! -d ".claude" ]; then
    echo "❌ Error: .claude directory not found"
    exit 1
fi

# 2. 验证JSON配置
if command -v jq >/dev/null 2>&1; then
    if [ -f ".claude/config.json" ]; then
        jq empty .claude/config.json || {
            echo "❌ Error: Invalid JSON in .claude/config.json"
            exit 1
        }
    fi
fi

# 3. 检查必需文件
REQUIRED_FILES=("CLAUDE.md" "README.md")
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "⚠️  Warning: Required file '$file' not found"
    fi
done

# 4. 运行自动化脚本
if [ -f "scripts/pre-commit-check.sh" ]; then
    bash scripts/pre-commit-check.sh
fi

echo "✅ Pre-commit checks passed"
```

### Post-Commit Hook

```bash
#!/bin/bash
# .git/hooks/post-commit

# 获取提交信息
COMMIT_MSG=$(git log -1 --pretty=%s)
COMMIT_HASH=$(git log -1 --pretty=%h)

echo "📦 Commit $COMMIT_HASH: $COMMIT_MSG"
echo "🚀 Triggering auto-deployment..."

# 自动部署
if [ -f "scripts/auto-deploy.sh" ]; then
    bash scripts/auto-deploy.sh --auto
else
    echo "⚠️  Auto-deploy script not found"
fi
```

---

## 🚀 自动化部署流程

### 标准部署脚本 (`scripts/auto-deploy.sh`)

```bash
#!/bin/bash
# 标准化自动部署脚本

set -e

# 配置
PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)")
DEPLOY_PATH="$HOME/.claude/skills/$PROJECT_NAME"
BACKUP_SUFFIX="-backup-$(date +%Y%m%d-%H%M%S)"
AUTO_MODE=false

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        --auto)
            AUTO_MODE=true
            shift
            ;;
        --message)
            CUSTOM_MSG="$2"
            shift 2
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔═══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        Claude Code Auto Deploy           ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}\n"

# 检查Git状态
echo -e "${BLUE}[1/5] Checking Git status...${NC}"
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${GREEN}✅ Working directory clean${NC}"
else
    echo -e "${YELLOW}📝 Uncommitted changes detected${NC}"
    git status --short
fi

# 准备提交
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\n${BLUE}[2/5] Preparing commit...${NC}"
    MSG="${CUSTOM_MSG:-chore: auto-update $(date '+%Y-%m-%d %H:%M')}"

    git add .
    git commit -m "$MSG"
    echo -e "${GREEN}✅ Commit created${NC}"
fi

# 运行测试
if [ "$SKIP_TESTS" != "true" ]; then
    echo -e "\n${BLUE}[3/5] Running tests...${NC}"
    if [ -f "scripts/test.sh" ]; then
        bash scripts/test.sh || {
            echo -e "${RED}❌ Tests failed${NC}"
            exit 1
        }
        echo -e "${GREEN}✅ All tests passed${NC}"
    else
        echo -e "${YELLOW}⚠️  Test script not found, skipping${NC}"
    fi
fi

# 部署
echo -e "\n${BLUE}[4/5] Deploying to production...${NC}"

# 创建部署目录
mkdir -p "$DEPLOY_PATH"

# 备份现有文件
if [ -n "$(ls -A $DEPLOY_PATH 2>/dev/null)" ]; then
    echo -e "${YELLOW}💾 Backing up existing files...${NC}"
    BACKUP_DIR="$DEPLOY_PATH$BACKUP_SUFFIX"
    cp -r "$DEPLOY_PATH" "$BACKUP_DIR"
    echo -e "${GREEN}✅ Backup created: $BACKUP_DIR${NC}"
fi

# 部署核心文件
echo -e "${YELLOW}📦 Deploying files...${NC}"
# 根据项目类型调整文件列表
DEPLOY_FILES=("CLAUDE.md" "README.md" "SKILL.md")
for file in "${DEPLOY_FILES[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$DEPLOY_PATH/"
        echo -e "  ✅ $file"
    fi
done

# 部署.claude配置
if [ -d ".claude" ]; then
    cp -r .claude "$DEPLOY_PATH/"
    echo -e "  ✅ .claude/"
fi

echo -e "${GREEN}✅ Deployment complete${NC}"

# 验证部署
echo -e "\n${BLUE}[5/5] Verifying deployment...${NC}"
FILE_COUNT=$(ls -1 "$DEPLOY_PATH" | wc -l)
echo -e "${GREEN}✅ Deployed $FILE_COUNT files${NC}"

# 显示部署摘要
echo -e "\n${GREEN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            Deployment Summary             ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"
echo -e "Project: $PROJECT_NAME"
echo -e "Deploy Path: $DEPLOY_PATH"
echo -e "Files Deployed: $FILE_COUNT"
echo -e "Commit: $(git rev-parse --short HEAD)"
echo -e "Message: $(git log -1 --pretty=%s)"
echo -e "Time: $(date '+%Y-%m-%d %H:%M:%S')"

if [ -n "$BACKUP_DIR" ]; then
    echo -e "Backup: $BACKUP_DIR"
fi

echo -e "\n${GREEN}✅ Auto-deployment successful!${NC}\n"
```

---

## 📝 CLAUDE.md - Claude Code指令文件

Claude Code会自动读取项目根目录的`CLAUDE.md`文件，这是配置自动化行为的关键：

```markdown
# Claude Code Project Configuration

## 🎯 自动化规则

### Git自动化
- 自动执行Git hooks（pre-commit, post-commit）
- 使用标准化的提交信息格式
- 自动部署到生产环境

### 部署规则
- 部署路径: `~/.claude/skills/{project-name}`
- 每次部署前自动备份
- 部署后自动运行测试

### 测试规则
- 部署前必须通过所有测试
- 测试失败时停止部署
- 生成详细的测试报告

## 🔧 命令

### /deploy
自动执行完整的Git提交流程：
1. 暂存所有变更
2. 生成提交信息
3. 运行pre-commit检查
4. 创建Git提交
5. 触发post-commit自动部署

### /test
运行项目测试套件：
- 文件完整性检查
- 格式验证
- 性能测试

### /watch
启用文件监控模式：
- 持续监控文件变化
- 自动触发部署
- 记录变更日志

## 🚀 工作流程

1. **开发阶段**
   - 编辑文件
   - 自动保存触发监控
   - 持续部署到测试环境

2. **提交阶段**
   - 运行pre-commit检查
   - 自动生成提交信息
   - 创建Git提交

3. **部署阶段**
   - post-commit触发
   - 备份现有文件
   - 部署到生产环境
   - 运行部署验证

## ✅ 检查清单

每次提交前自动检查：
- [ ] Claude Code配置存在
- [ ] JSON配置格式正确
- [ ] 必需文件存在
- [ ] 测试通过
- [ ] 构建成功

## 📚 参考文档

- Claude Code MCP: https://docs.anthropic.com/en/docs/claude-code/mcp
- Context7: https://context7.com
- Best Practices: /docs/AUTOMATION.md
```

---

## 🎯 Claude Code命令注册

### 标准命令格式

每个命令应在`.claude/commands/`下创建对应的JSON文件：

```json
{
  "name": "command-name",
  "description": "命令描述",
  "usage": "/command-name [options]",
  "script": "./scripts/command-script.sh",
  "parameters": [
    {
      "name": "param-name",
      "description": "参数描述",
      "required": false,
      "type": "string|boolean|number"
    }
  ],
  "hooks": ["pre-command", "post-command"],
  "enabled": true
}
```

### 可用命令列表

| 命令 | 脚本 | 描述 |
|------|------|------|
| `/deploy` | `auto-deploy.sh` | 自动部署 |
| `/test` | `test.sh` | 运行测试 |
| `/watch` | `watch.sh` | 启动监控 |
| `/build` | `build.sh` | 构建项目 |
| `/setup` | `setup.sh` | 初始化环境 |

---

## 🔍 MCP集成

### Context7 MCP配置

```bash
# 在Claude Code中添加Context7 MCP
claude mcp add context7 -- npx -y @upstash/context7-mcp

# 或者使用远程服务器
claude mcp add context7 --transport http \
  context7 https://mcp.context7.com/mcp \
  --header "CONTEXT7_API_KEY: YOUR_API_KEY"
```

### 使用Context7查询文档

在Claude Code中输入：
```text
Configure Git hooks for auto-deployment. use context7
```

Context7会自动获取最新的Git文档和最佳实践。

---

## 📊 监控与日志

### 部署日志 (`logs/deploy.log`)

```bash
# 记录每次部署
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Deploy: $COMMIT_HASH - $COMMIT_MSG" \
  >> logs/deploy.log
```

### 错误日志 (`logs/error.log`)

```bash
# 记录错误
echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $1" \
  >> logs/error.log
```

---

## 🎓 最佳实践总结

### 1. 标准化项目结构
- 使用`.claude/`目录管理配置
- 遵循Git hooks标准
- 统一的脚本命名规范

### 2. 自动化优先
- 减少手动操作
- 自动化测试和部署
- 错误自动检测和报告

### 3. 配置驱动
- 使用JSON配置管理行为
- 保持配置的灵活性
- 文档化配置选项

### 4. 持续集成
- 每次提交自动触发
- 失败时自动回滚
- 完整的审计日志

### 5. 监控和观察
- 实时监控部署状态
- 详细的日志记录
- 性能指标跟踪

---

## 🚀 立即开始

1. **创建项目结构**
```bash
mkdir your-project
cd your-project
git init
mkdir -p .claude/commands scripts logs
```

2. **添加配置文件**
```bash
# 创建 .claude/config.json
# 创建 .claude/settings.json
# 创建 CLAUDE.md
```

3. **设置Git hooks**
```bash
# 创建 .git/hooks/pre-commit
# 创建 .git/hooks/post-commit
chmod +x .git/hooks/*
```

4. **创建自动化脚本**
```bash
# scripts/auto-deploy.sh
# scripts/test.sh
# scripts/watch.sh
```

5. **首次部署**
```bash
git add .
git commit -m "feat: initial commit with Claude Code automation"
# post-commit hook will trigger auto-deployment
```

---

**版本**: v1.0
**更新**: 2025-11-04
**基于**: Claude Code标准和最佳实践
