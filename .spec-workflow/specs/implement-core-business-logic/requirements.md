# Requirements: HS Req Facilitator Skill

> **⚠️ IMPORTANT: LEGACY DOCUMENT - PLANNING ONLY**
> **This skill package has always been configuration-driven using SKILL.md**
> **No TypeScript code was ever implemented**
> **See SKILL.md for the actual implementation**

> **Spec Name**: hs-req-facilitator-skill
> **Created**: 2025-11-02
> **Status**: Active (Requirements for SKILL.md configuration)
> **Version**: v3.12 (完善需求版)
> **Last Updated**: 2025-11-04

---

## Introduction

HS Req Facilitator Skill is an intelligent requirement analysis assistant that uses AI-driven code and document analysis to help users identify, clarify, and refine project requirement documents.

**Core Value**:
- 🤖 Fully AI-driven, no regex
- 🔍 Analyzes both documents and code
- 💬 Interactive clarification through dialogue
- 📊 Ensures requirement completeness

**Target Users**: Product managers, system analysts, technical leads

---

## Requirements

### REQ-1: AI-Driven Requirement Analysis

**User Story**: As a developer, I want the requirement analyzer to identify unclear requirements, missing information, and inconsistencies between code and documents.

**Acceptance Criteria**:
- REQ-1.1: WHEN analyzing, THEN identify problems: missing-info, uncertainty, inconsistency
- REQ-1.2: WHEN problems identified, THEN mark confidence: high/medium/low
- REQ-1.3: WHEN analyzing, THEN NOT use regex, rely entirely on AI understanding
- REQ-1.4: WHEN analysis of code and documents completes, THEN list functional requirements list and present to user (Required, must complete after scanning and analysis)
  - List includes: function name, description, behavior, I/O, code status, location
  - Must be presented to user after completing analysis of code and documents
- REQ-1.5: WHEN listing, THEN classify as P0/P1/P2

**Note**: Analysis accuracy target ≥ 95%. Actual processing time is controlled by Claude Code platform.

---

### REQ-2: Interactive Clarification System

**User Story**: As a user, I want to answer clarification questions interactively to refine requirements.

**Acceptance Criteria**:
- REQ-2.1: WHEN problems detected, THEN use AskUserQuestion tool (required, cannot skip)
- REQ-2.2: WHEN Stage 2 completes, THEN MUST perform at least one AskUserQuestion interaction
  - IF problems detected, THEN ask clarification questions about problems
  - IF no problems detected, THEN inform user no problems found and ask: "是否要添加新需求？或直接进入下一步？"
- REQ-2.3: WHEN user answers, THEN record and adjust subsequent questions
- REQ-2.4: WHEN generating questions, THEN base on functional requirements list and problem analysis
- REQ-2.5: WHEN generating questions, THEN target specific functionalities, not generic checklists
- REQ-2.6: WHEN Stage 2 completes, THEN MUST enter Stage 3 (cannot skip)

**Quality Targets**: Question relevance ≥ 90%, support 5-30 rounds (default 20)
**Note**: Actual question generation time is controlled by Claude Code platform.

---

### REQ-3: Document Enhancement and Updating

**User Story**: As a user, I want the system to enhance requirement documents with user stories and acceptance criteria.

**Acceptance Criteria**:
- REQ-3.1: WHEN enhancing, THEN preserve original content (append mode)
- REQ-3.2: WHEN generating, THEN use format: "As a [role], I want [feature], so that [benefit]"
- REQ-3.3: WHEN adding criteria, THEN use EARS format: "WHEN [condition] THEN [system] SHALL [response]"
- REQ-3.4: WHEN generating, THEN follow spec-workflow format regardless of project usage
- REQ-3.5: WHEN updating, THEN acceptance criteria coverage ≥ 95%

**Quality Targets**: Acceptance criteria coverage ≥ 95%
**Note**: Actual document enhancement time is controlled by Claude Code platform.

---

### REQ-4: Problem Detection and Classification

**User Story**: As a developer, I want the system to detect and classify problems in requirements.

**Acceptance Criteria**:
- REQ-4.1: WHEN analyzing, THEN detect: uncertainty, missing-info, inconsistency
- REQ-4.2: WHEN detecting, THEN assign confidence level based on AI certainty
- REQ-4.3: WHEN detecting, THEN determine if false positives (code already explains)
- REQ-4.4: WHEN detecting, THEN clearly state: what missing, why problem, false positive?, how fix

**Quality Targets**: Detection accuracy ≥ 90%, classification accuracy ≥ 95%
**Note**: These are accuracy targets for the skill's logic. Actual AI processing time is controlled by Claude Code platform.

---

### REQ-5: Requirement Document Merging

**User Story**: As a user, I want to merge multiple requirement documents into one unified document.

**Acceptance Criteria**:
- REQ-5.1: WHEN multiple documents detected, THEN use AskUserQuestion to ask if merge
- REQ-5.2: WHEN merging, THEN use AI to analyze: duplicates, conflicts, complementary
- REQ-5.3: WHEN merging, THEN use AskUserQuestion to confirm plan and handle conflicts
- REQ-5.4: WHEN saving merged, THEN save to spec-workflow format requirement document
- REQ-5.5: WHEN deleting merged documents, THEN use AskUserQuestion to confirm list of documents to delete (must confirm document list before deletion)
- REQ-5.6: WHEN merge completes, THEN only one requirement document remains

---

### REQ-6: Empty Project Guidance

**User Story**: As a user, I want the system to guide me in creating initial requirement documents.

**Acceptance Criteria**:
- REQ-6.1: WHEN no documents detected, THEN use AskUserQuestion to ask if create
- REQ-6.2: WHEN creating, THEN collect: project goals, user groups, main functionalities
- REQ-6.3: WHEN creating, THEN extract potential requirements from code
- REQ-6.4: WHEN generating, THEN generate in spec-workflow format

---

### REQ-7: Spec-Workflow Integration

**User Story**: As a user, I want the system to integrate with spec-workflow for standardized formats.

**Acceptance Criteria**:
- REQ-7.1: WHEN processing, THEN follow spec-workflow format regardless of project usage
- REQ-7.2: WHEN project uses spec-workflow, THEN use MCP tools to get templates
- REQ-7.3: WHEN project doesn't use spec-workflow, THEN still generate in spec-workflow format
- REQ-7.4: WHEN project doesn't use spec-workflow, THEN ask if create spec-workflow structure

---

### REQ-8: Requirement Traceability

**User Story**: As a developer, I want to track requirement changes and code mappings.

**Acceptance Criteria**:
- REQ-8.1: WHEN updating, THEN record change history (metadata or separate file)
- REQ-8.2: WHEN analyzing, THEN track requirement-to-code mappings (file paths)
- REQ-8.3: WHEN tracking, THEN mark requirement sources (document/code/user input)

---

### REQ-9: Error Handling and Recovery

**User Story**: As a user, I want the system to gracefully handle errors and provide recovery guidance.

**Acceptance Criteria**:
- REQ-9.1: WHEN AskUserQuestion tool unavailable, THEN inform user of limitation and suggest manual approach
- REQ-9.2: WHEN file reading fails, THEN skip file and continue analysis
- REQ-9.3: WHEN AI analysis fails, THEN provide friendly error message with retry suggestion
- REQ-9.4: WHEN tool dependency check fails, THEN inform user and halt execution gracefully
- REQ-9.5: WHEN performing critical operations, THEN validate prerequisites before execution

---

### REQ-10: Tool Dependency Management

**User Story**: As a system administrator, I want the system to clearly communicate its tool dependencies.

**Acceptance Criteria**:
- REQ-10.1: WHEN skill starts, THEN check availability of required tools (Read, Bash, AskUserQuestion, Write, spec-workflow MCP)
- REQ-10.2: WHEN required tool unavailable, THEN clearly indicate limitation and affected functionality
- REQ-10.3: WHEN generating analysis, THEN NOT use regex, rely entirely on Claude AI understanding
- REQ-10.4: WHEN tool fails, THEN provide actionable error message indicating which tool failed and why

---

### REQ-11: AI Model Specification

**User Story**: As a developer, I want to understand the AI capabilities and limitations of the skill.

**Acceptance Criteria**:
- REQ-11.1: WHEN processing, THEN use Claude Code's built-in AI model for understanding
- REQ-11.2: WHEN analyzing, THEN rely entirely on AI understanding without regex or pattern matching
- REQ-11.3: WHEN generating questions, THEN base on AI understanding of context, not templates
- REQ-11.4: WHEN processing, THEN use AI to understand both code and documentation simultaneously

**Note**: This skill operates on the Claude Code platform and uses the platform's AI capabilities. No specific model selection is required.

---

### REQ-12: Multi-Language Support Specification

**User Story**: As a user, I want the skill to clearly handle both Chinese and English inputs.

**Acceptance Criteria**:
- REQ-12.1: WHEN user input is Chinese, THEN process Chinese input naturally
- REQ-12.2: WHEN user input is English, THEN process English input naturally
- REQ-12.3: WHEN generating output, THEN use Chinese as default language
- REQ-12.4: WHEN user explicitly requests English output, THEN switch to English output
- REQ-12.5: WHEN mixed language input detected, THEN process based on primary language used

---

## Non-Functional Requirements

### Performance
- **Note**: As a Claude Code Skill, actual AI processing time (analysis, question generation, document enhancement) is controlled by the Claude Code platform and is not part of this skill's implementation.
- Max document size: 10MB
- Max code files: 500 (configurable)
- **Note**: Memory usage is managed by the Claude Code platform.

### Reliability
- WHEN AI unavailable, THEN provide friendly error with retry suggestion
- WHEN file fails, THEN skip and continue
- **Quality Targets**: Accuracy ≥ 95%, false positive < 5%
  - **Note**: These are accuracy targets for the skill's logic. Actual AI service reliability is guaranteed by Claude Code platform.

### Security
- Encrypt sensitive data (TLS 1.3+)
- Validate file paths, limit sizes (≤ 10MB)
- Mask sensitive info in logs

### Usability
- Learning curve < 30 minutes
- Support Chinese and English
- Default language: Chinese

### Maintainability
- TypeScript strict mode
- Chinese comments explaining AI logic
- No regex patterns, use AI understanding
- Code comment coverage ≥ 60%
- Unit test coverage ≥ 80%

### Compatibility
- macOS 10.15+, Windows 10+, Linux Ubuntu 18.04+
- Node.js ≥ 16.0.0, TypeScript ≥ 4.9.0
- Support spec-workflow and non-spec-workflow projects

---

## Workflow

### Core Principles
1. Scan first, then decide
2. Analyze first, then interact
3. Interactive clarification cannot be skipped

### Stages

**Stage 0: Scan Code and Documents** (Required)
- Scan requirement documents
- Scan code files
- Analyze scan results

**Stage 1: Decide Flow**
- Empty project → Guide create requirements
- Multiple documents → Ask if merge, enter Stage 5
- Has documents → Enter Stage 2 directly

**Stage 2: Requirement Analysis** (Must complete before Stage 3)

**⚠️ Critical: Must execute in strict order, cannot skip steps**

1. **Read documents and code** (Required, first step)
   - Scan requirement documents
   - Scan code files

2. **Understand project functionality** (Required, critical step)
   - What is the project? What are its core functionalities?
   - What actual functionality does each requirement correspond to?
   - What functionalities are implemented in code?
   - Compare code and requirements to understand functional consistency

3. **Analyze problems and missing information** (Required, must complete before listing requirements)
   - Identify unclear/missing/inconsistent
   - Assess completeness
   - Determine false positives
   - State clearly: what missing, why problem, false positive?, how fix

4. **List functional requirements list** (Required, must present to user after completing analysis)
   - Based on code and document analysis results, list all functional requirements
   - Each requirement includes: function name, description, behavior, I/O, code status, location
   - Classify as P0/P1/P2
   - **Must be presented to user after scanning, analysis, and understanding project functionality**

**⚠️ Critical Checkpoint: After Stage 2 completes, MUST enter Stage 3 (cannot skip)**

**Stage 3: Interactive Clarification** (Required, cannot skip)

**⚠️ Critical: This stage is mandatory, cannot skip**

- **Must use AskUserQuestion tool** (cannot just output text)
- **Must perform at least one AskUserQuestion interaction** (required, cannot skip)
  - **IF problems detected**: Ask clarification questions about problems
  - **IF no problems detected**: Inform user "没有发现问题需要澄清"，then ask: "是否要添加新需求？或直接进入下一步？"
- Generate questions based on functional requirements list and problems
- Target specific functionalities, not generic checklists
- Ask one by one until all key questions answered

**⚠️ Critical Checkpoint: Only after completing all interactions in Stage 3 can enter Stage 4**

**Stage 4: Requirement Enhancement**
- Integrate: original document, user answers, code status, functional requirements list
- Generate user stories and EARS criteria
- Follow spec-workflow format (regardless of project usage)
- Preserve original content (append mode)
- If project uses spec-workflow: update `.spec-workflow/specs/*/requirements.md`
- If not: generate spec-workflow format, ask if create structure

**Stage 5: Requirement Document Merging** (When multiple documents)

**⚠️ Trigger condition**: In Stage 1, if multiple requirement documents detected, enter this stage.

1. Identify documents to merge
2. AI analyze: duplicates, conflicts, complementary
3. Generate merge plan
4. Use AskUserQuestion to confirm merge plan and handle conflicts
5. Execute merge
6. Save to spec-workflow format requirement document
7. **Use AskUserQuestion to confirm list of documents to delete** (must confirm document list before deletion)
8. Delete all merged documents (only after user confirmation)
9. Keep only one document

**⚠️ Critical: Must confirm document list using AskUserQuestion before deletion**

---

## Implementation Details

### Configuration
- **Sources**: Claude Code project folder, requirements.md metadata, defaults
- **Priority**: `.spec-workflow/requirements.md` metadata > root `requirements.md` > defaults
- **Storage**: Metadata in requirements.md (recommended) or SKILL.md
- **Default**: maxFiles=500, maxRounds=20, excludePatterns=[node_modules, .git, dist, build]

### Tools
- Read: Read documents and code
- Bash: Find files, execute commands
- AskUserQuestion: Interact with users (Required)
- Write: Update documents
- spec-workflow MCP: Get templates and context

---

## Important Principles

1. Fully AI-driven: No regex, rely entirely on AI understanding
2. Analyze code and documents: Both requirement documents and code files
3. Analyze first, then interact: Stage 2 must complete before Stage 3
4. Interactive clarification cannot be skipped: Stage 3 is required
5. First list functional requirements list: Stage 2 must list first, then analyze problems
6. Supplement through AskUserQuestion: Stage 3 must use AskUserQuestion
7. Integrated into spec-workflow: Process in spec-workflow format regardless
8. Strict execution order: Cannot skip Stage 1, 2, or 3

---

*Requirements Document Version: v3.12 (完善需求版)*
*Last Updated: 2025-11-02*
*Changes:
  - v3.12 - 完善需求文档：
    1. 新增 REQ-9: 错误处理和恢复 - 补充AskUserQuestion工具失败、文件读取失败、AI分析失败等情况的处理方案
    2. 新增 REQ-10: 工具依赖管理 - 明确技能的工具依赖性（Read, Bash, AskUserQuestion, Write, spec-workflow MCP）
    3. 新增 REQ-11: AI模型规范 - 明确使用Claude Code平台的AI能力，不使用正则表达式，完全依赖AI理解
    4. 新增 REQ-12: 多语言支持规范 - 明确中文输入处理、中文默认输出、英文输入处理、英文输出切换等规则
    5. 修正工作流阶段编号 - 统一为Stage 0-5，避免不一致
  - v3.11 - 修正性能要求：
    1. 删除不合理的具体时间要求（Analysis ≤ 2s, Code scanning ≤ 5s, Question generation ≤ 1s, Document enhancement ≤ 3s, Memory < 500MB）
    2. 明确说明：作为 Claude Code Skill，实际 AI 处理时间由 Claude Code 平台控制，不是技能本身能控制的
    3. 保留质量指标（准确性、相关性、覆盖率等），因为这些是技能逻辑可以控制的
    4. 更新 REQ-1、REQ-2、REQ-3、REQ-4 中的性能说明，将"Performance"改为"Quality Targets"或"Note"
  - v3.10 - 修正流程顺序和交互说明：
    1. REQ-1.4: 修正为"分析完成后列出功能需求清单"（不是分析之前）
    2. Stage 2: 调整顺序为：扫描 → 理解功能 → 分析问题 → 列出功能需求清单
    3. REQ-2.2: 明确即使没有问题也要告知用户，询问是否添加新需求或继续下一步
    4. Stage 3: 明确即使没有问题也要告知用户，询问是否添加新需求或继续下一步
  - v3.9 - 补充5个关键需求的明确说明：
    1. REQ-1.4: 明确"首先列出功能需求清单"必须展示给用户，是分析的第一步
    2. REQ-2.2: 添加"必须至少进行一次交互"的明确要求
    3. Stage 2: 明确"理解项目功能"是必需的关键步骤，必须在列出功能需求清单之前完成
    4. Stage 3: 加强关键检查点说明，明确必须至少进行一次AskUserQuestion交互
    5. REQ-5.5: 明确删除文档前必须使用AskUserQuestion确认要删除的文档列表
  - v3.8 - Enhanced Stage 5 (requirement document merging) workflow, clarified merged document must be saved to spec-workflow format and delete other documents, ensure only one document*
