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

**适用场景**:
- 大型Markdown文件分析
- 大型代码文件重构
- 批量数据处理
- 输出优化

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

### 基本用法

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
