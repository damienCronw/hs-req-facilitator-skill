# Claude Code Skill 自动化部署指南

## 🎯 概述

本文档描述了 `hs-req-facilitator-skill` 项目的完整自动化工作流程，包括代码变更检测、自动Git提交、生产环境部署和测试验证。

---

## 🚀 快速开始

### 方法一：使用Claude Code命令（推荐）

在Claude Code中直接使用以下命令：

```bash
/deploy                    # 部署当前更改
/deploy "自定义提交信息"    # 部署并使用自定义提交信息

/test                      # 运行完整测试
/test quick               # 运行快速测试

/watch                    # 启动文件监控模式（每10秒检查一次）
/watch 5                  # 启动监控模式（每5秒检查一次）
```

### 方法二：手动执行脚本

```bash
# 自动部署
./auto-deploy.sh

# 运行生产环境测试
./test-production.sh

# 启动监控模式
./watch-and-deploy.sh
```

---

## 📋 自动化流程详解

### 1. Git自动提交

**触发时机**：
- 手动执行部署脚本时
- 文件监控检测到变化时
- 运行 `/deploy` 命令时

**自动执行**：
1. 检查工作区是否有未提交变更
2. 如果有变更，自动暂存并提交
3. 生成提交信息（支持自定义）
4. 显示最新提交记录

**提交信息格式**：
- 自定义：`/deploy "我的提交信息"`
- 自动生成：`chore: auto-update 2025-11-04 14:30 - 3 file(s)`

### 2. 生产环境自动部署

**目标目录**：`~/.claude/skills/hs-req-facilitator-skill`

**部署步骤**：
1. 创建生产环境目录（如果不存在）
2. 备份现有文件到 `~/...-backup-YYYYMMDD-HHMMSS`
3. 部署核心文件：
   - `SKILL.md`
   - `README.md`
   - `STAGE3-DEBUG.md`
4. 部署指南文件（如果存在）：
   - `ANALYZER.md`
   - `QUESTIONS.md`
   - `ENHANCER.md`
   - `MERGER.md`
   - `EMPTY-PROJECT.md`
   - `SPEC-WORKFLOW-INTEGRATION.md`
5. 从备份恢复重要文件（如 `CURSOR_CUSTOMIZATION_GUIDE.md`）

### 3. 自动测试验证

**测试阶段**：
- **环境检查**：验证生产环境目录和权限
- **文件完整性**：检查核心文件是否存在
- **AskUserQuestion格式**：验证交互格式正确性
- **版本信息**：确认README包含正确的版本号
- **指南文件**：检查所有指南文件
- **功能模拟**：测试文件操作功能
- **集成测试**：验证AskUserQuestion调用
- **性能基准**：检查文件读取性能

**测试结果示例**：
```
╔═══════════════════════════════════════════╗
║   Claude Code Skill 生产环境测试套件     ║
╚═══════════════════════════════════════════╝

总测试数：25
通过：25
失败：0
通过率：100%

✅ 所有测试通过！生产环境状态正常。
```

---

## 🔧 配置选项

### 配置文件：`.claude-config.json`

```json
{
  "automation": {
    "enabled": true,           // 启用自动化
    "autoDeploy": true,        // 自动部署
    "autoTest": true           // 自动测试
  },
  "git": {
    "autoCommitMessage": "auto-update {timestamp}",
    "deployOnCommit": true,    // 提交时自动部署
    "testOnDeploy": true       // 部署时自动测试
  },
  "production": {
    "path": "~/.claude/skills/hs-req-facilitator-skill",
    "autoBackup": true,        // 自动备份
    "backupRetentionDays": 7   // 备份保留天数
  },
  "testing": {
    "enabled": true,
    "autoRun": true,
    "tests": [
      "file-integrity",
      "askuserquestion-format",
      "version-check",
      "performance"
    ]
  }
}
```

---

## 🔍 Git Hooks

### Pre-Commit Hook（提交前检查）

**位置**：`.git/hooks/pre-commit`

**检查项**：
- ✅ AskUserQuestion格式是否正确
- ✅ 必需Markdown结构是否存在
- ✅ 工作流程描述是否存在
- ✅ 文件大小是否正常

**失败处理**：
```bash
❌ 发现 1 个错误，请修复后再提交
```

### Post-Commit Hook（提交后自动部署）

**位置**：`.git/hooks/post-commit`

**执行步骤**：
1. 确认在正确的Git仓库中
2. 询问是否自动部署
3. 执行部署脚本
4. 检查是否有新的变更需要提交

**交互示例**：
```
=== Git Hook: Post-Commit ===
检测到hs-req-facilitator-skill项目提交
是否自动部署到生产环境？[Y/n] y

🚀 执行自动部署...
[1/4] 检查Git状态...
[2/4] 准备提交变更...
[3/4] 部署到生产环境...
[4/4] 运行部署测试...

✅ 自动化部署流程完成！
```

---

## 📊 文件监控模式

### 使用场景
当你在开发过程中需要持续修改文档和代码时，可以使用监控模式。

### 启动监控

```bash
# 使用默认间隔（10秒）
./watch-and-deploy.sh

# 自定义间隔（5秒）
./watch-and-deploy.sh 5
```

### 监控逻辑
1. 计算项目文件的MD5哈希值
2. 每隔指定时间重新计算哈希
3. 检测到变化时自动触发部署
4. 记录变化日志到 `watch-deploy.log`

### 日志示例
```
[2025-11-04 14:30:15] 检测到文件变化！
触发自动部署...
[1/4] 检查Git状态...
[2/4] 准备提交变更...
✅ 自动部署完成
继续监控...
```

---

## 🧪 测试套件

### 运行测试

```bash
# 完整测试
./test-production.sh

# 快速测试（仅核心检查）
./test-production.sh quick
```

### 测试类别

#### 1. 环境检查
- ✅ 生产环境目录存在
- ✅ 目录可读可写
- ✅ 权限验证

#### 2. 文件完整性
- ✅ SKILL.md存在且非空
- ✅ README.md存在
- ✅ STAGE3-DEBUG.md存在

#### 3. AskUserQuestion格式
- ✅ 包含AskUserQuestion调用
- ✅ 使用正确格式（questions数组）
- ✅ 包含Stage 3描述

#### 4. 版本信息
- ✅ README包含v2.0.0
- ✅ 包含配置驱动声明

#### 5. 指南文件
- ✅ ANALYZER.md存在
- ✅ QUESTIONS.md存在
- ✅ ENHANCER.md存在
- ✅ MERGER.md存在
- ✅ EMPTY-PROJECT.md存在

#### 6. 功能测试
- ✅ 文件复制功能
- ✅ Markdown语法检查

#### 7. 集成测试
- ✅ AskUserQuestion调用计数
- ✅ questions数组格式检查

#### 8. 性能测试
- ✅ 文件读取性能（<1000ms）

---

## 💾 备份与恢复

### 自动备份

每次部署时，会自动备份现有生产环境文件：

**备份位置**：
```
~/.claude/skills/hs-req-facilitator-skill-backup-YYYYMMDD-HHMMSS/
```

**备份内容**：
- 所有现有文件
- 保持完整目录结构

### 手动恢复

如需恢复到备份版本：

```bash
# 查看所有备份
ls -la ~/.claude/skills/ | grep backup

# 恢复指定备份
BACKUP_DIR="~/.claude/skills/hs-req-facilitator-skill-backup-20251104-143015"
rm -rf ~/.claude/skills/hs-req-facilitator-skill
mv "$BACKUP_DIR" ~/.claude/skills/hs-req-facilitator-skill
```

### 清理备份

```bash
# 删除7天前的备份
find ~/.claude/skills/ -name "hs-req-facilitator-skill-backup-*" -type d -mtime +7 -exec rm -rf {} +
```

---

## 🔄 工作流程图

```
┌─────────────────────────────────────────────────┐
│              开始开发                            │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│              编辑文档/代码                       │
│         (SKILL.md, README.md, etc.)             │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│              文件变化检测                        │
│         (监控模式 / 手动部署)                    │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│            Pre-Commit质量检查                    │
│  • AskUserQuestion格式检查                       │
│  • 文件完整性验证                               │
│  • 语法检查                                     │
└────────────────────┬────────────────────────────┘
                     │
              失败？───是───▶ 停止，修复错误
                     │
                     否
                     ▼
┌─────────────────────────────────────────────────┐
│              Git自动提交                         │
│     • 暂存所有变更                               │
│     • 生成提交信息                               │
│     • 记录提交历史                               │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│            Post-Commit自动部署                   │
│     • 询问用户确认                               │
│     • 备份现有文件                               │
│     • 复制新文件到生产环境                       │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│              自动测试验证                        │
│     • 环境检查                                   │
│     • 文件完整性                                 │
│     • AskUserQuestion格式                        │
│     • 性能测试                                   │
└────────────────────┬────────────────────────────┘
                     │
              失败？───是───▶ 发送告警
                     │
                     否
                     ▼
┌─────────────────────────────────────────────────┐
│              部署完成                            │
│     • 显示测试报告                               │
│     • 显示部署统计                               │
│     • 继续监控 (如果启用)                        │
└─────────────────────────────────────────────────┘
```

---

## 📝 最佳实践

### 1. 提交前检查
```bash
# 运行快速测试
./test-production.sh quick

# 检查AskUserQuestion格式
grep -A 5 "AskUserQuestion" SKILL.md
```

### 2. 使用监控模式开发
```bash
# 启动监控，开始编辑文档
./watch-and-deploy.sh 5
```

### 3. 定期清理备份
```bash
# 每月清理一次备份
crontab -e
# 添加：0 0 1 * * find ~/.claude/skills/ -name "*-backup-*" -type d -mtime +30 -exec rm -rf {} +
```

### 4. 自定义部署流程
```bash
# 使用自定义提交信息
./auto-deploy.sh "feat: 更新Stage 3交互逻辑"

# 跳过交互确认（CI/CD环境）
echo "y" | ./auto-deploy.sh
```

---

## ❓ 常见问题

### Q1: Git hooks没有执行？

**A1**: 检查hooks权限：
```bash
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/post-commit
```

### Q2: 部署失败，提示权限不足？

**A2**: 确保生产环境目录可写：
```bash
chmod -R 755 ~/.claude/skills/hs-req-facilitator-skill
```

### Q3: AskUserQuestion格式检查失败？

**A3**: 检查SKILL.md中的格式：
```bash
# 正确格式
AskUserQuestion({
  questions: [{
    header: "问题标题",
    question: "具体问题",
    options: [{label: "选项1", description: "描述"}],
    multiSelect: false
  }]
})

# 错误格式（会触发检查失败）
AskUserQuestion({
  question: "问题",
  context: "上下文"
})
```

### Q4: 监控模式检测不到变化？

**A4**: 确认监控目录正确：
```bash
# 检查当前目录
pwd
# 应该显示项目根目录
```

### Q5: 如何禁用自动部署？

**A5**: 修改 `.claude-config.json`：
```json
{
  "automation": {
    "enabled": false
  }
}
```

---

## 🎯 总结

这套自动化系统提供了：

1. **完全自动化**：从代码变更到生产部署无需手动操作
2. **质量保证**：多层次检查确保代码质量
3. **可追溯性**：每次部署都有完整记录
4. **安全性**：自动备份和回滚机制
5. **灵活性**：支持自定义配置和流程

通过这套系统，你可以专注于内容创作，而自动化处理所有的部署和测试工作。

---

**版本**：v2.0.0
**更新日期**：2025-11-04
**维护者**：Claude Code自动化系统
