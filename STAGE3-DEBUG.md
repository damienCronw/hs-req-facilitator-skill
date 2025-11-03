# Stage 3 交互澄清调试指南

> **版本**: v1.0
> **适用技能包**: hs-req-facilitator-skill
> **更新时间**: 2025-11-04

---

## 🎯 概述

本指南帮助用户诊断和解决 hs-req-facilitator-skill 中 Stage 3（交互澄清）的常见问题。

**Stage 3 是强制阶段**：必须通过 AskUserQuestion 工具与用户交互，不能跳过！

---

## 🔍 常见问题

### 问题 1: 交互没有出现

**症状**：
- 技能启动后直接跳到 Stage 4
- Stage 2 分析完成后没有进入 Stage 3
- 用户没有收到任何交互提示

**可能原因**：
1. AskUserQuestion 调用格式错误
2. Stage 2 未完成强制检查点
3. 工具不可用（Cursor 环境）

**解决方案**：

#### 检查点 1: 验证 Stage 2 完成情况
确保 Stage 2 已完成以下所有步骤：
- [ ] 步骤2.1：已读取需求文档和代码文件
- [ ] 步骤2.2：已理解项目功能并输出功能概述
- [ ] 步骤2.3：已分析问题和缺失信息
- [ ] 步骤2.4：已列出功能需求清单并展示给用户

#### 检查点 2: 验证 AskUserQuestion 格式
AskUserQuestion 工具调用必须使用**正确格式**：

```javascript
// ✅ 正确格式
AskUserQuestion({
  questions: [{
    header: "澄清问题",
    question: "[具体问题]",
    options: [
      {label: "[选项1]", description: "[描述]"},
      {label: "[选项2]", description: "[描述]"}
    ],
    multiSelect: false
  }]
})

// ❌ 错误格式
AskUserQuestion({
  question: "问题",
  context: "上下文"
})
```

**关键要求**：
- 使用 `questions` 数组（单元素数组）
- 每个问题必须有 `header` 字段（≤12字符）
- 提供 2-4 个 `options`
- 设置 `multiSelect` 为 false（单选）或 true（多选）

#### 检查点 3: 环境兼容性
**Claude Code 环境**：
- ✅ 支持 AskUserQuestion 工具
- ✅ 应该使用 AskUserQuestion 工具调用

**Cursor 环境**：
- ❌ 不支持 AskUserQuestion 工具
- ✅ 应该使用对话模式：`❓ 问题：[问题]`
- ✅ 等待用户在聊天中回答

---

### 问题 2: AskUserQuestion 工具不可用

**症状**：
- 错误信息："AskUserQuestion tool not found"
- 工具调用失败
- 技能包停止响应

**解决方案**：

1. **检测环境**：
   ```javascript
   // 检查 AskUserQuestion 工具是否可用
   try {
     // 尝试调用工具
     AskUserQuestion(...);
   } catch (error) {
     // 切换到对话模式
     display("❓ 问题: [问题]");
     awaitUserInputViaChat();
   }
   ```

2. **使用对话模式**：
   ```
   ❓ 澄清问题

   基于 Stage 2 的分析，我发现以下需要澄清的问题：

   问题1：[具体问题]
   - 关联需求：[哪个需求]
   - 识别的问题：[模糊点/缺失信息/不一致性]

   请回答：[具体问题]
   ```

3. **等待用户回答**：
   - 在对话模式中，必须等待用户回答
   - 不能在提问后立即继续
   - 用户回答后继续下一轮交互

---

### 问题 3: 工具调用格式错误

**症状**：
- AskUserQuestion 返回错误
- 工具调用失败
- 格式验证失败

**解决方案**：

#### 完整示例（Claude Code 环境）：
```javascript
AskUserQuestion({
  questions: [{
    header: "需求澄清",
    question: "功能需求1缺少验收标准。如何验证这个功能是否成功实现？",
    options: [
      {label: "提供验收标准", description: "补充详细的验收标准"},
      {label: "暂时跳过", description: "稍后补充验收标准"},
      {label: "使用标准验收", description: "使用通用的验收标准模板"},
      {label: "需要建议", description: "希望获得验收标准建议"}
    ],
    multiSelect: false
  }]
})
```

#### 完整示例（Cursor 环境）：
```
❓ 需求澄清

基于 Stage 2 的分析，我发现以下需要澄清的问题：

问题1：功能需求1缺少验收标准
- 关联需求：功能需求1
- 识别的问题：缺失信息

请回答：如何验证这个功能是否成功实现？

请等待用户回答后再继续。
```

---

### 问题 4: 交互被跳过

**症状**：
- Stage 2 完成后直接进入 Stage 4
- 没有停留等待用户回答
- 用户表示没有收到交互提示

**解决方案**：

1. **验证强制检查点**：
   - Stage 2 必须完成所有 4 个子步骤
   - Stage 3 必须在 Stage 2 后立即执行
   - 不能跳过 Stage 3 直接进入 Stage 4

2. **检查交互逻辑**：
   ```javascript
   // ✅ 正确流程
   if (stage2Complete) {
     // 必须进入 Stage 3
     enterStage3();
     askUserQuestions(); // 等待用户回答
     // 等待回答后才能进入 Stage 4
     if (answersReceived) {
       enterStage4();
     }
   }
   ```

3. **验证 AskUserQuestion 调用**：
   - 确保工具调用是同步的（等待回答）
   - 确保有适当的错误处理
   - 确保用户回答被正确捕获

---

## 🛠️ 故障排查检查清单

在报告问题前，请完成以下检查：

### 环境检查
- [ ] 确认运行环境（Claude Code / Cursor）
- [ ] 确认 AskUserQuestion 工具可用性
- [ ] 确认网络连接正常

### Stage 2 检查
- [ ] 步骤2.1：已读取需求文档（不是只列出文件名）
- [ ] 步骤2.2：已输出项目功能概述（不能只是说"已理解"）
- [ ] 步骤2.3：已分析问题和缺失信息（模糊点、缺失信息、不一致性）
- [ ] 步骤2.4：已列出功能需求清单并展示给用户

### Stage 3 检查
- [ ] AskUserQuestion 调用使用正确格式
- [ ] 工具调用包含必需的字段（header, question, options, multiSelect）
- [ ] 如果工具不可用，使用对话模式
- [ ] 等待用户回答后再继续

### 工具调用检查
- [ ] 使用 `questions` 数组（不是单个对象）
- [ ] `header` 长度 ≤ 12 字符
- [ ] 提供 2-4 个 `options`
- [ ] 正确设置 `multiSelect`

---

## 📊 错误代码对照表

| 错误类型 | 错误信息 | 解决方案 |
|---------|---------|---------|
| 格式错误 | `Invalid AskUserQuestion format` | 检查 `questions` 数组格式 |
| 字段缺失 | `Missing required field: header` | 确保所有必需字段都存在 |
| 数组为空 | `Questions array cannot be empty` | 提供至少一个问题 |
| 工具不可用 | `AskUserQuestion tool not found` | 切换到对话模式 |
| 超时 | `User response timeout` | 增加超时时间或提示用户 |

---

## 🔧 环境特定指南

### Claude Code 环境

**特点**：
- 支持 AskUserQuestion 工具
- 工具调用是同步的
- 可以等待用户回答

**最佳实践**：
```javascript
AskUserQuestion({
  questions: [{
    header: "澄清问题",
    question: "[具体问题]",
    options: [{label: "选项1", description: "描述1"}, {label: "选项2", description: "描述2"}],
    multiSelect: false
  }]
})
```

### Cursor 环境

**特点**：
- 不支持 AskUserQuestion 工具
- 使用对话交互
- 需要手动等待用户回答

**最佳实践**：
```
❓ 问题：[你的问题]

上下文：[问题上下文]

请在聊天中回答，等待您回答后再继续。
```

---

## 📞 获取帮助

如果问题仍未解决，请提供以下信息：

1. **环境信息**：
   - 运行环境（Claude Code / Cursor）
   - 技能包版本

2. **错误详情**：
   - 完整的错误信息
   - 发生问题的阶段（Stage 2/3/4）
   - 执行的步骤

3. **配置信息**：
   - SKILL.md 版本
   - AskUserQuestion 调用代码（如果适用）

4. **重现步骤**：
   - 详细的重现步骤
   - 预期行为 vs 实际行为

---

## 📝 更新日志

| 版本 | 日期 | 更新内容 |
|------|------|---------|
| v1.0 | 2025-11-04 | 初始版本，涵盖常见问题和解决方案 |

---

**重要提醒**：

✅ Stage 3 是强制阶段，不能跳过
✅ AskUserQuestion 调用格式必须正确
✅ 必须等待用户回答后再继续
✅ 环境不同时使用不同的交互模式

**See Also**：
- [SKILL.md](SKILL.md) - 主技能包文档
- [QUESTIONS.md](QUESTIONS.md) - 问题生成指南
- [ANALYZER.md](ANALYZER.md) - 需求分析指南
