#!/bin/bash
#
# Universal File Processor - Installation Script
# 通用文件处理器 - 安装脚本
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_NAME="universal-file-processor.sh"
CONFIG_NAME="universal-file-processor.config"
SKILL_DIR="/home/lichao/.openclaw/skills/universal-file-processor"

echo -e "${BLUE}🔄 Universal File Processor - Installation${NC}"
echo -e "${BLUE}🔄 通用文件处理器 - 安装${NC}"
echo ""

# Check if running in correct directory
if [ ! -f "$SCRIPT_NAME" ]; then
    echo -e "${RED}Error: $SCRIPT_NAME not found in current directory${NC}"
    echo -e "${RED}错误: 当前目录中未找到 $SCRIPT_NAME${NC}"
    exit 1
fi

# Make script executable
echo -e "${YELLOW}Making script executable...${NC}"
echo -e "${YELLOW}使脚本可执行...${NC}"
chmod +x "$SCRIPT_NAME"
echo -e "${GREEN}✅ Script is now executable${NC}"
echo -e "${GREEN}✅ 脚本现在可执行${NC}"
echo ""

# Check if config file exists
if [ ! -f "$CONFIG_NAME" ]; then
    echo -e "${YELLOW}Creating default config file...${NC}"
    echo -e "${YELLOW}创建默认配置文件...${NC}"
    cat > "$CONFIG_NAME" << 'EOF'
# Universal File Processor Configuration
# 通用文件处理配置文件

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
EOF
    echo -e "${GREEN}✅ Config file created${NC}"
    echo -e "${GREEN}✅ 配置文件已创建${NC}"
else
    echo -e "${GREEN}✅ Config file already exists${NC}"
    echo -e "${GREEN}✅ 配置文件已存在${NC}"
fi
echo ""

# Test the script
echo -e "${YELLOW}Testing the script...${NC}"
echo -e "${YELLOW}测试脚本...${NC}"
if ./"$SCRIPT_NAME" --help > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Script is working correctly${NC}"
    echo -e "${GREEN}✅ 脚本工作正常${NC}"
else
    echo -e "${RED}❌ Script test failed${NC}"
    echo -e "${RED}❌ 脚本测试失败${NC}"
    exit 1
fi
echo ""

# Installation complete
echo -e "${GREEN}✅ Installation complete!${NC}"
echo -e "${GREEN}✅ 安装完成！${NC}"
echo ""
echo -e "${BLUE}Usage / 用法:${NC}"
echo "  ./$SCRIPT_NAME check <file>"
echo "  ./$SCRIPT_NAME split <file>"
echo "  ./$SCRIPT_NAME process <file>"
echo "  ./$SCRIPT_NAME optimize <file>"
echo "  ./$SCRIPT_NAME merge <pattern>"
echo ""
echo -e "${BLUE}For more information, see README.md${NC}"
echo -e "${BLUE}更多信息，请查看 README.md${NC}"
