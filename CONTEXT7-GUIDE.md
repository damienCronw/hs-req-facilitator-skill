# Context7 MCP 全局安装指南

## ✅ 安装状态

Context7 MCP 已成功全局安装！

### 安装信息

- **版本**: 最新版本 (@upstash/context7-mcp)
- **安装路径**: `/Users/damien/.npm-global/bin/context7-mcp`
- **配置文件**: `~/.claude/mcp-servers.json`
- **PATH配置**: 已添加到 `~/.zshrc`

---

## 🚀 快速开始

### 1. 验证安装

```bash
# 检查可执行文件
which context7-mcp

# 查看帮助
context7-mcp --help
```

### 2. 在Claude Code中使用

在Claude Code中输入你的问题时，直接添加：

```text
Create a Next.js middleware that checks for a valid JWT in cookies. use context7
```

或者使用更具体的需求：

```text
Configure Git hooks for automatic deployment in a Claude Code project. use context7
```

---

## 📚 使用方法

### 基本用法

在Claude Code中 любой代码、配置或设置相关问题时，只需在提示末尾添加 `use context7`。

**示例**:
```
Build a React component with TypeScript that displays a loading spinner.
use context7
```

```
Set up ESLint and Prettier for a TypeScript project.
use context7
```

```
Create a Docker configuration for a Node.js application.
use context7
```

### 高级用法

#### 1. 指定特定库

如果你知道要使用的具体库，直接在提示中指定：

```text
Implement authentication with Supabase. use library /supabase/supabase
```

#### 2. 组合使用

与你的自动化项目结合：

```text
Set up Git hooks for auto-deployment of Claude Code Skill project. use context7
```

```text
Configure pre-commit checks for AskUserQuestion format validation. use context7
```

---

## 🔧 配置选项

### 全局配置文件

位置：`~/.claude/mcp-servers.json`

```json
{
  "mcpServers": {
    "context7": {
      "command": "context7-mcp",
      "args": [
        "--transport",
        "stdio"
      ],
      "env": {
        "CONTEXT7_API_KEY": ""
      }
    },
    "context7-http": {
      "command": "context7-mcp",
      "args": [
        "--transport",
        "http",
        "--port",
        "3000"
      ],
      "env": {
        "CONTEXT7_API_KEY": ""
      }
    }
  }
}
```

### 环境变量

如果你有API密钥，可以设置环境变量：

```bash
# 临时设置
export CONTEXT7_API_KEY="your-api-key-here"

# 永久设置（添加到 ~/.zshrc）
echo 'export CONTEXT7_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

**获取API密钥**: https://context7.com/dashboard

---

## 🎯 与Claude Code项目集成

### 在自动化脚本中使用

你可以在自动化脚本中使用Context7获取最新文档：

```bash
# 在部署前获取最佳实践
context7-mcp --transport http --port 3000 &
echo "使用Context7获取最新Git最佳实践..."
```

### 与你的自动化项目结合

在你的Claude Code项目中，现在可以这样使用：

```
更新自动化脚本，添加Context7 MCP集成。参考最新最佳实践。
use context7
```

```
优化pre-commit检查，参考Git hooks最佳实践。
use context7
```

---

## 📊 功能特性

### ✅ 已获取的功能

1. **实时文档** - 获取最新版本的库文档
2. **代码示例** - 真实的、可工作的代码示例
3. **版本特定** - 根据你使用的版本提供准确信息
4. **API参考** - 完整的API文档和参数说明

### 支持的库

Context7支持数千个流行库，包括：
- **前端**: React, Vue, Angular, Next.js, Nuxt.js
- **后端**: Node.js, Express, FastAPI, Django
- **工具**: Git, Docker, Kubernetes, AWS
- **数据库**: PostgreSQL, MongoDB, Redis
- **测试**: Jest, Cypress, Playwright

---

## 🔍 故障排除

### Q1: Context7 MCP未响应

**解决方案**:
```bash
# 检查安装
which context7-mcp

# 重新安装
npm install -g @upstash/context7-mcp@latest
```

### Q2: 提示中未加载最新文档

**解决方案**:
1. 确保在提示中包含 `use context7`
2. 检查网络连接
3. 尝试添加具体的库名：`use library /react/react`

### Q3: API密钥错误

**解决方案**:
```bash
# 检查环境变量
echo $CONTEXT7_API_KEY

# 重新设置
export CONTEXT7_API_KEY="your-new-api-key"
```

---

## 📖 实际使用示例

### 示例1: 优化Git Hooks

```
Improve the pre-commit hook for a Claude Code project to include AskUserQuestion format validation.
参考最新Git hooks最佳实践。
use context7
```

**Context7将提供**:
- 最新的Git hooks配置方法
- pre-commit工具推荐
- 最佳实践示例
- 错误处理模式

---

### 示例2: 配置CI/CD

```
Set up GitHub Actions for automated deployment of a Claude Code skill package.
use context7
```

**Context7将提供**:
- GitHub Actions最新配置
- 部署管道示例
- 安全最佳实践
- 缓存优化技巧

---

### 示例3: Docker配置

```
Create a Docker configuration for deploying Claude Code automation scripts.
use context7
```

**Context7将提供**:
- 最佳Dockerfile实践
- 多阶段构建优化
- 安全配置指南
- 性能调优建议

---

## 🎓 高级技巧

### 1. 组合多个查询

```
Compare GitHub Actions vs GitLab CI for Claude Code projects.
Compare CircleCI vs Jenkins for automation.
use context7
```

### 2. 特定版本查询

```
Configure webpack 5 for TypeScript project with React 18.
use context7
```

### 3. 问题排查

```
Debug: Git hooks not triggering pre-commit checks in Claude Code project.
use context7
```

---

## 📝 使用检查清单

- [ ] Context7 MCP已全局安装
- [ ] 可执行文件在PATH中
- [ ] 配置文件已创建
- [ ] 在Claude Code中测试了基本用法
- [ ] 了解如何使用 `use context7`
- [ ] 有API密钥（可选）
- [ ] 测试了实际项目中的使用

---

## 🎉 与自动化项目结合

现在你可以将Context7的强大功能与你的Claude Code自动化项目结合：

```
优化 hs-req-facilitator-skill 项目的自动化脚本。
参考最新的Claude Code最佳实践、Git hooks优化和自动化部署模式。
use context7
```

这将为你提供：
- 最新的Claude Code文档
- Git hooks最佳实践
- 自动化部署模式
- 性能优化建议

---

## 📞 获取帮助

### 官方资源

- **Context7官网**: https://context7.com
- **文档**: https://docs.context7.com
- **GitHub**: https://github.com/upstash/context7

### 本地资源

- **安装验证**: `./~/test-context7.sh`
- **配置文件**: `~/.claude/mcp-servers.json`
- **可执行文件**: `/Users/damien/.npm-global/bin/context7-mcp`

---

## ✅ 完成确认

✅ Context7 MCP已全局安装
✅ PATH配置完成
✅ 全局配置文件创建
✅ 测试脚本运行成功
✅ 使用指南已提供

**你现在可以在Claude Code中随时使用Context7！**

只需在问题末尾添加 `use context7`，就能获取最新的、版本特定的文档和代码示例！

---

**版本**: v1.0
**更新**: 2025-11-04
**状态**: ✅ 完成
