---
name: universal-file-processor
description: "大文件自动拆分处理技能 - 当文件超过模型处理能力时自动拆分并分批处理。AI可以自动调用此技能来处理大型Markdown文件、大型代码文件、批量数据集，以及优化长输出防止模型疲劳。"
homepage: "https://github.com/lichaonetuser/universal-file-processor"
metadata:
  {
    "openclaw":
      {
        "emoji": "🔄",
        "requires": { "bins": ["bash", "wc", "split", "cat", "sed", "awk"] },
        "install":
          [
            {
              "id": "download",
              "kind": "download",
              "url": "https://github.com/lichaonetuser/universal-file-processor/releases/latest/download/universal-file-processor.sh",
              "bins": ["universal-file-processor.sh"],
              "label": "Download universal-file-processor.sh",
            },
          ],
      },
  }
--- }

# Universal File Processor - 通用文件处理器

**Role / 角色**: OpenClaw Skill (OpenClaw技能)
**Version / 版本**: v1.0
**PM / PM**: lichaonetuser
**Category / 类别**: File Processing, Context Management, Output Optimization (文件处理、上下文管理、输出优化)

---

## 🔄 Overview / 概述

Universal File Processor是一个三合一的通用文件处理技能，整合了：
- ✅ **大文件输入处理**: 智能拆分大文件输入
- ✅ **大文件处理**: 分批处理大文件
- ✅ **防止输出疲劳**: 优化输出，避免模型疲劳

**核心功能**：
- 自动检测文件大小
- 智能拆分文件
- 分批处理
- 优化输出
- 结果整合

**适用场景**：
- 大型Markdown文件（>500行）
- 大型代码文件（>1000行）
- 长文档分析
- 批量数据处理
- 输出优化

---

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
2. **检测到大文件**: 文件有>500行 或 >50,000字符 或估算>30,000 tokens
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

### Installation / 安装

```bash
# Clone the repository
git clone https://github.com/lichaonetuser/universal-file-processor.git

# Navigate to the skill directory
cd universal-file-processor

# Run installation script
./install.sh
```

### Basic Usage / 基本用法

```bash
# Check file size
./skill.sh check /path/to/file.md

# Split file
./skill.sh split /path/to/file.md

# Process file
./skill.sh process /path/to/file.md

# Optimize output
./skill.sh optimize /path/to/output.md

# Merge results
./skill.sh merge /tmp/universal-file-processor/file_*.md
```

---

## 📖 Features / 功能

### 1. Large File Input Processing / 大文件输入处理

**Description / 描述**: 智能拆分大文件输入

**Metrics / 指标**:
- Line count (行数)
- Character count (字符数)
- Estimated token count (估算token数)

**Usage / 用法**:
```bash
./universal-file-processor.sh check /path/to/file.md
```

**Output / 输出**:
```
📊 File Analysis: /path/to/file.md
  Lines: 1100
  Characters: 85000
  Estimated Tokens: ~42500
  Status: ⚠️  EXCEEDS_LIMIT (Recommended split)
  Suggested Strategy: chapter
```

---

### 2. Large File Processing / 大文件处理

**Description / 描述**: 分批处理大文件

**Split Strategies / 拆分策略**:

1. **By Chapter (按章节)**: 适用于Markdown文档
   ```bash
   ./universal-file-processor.sh split --strategy chapter /path/to/file.md
   ```

2. **By Lines (按行数)**: 适用于代码文件
   ```bash
   ./universal-file-processor.sh split --strategy lines --max-lines 300 /path/to/file.md
   ```

3. **By Tokens (按Token数)**: 精确控制token数
   ```bash
   ./universal-file-processor.sh split --strategy tokens --max-tokens 15000 /path/to/file.md
   ```

**Output / 输出**:
```
📦 Splitting file: /path/to/file.md
  Strategy: chapter
  Parts: 4
  Output: /tmp/universal-file-processor/file_001.md
          /tmp/universal-file-processor/file_002.md
          /tmp/universal-file-processor/file_003.md
          /tmp/universal-file-processor/file_004.md
✅ Split complete
```

---

### 3. Output Fatigue Prevention / 防止输出疲劳

**Description / 描述**: 优化输出，避免模型疲劳

**Features / 特性**:
- 智能分段输出
- 避免过长输出
- 保持逻辑连贯
- 优化token使用

**Usage / 用法**:
```bash
./universal-file-processor.sh optimize /path/to/output.md
```

**Output / 输出**:
```
🎯 Optimizing output: /path/to/output.md
  Original length: 5000 tokens
  Target length: 10000 tokens
  Reduction: 30%
  Strategy: smart-segmentation
  Optimized length: 3500 tokens
  Output: /tmp/universal-file-processor/optimized_output.md
✅ Optimization complete
```

---

## 🔧 OpenClaw Integration / OpenClaw集成

### 1. AI Auto-Detection / AI自动检测

**When AI needs to process a file / 当AI需要处理文件时**:

**English**:
```
User: "Analyze this 1100-line documentation file"
  ↓
AI: First checks file size and line count by itself
  ↓
AI: Determines file is too large to process in one go
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
用户: "分析这个1100行的文档文件"
  ↓
AI: 先自己检查文件大小和行数
  ↓
AI: 判断文件是否太大无法一次性处理
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

---

### 2. Configuration / 配置

**Config File / 配置文件**:
`universal-file-processor.config`

**Example / 示例**:
```ini
# Token limit (tokens)
# Token限制
token_limit=30000

# Line limit (lines)
# 行数限制
line_limit=500

# Character limit (characters)
# 字符限制
char_limit=50000

# Default split strategy
# 默认拆分策略
default_strategy=chapter

# Output directory
# 输出目录
output_dir=/tmp/universal-file-processor

# Model context window (tokens)
# 模型上下文窗口
model_context_window=128000

# Token estimation ratio (chars per token)
# Token估算比例（每token字符数）
token_ratio=2.0

# Output optimization settings
# 输出优化设置
output_optimization=true
max_output_tokens=10000
output_segment_size=2000
smart_segmentation=true
```

---

## 🎯 Use Cases / 使用场景

### 1. Large Markdown File Analysis / 大型Markdown文件分析

**Scenario / 场景**: You have a 1100-line documentation file that needs analysis.

**Problem / 问题**: The file is too large for the model to process in one go, leading to:
- Incomplete analysis
- Missed details
- Inconsistent understanding

**Solution / 解决方案**: Use Universal File Processor to split the file by chapters, process each part, and merge results.

**Example / 示例**:
```bash
# Analyze a 1100-line documentation file
./skill.sh process /path/to/docs.md
```

### 2. Large Code File Refactoring / 大型代码文件重构

**Scenario / 场景**: You need to refactor a 1500-line C code file.

**Problem / 问题**: The code file is too large, making it difficult to:
- Understand the overall structure
- Identify refactoring opportunities
- Maintain consistency across the file

**Solution / 解决方案**: Split the file by functions, refactor each part, and merge results.

**Example / 示例**:
```bash
# Refactor a 1500-line C file
./skill.sh process /path/to/code.c
```

### 3. Batch Data Processing / 批量数据处理

**Scenario / 场景**: You need to process a large dataset (2MB CSV file).

**Problem / 问题**: The dataset is too large to process in one go, causing:
- Memory issues
- Processing timeouts
- Incomplete results

**Solution / 解决方案**: Split the dataset into chunks, process each chunk, and merge results.

**Example / 示例**:
```bash
# Process a large dataset
./skill.sh process /path/to/dataset.csv
```

### 4. Output Optimization / 输出优化

**Scenario / 场景**: The model generates a very long output that needs optimization.

**Problem / 问题**: Long outputs can:
- Overwhelm the user
- Contain redundant information
- Be difficult to read

**Solution / 解决方案**: Use output optimization to segment and condense the output.

**Example / 示例**:
```bash
# Optimize long output to prevent fatigue
./skill.sh optimize /path/to/long-output.md
```

---

## 📊 Performance / 性能

### Efficiency / 效率

- ✅ **Smart Detection**: Only split when necessary
- ✅ **Optimal Splitting**: Minimize context loss
- ✅ **Parallel Processing**: Process parts in parallel
- ✅ **Memory Efficient**: Low memory footprint
- ✅ **Output Optimization**: Reduce token usage

### Accuracy / 准确性

- ✅ **Context Preservation**: Maintain logical coherence
- ✅ **Consistent Results**: Same output as single-pass
- ✅ **Error Recovery**: Handle partial failures
- ✅ **Fatigue Prevention**: Avoid model fatigue

---

## 📁 File Structure / 文件结构

```
universal-file-processor/
├── universal-file-processor.sh    # Main script (主脚本)
├── universal-file-processor.config # Configuration file (配置文件)
├── install.sh                     # Installation script (安装脚本)
├── skill.sh                       # Skill implementation script (技能实现脚本)
├── SKILL.md                       # Skill metadata (技能元数据)
├── README.md                      # Chinese documentation (中文文档)
├── README_EN.md                   # English documentation (英文文档)
└── LICENSE                        # License (许可证)
```

---

## 🤝 Contributing / 贡献

Contributions are welcome! Please feel free to submit issues and pull requests.

欢迎贡献！请随时提交问题和拉取请求。

---

## 📄 License / 许可证

MIT License - see LICENSE file for details.

MIT License - 详见LICENSE文件。

---

## 👤 Author / 作者

- **Name**: lichaonetuser
- **GitHub**: [@lichaonetuser](https://github.com/lichaonetuser)

---

## 📞 Support / 支持

- **Issues**: [GitHub Issues](https://github.com/lichaonetuser/universal-file-processor/issues)
- **Discussions**: [GitHub Discussions](https://github.com/lichaonetuser/universal-file-processor/discussions)

---

**Made with ❤️ by lichaonetuser**

**由 lichaonetuser 用 ❤️ 制作**
