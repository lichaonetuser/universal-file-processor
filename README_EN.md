# Universal File Processor

**Comprehensive File Processing Skill for OpenClaw**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue.svg)](https://github.com/openclaw/openclaw)
[![Version](https://img.shields.io/badge/Version-1.0-green.svg)](https://github.com/lichaonetuser/universal-file-processor)

**🌐 [中文版本 / Chinese Version](https://github.com/lichaonetuser/universal-file-processor/blob/main/README.md)**

---

## 📖 Overview

Universal File Processor is a comprehensive file processing skill for OpenClaw that integrates three powerful capabilities:
- ✅ **Large File Input Processing**: Intelligently split large file inputs
- ✅ **Large File Processing**: Process large files in batches
- ✅ **Output Fatigue Prevention**: Optimize output to prevent model fatigue

**Perfect for**:
- Large Markdown file analysis
- Large code file refactoring
- Batch data processing
- Output optimization

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

### Basic Usage

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
