# HS Req Facilitator Skill - 故障排查指南

> **版本**: v2.0.2
> **更新日期**: 2025-11-04

本文档提供 hs-req-facilitator-skill 全阶段的故障排查和解决方案。

---

## 📋 快速诊断

执行以下命令进行快速诊断：

```bash
# 1. 检查版本号
grep "version:" hs-req-facilitator-skill/SKILL.md

# 2. 验证文件完整性
ls -la hs-req-facilitator-skill/

# 3. 检查环境
echo $CLAUDE_CODE_ENV
```

---

## 🔍 按阶段排查

### Stage 0: 工作流检查

#### 问题 0.1: 工作流规则检查失败

**症状**:
- 提示"工作流规则检查失败"
- 技能启动后立即退出

**可能原因**:
1. SKILL.md文件损坏
2. 版本号不一致

**解决方案**:
```bash
# 1. 验证SKILL.md存在且可读
cat hs-req-facilitator-skill/SKILL.md | head -20

# 2. 检查版本号一致性
grep "version:" hs-req-facilitator-skill/SKILL.md

# 3. 重新拉取代码（如需要）
git pull origin master
```

**验证**: 重新激活技能，应能正常进入Stage 1

---

### Stage 1: 文件扫描

#### 问题 1.1: 扫描命令执行失败

**症状**:
- find命令返回错误
- 无法识别文件

**可能原因**:
1. 权限不足
2. 文件路径错误
3. 系统不支持find命令

**解决方案**:
```bash
# 1. 检查当前目录权限
ls -la

# 2. 手动测试find命令
find . -type f -name "*.md" | head -5

# 3. 切换到项目根目录
cd /Volumes/MacHD/hs-skills
```

**验证**: find命令能正常返回结果

#### 问题 1.2: 未找到任何需求文档

**症状**:
- 扫描结果为0个需求文档
- 误判为空项目

**可能原因**:
1. 项目确实没有需求文档
2. 需求文档命名不符合规范
3. 文件被排除（node_modules, .git等）

**解决方案**:
```bash
# 1. 手动查找需求文档
find . -name "requirements.md" -o -name "*requirement*.md"

# 2. 检查隐藏目录
ls -la hs-req-facilitator-skill/

# 3. 如需创建，参考空项目引导
```

**验证**: 能找到至少一个需求文档，或确认为空项目

---

### Stage 2: 需求分析

#### 问题 2.1: 无法读取文件内容

**症状**:
- 提示"文件读取失败"
- 文件内容为空

**可能原因**:
1. 文件权限问题
2. 文件路径错误
3. 文件损坏

**解决方案**:
```bash
# 1. 检查文件存在性和权限
ls -la hs-req-facilitator-skill/SKILL.md

# 2. 尝试手动读取
cat hs-req-facilitator-skill/SKILL.md | head -50

# 3. 检查文件编码
file hs-req-facilitator-skill/SKILL.md
```

**验证**: 能正常读取文件前50行

#### 问题 2.2: AI分析失败

**症状**:
- Stage 2.2卡住
- 输出"AI理解超时"

**可能原因**:
1. 项目过于复杂
2. 需求文档格式异常
3. AI服务暂时不可用

**解决方案**:
1. **简化项目**: 暂时移除大型文档，只保留核心需求
2. **分段分析**: 将大文档拆分为多个小文档
3. **重试**: 等待几分钟后重新尝试

**验证**: Stage 2.2能输出功能概述

#### 问题 2.3: 问题分析不准确

**症状**:
- 识别到错误的模糊点/缺失信息
- 信心度评估不合理

**可能原因**:
1. 需求文档质量过低
2. AI理解偏差

**解决方案**:
1. **手动验证**: 对比AI分析和人工分析
2. **调整提示**: 重新运行Stage 2，要求更精确的分析
3. **Stage 3验证**: 通过交互澄清纠正AI理解偏差

**验证**: Stage 3中用户澄清后，问题得到纠正

#### 问题 2.4: 功能需求清单缺失

**症状**:
- 未输出P0/P1/P2分类
- 清单不完整

**可能原因**:
1. Stage 2.2或2.3未完成
2. 输出格式错误

**解决方案**:
```bash
# 1. 验证前序步骤完成
grep -A 20 "步骤2.2" hs-req-facilitator-skill/SKILL.md

# 2. 检查输出格式要求
grep -A 30 "步骤2.4" hs-req-facilitator-skill/SKILL.md
```

**验证**: 能输出完整的功能需求清单

---

### Stage 3: 交互澄清（关键阶段）

#### 问题 3.1: AskUserQuestion工具不可用

**症状**:
- 错误: "AskUserQuestion tool not found"
- 工具调用失败

**可能原因**:
1. 环境不支持AskUserQuestion工具
2. 工具版本过旧

**解决方案**:
1. **确认环境**: 确保在Claude Code环境中运行
   ```bash
   echo $CLAUDE_CODE_ENV
   # 应显示: claude-code 或类似标识
   ```

2. **更新工具**: 确保使用最新版本的Claude Code

3. **降级方案** (如无法使用AskUserQuestion):
   - 使用对话模式进行交互
   - 格式: `❓ 问题：[具体内容]`
   - 在聊天中等待用户回答

**验证**: 能正常调用AskUserQuestion工具

#### 问题 3.2: Stage 3未出现

**症状**:
- Stage 2后直接跳到Stage 4
- 没有交互提示

**可能原因**:
1. Stage 2未完全完成
2. 工作流程检查失败

**解决方案**:
```bash
# 1. 验证Stage 2的4个步骤
# - 步骤2.1: 读取文件
# - 步骤2.2: 功能概述
# - 步骤2.3: 问题分析
# - 步骤2.4: 需求清单

# 2. 重新执行Stage 2
# 确保每步都有实际输出
```

**验证**: Stage 2完成后出现Stage 3提示

#### 问题 3.3: 澄清问题无效

**症状**:
- AskUserQuestion问题过于通用
- 问题不针对具体功能

**可能原因**:
1. Stage 2分析不够深入
2. 问题生成逻辑有误

**解决方案**:
1. **重新运行Stage 2**: 要求更详细的功能分析
2. **调整问题生成**: 基于功能清单生成针对性问题
3. **手动补充**: 在交互中主动提供更多信息

**验证**: AskUserQuestion问题具体且可回答

#### 问题 3.4: 用户无响应

**症状**:
- AskUserQuestion后用户未回答
- 流程无法继续

**可能原因**:
1. 用户暂时离开
2. 问题不够清晰
3. 用户不知道如何回答

**解决方案**:
1. **重新询问**: 使用更清晰的语言重新提问
2. **提供选项**: 给出多个选择降低回答难度
3. **引导回答**: 提供回答示例

**验证**: 收到用户明确回答

#### 问题 3.5: 交互后无法继续

**症状**:
- 记录用户回答后卡住
- 无法进入Stage 4

**可能原因**:
1. 回答解析失败
2. 工作流程中断

**解决方案**:
```bash
# 1. 检查回答记录格式
# 2. 手动触发Stage 4
# 3. 重启技能（如需要）
```

**验证**: 能正常进入Stage 4

---

### Stage 4: 需求完善

#### 问题 4.1: Spec-Workflow集成失败

**症状**:
- 无法生成标准格式文档
- 目录结构创建失败

**可能原因**:
1. 权限不足
2. 路径冲突

**解决方案**:
```bash
# 1. 检查.spec-workflow目录
ls -la hs-req-facilitator-skill/.spec-workflow/

# 2. 手动创建目录结构
mkdir -p hs-req-facilitator-skill/.spec-workflow/specs/main/

# 3. 检查写权限
touch hs-req-facilitator-skill/.spec-workflow/test.txt
```

**验证**: 能成功创建.spec-workflow目录和文件

#### 问题 4.2: 文档生成格式错误

**症状**:
- 生成的文档不符合spec-workflow格式
- 用户故事或验收标准缺失

**可能原因**:
1. 模板缺失
2. 生成逻辑错误

**解决方案**:
1. **使用模板**: 参考现有spec-workflow文档格式
2. **手动校验**: 对照spec-workflow标准检查
3. **重新生成**: 修正后重新运行Stage 4

**验证**: 生成的文档符合spec-workflow标准

---

### Stage 5: 多文档合并

#### 问题 5.1: 未检测到多文档

**症状**:
- 实际有多个文档但未进入Stage 5
- 扫描结果不准确

**可能原因**:
1. 文档路径不标准
2. 扫描过滤规则过严

**解决方案**:
```bash
# 1. 手动列出所有需求文档
find . -name "requirements.md" -o -name "*requirement*.md"

# 2. 检查过滤条件
grep -n "grep -v" hs-req-facilitator-skill/SKILL.md

# 3. 调整扫描规则（如需要）
```

**验证**: 能正确识别多个需求文档

#### 问题 5.2: 合并方案不合理

**症状**:
- AI生成的合并方案有误
- 重复或冲突处理不当

**可能原因**:
1. AI理解偏差
2. 文档关系复杂

**解决方案**:
1. **详细审查**: 仔细检查合并方案
2. **AskUserQuestion确认**: 就合并方案与用户确认
3. **手动调整**: 基于用户反馈调整方案

**验证**: 用户确认合并方案合理

#### 问题 5.3: 文档删除错误

**症状**:
- 误删重要文档
- 合并后丢失信息

**可能原因**:
1. 删除列表错误
2. 未备份

**预防措施**:
```bash
# 1. 合并前备份所有文档
cp -r . ../backup-$(date +%Y%m%d)/

# 2. AskUserQuestion确认删除列表
# 3. 逐个确认后删除
```

**验证**: 只删除指定的冗余文档，保留合并后的文档

---

## 🚨 常见错误及解决方案

### 错误1: 版本号不一致

**现象**:
```
错误: SKILL.md v2.0.0 与 requirements.md v2.0.2 不匹配
```

**解决方案**:
```bash
# 统一版本号
sed -i '' 's/v2.0.0/v2.0.2/g' hs-req-facilitator-skill/SKILL.md
```

### 错误2: 强制性语言残留

**现象**:
```
警告: 检测到强制性语言"⚠️ 必须"
```

**解决方案**:
```bash
# 替换强制性语言
sed -i '' 's/⚠️ 必须//g' hs-req-facilitator-skill/SKILL.md
sed -i '' 's/⚠️ //g' hs-req-facilitator-skill/SKILL.md
```

### 错误3: 无效文件引用

**现象**:
```
错误: 引用不存在文件 ANALYZER.md
```

**解决方案**:
```bash
# 移除无效引用
grep -n "ANALYZER.md" hs-req-facilitator-skill/SKILL.md
# 手动替换为通用描述
```

### 错误4: 环境不支持

**现象**:
```
错误: AskUserQuestion tool not found
```

**解决方案**:
1. 确认在Claude Code环境中运行
2. 如使用其他环境，参考降级方案
3. 联系技术支持

---

## 🛠️ 诊断工具

### 自动诊断脚本

创建诊断脚本 `diagnose.sh`:

```bash
#!/bin/bash

echo "=== HS Req Facilitator Skill 诊断工具 ==="
echo ""

# 1. 检查版本
echo "1. 版本信息:"
grep "version:" hs-req-facilitator-skill/SKILL.md
echo ""

# 2. 检查文件
echo "2. 核心文件:"
ls -la hs-req-facilitator-skill/SKILL.md
ls -la hs-req-facilitator-skill/README.md
echo ""

# 3. 检查强制性语言
echo "3. 强制性语言检查:"
count=$(grep -c "⚠️\|绝对\|强制" hs-req-facilitator-skill/SKILL.md)
echo "发现 $count 处强制性语言"
echo ""

# 4. 检查文件引用
echo "4. 无效引用检查:"
grep -c "ANALYZER.md\|QUESTIONS.md\|ENHANCER.md\|MERGER.md" hs-req-facilitator-skill/SKILL.md || echo "无无效引用"
echo ""

# 5. 环境检查
echo "5. 环境信息:"
echo "当前目录: $(pwd)"
echo "用户: $(whoami)"
echo ""

echo "=== 诊断完成 ==="
```

运行诊断:
```bash
chmod +x hs-req-facilitator-skill/scripts/diagnose.sh
bash hs-req-facilitator-skill/scripts/diagnose.sh
```

---

## 📞 获取帮助

### 自助资源

1. **文档**: 参阅项目文档和README
2. **示例**: 查看examples/目录下的示例
3. **更新日志**: 查看CHANGELOG.md了解最新变更

### 提交问题

提交Issue时请包含：

1. **环境信息**
   - 操作系统版本
   - Claude Code版本
   - 技能包版本

2. **错误详情**
   - 完整的错误信息
   - 发生问题的阶段

3. **重现步骤**
   - 详细的操作步骤
   - 预期行为 vs 实际行为

4. **日志**
   - 诊断脚本输出
   - 相关日志文件

### 紧急联系

如遇到紧急问题：

1. 首先尝试回滚到稳定版本
2. 查看是否有已知解决方案
3. 提交详细的问题报告

---

## 🔄 恢复和回滚

### 回滚到v2.0.0

```bash
git reset --hard v2.0.0
```

### 回滚到v2.0.1

```bash
git reset --hard v2.0.1
```

### 修复特定问题

根据问题类型选择相应的修复方案：

```bash
# 修复版本号
sed -i '' 's/v2.0.0/v2.0.2/g' hs-req-facilitator-skill/SKILL.md

# 移除强制性语言
sed -i '' 's/⚠️ //g' hs-req-facilitator-skill/SKILL.md

# 移除无效引用
sed -i '' 's/ANALYZER.md/项目文档/g' hs-req-facilitator-skill/SKILL.md
```

---

**最后更新**: 2025-11-04
**下次更新**: v2.0.3发布时
