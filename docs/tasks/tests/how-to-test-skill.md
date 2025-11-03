# How to Test hs-req-facilitator-skill

This guide provides comprehensive testing instructions for the hs-req-facilitator-skill.

## Prerequisites

- Claude Code installed
- Test project with requirements documents
- Basic understanding of requirements analysis

## Testing Methods

### 1. Manual Testing (Recommended)

#### Test Case 1: Basic Requirements Analysis

**Setup**:
1. Create a test project directory
2. Add a requirements.md file with unclear requirements
3. Install the skill to `.claude/skills/hs-req-facilitator-skill`

**Test Steps**:
1. Activate the skill in Claude Code
2. Ask: "Analyze these requirements"
3. Verify the skill follows the 5-stage workflow
4. Check that Stage 3 (interactive clarification) executes
5. Confirm Stage 4 generates improved requirements

**Expected Results**:
- ✅ Skill activates automatically
- ✅ Stage 0-4 execute in sequence
- ✅ Stage 3 prompts for clarification
- ✅ Final requirements document is improved

#### Test Case 2: Multi-Document Consolidation

**Setup**:
1. Create test project with multiple requirements files
2. Files: requirements.md, user-requirements.md, api-requirements.md

**Test Steps**:
1. Activate the skill
2. Ask: "Consolidate requirements documents"
3. Answer the consolidation confirmation prompt
4. Verify the skill merges documents

**Expected Results**:
- ✅ Multiple documents detected
- ✅ Consolidation prompt appears
- ✅ Single merged document created
- ✅ Old documents removed (after confirmation)

#### Test Case 3: Empty Project

**Setup**:
1. Create empty project (no requirements files)

**Test Steps**:
1. Activate the skill
2. Ask: "I need help with requirements"

**Expected Results**:
- ✅ Empty project detected
- ✅ Prompt to create requirements appears
- ✅ Guidance provided for creating initial requirements

### 2. Automated Testing

#### Test Environment Setup

```bash
# Clone skill repository
git clone [skill-repo-url]
cd hs-req-facilitator-skill

# Copy to Claude Code skills directory
cp -r . ~/.claude/skills/hs-req-facilitator-skill

# Restart Claude Code
```

#### Test Scenarios

**Scenario 1: Skill Activation**
```bash
# Test trigger words
echo "Analyze requirements for my project"
echo "Clarify ambiguous requirements"
echo "Consolidate multiple requirement documents"
echo "Improve requirements quality"
```

**Expected**: Skill activates for all trigger phrases

**Scenario 2: Stage 2 Analysis**
```bash
# Provide clear requirements
echo "My project needs:
- User authentication
- Data persistence
- REST API
Please analyze."
```

**Expected**:
- Stage 2.1 reads requirements
- Stage 2.2 understands project features
- Stage 2.3 identifies issues
- Stage 2.4 lists functional requirements

**Scenario 3: Stage 3 Interaction**
```bash
# Test interaction flow
echo "Continue with the analysis"
```

**Expected**:
- AskUserQuestion tool is called
- User can provide clarification
- Skill waits for response before proceeding

### 3. Environment Compatibility Testing

#### Claude Code Environment

**Test**: Standard workflow execution
- ✅ Skill activates
- ✅ All stages execute
- ✅ AskUserQuestion tool works
- ✅ Files are created/modified

#### Cursor Environment (No AskUserQuestion)

**Test**: Fallback to conversation mode
- ✅ Skill detects missing tool
- ✅ Uses conversation format (❓ Question:)
- ✅ Waits for user input
- ✅ Continues workflow

### 4. Edge Case Testing

#### Edge Case 1: Very Short Requirements
**Input**: One-line requirements
**Expected**: Skill still executes full workflow

#### Edge Case 2: Extremely Long Requirements
**Input**: 100+ page requirements
**Expected**: Skill processes efficiently

#### Edge Case 3: Mixed Languages
**Input**: Requirements in multiple languages
**Expected**: Skill handles multilingual content

#### Edge Case 4: Binary Files
**Input**: Requirements with image attachments
**Expected**: Skill gracefully handles non-text content

### 5. Performance Testing

#### Metrics to Monitor

- **Activation Time**: < 2 seconds
- **Stage 1 Scan Time**: < 5 seconds (for 1000 files)
- **Stage 2 Analysis Time**: < 30 seconds
- **Stage 3 Response Time**: Interactive (user-dependent)
- **Stage 4 Generation Time**: < 10 seconds

#### Test Command

```bash
# Time the complete workflow
time claude "Analyze requirements in test-project/"
```

### 6. Error Handling Testing

#### Error Case 1: Missing Files
**Setup**: Reference non-existent files
**Expected**: Skill provides helpful error message

#### Error Case 2: Permission Denied
**Setup**: Restrict file read permissions
**Expected**: Skill reports access issues

#### Error Case 3: Invalid YAML
**Setup**: Create malformed SKILL.md
**Expected**: Skill handles gracefully or reports issue

### 7. Integration Testing

#### Spec-Workflow Integration

**Setup**: Project with `.spec-workflow/` directory
**Test**: Verify spec-workflow integration works
**Expected**:
- ✅ Spec-workflow structure detected
- ✅ Requirements integrated into spec-workflow format
- ✅ Files created in correct locations

### 8. Validation Checklist

**Pre-Testing**:
- [ ] Skill installed in correct location
- [ ] Claude Code restarted
- [ ] Test project prepared
- [ ] Test cases documented

**Testing**:
- [ ] All test cases executed
- [ ] Results documented
- [ ] Performance measured
- [ ] Errors recorded

**Post-Testing**:
- [ ] All issues documented
- [ ] Test report generated
- [ ] Skill behavior verified
- [ ] Documentation updated

## Troubleshooting

### Issue: Skill Not Activating

**Possible Causes**:
1. Skill not in `.claude/skills/` directory
2. SKILL.md has invalid YAML frontmatter
3. Trigger keywords not matched

**Solutions**:
1. Verify installation path
2. Check YAML syntax: `python3 -c "import yaml; yaml.safe_load(open('SKILL.md'))"`
3. Use explicit trigger: "Use hs-req-facilitator-skill to..."

### Issue: Stage 3 Not Executing

**Possible Causes**:
1. Stage 2 not completed
2. AskUserQuestion tool unavailable
3. Code logic error

**Solutions**:
1. Verify Stage 2 outputs are present
2. Check environment (Claude Code vs Cursor)
3. Review SKILL.md Stage 3 logic

### Issue: Files Not Created

**Possible Causes**:
1. Permission issues
2. Invalid paths
3. File system errors

**Solutions**:
1. Check write permissions
2. Verify paths are absolute
3. Check disk space

## Test Report Template

```
# Test Report: hs-req-facilitator-skill v2.0.0

## Test Environment
- OS: [OS Version]
- Claude Code: [Version]
- Test Date: [Date]

## Test Results

### Manual Testing
- Test Case 1: ✅ Pass / ❌ Fail
- Test Case 2: ✅ Pass / ❌ Fail
- Test Case 3: ✅ Pass / ❌ Fail

### Automated Testing
- Scenario 1: ✅ Pass / ❌ Fail
- Scenario 2: ✅ Pass / ❌ Fail
- Scenario 3: ✅ Pass / ❌ Fail

### Compatibility Testing
- Claude Code: ✅ Pass / ❌ Fail
- Cursor: ✅ Pass / ❌ Fail

## Issues Found
1. [Issue Description]
   - Severity: High/Medium/Low
   - Reproduction Steps: ...
   - Expected vs Actual: ...

## Performance Metrics
- Activation Time: X seconds
- Full Workflow: Y seconds
- Memory Usage: Z MB

## Overall Result
✅ Ready for Release / ⚠️ Minor Issues / ❌ Major Issues

## Recommendations
- [Recommendation 1]
- [Recommendation 2]
```

## Continuous Testing

### Automated Tests (Future)

```bash
# Example test script (to be implemented)
python3 scripts/test-skill.py --test-case basic-analysis
python3 scripts/test-skill.py --test-case consolidation
python3 scripts/test-skill.py --test-case empty-project
```

### CI/CD Integration

```yaml
# Example GitHub Actions workflow
name: Test Skill
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install Skill
        run: cp -r . ~/.claude/skills/hs-req-facilitator-skill
      - name: Run Tests
        run: python3 scripts/test-skill.py
```

## Contact

For test-related issues:
- Create an issue on GitHub
- Include test environment details
- Attach test report if available
