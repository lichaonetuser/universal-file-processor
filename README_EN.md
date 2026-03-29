# Universal File Processor

**Comprehensive File Processing Skill for OpenClaw**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue.svg)](https://github.com/openclaw/openclaw)
[![Version](https://img.shields.io/badge/Version-1.0-green.svg)](https://github.com/lichaonetuser/universal-file-processor)

**🌐 [Chinese Version / 中文版本](https://github.com/lichaonetuser/universal-file-processor/blob/main/README.md)**

---

## 📖 Overview

Universal File Processor is a comprehensive file processing skill for OpenClaw that integrates three powerful capabilities:
- ✅ **Large File Input Processing**: Intelligently split large file inputs
- ✅ **Large File Processing**: Process large files in batches
- ✅ **Output Fatigue Prevention**: Optimize output to prevent model fatigue

**🤖 AI Can Automatically Invoke**: This skill can be fully controlled by AI agents without human intervention.

---

## 🎯 Why Do You Need This Skill?

### Problem Background

When working with large files in AI systems, several challenges arise:

1. **Attention Decay**: As models process longer texts, their attention to earlier content diminishes
2. **Context Loss**: Cross-file references and consistency checks become error-prone
3. **Structural Confusion**: Without clear segmentation markers, models struggle to maintain logical coherence
4. **Output Fatigue**: Long outputs can overwhelm both the model and the user

### Solution

Universal File Processor addresses these challenges by:

1. **Smart Detection**: Automatically detects when files exceed processing limits
2. **Intelligent Splitting**: Splits files by logical blocks (chapters, functions, etc.)
3. **Batch Processing**: Processes parts sequentially while maintaining context
4. **Output Optimization**: Reduces token usage and prevents fatigue

---

## 🤖 Agent Automatic Invocation

### How It Works

Universal File Processor is designed to be fully controlled by AI agents. When an agent needs to process a large file, it can automatically invoke this skill without human intervention.

### Automated Workflow

```
User: "Analyze this 1100-line documentation file"
  ↓
AI Agent: Detects file is too large
  ↓
AI Agent: Automatically calls universal-file-processor.sh
  ↓
Skill: Automatically checks file size
  ↓
Skill: Automatically splits file into 4 parts
  ↓
AI Agent: Processes each part sequentially
  ↓
AI Agent: Merges results
  ↓
AI Agent: Returns complete analysis to user
```

### Agent Integration Example

```bash
# AI Agent automatically invokes the skill

# Step 1: Check file size
FILE_SIZE=$(./skill.sh check "$FILE_PATH")

# Step 2: If exceeds limit, split
if echo "$FILE_SIZE" | grep -q "EXCEEDS_LIMIT"; then
  ./skill.sh split "$FILE_PATH"
fi

# Step 3: Process each part
for PART in /tmp/universal-file-processor/file_*.md; do
  # AI Agent processes each part
  process_part "$PART"
done

# Step 4: Optimize output
./skill.sh optimize "$OUTPUT_PATH"

# Step 5: Merge results
./skill.sh merge /tmp/universal-file-processor/file_*.md
```

### Benefits of Agent Control

- ✅ **Fully Automated**: No human intervention required
- ✅ **Intelligent Decision**: Agent decides when to split
- ✅ **Context Preservation**: Agent maintains context across parts
- ✅ **Optimal Results**: Agent ensures quality and consistency

---

## 🎯 Use Cases

### 1. Large Markdown File Analysis

**Scenario**: You have a 1100-line documentation file that needs analysis.

**Problem**: The file is too large for the model to process in one go, leading to:
- Incomplete analysis
- Missed details
- Inconsistent understanding

**Solution**: Use Universal File Processor to split the file by chapters, process each part, and merge results.

**Example**:
```bash
# Analyze a 1100-line documentation file
./skill.sh process /path/to/docs.md
```

### 2. Large Code File Refactoring

**Scenario**: You need to refactor a 1500-line C code file.

**Problem**: The code file is too large, making it difficult to:
- Understand the overall structure
- Identify refactoring opportunities
- Maintain consistency across the file

**Solution**: Split the file by functions, refactor each part, and merge results.

**Example**:
```bash
# Refactor a 1500-line C file
./skill.sh process /path/to/code.c
```

### 3. Batch Data Processing

**Scenario**: You need to process a large dataset (2MB CSV file).

**Problem**: The dataset is too large to process in one go, causing:
- Memory issues
- Processing timeouts
- Incomplete results

**Solution**: Split the dataset into chunks, process each chunk, and merge results.

**Example**:
```bash
# Process a large dataset
./skill.sh process /path/to/dataset.csv
```

### 4. Output Optimization

**Scenario**: The model generates a very long output that needs optimization.

**Problem**: Long outputs can:
- Overwhelm the user
- Contain redundant information
- Be difficult to read

**Solution**: Use output optimization to segment and condense the output.

**Example**:
```bash
# Optimize long output to prevent fatigue
./skill.sh optimize /path/to/long-output.md
```

---

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/lichaonetuser/universal-file-processor.git

# Navigate to the skill directory
cd universal-file-processor

# Run installation script
./install.sh
```

---

## 📖 Detailed Usage

### 1. Check File Size

**Command**: `./skill.sh check <file>`

**Function**: Detect file size, estimate token count, and determine if splitting is needed

**Parameters**:
- `<file>`: Path to the file to check

**Output**:
```
📊 File Analysis: /path/to/file.md
  Lines: 1100
  Characters: 85000
  Estimated Tokens: ~42500
  Status: ⚠️  EXCEEDS_LIMIT (Recommended split)
  Suggested Strategy: chapter
```

**Use Cases**:
- Check file size before processing
- Determine if splitting is needed
- Choose appropriate splitting strategy

**Example**:
```bash
# Check file size
./skill.sh check /path/to/file.md
```

### 2. Split File

**Command**: `./skill.sh split <file>`

**Function**: Split file using default strategy

**Parameters**:
- `<file>`: Path to the file to split

**Output**:
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

**Use Cases**:
- When file exceeds processing limits
- When batch processing is needed
- When you want to split by logical blocks

**Example**:
```bash
# Split file
./skill.sh split /path/to/file.md
```

### 3. Process File

**Command**: `./skill.sh process <file>`

**Function**: Automatically detect and process file (splits if needed)

**Parameters**:
- `<file>`: Path to the file to process

**Output**:
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

**Use Cases**:
- When processing large files
- When unsure if splitting is needed
- When you want automated processing workflow

**Example**:
```bash
# Process file
./skill.sh process /path/to/file.md
```

### 4. Optimize Output

**Command**: `./skill.sh optimize <file>`

**Function**: Optimize output to prevent model fatigue

**Parameters**:
- `<file>`: Path to the file to optimize

**Output**:
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

**Use Cases**:
- When output is too long
- When you need to reduce token usage
- When you want to improve output quality

**Example**:
```bash
# Optimize output
./skill.sh optimize /path/to/output.md
```

### 5. Merge Results

**Command**: `./skill.sh merge <pattern>`

**Function**: Merge processed results

**Parameters**:
- `<pattern>`: File pattern (e.g., `/tmp/universal-file-processor/file_*.md`)

**Output**:
```
🔗 Merging results...
  Parts: 4
  Output: /tmp/universal-file-processor/merged_result.md
✅ Merge complete
```

**Use Cases**:
- After processing split files
- When you need to merge results
- When you want complete output

**Example**:
```bash
# Merge results
./skill.sh merge /tmp/universal-file-processor/file_*.md
```

---

## 🎯 Features

### 1. Large File Input Processing

- Automatically detect file size (lines, characters, tokens)
- Intelligently determine if splitting is needed
- Support multiple splitting strategies

### 2. Large File Processing

- Split by chapter (suitable for Markdown)
- Split by lines (suitable for code)
- Split by tokens (precise control)
- Batch processing with context preservation
- Automatic result merging

### 3. Output Fatigue Prevention

- Smart segmentation of output
- Avoid overly long outputs
- Maintain logical coherence
- Optimize token usage

---

## ⚙️ Configuration

Edit `universal-file-processor.config` to customize settings:

```ini
# Token limit (tokens)
token_limit=30000

# Line limit (lines)
line_limit=500

# Character limit (characters)
char_limit=50000

# Default split strategy
default_strategy=chapter

# Output directory
output_dir=/tmp/universal-file-processor

# Model context window (tokens)
model_context_window=128000

# Token estimation ratio (chars per token)
token_ratio=2.0

# Output optimization settings
output_optimization=true
max_output_tokens=10000
output_segment_size=2000
smart_segmentation=true
```

---

## 📊 Performance

### Efficiency

- ✅ **Smart Detection**: Only split when necessary
- ✅ **Optimal Splitting**: Minimize context loss
- ✅ **Parallel Processing**: Process parts in parallel
- ✅ **Memory Efficient**: Low memory footprint
- ✅ **Output Optimization**: Reduce token usage

### Accuracy

- ✅ **Context Preservation**: Maintain logical coherence
- ✅ **Consistent Results**: Same output as single-pass
- ✅ **Error Recovery**: Handle partial failures
- ✅ **Fatigue Prevention**: Avoid model fatigue

---

## 📁 File Structure

```
universal-file-processor/
├── universal-file-processor.sh    # Main script
├── universal-file-processor.config # Configuration file
├── install.sh                     # Installation script
├── skill.sh                       # Skill implementation script
├── SKILL.md                       # Skill metadata
├── README.md                      # Chinese documentation
├── README_EN.md                   # English documentation
└── LICENSE                        # License
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

---

## 📄 License

MIT License - see LICENSE file for details.

---

## 👤 Author

- **Name**: lichaonetuser
- **GitHub**: [@lichaonetuser](https://github.com/lichaonetuser)

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/lichaonetuser/universal-file-processor/issues)
- **Discussions**: [GitHub Discussions](https://github.com/lichaonetuser/universal-file-processor/discussions)

---

**Made with ❤️ by lichaonetuser**
