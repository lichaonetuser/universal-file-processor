# Universal File Processor - 通用文件处理技能

三合一的通用文件处理技能，整合了：
- ✅ 大文件输入处理
- ✅ 大文件处理
- ✅ 防止输出疲劳

## 功能特性

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

## 安装

```bash
cd /home/lichao/.openclaw/skills/universal-file-processor
chmod +x universal-file-processor.sh
```

## 使用方法

### 检查文件大小

```bash
./universal-file-processor.sh check /path/to/file.md
```

输出示例：
```
📊 File Analysis: /path/to/file.md
  Lines: 1100
  Characters: 85000
  Estimated Tokens: ~42500
  Status: ⚠️  EXCEEDS_LIMIT (Recommended split)
  Suggested Strategy: chapter
```

### 拆分文件

#### 按章节拆分（适用于Markdown）

```bash
./universal-file-processor.sh split --strategy chapter /path/to/file.md
```

#### 按行数拆分（适用于代码）

```bash
./universal-file-processor.sh split --strategy lines --max-lines 300 /path/to/file.md
```

#### 按Token数拆分（精确控制）

```bash
./universal-file-processor.sh split --strategy tokens --max-tokens 15000 /path/to/file.md
```

### 处理文件

```bash
# 自动检测并处理（如果需要会自动拆分）
./universal-file-processor.sh process /path/to/file.md

# 只处理特定部分
./universal-file-processor.sh process --part 2 /path/to/file.md
```

### 优化输出

```bash
# 优化输出，防止疲劳
./universal-file-processor.sh optimize /path/to/output.md

# 指定最大输出token数
./universal-file-processor.sh optimize --max-output 8000 /path/to/output.md
```

### 合并结果

```bash
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.md
```

## 配置

编辑 `universal-file-processor.config` 文件：

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

## AI集成示例

当AI需要处理大文件时，可以自动调用此技能：

```bash
# 1. 检查文件大小
./universal-file-processor.sh check "$FILE_PATH"

# 2. 如果超过限制，拆分文件
./universal-file-processor.sh split "$FILE_PATH"

# 3. 处理每个部分
for PART in /tmp/universal-file-processor/file_*.md; do
    # 处理部分
    process_part "$PART"
done

# 4. 优化输出
./universal-file-processor.sh optimize "$OUTPUT_PATH"

# 5. 合并结果
./universal-file-processor.sh merge /tmp/universal-file-processor/file_*.md
```

## 使用场景

### 1. 大型Markdown文件分析

```bash
# 分析1100行的文档
./universal-file-processor.sh process /path/to/docs.md
```

### 2. 大型代码文件重构

```bash
# 重构1500行的C代码
./universal-file-processor.sh process /path/to/code.c
```

### 3. 批量数据处理

```bash
# 处理大型数据集
./universal-file-processor.sh process /path/to/dataset.csv
```

### 4. 输出优化

```bash
# 优化长输出，防止疲劳
./universal-file-processor.sh optimize /path/to/long-output.md
```

## 技术细节

### Token估算

使用简单的字符数除以比例来估算token数：
- 默认比例：2.0字符/token
- 可在配置文件中调整

### 拆分策略

1. **Chapter（章节）**: 按Markdown标题（##）拆分
2. **Lines（行数）**: 按固定行数拆分
3. **Tokens（Token数）**: 按估算token数拆分

### 输出优化

1. **智能分段**: 按逻辑块分段
2. **长度控制**: 限制最大输出token数
3. **保持连贯**: 保持逻辑连贯性

### 输出目录

默认输出目录：`/tmp/universal-file-processor/`

文件命名格式：`file_001.md`, `file_002.md`, ...

## 性能

- **智能检测**: 只在必要时拆分
- **优化拆分**: 最小化上下文丢失
- **并行处理**: 支持并行处理各部分
- **内存高效**: 低内存占用
- **输出优化**: 减少token使用

## 故障排除

### 文件未找到

```bash
Error: File not found: /path/to/file.md
```

检查文件路径是否正确。

### 未知策略

```bash
Error: Unknown strategy: xxx
```

使用支持的策略：chapter, lines, tokens

### 无匹配文件

```bash
Error: No files found matching pattern: /tmp/universal-file-processor/file_*.md
```

确保先执行split命令生成拆分文件。

## 贡献

欢迎贡献！请随时提交问题和拉取请求。

## 许可证

MIT License

## 作者

lichaoonetuser

## 版本

v1.0 - 2026-03-30
