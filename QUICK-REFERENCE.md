# 🚀 Claude Code Skill 自动化系统 - 快速参考

## ✅ 已完成的设置

你的 `hs-req-facilitator-skill` 项目现在拥有完整的自动化系统：

- ✅ Git自动提交和版本控制
- ✅ 生产环境自动部署
- ✅ Pre-commit质量检查
- ✅ Post-commit自动部署
- ✅ 生产环境测试套件
- ✅ 文件监控模式
- ✅ AskUserQuestion格式验证
- ✅ 自动备份和恢复机制

---

## 🎯 核心工作流程

### 自动部署流程（推荐）

```
编辑文档 → Git提交 → 自动部署 → 测试验证 → 完成
     ↓          ↓         ↓         ↓
  SKILL.md   git add   自动备份   质量检查
 README.md   git cm    自动复制   AskUserQuestion验证
             (可选)    自动测试   性能基准
```

### 监控模式流程

```
启动监控 → 文件变化 → 自动提交 → 自动部署 → 自动测试
     ↓         ↓         ↓         ↓         ↓
watch模式  检测变化   自动暂存   自动复制   自动验证
```

---

## 🖥️ 日常使用命令

### 1. 快速部署（推荐）

```bash
/deploy
```

或在终端中：

```bash
./auto-deploy.sh
```

**功能**：
- 自动检查Git状态
- 自动暂存未提交文件
- 生成提交信息（可自定义）
- 备份现有生产环境文件
- 部署到 `~/.claude/skills/hs-req-facilitator-skill`
- 自动运行测试验证

### 2. 运行测试

```bash
/test
```

或在终端中：

```bash
./test-production.sh
```

**测试内容**：
- 环境检查（目录、权限）
- 文件完整性验证
- AskUserQuestion格式检查
- 版本信息验证
- 指南文件检查
- 功能模拟测试
- 集成测试
- 性能基准测试

### 3. 启动监控模式

```bash
/watch
```

或在终端中：

```bash
./watch-and-deploy.sh
```

**功能**：
- 每10秒检查文件变化
- 检测到变化时自动提交
- 自动部署到生产环境
- 记录变化日志

---

## 📝 常用操作示例

### 示例1：更新SKILL.md

```bash
# 1. 编辑文件
vim SKILL.md

# 2. 部署更改
/deploy "feat: 更新Stage 3交互逻辑"

# 3. 查看结果
git log -1 --oneline
```

### 示例2：批量更新多个文件

```bash
# 1. 同时编辑多个文件
vim SKILL.md README.md STAGE3-DEBUG.md

# 2. 一次性部署所有更改
/deploy "docs: 批量更新文档"

# 3. 检查测试结果
/test
```

### 示例3：启用监控模式开发

```bash
# 1. 启动监控
/watch

# 2. 在另一个窗口编辑文件
vim SKILL.md

# 3. 保存文件（自动触发部署）
# 4. 观察自动部署输出

# 5. 停止监控
# 按 Ctrl+C
```

### 示例4：使用自定义提交信息

```bash
# 在部署时指定提交信息
/deploy "fix: 修正AskUserQuestion参数格式"

# 或
./auto-deploy.sh "fix: 修正AskUserQuestion参数格式"
```

### 示例5：恢复备份

```bash
# 查看所有备份
ls -la ~/.claude/skills/ | grep backup

# 恢复指定备份
rm -rf ~/.claude/skills/hs-req-facilitator-skill
mv ~/.claude/skills/hs-req-facilitator-skill-backup-20251104-025915 \
   ~/.claude/skills/hs-req-facilitator-skill
```

---

## 🔍 故障排除

### 问题1：AskUserQuestion格式错误

**症状**：
```
❌ 错误：检测到旧的AskUserQuestion格式 ({ question: ... })
```

**解决**：
```bash
# 检查当前格式
grep -A 5 "AskUserQuestion" SKILL.md

# 确保使用正确格式：
AskUserQuestion({
  questions: [{
    header: "问题标题",
    question: "具体问题",
    options: [{label: "选项1", description: "描述"}],
    multiSelect: false
  }]
})
```

### 问题2：部署权限错误

**症状**：
```
permission denied: ~/.claude/skills/hs-req-facilitator-skill
```

**解决**：
```bash
# 修复权限
chmod -R 755 ~/.claude/skills/hs-req-facilitator-skill

# 重新部署
/deploy
```

### 问题3：测试失败

**症状**：
```
❌ 发现 3 个测试失败！
```

**解决**：
```bash
# 查看详细测试结果
./test-production.sh verbose

# 手动验证文件
ls -la ~/.claude/skills/hs-req-facilitator-skill/

# 重新部署
/deploy
```

### 问题4：监控模式无响应

**症状**：监控模式启动但检测不到文件变化

**解决**：
```bash
# 检查监控目录
pwd

# 手动验证文件变化
md5sum SKILL.md
# 编辑文件后再次运行
md5sum SKILL.md

# 重新启动监控
/watch
```

---

## 📊 项目状态查看

### 查看Git历史

```bash
# 查看最近5次提交
git log --oneline -5

# 查看特定提交
git show <commit-hash>

# 查看当前状态
git status
```

### 查看生产环境

```bash
# 查看生产环境文件
ls -la ~/.claude/skills/hs-req-facilitator-skill/

# 查看文件大小
du -sh ~/.claude/skills/hs-req-facilitator-skill/

# 查看备份
ls -la ~/.claude/skills/ | grep backup
```

### 查看部署日志

```bash
# 查看watch日志
cat watch-deploy.log

# 查看Git日志（包含部署信息）
git log --all --oneline --grep="deploy"
```

---

## 📚 文档位置

| 文档 | 位置 | 说明 |
|------|------|------|
| 使用指南 | `AUTOMATION.md` | 完整的自动化系统文档 |
| 快速参考 | `QUICK-REFERENCE.md` | 本文档，常用命令速查 |
| 项目说明 | `README.md` | 项目概述和特性说明 |
| 调试指南 | `STAGE3-DEBUG.md` | Stage 3问题排查 |
| 核心文档 | `SKILL.md` | 技能包核心实现 |

---

## ⚙️ 配置文件说明

| 文件 | 用途 | 重要设置 |
|------|------|----------|
| `.claude-config.json` | 自动化配置 | 自动部署、测试开关 |
| `.claude/settings.json` | 项目设置 | Git、部署、测试配置 |
| `.git/hooks/pre-commit` | 提交前检查 | AskUserQuestion格式验证 |
| `.git/hooks/post-commit` | 提交后操作 | 自动部署触发 |
| `.gitignore` | Git忽略 | 敏感文件和临时文件 |

---

## 🎓 进阶技巧

### 1. 自定义提交信息模板

编辑 `.claude-config.json`：

```json
{
  "automation": {
    "git": {
      "commitMessageTemplate": "docs: {description} [{files}]"
    }
  }
}
```

### 2. 跳过某些文件的自动提交

编辑 `.gitignore`：

```
# 添加要忽略的文件
custom-notes.md
experimental.md
```

### 3. 修改监控间隔

```bash
# 5秒间隔监控
/watch 5

# 30秒间隔监控
/watch 30
```

### 4. 批量测试特定项

```bash
# 只测试AskUserQuestion格式
grep -q "AskUserQuestion.*questions.*\[" SKILL.md && echo "✅ 格式正确" || echo "❌ 格式错误"
```

### 5. 创建部署别名

添加到 `~/.bashrc` 或 `~/.zshrc`：

```bash
alias skill-deploy="cd /Volumes/MacHD/hs-skills/hs-req-facilitator-skill && /deploy"
alias skill-test="cd /Volumes/MacHD/hs-skills/hs-req-facilitator-skill && /test"
alias skill-watch="cd /Volumes/MacHD/hs-skills/hs-req-facilitator-skill && /watch"
```

然后使用：

```bash
skill-deploy        # 快速部署
skill-test          # 快速测试
skill-watch         # 快速监控
```

---

## ✅ 最佳实践

1. **提交前检查**：确保AskUserQuestion格式正确
2. **定期测试**：每次部署后运行 `/test`
3. **使用监控模式**：长时间编辑时启用 `/watch`
4. **保留备份**：重要更改前确认备份存在
5. **查看日志**：遇到问题时检查Git日志和部署日志
6. **自定义提交信息**：使用描述性的提交信息
7. **分批更改**：避免一次性修改过多文件

---

## 🎉 总结

你的自动化系统已经完全配置好！只需要记住：

```bash
/deploy    # 部署更改
/test      # 运行测试
/watch     # 启动监控
```

其余一切都是自动的！

---

**当前状态**：✅ 系统已就绪
**版本**：v2.0.0
**最后更新**：2025-11-04
