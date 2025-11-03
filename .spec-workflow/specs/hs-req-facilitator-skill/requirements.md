# Requirements: HS Req Facilitator Skill

> **需求分析助手技能包** - 智能分析、澄清并完善项目需求文档
>
> **版本**: v2.0.0
> **创建日期**: 2025-11-04
> **作者**: 苏州核朔智能科技有限公司
> **邮箱**: limian@norkern.com
> **网站**: www.norker.com

---

## User Story

**作为** 一名中级到高级的开发者、产品经理或业务分析师
**我想要** 一个智能的需求分析助手，能够自动分析、识别问题、通过交互澄清并改进项目需求文档
**以便于** 提高需求文档质量，避免项目开发中的需求误解和遗漏，确保项目成功

---

## Acceptance Criteria

### REQ-1: AI驱动的需求分析系统

**WHEN** 技能被激活
**THEN** 系统 SHALL 自动执行5-stage工作流程 (Stage 0-4)

- WHEN 扫描项目文件时
  THEN 系统 SHALL 识别需求文档 (requirements.md, *requirement*.md, 需求*.md, .spec-workflow/specs/*/requirements.md)
  THEN 系统 SHALL 扫描代码文件并分析功能实现
  THEN 系统 SHALL 检测spec-workflow结构并获取上下文

- WHEN 分析需求时
  THEN 系统 SHALL 识别模糊点 (uncertainty)
  THEN 系统 SHALL 识别缺失信息 (missing-info)
  THEN 系统 SHALL 识别不一致性 (inconsistency)
  THEN 系统 SHALL 评估信心度 (high/medium/low)

- WHEN 完成分析后
  THEN 系统 SHALL 列出功能需求清单 (P0/P1/P2分类)
  THEN 系统 SHALL 展示给用户确认

**质量目标**: 分析准确性 ≥ 95%, 启动时间 < 2秒

---

### REQ-2: 交互式需求澄清系统

**WHEN** Stage 2 (需求分析) 完成后
**THEN** 系统 SHALL 进入 Stage 3 (交互澄清)，绝对不能跳过

- WHEN 存在识别问题时
  THEN 系统 SHALL 使用 AskUserQuestion 工具生成澄清问题
  THEN 系统 SHALL 基于功能需求清单生成针对性问题
  THEN 系统 SHALL 逐个询问缺失信息，等待用户回答
  THEN 系统 SHALL 基于用户回答调整后续问题

- WHEN 未发现问题时
  THEN 系统 SHALL 告知用户"未发现问题"
  THEN 系统 SHALL 询问"是否要添加新需求？或直接进入下一步？"
  THEN 系统 SHALL 等待用户选择并执行

**强制要求**: 无论如何都必须至少进行一次 AskUserQuestion 交互

---

### REQ-3: Spec-Workflow格式需求文档生成

**WHEN** Stage 3 (交互澄清) 完成后
**THEN** 系统 SHALL 进入 Stage 4 (需求完善)

- WHEN 生成改进文档时
  THEN 系统 SHALL 整合原始需求、用户澄清回答、代码实现情况、功能需求清单
  THEN 系统 SHALL 生成用户故事 (As a [role], I want [feature], so that [benefit])
  THEN 系统 SHALL 生成EARS格式验收标准 (WHEN [condition] THEN [system] SHALL [response])
  THEN 系统 SHALL 添加业务价值说明

- WHEN 保存文档时
  THEN 系统 SHALL 按 spec-workflow 格式生成需求文档
  THEN 系统 SHALL 更新 .spec-workflow/specs/*/requirements.md
  THEN 系统 SHALL 保留原始内容 (追加模式)
  THEN 系统 SHALL 确保验收标准覆盖率 ≥ 95%

---

### REQ-4: 多文档智能合并

**WHEN** Stage 1 检测到多个需求文档时
**THEN** 系统 SHALL 进入 Stage 5 (文档合并)

- WHEN 处理多文档时
  THEN 系统 SHALL 使用 AskUserQuestion 询问是否合并
  THEN 系统 SHALL AI分析文档关系 (重复、冲突、互补)
  THEN 系统 SHALL 生成合并方案
  THEN 系统 SHALL AskUserQuestion 确认合并方案和冲突处理

- WHEN 执行合并时
  THEN 系统 SHALL 按 spec-workflow 格式生成合并文档
  THEN 系统 SHALL 保存到指定位置
  THEN 系统 SHALL AskUserQuestion 确认删除文档列表
  THEN 系统 SHALL 删除已合并文档，只保留一份

---

### REQ-5: 性能和质量保证

**WHEN** 执行需求分析时
**THEN** 系统 SHALL 满足以下性能要求

- 启动时间: < 2秒
- 文件扫描能力: 支持1000+文件
- 内存使用: < 500MB
- 分析准确性: ≥ 95%
- 问题检测准确率: ≥ 90%

**WHEN** 使用 AskUserQuestion 工具时
**THEN** 系统 SHALL 满足以下质量要求

- AskUserQuestion集成测试: 100%通过 (10/10)
- Stage执行验证: 100%通过 (12/12)
- 工作流程测试: 5/5阶段完整
- 环境兼容性: Claude Code环境完全支持

---

### REQ-6: 用户画像和市场定位

**WHEN** 定义目标用户时
**THEN** 需求 SHALL 明确以下用户画像

**主要用户群体**:
- 中级到高级软件开发者
- 产品经理 (具备技术背景)
- 业务分析师
- 技术文档编写者

**使用场景**:
- 项目初始阶段建立需求文档
- 现有需求文档的改进和完善
- 多团队需求文档的整合
- 需求质量审查和改进

**专业水平**:
- 熟悉软件开发流程
- 理解需求分析概念
- 能够与AI工具交互

**市场定位**:
- 面向企业级团队使用
- 作为开源工具提供价值
- 差异化优势: 5-stage工作流程 + 强制交互澄清 + spec-workflow集成

---

### REQ-7: 技术架构和实现

**WHEN** 实现技能时
**THEN** 系统 SHALL 采用以下技术方案

**架构设计**:
- 配置驱动实现: 仅依赖 SKILL.md，无需代码
- 完全AI驱动: 不使用正则表达式，依赖Claude AI理解
- MCP服务集成: 支持spec-workflow MCP工具

**环境支持**:
- Claude Code: 完整功能支持，包括AskUserQuestion工具
- 不支持 Cursor 环境: 技能仅适用于Claude Code

**工具集成**:
- Read: 读取需求文档和代码文件
- Bash: 查找文件、执行命令
- AskUserQuestion: 与用户交互 (必需)
- Write: 更新和完善需求文档
- spec-workflow MCP/CLI: 获取模板和上下文

---

### REQ-8: 安全和合规要求

**WHEN** 处理数据和文件时
**THEN** 系统 SHALL 遵循以下安全要求

- 绝不硬编码密钥、密码等敏感信息
- 安全的文件操作，验证文件路径
- 加密敏感数据传输 (TLS 1.3+)
- 限制文件大小 (≤ 10MB)
- 在日志中屏蔽敏感信息

**合规标准**:
- Claude Code Skills 95%+ 合规
- 遵循官方技能开发模板
- 完整的文档结构 (references/, assets/, examples/, docs/)
- MIT开源许可证

---

### REQ-9: 工作流程严格性

**WHEN** 执行技能时
**THEN** 系统 SHALL 严格遵循以下规则

1. **先扫描，后分析**: 必须先执行Stage 1 (扫描)，才能进入Stage 2
2. **先分析，后交互**: 必须完成Stage 2所有4子步骤，才能进入Stage 3
3. **交互不可跳过**: Stage 3是强制阶段，绝对不能跳过
4. **严格按照顺序**: 不能跳过Stage 1、2、3中的任何步骤
5. **完全AI驱动**: 所有分析必须基于AI理解，不使用模式匹配

**验证机制**:
- 每个步骤完成后必须验证
- 检查清单式验证
- 必须输出具体结果，不能只是说"已完成"

---

### REQ-10: 品牌和作者信息

**WHEN** 显示技能信息时
**THEN** 系统 SHALL 展示以下品牌信息

**作者信息**:
- 公司: 苏州核朔智能科技有限公司
- 邮箱: limian@norkern.com
- 网站: www.norker.com

**技能标识**:
- 名称: hs-req-facilitator-skill
- 版本: v2.0.0
- 合规: Claude Code Skills 95%+

**启动横幅**:
- ASCII艺术字"HS"
- 中英文双语描述
- 完整品牌信息展示

---

## Functional Requirements

### FR-1: 5-Stage工作流程引擎 (P0)

**需求ID**: FR-1
**优先级**: P0 (核心功能)
**状态**: 已实现
**描述**: 提供系统化的5-stage需求分析工作流

**功能点**:
- Stage 0: 强制工作流检查
- Stage 1: 自动扫描代码和文档
- Stage 2: 需求分析 (4子步骤)
- Stage 3: 交互澄清 (强制)
- Stage 4: 需求增强
- Stage 5: 多文档合并 (可选)

**验收标准**:
- 所有stage按顺序执行，不能跳过
- 每个stage有明确的检查点
- 输出具体的执行结果

---

### FR-2: 智能文件扫描系统 (P0)

**需求ID**: FR-2
**优先级**: P0 (核心功能)
**状态**: 已实现
**描述**: 自动识别和扫描需求相关文件

**功能点**:
- 扫描需求文档 (requirements.md, *requirement*.md, 需求*.md)
- 扫描代码文件 (TS, JS, Python, Java, Go, Rust等)
- 检测spec-workflow结构
- 统计文件和代码行数

**验收标准**:
- 支持多种文件命名模式
- 实际读取文件内容，不只是列出文件名
- 5秒内完成1000+文件扫描

---

### FR-3: AI驱动需求分析 (P0)

**需求ID**: FR-3
**优先级**: P0 (核心功能)
**状态**: 已实现
**描述**: 基于AI理解进行深度需求分析

**功能点**:
- 理解项目功能和业务逻辑
- 对比代码与需求一致性
- 识别模糊点、缺失信息、不一致性
- 评估信心度 (high/medium/low)
- 生成功能需求清单 (P0/P1/P2)

**验收标准**:
- 分析准确性 ≥ 95%
- 必须输出具体分析结果，不能只是说"已理解"
- 按优先级分类功能需求

---

### FR-4: AskUserQuestion交互系统 (P0)

**需求ID**: FR-4
**优先级**: P0 (核心功能)
**状态**: 已实现
**描述**: 通过AskUserQuestion工具进行强制交互澄清

**功能点**:
- 检测AskUserQuestion工具可用性
- 生成针对性澄清问题
- 等待用户回答并记录
- 基于回答调整后续问题
- 支持有/无问题两种场景

**验收标准**:
- 必须使用AskUserQuestion工具，不能用对话替代
- 必须等待用户回答后才能继续
- 即使没有问题也至少交互一次
- 10/10 AskUserQuestion测试通过

---

### FR-5: Spec-Workflow集成 (P1)

**需求ID**: FR-5
**优先级**: P1 (重要功能)
**状态**: 已实现
**描述**: 自动生成和管理spec-workflow格式文档

**功能点**:
- 检测项目是否使用spec-workflow
- 使用MCP工具或CLI获取模板
- 生成标准化需求文档
- 更新现有spec-workflow结构
- 自动创建目录结构

**验收标准**:
- 生成符合spec-workflow标准的文档
- 支持现有和新建两种场景
- 文档格式一致性

---

### FR-6: 多文档合并引擎 (P1)

**需求ID**: FR-6
**优先级**: P1 (重要功能)
**状态**: 已实现
**描述**: 智能合并多个需求文档

**功能点**:
- 检测多个需求文档
- AI分析文档关系 (重复/冲突/互补)
- 生成合并方案
- AskUserQuestion确认合并计划
- 执行合并并清理冗余文档

**验收标准**:
- 准确识别文档关系
- 生成合理的合并方案
- 确保只保留一份文档
- 删除前必须用户确认

---

### FR-7: 需求增强和标准化 (P2)

**需求ID**: FR-7
**优先级**: P2 (一般功能)
**状态**: 已实现
**描述**: 生成用户故事和验收标准

**功能点**:
- 生成用户故事 (As a [role], I want [feature], so that [benefit])
- 生成EARS格式验收标准 (WHEN [condition] THEN [system] SHALL [response])
- 添加业务价值说明
- 补充非功能性需求

**验收标准**:
- 用户故事格式正确
- 验收标准覆盖率 ≥ 95%
- 业务价值清晰表达

---

### FR-8: 空项目引导系统 (P2)

**需求ID**: FR-8
**优先级**: P2 (一般功能)
**状态**: 已实现
**描述**: 为空白项目提供需求创建指导

**功能点**:
- 检测无需求文档的项目
- AskUserQuestion询问是否创建
- 引导收集项目信息
- 生成初始需求文档
- 提供模板和示例

**验收标准**:
- 准确检测空项目
- 引导过程清晰易懂
- 生成符合要求的初始文档

---

## Non-Functional Requirements

### Performance

- **启动时间**: < 2秒
- **文件扫描**: 支持1000+文件，5秒内完成
- **分析准确性**: ≥ 95%
- **内存使用**: < 500MB
- **问题检测准确率**: ≥ 90%
- **分类准确率**: ≥ 95%

### Reliability

- **AskUserQuestion集成测试**: 100%通过 (10/10)
- **Stage执行验证**: 100%通过 (12/12)
- **工作流程测试**: 5/5阶段完整
- **错误处理**: 优雅处理工具不可用和文件读取失败
- **恢复机制**: 提供友好错误信息和重试建议

### Security

- **数据保护**: 绝不硬编码敏感信息
- **文件安全**: 验证文件路径，限制大小 ≤ 10MB
- **传输加密**: 使用TLS 1.3+加密敏感数据
- **日志安全**: 屏蔽敏感信息
- **权限控制**: 安全的文件读写操作

### Usability

- **学习曲线**: < 30分钟上手
- **语言支持**: 中文输入，中文输出 (默认)
- **交互方式**: AskUserQuestion工具 + 可视化进度
- **错误提示**: 清晰、可操作的错误信息
- **文档完整性**: 95%+ 文档覆盖率

### Maintainability

- **架构**: 配置驱动，无代码依赖
- **文档**: 完整的README、SETUP、CHANGELOG
- **测试**: 自动化测试覆盖
- **版本控制**: Semantic Versioning (v2.0.0)
- **标准合规**: Claude Code Skills 95%+ 合规

### Compatibility

- **环境**: 仅支持Claude Code环境
- **平台**: macOS, Windows, Linux
- **集成**: spec-workflow MCP服务支持
- **标准**: 遵循官方技能开发模板
- **许可证**: MIT开源许可证

---

## Success Metrics

### 定量指标

1. **AskUserQuestion测试通过率**: 目标100% (当前: 100%)
2. **Stage执行验证**: 目标100% (当前: 100%)
3. **用户满意度**: 通过AskUserQuestion收集反馈
4. **使用频次**: 统计技能激活次数
5. **分析准确性**: ≥ 95%
6. **文档覆盖率**: ≥ 95%

### 定性指标

1. **用户体验**: 流程清晰，交互顺畅
2. **文档质量**: 改进后的需求文档更清晰、更完整
3. **品牌认知**: 技能启动横幅提升品牌识别度
4. **社区反馈**: GitHub Issues和Discussions积极反馈
5. **合规认可**: Claude Code Skills官方标准认可

---

## Constraints

1. **环境限制**: 仅支持Claude Code环境，不支持Cursor
2. **工具依赖**: 必须使用AskUserQuestion工具，无法降级
3. **MCP服务**: spec-workflow MCP工具可选但优先使用
4. **AI依赖**: 完全依赖Claude AI能力，无法使用外部LLM API
5. **实现方式**: 纯配置驱动 (SKILL.md)，无代码实现

---

## Assumptions

1. 用户具备基本的软件开发知识
2. 用户熟悉需求分析概念
3. 项目使用Git版本控制
4. 需求文档使用Markdown格式
5. 用户愿意进行交互澄清

---

## Dependencies

1. **Claude Code平台**: 提供AI能力和AskUserQuestion工具
2. **spec-workflow生态**: 用于标准化需求文档格式
3. **Git**: 用于版本控制和变更追踪
4. **Markdown**: 用于需求文档编写
5. **文件系统**: 用于读取和写入项目文件

---

*本文档通过HS Req Facilitator Skill v2.0.0自动生成和改进*
*遵循spec-workflow标准和Claude Code Skills最佳实践*
