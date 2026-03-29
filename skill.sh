#!/bin/bash
#
# Universal File Processor - OpenClaw Skill Implementation Script
# 通用文件处理器 - OpenClaw技能实现脚本
#

set -e

# Configuration
SCRIPT_DIR="/home/lichao/.openclaw/skills/universal-file-processor"
SCRIPT_NAME="universal-file-processor.sh"
CONFIG_NAME="universal-file-processor.config"

# Full paths
SCRIPT_PATH="$SCRIPT_DIR/$SCRIPT_NAME"
CONFIG_PATH="$SCRIPT_DIR/$CONFIG_NAME"

case "$1" in
    check)
        if [ -z "$2" ]; then
            echo "Error: Please provide a file path"
            echo "错误: 请提供文件路径"
            exit 1
        fi
        "$SCRIPT_PATH" check "$2"
        ;;
    split)
        if [ -z "$2" ]; then
            echo "Error: Please provide a file path"
            echo "错误: 请提供文件路径"
            exit 1
        fi
        "$SCRIPT_PATH" split "$2"
        ;;
    process)
        if [ -z "$2" ]; then
            echo "Error: Please provide a file path"
            echo "错误: 请提供文件路径"
            exit 1
        fi
        "$SCRIPT_PATH" process "$2"
        ;;
    optimize)
        if [ -z "$2" ]; then
            echo "Error: Please provide a file path"
            echo "错误: 请提供文件路径"
            exit 1
        fi
        "$SCRIPT_PATH" optimize "$2"
        ;;
    merge)
        if [ -z "$2" ]; then
            echo "Error: Please provide a file pattern"
            echo "错误: 请提供文件模式"
            exit 1
        fi
        "$SCRIPT_PATH" merge "$2"
        ;;
    *)
        echo "Usage: $0 {check|split|process|optimize|merge} <file|pattern>"
        echo "用法: $0 {check|split|process|optimize|merge} <文件|模式>"
        echo ""
        echo "Commands / 命令:"
        echo "  check <file>              Check file size and estimate tokens"
        echo "  check <文件>              检查文件大小并估算token数"
        echo "  split <file>              Split file into parts"
        echo "  split <文件>              拆分文件"
        echo "  process <file>            Process file (auto-split if needed)"
        echo "  process <文件>            处理文件（如果需要会自动拆分）"
        echo "  optimize <file>           Optimize output to prevent fatigue"
        echo "  optimize <文件>           优化输出，防止疲劳"
        echo "  merge <pattern>           Merge processed parts"
        echo "  merge <模式>              合并处理后的部分"
        exit 1
        ;;
esac
