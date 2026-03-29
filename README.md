# Universal File Processor

**通用文件处理器**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue.svg)](https://github.com/openclaw/openclaw)
[![Version](https://img.shields.io/badge/Version-1.0-green.svg)](https://github.com/lichaonetuser/universal-file-processor)

**🌐 [View Interactive README (English/中文)](https://lichaonetuser.github.io/universal-file-processor/)**

---

## 📖 Overview / 概述

**English**:
Universal File Processor is a comprehensive file processing skill for OpenClaw that integrates three powerful capabilities:
- ✅ **Large File Input Processing**: Intelligently split large file inputs
- ✅ **Large File Processing**: Process large files in batches
- ✅ **Output Fatigue Prevention**: Optimize output to prevent model fatigue

**中文**:
通用文件处理器是一个为OpenClaw设计的综合文件处理技能，整合了三大强大功能：
- ✅ **大文件输入处理**: 智能拆分大文件输入
- ✅ **大文件处理**: 分批处理大文件
- ✅ **防止输出疲劳**: 优化输出，避免模型疲劳

**Perfect for / 适用场景**:
- Large Markdown file analysis (大型Markdown文件分析)
- Large code file refactoring (大型代码文件重构)
- Batch data processing (批量数据处理)
- Output optimization (输出优化)

---

## 🚀 Quick Start / 快速开始

### Installation / 安装

**English**:
```bash
# Clone the repository
git clone https://github.com/lichaonetuser/universal-file-processor.git

# Navigate to the skill directory
cd universal-file-processor

# Run installation script
./install.sh
```

**中文**:
```bash
# 克隆仓库
git clone https://github.com/lichaonetuser/universal-file-processor.git

# 进入技能目录
cd universal-file-processor

# 运行安装脚本
./install.sh
```

### Basic Usage / 基本用法

**English**:
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

**中文**:
```bash
# 检查文件大小
./skill.sh check /path/to/file.md

# 拆分文件
./skill.sh split /path/to/file.md

# 处理文件
./skill.sh process /path/to/file.md

# 优化输出
./skill.sh optimize /path/to/output.md

# 合并结果
./skill.sh merge /tmp/universal-file-processor/file_*.md
```

---

## 🎯 Features / 功能特性

### 1. Large File Input Processing / 大文件输入处理

**English**:
- Automatically detect file size (lines, characters, tokens)
- Intelligently determine if splitting is needed
- Support multiple splitting strategies

**中文**:
- 自动检测文件大小（行数、字符数、token数）
- 智能判断是否需要拆分
- 支持多种拆分策略

### 2. Large File Processing / 大文件处理

**English**:
- Split by chapter (suitable for Markdown)
- Split by lines (suitable for code)
- Split by tokens (precise control)
- Batch processing with context preservation
- Automatic result merging

**中文**:
- 按章节拆分（适用于Markdown）
- 按行数拆分（适用于代码）
- 按token数拆分（精确控制）
- 分批处理，保持上下文连贯
- 自动合并结果

### 3. Output Fatigue Prevention / 防止输出疲劳

**English**:
- Smart segmentation of output
- Avoid overly long outputs
- Maintain logical coherence
- Optimize token usage

**中文**:
- 智能分段输出
- 避免过长输出
- 保持逻辑连贯
- 优化token使用

---

## ⚙️ Configuration / 配置

### Config File / 配置文件

**English**:
Edit `universal-file-processor.config` to customize settings:

**中文**:
编辑 `universal-file-processor.config` 来自定义设置：

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

## 📊 Performance / 性能

### Efficiency / 效率

**English**:
- ✅ **Smart Detection**: Only split when necessary
- ✅ **Optimal Splitting**: Minimize context loss
- ✅ **Parallel Processing**: Process parts in parallel
- ✅ **Memory Efficient**: Low memory footprint
- ✅ **Output Optimization**: Reduce token usage

**中文**:
- ✅ **智能检测**: 只在必要时拆分
- ✅ **优化拆分**: 最小化上下文丢失
- ✅ **并行处理**: 支持并行处理各部分
- ✅ **内存高效**: 低内存占用
- ✅ **输出优化**: 减少token使用

### Accuracy / 准确性

**English**:
- ✅ **Context Preservation**: Maintain logical coherence
- ✅ **Consistent Results**: Same output as single-pass
- ✅ **Error Recovery**: Handle partial failures
- ✅ **Fatigue Prevention**: Avoid model fatigue

**中文**:
- ✅ **上下文保留**: 保持逻辑连贯性
- ✅ **一致结果**: 与单次处理相同输出
- ✅ **错误恢复**: 处理部分失败
- ✅ **疲劳预防**: 避免模型疲劳

---

## 📁 File Structure / 文件结构

**English**:
```
universal-file-processor/
├── universal-file-processor.sh    # Main script (主脚本)
├── universal-file-processor.config # Configuration file (配置文件)
├── install.sh                     # Installation script (安装脚本)
├── skill.sh                       # Skill implementation script (技能实现脚本)
├── SKILL.md                       # Skill metadata (技能元数据)
├── README.md                      # Documentation (文档)
└── README.html                    # Interactive documentation (交互式文档)
```

**中文**:
```
universal-file-processor/
├── universal-file-processor.sh    # 主脚本
├── universal-file-processor.config # 配置文件
├── install.sh                     # 安装脚本
├── skill.sh                       # 技能实现脚本
├── SKILL.md                       # 技能元数据
├── README.md                      # 文档
└── README.html                    # 交互式文档
```

---

## 🤝 Contributing / 贡献

**English**:
Contributions are welcome! Please feel free to submit issues and pull requests.

**中文**:
欢迎贡献！请随时提交问题和拉取请求。

---

## 📄 License / 许可证

**English**:
MIT License - see LICENSE file for details.

**中文**:
MIT License - 详见LICENSE文件。

---

## 👤 Author / 作者

**English**:
- **Name**: lichaonetuser
- **GitHub**: [@lichaonetuser](https://github.com/lichaonetuser)

**中文**:
- **姓名**: lichaonetuser
- **GitHub**: [@lichaonetuser](https://github.com/lichaonetuser)

---

## 📞 Support / 支持

**English**:
- **Issues**: [GitHub Issues](https://github.com/lichaonetuser/universal-file-processor/issues)
- **Discussions**: [GitHub Discussions](https://github.com/lichaonetuser/universal-file-processor/discussions)

**中文**:
- **问题**: [GitHub Issues](https://github.com/lichaonetuser/universal-file-processor/issues)
- **讨论**: [GitHub Discussions](https://github.com/lichaonetuser/universal-file-processor/discussions)

---

**Made with ❤️ by lichaonetuser**

**由 lichaonetuser 用 ❤️ 制作**
