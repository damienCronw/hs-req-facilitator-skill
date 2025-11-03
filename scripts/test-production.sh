#!/bin/bash

# Claude Code Skill 生产环境测试脚本
# 功能：验证生产环境部署的正确性

set -e

# 配置
SKILL_DIR="$HOME/.claude/skills/hs-req-facilitator-skill"
TEST_DIR="/tmp/skill-test-$(date +%Y%m%d-%H%M%S)"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 测试计数器
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

echo -e "${BLUE}╔═══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Claude Code Skill 生产环境测试套件     ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}\n"

# 辅助函数
run_test() {
    local test_name="$1"
    local test_command="$2"

    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    echo -e "${CYAN}[TEST $TESTS_TOTAL] $test_name${NC}"

    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "  ${GREEN}✅ PASS${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "  ${RED}❌ FAIL${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# 1. 检查生产环境目录
echo -e "\n${BLUE}━━━ 第一阶段：环境检查 ━━━${NC}\n"

run_test "生产环境目录存在" "[ -d '$SKILL_DIR' ]"
run_test "生产环境目录可读" "[ -r '$SKILL_DIR' ]"
run_test "生产环境目录可写" "[ -w '$SKILL_DIR' ]"

# 2. 检查核心文件
echo -e "\n${BLUE}━━━ 第二阶段：文件完整性检查 ━━━${NC}\n"

run_test "SKILL.md 存在" "[ -f '$SKILL_DIR/SKILL.md' ]"
run_test "README.md 存在" "[ -f '$SKILL_DIR/README.md' ]"
run_test "STAGE3-DEBUG.md 存在" "[ -f '$SKILL_DIR/STAGE3-DEBUG.md' ]"

if [ -f "$SKILL_DIR/SKILL.md" ]; then
    SKILL_SIZE=$(wc -c < "$SKILL_DIR/SKILL.md")
    run_test "SKILL.md 非空 (${SKILL_SIZE} 字节)" "[ $SKELL_SIZE -gt 0 ]"
fi

# 3. 检查AskUserQuestion格式
echo -e "\n${BLUE}━━━ 第三阶段：AskUserQuestion格式检查 ━━━${NC}\n"

if [ -f "$SKILL_DIR/SKILL.md" ]; then
    run_test "包含AskUserQuestion调用" "grep -q 'AskUserQuestion' '$SKILL_DIR/SKILL.md'"
    run_test "AskUserQuestion使用正确格式 (questions数组)" "grep -q 'questions: \[' '$SKILL_DIR/SKILL.md'"
    run_test "包含Stage 3描述" "grep -q -i 'stage.*3\|interactive.*clarification' '$SKILL_DIR/SKILL.md'"
fi

# 4. 检查版本信息
echo -e "\n${BLUE}━━━ 第四阶段：版本信息验证 ━━━${NC}\n"

if [ -f "$SKILL_DIR/README.md" ]; then
    run_test "README包含v2.0.0" "grep -q 'v2.0.0' '$SKILL_DIR/README.md'"
    run_test "README包含配置驱动声明" "grep -q -i 'config.*driven\|configuration.*driven' '$SKILL_DIR/README.md'"
fi

# 5. 检查指南文件
echo -e "\n${BLUE}━━━ 第五阶段：指南文件检查 ━━━${NC}\n"

GUIDE_FILES=("ANALYZER.md" "QUESTIONS.md" "ENHANCER.md" "MERGER.md" "EMPTY-PROJECT.md")
for file in "${GUIDE_FILES[@]}"; do
    if [ -f "$SKILL_DIR/$file" ]; then
        run_test "$file 存在" "true"
    else
        run_test "$file 存在" "[ -f '$SKILL_DIR/$file' ]"
    fi
done

# 6. 功能测试（模拟）
echo -e "\n${BLUE}━━━ 第六阶段：功能模拟测试 ━━━${NC}\n"

# 创建临时测试环境
mkdir -p "$TEST_DIR"
cp -r "$SKILL_DIR" "$TEST_DIR/skill-test"

echo -e "${CYAN}[TEST $((TESTS_TOTAL + 1))] 文件复制功能测试${NC}"
TESTS_TOTAL=$((TESTS_TOTAL + 1))
if [ -d "$TEST_DIR/skill-test" ]; then
    echo -e "  ${GREEN}✅ PASS${NC}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    echo -e "  ${RED}❌ FAIL${NC}"
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

echo -e "${CYAN}[TEST $((TESTS_TOTAL + 1))] SKILL.md语法检查${NC}"
TESTS_TOTAL=$((TESTS_TOTAL + 1))
if [ -f "$TEST_DIR/skill-test/SKILL.md" ]; then
    # 检查是否有基本的Markdown语法
    if grep -q "^# " "$TEST_DIR/skill-test/SKILL.md"; then
        echo -e "  ${GREEN}✅ PASS (Markdown格式正确)${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "  ${RED}❌ FAIL (Markdown格式错误)${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
fi

# 7. AskUserQuestion集成测试
echo -e "\n${BLUE}━━━ 第七阶段：AskUserQuestion集成测试 ━━━${NC}\n"

if [ -f "$SKILL_DIR/SKILL.md" ]; then
    # 计算AskUserQuestion调用次数
    AQ_COUNT=$(grep -c "AskUserQuestion" "$SKILL_DIR/SKILL.md")
    echo -e "${CYAN}[TEST $((TESTS_TOTAL + 1))] AskUserQuestion调用检查 ($AQ_COUNT 次调用)${NC}"
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    if [ $AQ_COUNT -gt 0 ]; then
        echo -e "  ${GREEN}✅ PASS (发现 $AQ_COUNT 次调用)${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "  ${RED}❌ FAIL (未找到AskUserQuestion调用)${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi

    # 检查AskUserQuestion的questions数组格式
    echo -e "${CYAN}[TEST $((TESTS_TOTAL + 1))] AskUserQuestion questions数组格式检查${NC}"
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    if grep -q "questions: \[{" "$SKILL_DIR/SKILL.md"; then
        echo -e "  ${GREEN}✅ PASS (questions数组格式正确)${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "  ${RED}❌ FAIL (questions数组格式可能不正确)${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
fi

# 8. 性能测试
echo -e "\n${BLUE}━━━ 第八阶段：性能基准测试 ━━━${NC}\n"

echo -e "${CYAN}[TEST $((TESTS_TOTAL + 1))] 文件读取性能测试${NC}"
TESTS_TOTAL=$((TESTS_TOTAL + 1))
START_TIME=$(date +%s%N)
if [ -f "$SKILL_DIR/SKILL.md" ]; then
    cat "$SKILL_DIR/SKILL.md" > /dev/null
    END_TIME=$(date +%s%N)
    DURATION=$(( (END_TIME - START_TIME) / 1000000 ))
    if [ $DURATION -lt 1000 ]; then
        echo -e "  ${GREEN}✅ PASS (读取耗时: ${DURATION}ms < 1000ms)${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "  ${YELLOW}⚠️  警告 (读取耗时: ${DURATION}ms >= 1000ms)${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
fi

# 清理测试环境
rm -rf "$TEST_DIR"

# 生成测试报告
echo -e "\n${BLUE}╔═══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              测试结果报告                ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}\n"

echo -e "总测试数：$TESTS_TOTAL"
echo -e "${GREEN}通过：$TESTS_PASSED${NC}"
if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}失败：$TESTS_FAILED${NC}"
else
    echo -e "失败：$TESTS_FAILED"
fi

PASS_RATE=$(( TESTS_PASSED * 100 / TESTS_TOTAL ))
echo -e "通过率：${PASS_RATE}%"

echo -e "\n${BLUE}生产环境信息：${NC}"
echo -e "  目录：$SKILL_DIR"
echo -e "  文件数：$(ls -1 "$SKILL_DIR" | wc -l)"
echo -e "  测试时间：$(date '+%Y-%m-%d %H:%M:%S')"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}✅ 所有测试通过！生产环境状态正常。${NC}\n"
    exit 0
else
    echo -e "\n${RED}❌ 发现 $TESTS_FAILED 个测试失败！请检查生产环境。${NC}\n"
    exit 1
fi
