# 🎬 自动化系统使用演示

欢迎使用 `hs-req-facilitator-skill` 自动化系统！

本文档将通过实际演示向你展示如何使用这个系统。

---

## 📺 演示视频脚本

### 演示1：首次部署

```bash
# 场景：你刚刚完成项目设置
./quick-start.sh

# 输出：
╔════════════════════════════════════════════╗
║   Claude Code Skill 自动化快速开始       ║
╚════════════════════════════════════════════╝

[1/4] 配置Git环境...
✅ Git配置完成

[2/4] 创建.gitignore...
✅ .gitignore已创建

[3/4] 提交项目文件...
✅ 文件已提交

[4/4] 部署到生产环境...
=== Claude Code Skill 自动部署脚本 ===
[1/4] 检查Git状态...
✅ 工作区干净，没有变更需要提交
⚠️  仍然会进行部署检查

[3/4] 部署到生产环境...
💾 备份现有生产环境文件...
✅ 备份完成：/Users/...-backup-20251104-025915
📦 部署核心文件...
  ✅ SKILL.md
  ✅ README.md
  ✅ STAGE3-DEBUG.md
📚 部署指南文件...
🔄 保留旧版本重要文件...
✅ 部署完成！

[4/4] 运行部署测试...
🔍 验证部署文件...
✅ AskUserQuestion 调用存在
✅ AskUserQuestion 格式正确
✅ 部署验证完成，共 11 个文件

=== 部署总结 ===
项目：hs-req-facilitator-skill
Git提交ID：2e97f8c
✅ 自动化部署流程完成！

🎉 自动化环境就绪！
```

---

### 演示2：日常文档更新

```bash
# 场景：你需要更新SKILL.md中的Stage 3描述

# 1. 编辑文件
vim SKILL.md

# 在vim中：
/stage 3
# 修改内容...
# :wq 保存退出

# 2. 部署更改
/deploy "docs: 更新Stage 3交互描述"

# 输出：
=== Git Hook: Pre-Commit 质量检查 ===
[1/3] 检查AskUserQuestion格式...
✅ 发现AskUserQuestion调用
✅ AskUserQuestion格式正确

[2/3] 检查文件完整性...
✅ 标题格式正确
✅ 包含工作流程描述

[3/3] 检查文件大小...
✅ SKILL.md大小正常 (42227 字节)
✅ README.md大小正常 (9962 字节)

=== 质量检查总结 ===
✅ 所有检查通过，可以提交

=== Git Hook: Post-Commit ===
检测到hs-req-facilitator-skill项目提交
是否自动部署到生产环境？[Y/n] y

🚀 执行自动部署...
=== Claude Code Skill 自动部署脚本 ===
[1/4] 检查Git状态...
📝 发现未提交的变更：
 M SKILL.md

[2/4] 准备提交变更...
使用自动生成的提交信息：docs: 更新Stage 3交互描述
✅ Git提交完成

[3/4] 部署到生产环境...
💾 备份现有生产环境文件...
✅ 备份完成：/Users/...-backup-20251104-030500
📦 部署核心文件...
  ✅ SKILL.md
  ✅ README.md
  ✅ STAGE3-DEBUG.md
✅ 部署完成！

[4/4] 运行部署测试...
✅ 部署验证完成，共 11 个文件

✅ 自动化部署流程完成！
```

---

### 演示3：文件监控模式

```bash
# 场景：你要持续编辑文档，希望每次保存都自动部署

# 1. 启动监控模式
/watch

# 输出：
╔═══════════════════════════════════════════╗
║       Claude Code Skill 监控部署模式     ║
╚═══════════════════════════════════════════╝

监控目录：/Volumes/MacHD/hs-skills/hs-req-facilitator-skill
检查间隔：10秒
按 Ctrl+C 停止监控

# 2. 在另一个终端窗口编辑文件
vim SKILL.md

# 在vim中：
i
# 添加新内容...
# 按ESC，输入 :wq 保存退出

# 3. 观察监控终端输出
[2025-11-04 03:05:15] 检测到文件变化！
触发自动部署...
[1/4] 检查Git状态...
[2/4] 准备提交变更...
✅ 自动部署完成
继续监控...

# 4. 停止监控
# 按 Ctrl+C
```

---

### 演示4：运行测试

```bash
# 场景：你想要验证生产环境是否正常

/test

# 输出：
╔═══════════════════════════════════════════╗
║   Claude Code Skill 生产环境测试套件     ║
╚═══════════════════════════════════════════╝

━━━ 第一阶段：环境检查 ━━━

[TEST 1] 生产环境目录存在
  ✅ PASS
[TEST 2] 生产环境目录可读
  ✅ PASS
[TEST 3] 生产环境目录可写
  ✅ PASS

━━━ 第二阶段：文件完整性检查 ━━━

[TEST 4] SKILL.md 存在
  ✅ PASS
[TEST 5] README.md 存在
  ✅ PASS
[TEST 6] STAGE3-DEBUG.md 存在
  ✅ PASS

━━━ 第三阶段：AskUserQuestion格式检查 ━━━

[TEST 7] 包含AskUserQuestion调用
  ✅ PASS
[TEST 8] AskUserQuestion使用正确格式 (questions数组)
  ✅ PASS
[TEST 9] 包含Stage 3描述
  ✅ PASS

[... 更多测试 ...]

━━━ 第八阶段：性能基准测试 ━━━

[TEST 25] 文件读取性能测试
  ✅ PASS (读取耗时: 45ms < 1000ms)

╔═══════════════════════════════════════════╗
║              测试结果报告                ║
╚═══════════════════════════════════════════╝

总测试数：25
通过：25
失败：0
通过率：100%

生产环境信息：
  目录：/Users/damien/.claude/skills/hs-req-facilitator-skill
  文件数：11
  测试时间：2025-11-04 03:06:00

✅ 所有测试通过！生产环境状态正常。
```

---

### 演示5：批量更新多个文件

```bash
# 场景：你要同时更新多个文档

# 1. 编辑多个文件
vim SKILL.md README.md STAGE3-DEBUG.md

# 在vim中依次编辑：
# :n 切换到下一个文件
# 编辑完成后 :wq 保存

# 2. 一次性部署所有更改
/deploy "docs: 批量更新多个文档"

# 输出：
=== Git Hook: Pre-Commit 质量检查 ===
[1/3] 检查AskUserQuestion格式...
✅ AskUserQuestion格式正确

[2/3] 检查文件完整性...
✅ 标题格式正确
✅ 包含工作流程描述

[3/3] 检查文件大小...
✅ SKILL.md大小正常
✅ README.md大小正常
✅ STAGE3-DEBUG.md大小正常

=== 质量检查总结 ===
✅ 所有检查通过，可以提交

=== Git Hook: Post-Commit ===
🚀 执行自动部署...
=== Claude Code Skill 自动部署脚本 ===
[1/4] 检查Git状态...
📝 发现未提交的变更：
 M SKILL.md
 M README.md
 M STAGE3-DEBUG.md

[2/4] 准备提交变更...
使用自动生成的提交信息：docs: 批量更新多个文档
✅ Git提交完成

[3/4] 部署到生产环境...
✅ 部署完成！

[4/4] 运行部署测试...
✅ 所有测试通过

✅ 自动化部署流程完成！
```

---

### 演示6：恢复备份

```bash
# 场景：当前部署有问题，需要恢复到之前的版本

# 1. 查看所有备份
ls -la ~/.claude/skills/ | grep backup

# 输出：
drwxr-xr-x  3 damien  staff   96  Nov  4 02:59 hs-req-facilitator-skill-backup-20251104-025915
drwxr-xr-xr-x  3 damien  staff   96  Nov  4 03:00 hs-req-facilitator-skill-backup-20251104-030010
drwxr-xr-xr-x  3 damien  staff   96  Nov  4 03:01 hs-req-facilitator-skill-backup-20251104-030112

# 2. 恢复到指定备份
rm -rf ~/.claude/skills/hs-req-facilitator-skill
mv ~/.claude/skills/hs-req-facilitator-skill-backup-20251104-030010 \
   ~/.claude/skills/hs-req-facilitator-skill

# 输出：
# 恢复完成
```

---

## 🎯 实际使用场景

### 场景A：添加新功能到SKILL.md

**问题**：要在SKILL.md中添加新的AskUserQuestion交互

**步骤**：
```bash
1. 编辑SKILL.md
2. 添加AskUserQuestion调用（确保格式正确）
3. /deploy "feat: 添加新的交互功能"
4. 观察自动部署和测试结果
```

**自动执行**：
- ✅ Pre-commit检查AskUserQuestion格式
- ✅ Git提交更改
- ✅ 备份现有文件
- ✅ 部署到生产环境
- ✅ 运行测试验证
- ✅ 报告部署结果

---

### 场景B：更新项目README

**问题**：项目增加了新特性，需要更新README.md

**步骤**：
```bash
1. vim README.md
2. 添加新功能描述
3. /deploy "docs: 更新README.md说明"
4. 验证更新
```

**自动执行**：
- ✅ 检查文件格式
- ✅ 自动提交
- ✅ 部署更新
- ✅ 验证文件存在

---

### 场景C：长时间编辑开发

**问题**：要花1小时编辑多个文档，不想每次手动部署

**步骤**：
```bash
1. /watch 5  # 启动5秒间隔监控
2. 自由编辑文档
3. 每次保存都会自动部署
4. 观察监控输出
5. 按Ctrl+C停止监控
```

**优势**：
- ✅ 无需手动部署
- ✅ 每次保存自动触发
- ✅ 详细的变化日志
- ✅ 自动错误检查

---

### 场景D：验证生产环境

**问题**：怀疑生产环境有问题，需要全面检查

**步骤**：
```bash
/test
```

**检查内容**：
- ✅ 11个环境检查
- ✅ 5个文件完整性检查
- ✅ 3个AskUserQuestion格式检查
- ✅ 2个版本信息验证
- ✅ 6个指南文件检查
- ✅ 2个功能测试
- ✅ 2个集成测试
- ✅ 1个性能测试

**结果**：
```
总测试数：25
通过：25
失败：0
通过率：100%

✅ 所有测试通过！生产环境状态正常。
```

---

## 🔍 常见问题演示

### Q1：AskUserQuestion格式错误

```bash
# 问题代码：
AskUserQuestion({
  question: "你的问题是什么？",
  context: "这是上下文"
})

# 自动检测：
❌ 错误：检测到旧的AskUserQuestion格式 ({ question: ... })

# 解决：
AskUserQuestion({
  questions: [{
    header: "问题标题",
    question: "你的问题是什么？",
    options: [{label: "选项1", description: "描述"}],
    multiSelect: false
  }]
})

# 验证：
✅ AskUserQuestion格式正确
```

---

### Q2：文件权限问题

```bash
# 症状：
❌ 错误：权限被拒绝

# 解决：
chmod -R 755 ~/.claude/skills/hs-req-facilitator-skill

# 重新部署：
/deploy

# 结果：
✅ 部署完成
```

---

### Q3：测试失败

```bash
# 症状：
❌ 发现 3 个测试失败！

# 解决：
./test-production.sh verbose

# 查看详细错误：
[TEST 7] 包含AskUserQuestion调用
  ❌ FAIL

# 手动验证：
grep -n "AskUserQuestion" ~/.claude/skills/hs-req-facilitator-skill/SKILL.md

# 修复问题后重新部署：
/deploy
```

---

## 📊 演示结果统计

经过以上演示，系统表现：

- ✅ **部署成功率**：100%
- ✅ **测试通过率**：100%
- ✅ **AskUserQuestion格式正确率**：100%
- ✅ **文件完整性**：100%
- ✅ **自动化覆盖率**：100%

---

## 🎓 学习要点

1. **记住三个核心命令**：
   - `/deploy` - 部署
   - `/test` - 测试
   - `/watch` - 监控

2. **自动化流程**：
   - 编辑 → 保存 → 自动部署 → 自动测试

3. **质量保证**：
   - 每次提交前自动检查
   - 每次部署后自动测试

4. **数据安全**：
   - 每次部署自动备份
   - 一键恢复功能

5. **开发效率**：
   - 零配置启动
   - 无需手动操作
   - 实时反馈

---

## 🚀 开始使用

现在你已经看完了演示，可以开始使用了：

```bash
# 1. 快速开始（如果还未设置）
./quick-start.sh

# 2. 编辑你的第一个文件
vim SKILL.md

# 3. 部署更改
/deploy

# 4. 查看结果
git log --oneline -1
```

---

**祝你使用愉快！** 🎉

如需帮助，请查看：
- `AUTOMATION.md` - 完整文档
- `QUICK-REFERENCE.md` - 快速参考
- `PROJECT-SUMMARY.md` - 项目总结
