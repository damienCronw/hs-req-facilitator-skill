# 故障排查指南

本指南帮助您解决使用 hs-req-facilitator-skill 时遇到的常见问题。

---

## 快速检查清单

在使用技能前，请确认：

- ✅ Claude Code 已安装并配置
- ✅ 技能文件（SKILL.md）完整存在
- ✅ 项目中有可读的需求文档
- ✅ 有读取和写入权限

---

## 常见问题

### 1. 技能未激活

**症状**：技能没有响应或未被触发

**解决方案**：
1. 确认在 Claude Code 环境中
2. 使用明确关键词："analyze requirements" 或 "clarify requirements"
3. 重启 Claude Code

---

### 2. Stage 3 交互未出现

**症状**：跳过交互澄清，直接进入 Stage 4

**解决方案**：
1. 确认已完成 Stage 2 的所有4个子步骤
2. 检查 AskUserQuestion 工具是否可用
3. 查看是否有错误消息

---

### 3. 文件扫描失败

**症状**：提示"未找到需求文档"

**解决方案**：
1. 确认文档格式为 `.md`
2. 检查文档命名：`requirements.md`、`*requirement*.md` 或 `.spec-workflow/specs/*/requirements.md`
3. 确认文件有读取权限

---

### 4. 生成文档失败

**症状**：技能运行但未生成改进文档

**解决方案**：
1. 检查工作目录写入权限
2. 确认 Stage 3 交互已正常完成
3. 查看错误日志

---

### 5. 分析结果不准确

**症状**：分析模糊或不完整

**解决方案**：
1. 在 Stage 3 中积极回答澄清问题
2. 提供更多上下文信息
3. 检查需求文档格式是否清晰

---

### 6. 多文档合并失败

**症状**：无法合并多个需求文档

**解决方案**：
1. 确认所有文档都是 Markdown 格式
2. 检查文档编码（建议 UTF-8）
3. 备份原始文档后再尝试合并

---

## 获取帮助

### 提交问题

在 [GitHub Issues](https://github.com/damienCronw/hs-req-facilitator-skill/issues) 提交问题时，请提供：

1. **环境信息**：Claude Code 版本、操作系统
2. **问题描述**：详细说明问题现象
3. **重现步骤**：如何触发问题
4. **错误日志**：完整的错误信息

### 社区支持

- 查看 [GitHub Discussions](https://github.com/damienCronw/hs-req-facilitator-skill/discussions)
- 搜索已解决的类似问题
- 查看 README.md 和示例

---

## 预防措施

1. **定期更新**：保持 Claude Code 为最新版本
2. **备份文档**：重要需求文档请先备份
3. **清晰表达**：需求文档越清晰，分析结果越准确
4. **积极交互**：在 Stage 3 中认真回答问题

---

最后更新：2025-11-04
