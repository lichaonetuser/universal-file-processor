# Universal File Processor

**通用文件处理器**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue.svg)](https://github.com/openclaw/openclaw)
[![Version](https://img.shields.io/badge/Version-1.0-green.svg)](https://github.com/lichaonetuser/universal-file-processor)

**🌐 [English Version / 英文版本](https://github.com/lichaonetuser/universal-file-processor/blob/main/README_EN.md)**

---

## 📖 概述

通用文件处理器是一个为OpenClaw设计的综合文件处理技能，整合了三大强大功能：
- ✅ **大文件输入处理**: 智能拆分大文件输入
- ✅ **大文件处理**: 分批处理大文件
- ✅ **防止输出疲劳**: 优化输出，避免模型疲劳

**🤖 AI可以自动调用**: 这个技能可以被agent全程控制使用，无需人工干预。

---

## 🎯 为什么需要这个技能？

### 问题背景

在AI系统中处理大文件时，会遇到以下挑战：

1. **注意力衰减**: 模型处理较长文本时，对前面内容的注意力会减弱
2. **上下文丢失**: 跨文件引用和一致性检查容易出错
3. **结构混乱**: 没有清晰的分段标记时，模型难以保持逻辑连贯性
4. **输出疲劳**: 长输出会压倒模型和用户

### 解决方案

通用文件处理器通过以下方式解决这些挑战：

1. **智能检测**: 自动检测文件何时超过处理限制
2. **智能拆分**: 按逻辑块（章节、函数等）拆分文件
3. **分批处理**: 顺序处理各部分，同时保持上下文
4. **输出优化**: 减少token使用，防止疲劳

---

## 🤖 Agent自动调用

### 工作原理

通用文件处理器设计为可以被AI agent全程控制使用。当agent需要处理大文件时，它可以自动调用这个技能，无需人工干预。

### 自动化流程

```
用户: "分析这个1100行的文档文件"
  ↓
AI Agent: 检测到文件太大
  ↓
AI Agent: 自动调用 universal-file-processor.sh
  ↓
技能: 自动检查文件大小
  ↓
技能: 自动拆分文件成4个部分
  ↓
AI Agent: 顺序处理每个部分
  ↓
AI Agent: 合并结果
  ↓
AI Agent: 返回完整分析给用户
```

### Agent集成示例

```bash
# AI Agent自动调用技能

# 步骤1：检查文件大小
FILE_SIZE=$(./skill.sh check "$FILE_PATH")

# 步骤2：如果超过限制，拆分
if echo "$FILE_SIZE" | grep -q "EXCEEDS_LIMIT"; then
  ./skill.sh split "$FILE_PATH"
fi

# 步骤3：处理每个部分
for PART in /tmp/universal-file-processor/file_*.md; do
  # AI Agent处理每个部分
  process_part "$PART"
done

# 步骤4：优化输出
./skill.sh optimize "$OUTPUT_PATH"

# 步骤5：合并结果
./skill.sh merge /tmp/universal-file-processor/file_*.md
```

### Agent控制的优势

- ✅ **完全自动化**: 无需人工干预
- ✅ **智能决策**: Agent决定何时拆分
- ✅ **上下文保留**: Agent在各部分之间保持上下文
- ✅ **最优结果**: Agent确保质量和一致性

---

## 🎯 适用场景

### 1. 大型Markdown文件分析

**场景**: 你有一个1100行的文档文件需要分析。

**问题**: 文件太大，模型无法一次性处理，导致：
- 分析不完整
- 遗漏细节
- 理解不一致

**解决方案**: 使用通用文件处理器按章节拆分文件，处理每个部分，然后合并结果。

**示例**:
```bash
# 分析1100行的文档文件
./skill.sh process /path/to/docs.md
```

### 2. 大型代码文件重构

**场景**: 你需要重构一个1500行的C代码文件。

**问题**: 代码文件太大，难以：
- 理解整体结构
- 识别重构机会
- 保持文件一致性

**解决方案**: 按函数拆分文件，重构每个部分，然后合并结果。

**示例**:
```bash
# 重构1500行的C代码文件
./skill.sh process /path/to/code.c
```

### 3. 批量数据处理

**场景**: 你需要处理大型数据集（2MB的CSV文件）。

**问题**: 数据集太大，无法一次性处理，导致：
- 内存问题
- 处理超时
- 结果不完整

**解决方案**: 将数据集拆分成块，处理每个块，然后合并结果。

**示例**:
```bash
# 处理大型数据集
./skill.sh process /path/to/dataset.csv
```

### 4. 输出优化

**场景**: 模型生成了非常长的输出，需要优化。

**问题**: 长输出可能：
- 压倒用户
- 包含冗余信息
- 难以阅读

**解决方案**: 使用输出优化来分段和压缩输出。

**示例**:
```bash
# 优化长输出，防止疲劳
./skill.sh optimize /path/to/long-output.md
```

---

## 🚀 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/lichaonetuser/universal-file-processor.git

# 进入技能目录
cd universal-file-processor

# 运行安装脚本
./install.sh
```

---

## 📖 详细用法

### 1. 检查文件大小

**命令**: `./skill.sh check <file>`

**功能**: 检测文件大小，估算token数，判断是否需要拆分

**参数**:
- `<file>`: 要检查的文件路径

**输出**:
```
📊 File Analysis: /path/to/file.md
  Lines: 1100
  Characters: 85000
  Estimated Tokens: ~42500
  Status: ⚠️  EXCEEDS_LIMIT (Recommended split)
  Suggested Strategy: chapter
```

**使用场景**:
- 在处理文件前，先检查文件大小
- 判断是否需要拆分
- 选择合适的拆分策略

**示例**:
```bash
# 检查文件大小
./skill.sh check /path/to/file.md
```

### 2. 拆分文件

**命令**: `./skill.sh split <file>`

**功能**: 按默认策略拆分文件

**参数**:
- `<file>`: 要拆分的文件路径

**输出**:
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

**使用场景**:
- 文件超过处理限制时
- 需要分批处理时
- 想要按逻辑块拆分时

**示例**:
```bash
# 拆分文件
./skill.sh split /path/to/file.md
```

### 3. 处理文件

**命令**: `./skill.sh process <file>`

**功能**: 自动检测并处理文件（如果需要会自动拆分）

**参数**:
- `<file>`: 要处理的文件路径

**输出**:
```
⚠️  File exceeds limits, splitting...
📦 Splitting file: /path/to/file.md
  Strategy: chapter
  Parts: 4
✅ Split complete
🔄 Processing 4 parts...
  Processing part 1/4: /tmp/universal-file-processor/file_001.md
    Lines: 275, Chars: 21250, Tokens: ~10625
  Processing part 2/4: /tmp/universal-file-processor/file_002.md
    Lines: 275, Chars: 21250, Tokens: ~10625
  Processing part 3/4: /tmp/universal-file-processor/file_003.md
    Lines: 275, Chars: 21250, Tokens: ~10625
  Processing part 4/4: /tmp/universal-file-processor/file_004.md
    Lines: 275, Chars: 21250, Tokens: ~10625
✅ Processing complete
💡 Next step: Merge results with: ./skill.sh merge /tmp/universal-file-processor/file_*.md
```

**使用场景**:
- 需要处理大文件时
- 不确定是否需要拆分时
- 想要自动化处理流程时

**示例**:
```bash
# 处理文件
./skill.sh process /path/to/file.md
```

### 4. 优化输出

**命令**: `./skill.sh optimize <file>`

**功能**: 优化输出，防止模型疲劳

**参数**:
- `<file>`: 要优化的文件路径

**输出**:
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

**使用场景**:
- 输出过长时
- 需要减少token使用时
- 想要提高输出质量时

**示例**:
```bash
# 优化输出
./skill.sh optimize /path/to/output.md
```

### 5. 合并结果

**命令**: `./skill.sh merge <pattern>`

**功能**: 合并处理后的结果

**参数**:
- `<pattern>`: 文件模式（例如：`/tmp/universal-file-processor/file_*.md`）

**输出**:
```
🔗 Merging results...
  Parts: 4
  Output: /tmp/universal-file-processor/merged_result.md
✅ Merge complete
```

**使用场景**:
- 处理完拆分后的文件后
- 需要合并结果时
- 想要得到完整输出时

**示例**:
```bash
# 合并结果
./skill.sh merge /tmp/universal-file-processor/file_*.md
```

---

## 🎯 功能特性

### 1. 大文件输入处理

- 自动检测文件大小（行数、字符数、token数）
- 智能判断是否需要拆分
- 支持多种拆分策略

### 2. 大文件处理

- 按章节拆分（适用于Markdown）
- 按行数拆分（适用于代码）
- 按token数拆分（精确控制）
- 分批处理，保持上下文连贯
- 自动合并结果

### 3. 防止输出疲劳

- 智能分段输出
- 避免过长输出
- 保持逻辑连贯
- 优化token使用

---

## ⚙️ 配置

编辑 `universal-file-processor.config` 来自定义设置：

```ini
# Token限制
token_limit=30000

# 行数限制
line_limit=500

# 字符限制
char_limit=50000

# 默认拆分策略
default_strategy=chapter

# 输出目录
output_dir=/tmp/universal-file-processor

# 模型上下文窗口
model_context_window=128000

# Token估算比例（每token字符数）
token_ratio=2.0

# 输出优化设置
output_optimization=true
max_output_tokens=10000
output_segment_size=2000
smart_segmentation=true
```

---

## 📊 性能

### 效率

- ✅ **智能检测**: 只在必要时拆分
- ✅ **优化拆分**: 最小化上下文丢失
- ✅ **并行处理**: 支持并行处理各部分
- ✅ **内存高效**: 低内存占用
- ✅ **输出优化**: 减少token使用

### 准确性

- ✅ **上下文保留**: 保持逻辑连贯性
- ✅ **一致结果**: 与单次处理相同输出
- ✅ **错误恢复**: 处理部分失败
- ✅ **疲劳预防**: 避免模型疲劳

---

## 📁 文件结构

```
universal-file-processor/
├── universal-file-processor.sh    # 主脚本
├── universal-file-processor.config # 配置文件
├── install.sh                     # 安装脚本
├── skill.sh                       # 技能实现脚本
├── SKILL.md                       # 技能元数据
├── README.md                      # 中文文档
├── README_EN.md                   # 英文文档
└── LICENSE                        # 许可证
```

---

## 🤝 贡献

欢迎贡献！请随时提交问题和拉取请求。

---

## 📄 许可证

MIT License - 详见LICENSE文件。

---

## 👤 作者

- **姓名**: lichaonetuser
- **GitHub**: [@lichaonetuser](https://github.com/lichaonetuser)

---

## 📞 支持

- **问题**: [GitHub Issues](https://github.com/lichaonetuser/universal-file-processor/issues)
- **讨论**: [GitHub Discussions](https://github.com/lichaonetuser/universal-file-processor/discussions)

---

**由 lichaonetuser 用 ❤️ 制作**
