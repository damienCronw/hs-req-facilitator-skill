# Tasks: Implement Core Business Logic

> **⚠️ IMPORTANT: LEGACY DOCUMENT - PLANNING ONLY**
> **This skill package has always been configuration-driven using SKILL.md**
> **No TypeScript code was ever implemented**
> **See SKILL.md for the actual implementation**

> **Spec Name**: implement-core-business-logic
> **Created**: 2025-11-02
> **Status**: Complete (Planning Documentation - Never Implemented)

---

## Overview

This document breaks down the design into atomic, executable tasks. Each task is designed to be:
- **Atomic**: Touches 1-3 related files maximum
- **Time-boxed**: Completable in 15-30 minutes
- **Single-purpose**: One testable outcome per task
- **Agent-friendly**: Clear input/output with minimal context switching

---

## Task List

### Phase 1: RequirementAnalyzer Implementation

#### Task 1.1: Enhance analyzeRequirements() Method with AI Guidance

**Status**: [x] Completed

**Files to Modify**:
- `src/services/requirementAnalyzer.ts`

**Requirements**: REQ-1.1, REQ-1.2, REQ-1.3, REQ-1.4, REQ-1.5

**Description**:
Enhance the `analyzeRequirements()` method to guide Claude Code AI in performing actual requirement analysis. Replace the empty array returns with structured code that guides AI understanding.

**Implementation Details**:
1. Enhance the method with detailed comments explaining what analysis should be performed
2. Structure the context building to guide AI understanding
3. Add validation logic to ensure results are meaningful
4. Add error handling for AI understanding failures

**Acceptance Criteria**:
- Method includes detailed comments guiding AI analysis
- Context structure helps AI identify problems, recommendations, and priorities
- Returns AnalysisReport with actual structure (even if empty initially, structure guides AI)
- Statistics calculation logic is present

**Leverage**:
- Existing `buildAnalysisContext()` method
- Type definitions in `src/types/index.ts`
- Design document section 1.1

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in AI-driven code analysis

Task: Enhance the analyzeRequirements() method in src/services/requirementAnalyzer.ts to guide Claude Code AI in performing requirement analysis. Add detailed comments explaining:
1. What analysis should be performed (missing-info, uncertainty, inconsistency detection)
2. How to structure results (problems array with confidence levels)
3. How to calculate statistics (total problems, breakdown by priority)
4. How AI should understand the context and populate results

The method should NOT call external APIs, but instead structure code and comments in a way that guides Claude Code AI to understand and perform analysis.

Restrictions:
- Do NOT use regex patterns
- Do NOT call external LLM APIs
- Do NOT change method signature
- Keep existing buildAnalysisContext() method intact
- Maintain TypeScript type compatibility

Leverage:
- src/services/requirementAnalyzer.ts (existing code)
- src/types/index.ts (AnalysisReport type definition)
- Design document section 1.1

Requirements: REQ-1.1, REQ-1.2, REQ-1.3, REQ-1.4, REQ-1.5

Success Criteria:
- Method has detailed comments explaining AI-guided analysis
- Code structure guides AI understanding
- Returns properly structured AnalysisReport
- Statistics calculation logic is present

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/requirementAnalyzer.ts
3. Enhance analyzeRequirements() method with AI guidance comments
4. Add structure for AI to populate problems, recommendations, priorities
5. Add statistics calculation logic
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

#### Task 1.2: Implement detectProblems() Method with AI Guidance

**Status**: [x] Completed

**Files to Modify**:
- `src/services/requirementAnalyzer.ts`

**Requirements**: REQ-4.1, REQ-4.2, REQ-4.3, REQ-4.4, REQ-4.5

**Description**:
Implement the `detectProblems()` method to guide AI in detecting three types of problems: missing-info, uncertainty, and inconsistency.

**Implementation Details**:
1. Build focused context for problem detection
2. Add comments guiding AI to identify problem types
3. Assign confidence levels based on AI certainty
4. Include location information for problems

**Acceptance Criteria**:
- Method detects missing-info (required information not present)
- Method detects uncertainty (vague statements)
- Method detects inconsistency (code vs document conflicts)
- Confidence levels are assigned (high/medium/low)
- Location information is included

**Leverage**:
- Existing `buildAnalysisContext()` method
- Problem type definitions in `src/types/index.ts`
- Design document section 1.2

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in AI-driven problem detection

Task: Implement the detectProblems() method in src/services/requirementAnalyzer.ts to guide AI in detecting three types of problems:
1. missing-info: Required information not present in documents
2. uncertainty: Vague or ambiguous statements
3. inconsistency: Conflicts between code implementation and document requirements

Add detailed comments explaining:
- How to identify each problem type using AI understanding
- How to assign confidence levels (high ≥90%, medium 50-89%, low <50%)
- How to extract location information (file path, optional line number)

Restrictions:
- Do NOT use regex patterns
- Do NOT call external LLM APIs
- Use AI understanding through code structure and comments
- Maintain Problem type compatibility

Leverage:
- src/services/requirementAnalyzer.ts (existing code)
- src/types/index.ts (Problem type definition)
- Design document section 1.2

Requirements: REQ-4.1, REQ-4.2, REQ-4.3, REQ-4.4, REQ-4.5

Success Criteria:
- Method detects all three problem types
- Confidence levels are assigned correctly
- Location information is included
- Returns Problem[] array

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/requirementAnalyzer.ts
3. Implement detectProblems() method with AI guidance
4. Add problem detection logic with comments
5. Add confidence level assignment logic
6. Add location extraction logic
7. Verify TypeScript compilation passes
8. Mark task as complete [x] in tasks.md
```

---

#### Task 1.3: Implement extractRequirements() Method with AI Guidance

**Status**: [x] Completed

**Files to Modify**:
- `src/services/requirementAnalyzer.ts`

**Requirements**: REQ-3.2, REQ-3.3

**Description**:
Implement the `extractRequirements()` method to guide AI in extracting requirements from documents.

**Implementation Details**:
1. Build context focused on requirement extraction
2. Guide AI to identify user stories, acceptance criteria, and business value
3. Return structured Requirement[] array

**Acceptance Criteria**:
- Method extracts requirements from document
- Requirements include user stories, acceptance criteria, and business value
- Returns Requirement[] array matching type definition

**Leverage**:
- Requirement type definition in `src/types/index.ts`
- Design document section 1.3

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in AI-driven requirement extraction

Task: Implement the extractRequirements() method in src/services/requirementAnalyzer.ts to guide AI in extracting requirements from documents.

Add detailed comments explaining:
- How to identify requirements using AI understanding
- How to extract user stories, acceptance criteria, and business value
- How to structure requirements according to Requirement type

Restrictions:
- Do NOT use regex patterns
- Do NOT call external LLM APIs
- Use AI understanding through code structure and comments
- Maintain Requirement type compatibility

Leverage:
- src/services/requirementAnalyzer.ts (existing code)
- src/types/index.ts (Requirement type definition)
- Design document section 1.3

Requirements: REQ-3.2, REQ-3.3

Success Criteria:
- Method extracts requirements from document
- Requirements include user stories, acceptance criteria, business value
- Returns Requirement[] array

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/requirementAnalyzer.ts
3. Implement extractRequirements() method with AI guidance
4. Add requirement extraction logic with comments
5. Add structure for user stories, acceptance criteria, business value
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

### Phase 2: ClarificationService Integration

#### Task 2.1: Add AskUserQuestion Integration Pattern

**Status**: [x] Completed

**Files to Modify**:
- `src/services/clarificationService.ts`

**Requirements**: REQ-2.1, REQ-2.2, REQ-2.3

**Description**:
Add `askUserQuestions()` method that integrates with AskUserQuestion tool using code comments to guide Claude Code AI.

**Implementation Details**:
1. Create `askUserQuestions()` method
2. Add detailed comments explaining AskUserQuestion tool usage
3. Structure code to guide AI in using the tool
4. Implement answer collection and recording

**Acceptance Criteria**:
- Method exists with AskUserQuestion integration pattern
- Comments guide AI on when and how to use AskUserQuestion
- Answers are collected and recorded
- Conversation context is maintained

**Leverage**:
- Existing `recordAnswer()` method
- ConversationContext type definition
- Design document section 2.1

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in Claude Code Skill tool integration

Task: Add askUserQuestions() method to src/services/clarificationService.ts that integrates with AskUserQuestion tool.

Since this is a Claude Code Skill, the tool is not directly importable. Instead, use code comments to guide Claude Code AI:
1. Explain when to use AskUserQuestion tool
2. Show expected tool call format in comments
3. Structure code to guide AI behavior
4. Collect and record user answers

The method should:
- Accept ClarificationQuestion[] array
- Iterate through questions
- Use AskUserQuestion tool for each question (guided by comments)
- Record answers using existing recordAnswer() method
- Return UserAnswer[] array

Restrictions:
- Do NOT directly import AskUserQuestion (not available in code context)
- Use code comments to guide Claude Code AI to use the tool
- Maintain existing conversation context management
- Do NOT simulate user interaction

Leverage:
- src/services/clarificationService.ts (existing code)
- src/types/index.ts (ClarificationQuestion, UserAnswer types)
- Design document section 2.1

Requirements: REQ-2.1, REQ-2.2, REQ-2.3

Success Criteria:
- askUserQuestions() method exists
- Comments guide AskUserQuestion tool usage
- Answers are collected and recorded
- Conversation context is maintained

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/clarificationService.ts
3. Add askUserQuestions() method with AskUserQuestion integration pattern
4. Add detailed comments explaining tool usage
5. Implement answer collection logic
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

#### Task 2.2: Enhance adjustQuestions() Method with AI Guidance

**Status**: [x] Completed

**Files to Modify**:
- `src/services/clarificationService.ts`

**Requirements**: REQ-2.2

**Description**:
Enhance the `adjustQuestions()` method to generate follow-up questions based on user answers using AI understanding.

**Implementation Details**:
1. Add logic to analyze user answers
2. Guide AI to generate contextual follow-up questions
3. Maintain conversation flow

**Acceptance Criteria**:
- Method analyzes user answers using AI guidance
- Generates contextual follow-up questions
- Maintains conversation flow

**Leverage**:
- Existing `generateQuestions()` method
- UserAnswer type definition
- Design document section 2.3

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in AI-driven conversation management

Task: Enhance the adjustQuestions() method in src/services/clarificationService.ts to generate follow-up questions based on user answers using AI understanding.

Add detailed comments explaining:
- How to analyze user answers using AI understanding
- How to generate contextual follow-up questions
- How to maintain conversation flow

The method should:
- Accept UserAnswer[] array (previous answers)
- Analyze answers using AI guidance (through comments)
- Generate follow-up questions based on context
- Return ClarificationQuestion[] array

Restrictions:
- Do NOT use regex patterns to parse answers
- Do NOT call external LLM APIs
- Use AI understanding through code structure and comments
- Maintain conversation context

Leverage:
- src/services/clarificationService.ts (existing code)
- src/types/index.ts (UserAnswer, ClarificationQuestion types)
- Design document section 2.3

Requirements: REQ-2.2

Success Criteria:
- Method analyzes user answers
- Generates contextual follow-up questions
- Maintains conversation flow

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/clarificationService.ts
3. Enhance adjustQuestions() method with AI guidance
4. Add answer analysis logic with comments
5. Add follow-up question generation logic
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

### Phase 3: DocumentEnhancer Implementation

#### Task 3.1: Implement generateUserStory() Method with AI Guidance

**Status**: [x] Completed

**Files to Modify**:
- `src/services/documentEnhancer.ts`

**Requirements**: REQ-3.2, REQ-3.5

**Description**:
Implement the `generateUserStory()` method to generate standard user story format using AI understanding.

**Implementation Details**:
1. Build context with requirement information
2. Guide AI to generate format: "As a [role], I want [feature], so that [benefit]"
3. Use AI understanding to extract role, feature, and benefit

**Acceptance Criteria**:
- Method generates user stories in standard format
- Uses AI understanding (not regex parsing)
- Returns properly formatted user story string

**Leverage**:
- Requirement type definition
- Design document section 3.1

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in AI-driven content generation

Task: Implement the generateUserStory() method in src/services/documentEnhancer.ts to generate standard user story format using AI understanding.

Add detailed comments explaining:
- How to extract role, feature, and benefit from requirement
- How to format user story: "As a [role], I want [feature], so that [benefit]"
- How AI should understand requirement information

The method should:
- Accept Requirement object
- Generate user story using AI understanding (guided by comments)
- Return formatted user story string

Restrictions:
- Do NOT use regex patterns to parse requirement
- Do NOT call external LLM APIs
- Use AI understanding through code structure and comments
- Generate standard user story format

Leverage:
- src/services/documentEnhancer.ts (existing code)
- src/types/index.ts (Requirement type definition)
- Design document section 3.1

Requirements: REQ-3.2, REQ-3.5

Success Criteria:
- Method generates user stories in standard format
- Uses AI understanding (not regex)
- Returns properly formatted string

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/documentEnhancer.ts
3. Implement generateUserStory() method with AI guidance
4. Add user story generation logic with comments
5. Add format structure guidance
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

#### Task 3.2: Implement generateEARS() Method with AI Guidance

**Status**: [x] Completed

**Files to Modify**:
- `src/services/documentEnhancer.ts`

**Requirements**: REQ-3.3, REQ-3.6

**Description**:
Implement the `generateEARS()` method to generate EARS format acceptance criteria using AI understanding.

**Implementation Details**:
1. Build context with requirement details
2. Guide AI to generate format: "WHEN [condition] THEN [system] SHALL [response]"
3. Use AI understanding to identify conditions, system behavior, and expected responses

**Acceptance Criteria**:
- Method generates EARS format acceptance criteria
- Uses AI understanding (not regex matching)
- Returns string[] array with EARS format criteria

**Leverage**:
- Requirement type definition
- Design document section 3.2

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in AI-driven acceptance criteria generation

Task: Implement the generateEARS() method in src/services/documentEnhancer.ts to generate EARS format acceptance criteria using AI understanding.

Add detailed comments explaining:
- How to identify conditions, system behavior, and expected responses
- How to format EARS criteria: "WHEN [condition] THEN [system] SHALL [response]"
- How AI should understand requirement details

The method should:
- Accept Requirement object
- Generate EARS format criteria using AI understanding (guided by comments)
- Return string[] array with EARS format criteria

Restrictions:
- Do NOT use regex patterns to match EARS format
- Do NOT call external LLM APIs
- Use AI understanding through code structure and comments
- Generate EARS format criteria

Leverage:
- src/services/documentEnhancer.ts (existing code)
- src/types/index.ts (Requirement type definition)
- Design document section 3.2

Requirements: REQ-3.3, REQ-3.6

Success Criteria:
- Method generates EARS format acceptance criteria
- Uses AI understanding (not regex)
- Returns properly formatted string[] array

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/documentEnhancer.ts
3. Implement generateEARS() method with AI guidance
4. Add EARS criteria generation logic with comments
5. Add format structure guidance
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

#### Task 3.3: Enhance enhanceDocument() Method Integration

**Status**: [x] Completed

**Files to Modify**:
- `src/services/documentEnhancer.ts`

**Requirements**: REQ-3.1, REQ-3.4

**Description**:
Enhance the `enhanceDocument()` method to use `generateUserStory()` and `generateEARS()` methods for actual generation.

**Implementation Details**:
1. Call `generateUserStory()` and `generateEARS()` methods
2. Integrate user answers into enhancement process
3. Maintain original document content (append mode)

**Acceptance Criteria**:
- Method uses generateUserStory() and generateEARS()
- User answers are integrated into enhancement
- Original content is preserved (append mode)

**Leverage**:
- Existing `enhanceDocument()` method
- `generateUserStory()` and `generateEARS()` methods (from tasks 3.1 and 3.2)
- Design document section 3.3

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in document enhancement

Task: Enhance the enhanceDocument() method in src/services/documentEnhancer.ts to integrate generateUserStory() and generateEARS() methods.

Update the method to:
1. Call generateUserStory() for each requirement
2. Call generateEARS() for each requirement
3. Integrate user answers into requirement enhancement
4. Maintain original document content (append mode)
5. Add timestamp comment: <!-- 需求完善时间: YYYY-MM-DD -->

Restrictions:
- Do NOT change method signature
- Maintain append mode (preserve original content)
- Use existing generateEnhancementSection() helper
- Maintain Markdown format

Leverage:
- src/services/documentEnhancer.ts (existing code)
- generateUserStory() method (from task 3.1)
- generateEARS() method (from task 3.2)
- Design document section 3.3

Requirements: REQ-3.1, REQ-3.4

Success Criteria:
- Method calls generateUserStory() and generateEARS()
- User answers are integrated
- Original content is preserved
- Timestamp comment is added

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/services/documentEnhancer.ts
3. Enhance enhanceDocument() method
4. Integrate generateUserStory() and generateEARS() calls
5. Add user answer integration logic
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

### Phase 4: Workflow Integration

#### Task 4.1: Enhance stage2AnalyzeRequirements() to Handle Real Results

**Status**: [x] Completed

**Files to Modify**:
- `src/index.ts`

**Requirements**: REQ-5.1

**Description**:
Enhance `stage2AnalyzeRequirements()` method to handle actual analysis results from RequirementAnalyzer.

**Implementation Details**:
1. Verify analysis results are meaningful (not empty arrays)
2. Handle cases where analysis returns actual problems
3. Pass results to next stage

**Acceptance Criteria**:
- Method verifies analysis results
- Handles real analysis results
- Passes results to next stage

**Leverage**:
- Existing `stage2AnalyzeRequirements()` method
- RequirementAnalyzer service
- Design document section 4.1

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in workflow orchestration

Task: Enhance the stage2AnalyzeRequirements() method in src/index.ts to handle actual analysis results from RequirementAnalyzer.

Update the method to:
1. Verify analysis results are meaningful (check if problems array has items)
2. Add validation for empty results with error handling
3. Store analysis results for use in next stage
4. Add error handling for AI understanding failures

Restrictions:
- Do NOT change method signature
- Maintain existing console output
- Add validation without breaking existing flow
- Store results for next stage

Leverage:
- src/index.ts (existing code)
- RequirementAnalyzer service (from Phase 1 tasks)
- Design document section 4.1

Requirements: REQ-5.1

Success Criteria:
- Method verifies analysis results
- Handles real analysis results
- Stores results for next stage
- Error handling is present

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/index.ts
3. Enhance stage2AnalyzeRequirements() method
4. Add result validation logic
5. Add error handling
6. Store results for next stage
7. Verify TypeScript compilation passes
8. Mark task as complete [x] in tasks.md
```

---

#### Task 4.2: Implement stage3InteractiveClarification() with AskUserQuestion

**Status**: [x] Completed

**Files to Modify**:
- `src/index.ts`

**Requirements**: REQ-5.2

**Description**:
Implement the `stage3InteractiveClarification()` method to use ClarificationService with AskUserQuestion integration.

**Implementation Details**:
1. Get analysis results from stage 2
2. Generate questions using ClarificationService
3. Use AskUserQuestion integration pattern
4. Collect and record user answers
5. Adjust questions based on answers

**Acceptance Criteria**:
- Method uses ClarificationService to generate questions
- Uses AskUserQuestion integration pattern
- Collects and records user answers
- Adjusts questions based on answers

**Leverage**:
- Existing `stage3InteractiveClarification()` placeholder
- ClarificationService (from Phase 2 tasks)
- Design document section 4.2

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in interactive workflow stages

Task: Implement the stage3InteractiveClarification() method in src/index.ts to integrate with ClarificationService and AskUserQuestion.

The method should:
1. Get analysis results from stage 2 (stored in class state)
2. Generate questions using ClarificationService.generateQuestions()
3. Use ClarificationService.askUserQuestions() to interact with users
4. Collect and record user answers
5. Adjust questions based on answers using adjustQuestions()
6. Continue until maxRounds reached or user indicates completion

Restrictions:
- Do NOT change method signature
- Use ClarificationService methods (not direct AskUserQuestion calls)
- Maintain conversation context
- Respect maxRounds configuration

Leverage:
- src/index.ts (existing code)
- ClarificationService (from Phase 2 tasks)
- Design document section 4.2

Requirements: REQ-5.2

Success Criteria:
- Method uses ClarificationService
- Questions are generated and asked
- Answers are collected
- Questions are adjusted based on answers

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/index.ts
3. Implement stage3InteractiveClarification() method
4. Integrate ClarificationService methods
5. Add conversation flow logic
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

#### Task 4.3: Implement stage4EnhanceRequirements() with Full Flow

**Status**: [x] Completed

**Files to Modify**:
- `src/index.ts`

**Requirements**: REQ-5.3, REQ-5.4

**Description**:
Implement the `stage4EnhanceRequirements()` method to enhance documents using DocumentEnhancer with user answers and requirements.

**Implementation Details**:
1. Get user answers from stage 3
2. Extract requirements from original document and answers
3. Generate user stories and EARS criteria
4. Enhance document using DocumentEnhancer
5. Save enhanced document

**Acceptance Criteria**:
- Method uses DocumentEnhancer with user answers
- Generates user stories and EARS criteria
- Enhances document
- Saves enhanced document

**Leverage**:
- Existing `stage4EnhanceRequirements()` placeholder
- DocumentEnhancer (from Phase 3 tasks)
- Design document section 4.3

**Prompt**:
```
Implement the task for spec implement-core-business-logic, first run spec-workflow-guide to get the workflow guide then implement the task:

Role: TypeScript developer specializing in document enhancement workflow

Task: Implement the stage4EnhanceRequirements() method in src/index.ts to enhance documents using DocumentEnhancer.

The method should:
1. Get user answers from stage 3 (stored in class state)
2. Get original document content from stage 2
3. Extract requirements using RequirementAnalyzer.extractRequirements()
4. Enhance document using DocumentEnhancer.enhanceDocument()
5. Save enhanced document to file
6. Handle both spec-workflow and non-spec-workflow projects

Restrictions:
- Do NOT change method signature
- Use DocumentEnhancer methods
- Maintain append mode (preserve original content)
- Handle file saving errors

Leverage:
- src/index.ts (existing code)
- DocumentEnhancer (from Phase 3 tasks)
- RequirementAnalyzer (from Phase 1 tasks)
- Design document section 4.3

Requirements: REQ-5.3, REQ-5.4

Success Criteria:
- Method uses DocumentEnhancer
- Generates user stories and EARS criteria
- Enhances document
- Saves enhanced document

Instructions:
1. Mark this task as in-progress [-] in tasks.md
2. Read src/index.ts
3. Implement stage4EnhanceRequirements() method
4. Integrate DocumentEnhancer methods
5. Add document saving logic
6. Verify TypeScript compilation passes
7. Mark task as complete [x] in tasks.md
```

---

## Task Summary

**Total Tasks**: 9

**Phase 1 - RequirementAnalyzer**: 3 tasks
- Task 1.1: Enhance analyzeRequirements() [x] Completed
- Task 1.2: Implement detectProblems() [x] Completed
- Task 1.3: Implement extractRequirements() [x] Completed

**Phase 2 - ClarificationService**: 2 tasks
- Task 2.1: Add AskUserQuestion integration [x] Completed
- Task 2.2: Enhance adjustQuestions() [x] Completed

**Phase 3 - DocumentEnhancer**: 3 tasks
- Task 3.1: Implement generateUserStory() [x] Completed
- Task 3.2: Implement generateEARS() [x] Completed
- Task 3.3: Enhance enhanceDocument() integration [x] Completed

**Phase 4 - Workflow Integration**: 3 tasks
- Task 4.1: Enhance stage2AnalyzeRequirements() [x] Completed
- Task 4.2: Implement stage3InteractiveClarification() [x] Completed
- Task 4.3: Implement stage4EnhanceRequirements() [x] Completed

---

## Current Implementation Status

**Last Updated**: 2025-11-04
**Status Check**: Implementation approach has changed

### ⚠️ IMPORTANT: LEGACY DOCUMENT - PLANNING ONLY

**Note**: This skill package is **configuration-driven** and uses `SKILL.md` as the implementation method. There is no TypeScript code - this has always been the case.

**Critical**: This document contains planning documentation for a TypeScript implementation that was **NEVER BUILT**. All TypeScript code examples and references in this document are for reference only and do not represent actual code. The actual implementation is in SKILL.md (configuration-driven).

### Implementation Approach

| Implementation Method | Status | Recommendation |
|----------------------|--------|----------------|
| SKILL.md (Configuration-driven) | ✅ Only Implementation | **Use this** |
| TypeScript Code | ❌ Not Applicable | Does not exist |

### Implementation Details

**Actual Implementation**:
This skill package has always been **configuration-driven** using `SKILL.md` as the sole implementation method. The tasks listed in this document were **planning/planning文档**，not actual code implementation.

**Key Points**:
- ✅ SKILL.md contains the complete workflow implementation
- ✅ All functionality is implemented through SKILL.md and guide files
- ✅ Stage 3 interactive clarification is fully defined in SKILL.md
- ✅ AskUserQuestion integration is specified in SKILL.md and guide files
- ❌ There is no TypeScript code (src/ directory does not exist)
- ❌ The tasks in this document were never implemented as code

**What This Document Is**:
- **Purpose**: Planning documentation for a planned TypeScript implementation
- **Reality**: This planning was never executed as code
- **Current State**: Skill package uses configuration-driven approach via SKILL.md
- **Recommendation**: Ignore Phase 1-4 task details, use SKILL.md instead

**For Current Implementation**:
- See SKILL.md for the actual implementation
- Follow the 5-stage workflow defined in SKILL.md
- Use AskUserQuestion tool as specified in SKILL.md Stage 3

---

## Implementation Progress Summary

**Important Note**: This is a Claude Code Skill with a **hybrid implementation approach**:
1. **Primary Method**: `SKILL.md` configuration file (recommended)
2. **Legacy Method**: TypeScript code in `src/` (not recommended)

### Implementation Status

| Implementation | Method | Status | Recommendation |
|---------------|--------|--------|----------------|
| Core Workflow | SKILL.md | ✅ Active | **Use this** |
| Analysis Logic | SKILL.md + ANALYZER.md | ✅ Active | **Use this** |
| Question Generation | SKILL.md + QUESTIONS.md | ✅ Active | **Use this** |
| Document Enhancement | SKILL.md + ENHANCER.md | ✅ Active | **Use this** |
| Document Merging | SKILL.md + MERGER.md | ✅ Active | **Use this** |
| Empty Project Guidance | SKILL.md + EMPTY-PROJECT.md | ✅ Active | **Use this** |
| Spec-Workflow Integration | SKILL.md + SPEC-WORKFLOW-INTEGRATION.md | ✅ Active | **Use this** |

### Current Status

**SKILL.md Implementation**:
- ✅ All 5 workflow stages implemented
- ✅ AskUserQuestion integration pattern defined
- ✅ Stage 3 interactive clarification is mandatory
- ✅ Complete workflow with error handling
- ✅ Corrected AskUserQuestion format (uses `questions` array)

**This Document (tasks.md)**:
- ⚠️ Contains planning documentation for a TypeScript implementation that was never built
- ⚠️ References non-existent TypeScript methods and classes
- ❌ Does not reflect actual implementation
- **Status**: Planning document - not the actual implementation

### Key Findings

- ✅ SKILL.md contains complete workflow with mandatory AskUserQuestion calls
- ✅ AskUserQuestion format corrected to use `questions` array
- ✅ Clear fallback mechanism for environments without AskUserQuestion tool
- ✅ All guide files provide detailed instructions for AI-driven implementation
- ❌ No TypeScript code exists (was never implemented)
- ✅ This document was planning-only, never actual code

### Recommendation

**Use SKILL.md for all functionality**:
- Follow the workflow stages defined in SKILL.md
- Use AskUserQuestion tool as specified
- Reference guide files for detailed instructions
- **Ignore the Phase 1-4 tasks in this document** - they were planning, not implementation

---

## Implementation Order

Tasks should be implemented in the order listed above, as each phase builds on the previous one:

1. **Phase 1** must be completed first (RequirementAnalyzer provides analysis results)
2. **Phase 2** depends on Phase 1 (needs problems from analysis)
3. **Phase 3** depends on Phase 2 (needs user answers from clarification)
4. **Phase 4** depends on all previous phases (integrates all services)

---

## Notes

- Each task includes a detailed _Prompt field for implementation guidance
- Tasks are atomic and can be implemented independently within their phase
- All tasks maintain backward compatibility with existing type definitions
- AI guidance is implemented through code comments and structure, not external APIs

---

*Tasks Document Version: 1.2*
*Last Updated: 2025-11-02*
*Changes:
  - v1.2 - Updated status to reflect Claude Code Skill implementation:
    - All tasks completed via SKILL.md configuration and guide files
    - Clarified that this is a configuration-driven skill, not traditional code
    - Updated implementation progress summary to reflect actual status
  - v1.1 - Initial task breakdown for TypeScript implementation*
