# Design: HS Req Facilitator Skill

> **智能需求分析助手技能包设计** - 配置驱动实现方案
>
> **Spec Name**: hs-req-facilitator-skill
> **Created**: 2025-11-04
> **Status**: Active
> **Implementation**: Configuration-driven (SKILL.md)
> **Version**: v2.0.2

---

## Introduction

HS Req Facilitator Skill is an intelligent requirement analysis assistant that helps developers, product managers, and business analysts analyze, clarify, and improve requirement documents through AI-driven analysis and interactive clarification.

### Core Design Philosophy

**Configuration-Driven Approach**:
- Pure configuration implementation using SKILL.md
- No TypeScript code required
- AI-driven analysis without regex patterns
- Interactive clarification through AskUserQuestion tool
- 5-stage workflow system

---

## Architecture Overview

### System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Claude Code Environment                    │
├─────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │           HS Req Facilitator Skill (SKILL.md)          │  │
│  │                                                            │  │
│  │  Stage 0: Workflow Validation                           │  │
│  │  Stage 1: Code & Document Scanning                      │  │
│  │  Stage 2: Requirement Analysis (4 sub-steps)            │  │
│  │  Stage 3: Interactive Clarification (AskUserQuestion)   │  │
│  │  Stage 4: Requirement Enhancement                       │  │
│  │  Stage 5: Document Merging (Optional)                   │  │
│  └─────────────────────────────────────────────────────────┘  │
│                          │                                         │
│                          ▼                                         │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                 Claude Code AI                          │  │
│  │  - Document understanding                               │  │
│  │  - Code analysis                                        │  │
│  │  - Problem identification                               │  │
│  │  - Interactive clarification                            │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────┘
```

### Component Responsibilities

1. **Workflow Orchestrator**: Manages the 5-stage workflow
2. **Document Scanner**: Identifies and reads requirement documents
3. **Code Analyzer**: Analyzes project code for context
4. **AI Analyzer**: Performs AI-driven requirement analysis
5. **Clarification Manager**: Handles interactive user clarification
6. **Document Enhancer**: Generates enhanced requirement documents

---

## Implementation Details

### 1. Configuration-Driven Implementation

**Primary Implementation**:
- **SKILL.md**: Complete workflow definition and implementation
- No separate TypeScript code files
- All functionality defined in configuration format
- AI-driven through prompt engineering and guidance

**Key Files**:
- `SKILL.md` - Main implementation (56KB)
- `README.md` - User documentation
- `requirements.md` - Spec requirements (23KB)

### 2. Stage-by-Stage Design

#### Stage 0: Workflow Validation
- Validates workflow rules and dependencies
- Ensures proper execution order
- Checks environment compatibility

#### Stage 1: Automatic Scanning
- Scans for requirement documents:
  - `requirements.md`
  - `*requirement*.md`
  - `需求*.md`
  - `.spec-workflow/specs/*/requirements.md`
- Scans code files (TS, JS, Python, Java, Go, Rust)
- Detects spec-workflow structure
- Statistics collection (files, lines of code)

#### Stage 2: Requirement Analysis (4 Sub-Steps)
1. **Step 2.1**: Read requirement documents and code files
2. **Step 2.2**: Understand project functionality (output overview)
3. **Step 2.3**: Analyze problems and missing information
   - Identify uncertainty (模糊点)
   - Identify missing-info (缺失信息)
   - Identify inconsistency (不一致性)
4. **Step 2.4**: List functional requirements (P0/P1/P2 classification)

#### Stage 3: Interactive Clarification (Mandatory)
- **Critical**: Cannot be skipped
- Uses AskUserQuestion tool for interaction
- Generates clarification questions based on analysis
- Waits for user responses
- Adapts follow-up questions based on answers

#### Stage 4: Requirement Enhancement
- Integrates original requirements, user answers, code implementation
- Generates user stories: "As a [role], I want [feature], so that [benefit]"
- Generates EARS format acceptance criteria: "WHEN [condition] THEN [system] SHALL [response]"
- Adds business value descriptions
- Updates spec-workflow format documents

#### Stage 5: Document Merging (Optional)
- Triggered when multiple requirement documents detected
- Analyzes document relationships (duplicate/conflict/complement)
- Generates merge plan
- Confirms with user via AskUserQuestion
- Executes merge and cleanup

### 3. AI Integration Strategy

**No Regex Patterns**:
- Completely AI-driven analysis
- Uses Claude Code's natural language understanding
- Pattern recognition through semantic analysis
- Context-aware problem identification

**AI Guidance**:
- Structured prompts in SKILL.md guide AI behavior
- Clear instructions for each workflow stage
- Expected output formats specified
- Error handling and validation

### 4. Tool Integration

**Primary Tools**:
- `Read`: Read requirement documents and code files
- `Bash`: Find files, execute commands
- `AskUserQuestion`: Interactive user clarification (mandatory in Stage 3)
- `Write`: Update and enhance requirement documents

**MCP Services**:
- `spec-workflow`: For standardized requirement document format

---

## Data Flow Design

### Analysis Flow

```
Stage 1: Scanning
Documents → Read Tool → Content Extraction → AI Analysis

Stage 2: Analysis
Content → AI Understanding → Problem Identification → Requirements List

Stage 3: Clarification
Questions → AskUserQuestion Tool → User Answers → Record Responses

Stage 4: Enhancement
Requirements + Answers → AI Generation → Enhanced Document

Stage 5: Merging
Multiple Docs → AI Analysis → Merge Plan → User Confirmation → Merge
```

### Data Structures

**Analysis Report**:
```typescript
{
  problems: Problem[],
  recommendations: Recommendation[],
  priorities: Priority[],
  statistics: {
    totalProblems: number,
    highPriorityProblems: number,
    mediumPriorityProblems: number,
    lowPriorityProblems: number,
  },
}
```

**Clarification Question**:
```typescript
{
  id: string,
  question: string,
  context: string,
  type: 'missing-info' | 'uncertainty' | 'inconsistency',
  confidence: 'high' | 'medium' | 'low',
}
```

---

## Technical Decisions

### Decision 1: Configuration-Driven vs Code-Based

**Option A**: TypeScript code implementation
**Option B**: Configuration-driven (SKILL.md) ✓ **Selected**

**Rationale**:
- Simpler deployment (no compilation needed)
- Easier maintenance and updates
- Direct AI guidance through prompts
- No technical debt from code complexity
- Faster iteration and experimentation

### Decision 2: AI Analysis Without Regex

**Option A**: Regex pattern matching for problem detection
**Option B**: Pure AI semantic understanding ✓ **Selected**

**Rationale**:
- More flexible and accurate
- Handles complex language nuances
- No pattern maintenance required
- Better handling of edge cases
- Adapts to different writing styles

### Decision 3: Mandatory AskUserQuestion in Stage 3

**Option A**: Optional clarification
**Option B**: Mandatory clarification ✓ **Selected**

**Rationale**:
- Ensures requirement completeness
- Captures tacit knowledge
- Validates AI analysis
- Improves document quality
- Reduces post-implementation issues

---

## Error Handling

### AI Understanding Failures

**Scenario**: AI fails to understand document or code

**Handling**:
- Provide friendly error messages
- Suggest retry or manual review
- Log error details for debugging
- Offer fallback to basic scanning

### AskUserQuestion Tool Unavailable

**Scenario**: Environment doesn't support AskUserQuestion

**Handling**:
- Detect tool availability
- Provide alternative interaction guidance
- Suggest using supported environment (Claude Code)
- Allow manual answer input

### File Operation Failures

**Scenario**: Cannot read required files

**Handling**:
- Skip unreadable files
- Continue with available files
- Log warnings for user awareness
- Provide partial results if possible

---

## Performance Considerations

### File Scanning
- Support for 1000+ files
- 5-second scanning target
- Memory usage < 500MB
- Concurrent file reading when possible

### AI Analysis
- Analysis accuracy target ≥ 95%
- Problem detection accuracy ≥ 90%
- Confidence level assignment
- Structured output generation

---

## Security Considerations

### Data Protection
- No hardcoded secrets or credentials
- Secure file path validation
- File size limits (≤ 10MB)
- Sensitive information masking in logs

### Access Control
- Read-only file operations (when possible)
- Permission verification
- Safe file writing operations
- Backup before modifications

---

## Testing Strategy

### Unit Testing (Conceptual)
- Workflow stage validation
- Question generation logic
- Document format verification

### Integration Testing
- End-to-end workflow execution
- Stage transition validation
- AskUserQuestion integration

### User Acceptance Testing
- Real project requirement analysis
- Clarification question quality
- Enhanced document usefulness

---

## Deployment Considerations

### Requirements
- Claude Code environment
- AskUserQuestion tool availability
- Read/Bash/Write tool access
- spec-workflow MCP (optional)

### Installation
- Copy SKILL.md to Claude Code skills directory
- Configure if needed
- Activate skill in Claude Code
- Ready to use

---

## Maintenance and Evolution

### Version Management
- Semantic versioning (MAJOR.MINOR.PATCH)
- changelog maintained
- Backward compatibility considerations

### Enhancement Process
- User feedback collection
- Feature request evaluation
- Iterative improvement
- Documentation updates

---

## Success Criteria

This design is successful when:

1. ✅ 5-stage workflow executes completely
2. ✅ AskUserQuestion integration works in Stage 3
3. ✅ AI analysis identifies real problems (no false positives)
4. ✅ Enhanced documents are more complete than originals
5. ✅ User clarifies requirements through interaction
6. ✅ Configuration-driven approach remains simple
7. ✅ No TypeScript code required for implementation

---

## Dependencies

### External Services
- Claude Code platform (AI capabilities)
- AskUserQuestion tool (provided by Claude Code)
- spec-workflow MCP (optional, for standardization)

### Internal Components
- SKILL.md (configuration)
- README.md (documentation)
- requirements.md (this spec)

---

## Future Enhancements

### Potential Improvements
1. **Multi-language Support**: Analyze requirements in multiple languages
2. **Advanced Templates**: More spec-workflow templates
3. **Integration APIs**: Connect with project management tools
4. **Analytics Dashboard**: Track requirement quality improvements
5. **Team Collaboration**: Multi-user clarification sessions

### Research Areas
1. **Automated Testing**: Generate test cases from requirements
2. **Traceability**: Link requirements to code implementations
3. **Quality Metrics**: Quantify requirement quality improvements
4. **Machine Learning**: Improve AI models for better analysis

---

*Design Document Version: 1.0*
*Last Updated: 2025-11-04*
*Implementation: Configuration-driven (SKILL.md)*
