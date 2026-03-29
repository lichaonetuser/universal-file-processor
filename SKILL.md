## 🎯 Use When / 使用时机

**English**:
AI should first check the file size and line count by itself. Only when the AI determines that the file exceeds its processing capacity should it invoke this skill.

**中文**:
AI应该先自己检查文件大小和行数。只有当AI判断文件超过其处理能力时，才应该调用此技能。

**Correct Workflow / 正确流程**:

**English**:
```
User: "Analyze this file"
  ↓
AI: First checks file size and line count by itself
  ↓
AI: Determines if file is too large to process in one go
  ↓
If file is within limits:
  ↓
  AI: Processes file directly
  ↓
  AI: Returns results to user
  ↓
If file exceeds limits:
  ↓
  AI: Invokes universal-file-processor.sh
  ↓
Skill: Automatically checks file size
  ↓
Skill: Automatically splits file into parts
  ↓
AI: Processes each part sequentially
  ↓
AI: Merges results
  ↓
AI: Returns complete analysis to user
```

**中文**:
```
用户: "分析这个文件"
  ↓
AI: 先自己检查文件大小和行数
  ↓
AI: 判断文件是否太大无法一次性处理
  ↓
如果文件在限制内：
  ↓
  AI: 直接处理文件
  ↓
  AI: 返回结果给用户
  ↓
如果文件超过限制：
  ↓
  AI: 调用 universal-file-processor.sh
  ↓
  技能: 自动检查文件大小
  ↓
  技能: 自动拆分文件成多个部分
  ↓
  AI: 顺序处理每个部分
  ↓
  AI: 合并结果
  ↓
  AI: 返回完整分析给用户
```

**Key Decision Points / 关键决策点**:

**English**:
1. **First Check**: AI should first check file size and line count using standard tools (wc, ls, etc.)
2. **Self-Judgment**: AI should make its own decision about whether the file is too large
3. **Skill Invocation**: Only invoke this skill when AI determines it's necessary
4. **Fallback**: If the skill is not available, AI should still be able to process smaller files

**中文**:
1. **首先检查**: AI应该首先使用标准工具（wc、ls等）检查文件大小和行数
2. **自我判断**: AI应该自己判断文件是否太大
3. **技能调用**: 只有在AI认为必要时才调用此技能
4. **后备方案**: 如果技能不可用，AI仍然应该能够处理较小的文件

**Trigger Conditions / 触发条件**:

**English**:
AI should invoke this skill when:

1. **After Self-Check**: AI has checked the file and determined it exceeds limits
2. **Large File Detected**: File has >500 lines OR >50,000 characters OR estimated >30,000 tokens
3. **Batch Processing Needed**: User needs to process multiple large files
4. **Output Too Long**: AI's output exceeds 10,000 tokens and needs optimization
5. **Context Preservation**: AI needs to maintain context across multiple file parts

**中文**:
AI应该在以下情况调用此技能：

1. **自我检查后**: AI已经检查文件并确定超过限制
2. **检测到大文件**: 文件有>500行 或 >50,000字符 或 估算>30,000 tokens
3. **需要批量处理**: 用户需要处理多个大文件
4. **输出过长**: AI的输出超过10,000 tokens需要优化
5. **需要上下文保留**: AI需要在多个文件部分之间保持上下文

**NOT Trigger / 不触发**:

**English**:
- Small files (<500 lines, <50KB, <30K tokens)
- Files that can be processed in one go
- When AI can handle the task without splitting

**中文**:
- 小文件（<500行，<50KB，<30K tokens）
- 可以一次性处理的文件
- AI可以不拆分就处理的任务

**Example Scenarios / 示例场景**:

**English**:
```
Scenario 1: Small file (100 lines)
User: "Analyze this file"
  ↓
AI: Checks file size: 100 lines, 5KB, ~2.5K tokens
  ↓
AI: File is within limits, no need to invoke skill
  ↓
AI: Processes file directly
  ↓
AI: Returns results to user

Scenario 2: Large file (1100 lines)
User: "Analyze this file"
  ↓
AI: Checks file size: 1100 lines, 85KB, ~42.5K tokens
  ↓
AI: File exceeds limits, need to invoke skill
  ↓
AI: Invokes universal-file-processor.sh
  ↓
Skill: Splits file into 4 parts
  ↓
AI: Processes each part
  ↓
AI: Merges results
  ↓
AI: Returns complete analysis to user
```

**中文**:
```
场景1: 小文件（100行）
用户: "分析这个文件"
  ↓
AI: 检查文件大小：100行，5KB，~2.5K tokens
  ↓
AI: 文件在限制内，不需要调用技能
  ↓
AI: 直接处理文件
  ↓
AI: 返回结果给用户

场景2: 大文件（1100行）
用户: "分析这个文件"
  ↓
AI: 检查文件大小：1100行，85KB，~42.5K tokens
  ↓
AI: 文件超过限制，需要调用技能
  ↓
AI: 调用 universal-file-processor.sh
  ↓
技能: 拆分文件成4个部分
  ↓
AI: 处理每个部分
  ↓
AI: 合并结果
  ↓
AI: 返回完整分析给用户
```

---

## 🚀 Quick Start / 快速开始