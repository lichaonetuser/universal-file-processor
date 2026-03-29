---
name: universal-file-processor
description: "通用文件处理技能 - 大文件输入处理、大文件处理、防止输出疲劳的三合一技能"
homepage: "https://github.com/openclaw/universal-file-processor"
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
              "url": "https://github.com/openclaw/universal-file-processor/releases/latest/download/universal-file-processor.sh",
              "bins": ["universal-file-processor.sh"],
              "label": "Download universal-file-processor.sh",
            },
          ],
      },
  }
--- }

# Universal File Processor - 通用文件处理技能

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
- 防止模型输出疲劳

---

## 🚀 Quick Start / 快速开始

### Installation / 安装

```bash
# Download the skill script
# 下载技能脚本
cd /home/lichao/.openclaw/skills/universal-file-processor
wget https://github.com/openclaw/universal-file-processor/releases/latest/download/universal-file-processor.sh
chmod +x universal-file-processor.sh
```

### Basic Usage / 基本用法

```bash
# Process a large file
# 处理大文件
./universal-file-processor.sh process /path/to/large-file.md

# Check file size
# 检查文件大小
./universal-file-processor.sh check /path/to/large-file.md

# Split file manually
# 手动拆分文件
./universal-file-processor.sh split /path/to/large-file.md

# Optimize output
# 优化输出
./universal-file-processor.sh optimize /path/to/output.md
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
  Suggested Strategy: split-by-chapter
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
  Optimized length: 3500 tokens
  Reduction: 30%
  Strategy: smart-segmentation
✅ Optimization complete
```

---

## 🔧 OpenClaw Integration / OpenClaw集成

### 1. AI Auto-Detection / AI自动检测

**When AI needs to process a file / 当AI需要处理文件时**:

```bash
# Step 1: Check file size
# 步骤1：检查文件大小
FILE_SIZE=$(./universal-file-processor.sh check "$FILE_PATH")

# Step 2: If exceeds limit, split
# 步骤2：如果超过限制，拆分
if echo "$FILE_SIZE" | grep -q "EXCEEDS_LIMIT"; then
  ./universal-file-processor.sh split "$FILE_PATH"
fi

# Step 3: Process each part
# 步骤3：处理每个部分
for PART in /tmp/universal-file-processor/file_*.md; do
  # Process part
  # 处理部分
  process_part "$PART"
done

# Step 4: Optimize output
# 步骤4：优化输出
./universal-file-processor.sh optimize "$OUTPUT_PATH"

# Step 5: Merge results
# 步骤5：合并结果
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.md
```

---

### 2. Configuration / 配置

**Config File / 配置文件**: `universal-file-processor.config`

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

**User / 用户**:
```
User: Analyze this 1100-line documentation file
AI: (auto-detects file size) exceeds limit
AI: (splits file into 4 parts)
AI: (processes each part)
AI: (optimizes output)
AI: (merges results)
AI: ✅ Analysis complete
```

**AI Operation / AI操作**:
```bash
# Check file
./universal-file-processor.sh check /path/to/docs.md

# Split by chapter
./universal-file-processor.sh split --strategy chapter /path/to/docs.md

# Process each part
for PART in /tmp/universal-file-processor/file_*.md; do
  # Analyze part
  analyze_part "$PART"
done

# Optimize output
./universal-file-processor.sh optimize /path/to/output.md

# Merge results
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.md
```

---

### 2. Large Code File Refactoring / 大型代码文件重构

**User / 用户**:
```
User: Refactor this 1500-line C file
AI: (auto-detects file size) exceeds limit
AI: (splits file into 5 parts by functions)
AI: (refactors each part)
AI: (optimizes output)
AI: (merges results)
AI: ✅ Refactoring complete
```

**AI Operation / AI操作**:
```bash
# Check file
./universal-file-processor.sh check /path/to/code.c

# Split by functions
./universal-file-processor.sh split --strategy functions /path/to/code.c

# Refactor each part
for PART in /tmp/universal-file-processor/file_*.c; do
  # Refactor part
  refactor_part "$PART"
done

# Optimize output
./universal-file-processor.sh optimize /path/to/output.c

# Merge results
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.c
```

---

### 3. Batch Data Processing / 批量数据处理

**User / 用户**:
```
User: Process this large dataset
AI: (auto-detects file size) exceeds limit
AI: (splits file into chunks)
AI: (processes each chunk)
AI: (optimizes output)
AI: (merges results)
AI: ✅ Processing complete
```

**AI Operation / AI操作**:
```bash
# Check file
./universal-file-processor.sh check /path/to/dataset.csv

# Split by lines
./universal-file-processor.sh split --strategy lines --max-lines 1000 /path/to/dataset.csv

# Process each chunk
for CHUNK in /tmp/universal-file-processor/file_*.csv; do
  # Process chunk
  process_chunk "$CHUNK"
done

# Optimize output
./universal-file-processor.sh optimize /path/to/output.csv

# Merge results
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.csv
```

---

## 📊 Performance / 性能

### Efficiency / 效率

- ✅ **Smart Detection**: Only split when necessary / 智能检测：只在必要时拆分
- ✅ **Optimal Splitting**: Minimize context loss / 优化拆分：最小化上下文丢失
- ✅ **Parallel Processing**: Process parts in parallel / 并行处理：并行处理各部分
- ✅ **Memory Efficient**: Low memory footprint / 内存高效：低内存占用
- ✅ **Output Optimization**: Reduce token usage / 输出优化：减少token使用

### Accuracy / 准确性

- ✅ **Context Preservation**: Maintain logical coherence / 上下文保留：保持逻辑连贯性
- ✅ **Consistent Results**: Same output as single-pass / 一致结果：与单次处理相同输出
- ✅ **Error Recovery**: Handle partial failures / 错误恢复：处理部分失败
- ✅ **Fatigue Prevention**: Avoid model fatigue / 疲劳预防：避免模型疲劳

---

## 📄 File Structure / 文件结构

```
/home/lichao/.openclaw/skills/universal-file-processor/
├── universal-file-processor.sh    # Main script (主脚本)
├── universal-file-processor.config # Configuration file (配置文件)
├── SKILL.md                        # Skill metadata (技能元数据)
└── README.md                       # Documentation (文档)
```

---

## 📋 Configuration / 配置

### Config File / 配置文件

**Location / 位置**: `universal-file-processor.config`

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

## 🔧 Development / 开发

### Testing / 测试

```bash
# Test file size detection
# 测试文件大小检测
./universal-file-processor.sh check /path/to/test-file.md

# Test file splitting
# 测试文件拆分
./universal-file-processor.sh split /path/to/test-file.md

# Test batch processing
# 测试分批处理
./universal-file-processor.sh process /path/to/test-file.md

# Test output optimization
# 测试输出优化
./universal-file-processor.sh optimize /path/to/output.md

# Test result merging
# 测试结果合并
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.md
```

---

## 📄 Contributing / 贡献

Contributions are welcome! Please feel free to submit issues and pull requests.

欢迎贡献！请随时提交问题和拉取请求。

---

## 📄 License / 许可证

MIT License

---

**PM Signature / PM签字**: lichaonetuser
**Created / 创建时间**: 2026-03-30 04:15
**Status / 状态**: ✅ Created / 已创建
