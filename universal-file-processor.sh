#!/bin/bash
#
# Universal File Processor - 通用文件处理脚本
# Version: 1.0
# Author: lichaonetuser
# Features: Large file input processing, Large file processing, Output fatigue prevention
#

set -e

# Configuration
CONFIG_FILE="$(dirname "$0")/universal-file-processor.config"
OUTPUT_DIR="/tmp/universal-file-processor"
TOKEN_LIMIT=30000
LINE_LIMIT=500
CHAR_LIMIT=50000
DEFAULT_STRATEGY="chapter"
TOKEN_RATIO=2.0
OUTPUT_OPTIMIZATION=true
MAX_OUTPUT_TOKENS=10000
OUTPUT_SEGMENT_SIZE=2000
SMART_SEGMENTATION=true

# Load config if exists
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print usage
usage() {
    echo "Usage: $0 <command> [options] <file>"
    echo ""
    echo "Commands:"
    echo "  check <file>              Check file size and estimate tokens"
    echo "  split <file>              Split file into parts"
    echo "  process <file>            Process file (auto-split if needed)"
    echo "  merge <pattern>           Merge processed parts"
    echo "  optimize <file>           Optimize output to prevent fatigue"
    echo ""
    echo "Options:"
    echo "  --strategy <strategy>    Split strategy: chapter, lines, tokens (default: $DEFAULT_STRATEGY)"
    echo "  --max-lines <num>        Max lines per part (for lines strategy)"
    echo "  --max-tokens <num>       Max tokens per part (for tokens strategy)"
    echo "  --part <num>             Process specific part only"
    echo "  --max-output <num>       Max output tokens (for optimize)"
    echo ""
    echo "Examples:"
    echo "  $0 check /path/to/file.md"
    echo "  $0 split --strategy chapter /path/to/file.md"
    echo "  $0 split --strategy lines --max-lines 300 /path/to/file.md"
    echo "  $0 process /path/to/file.md"
    echo "  $0 optimize /path/to/output.md"
    echo "  $0 merge /tmp/universal-file-processor/file_*.md"
}

# Estimate token count
estimate_tokens() {
    local file="$1"
    local char_count=$(wc -c < "$file" | tr -d ' ')
    local token_count=$(echo "scale=0; $char_count / $TOKEN_RATIO" | bc)
    echo "$token_count"
}

# Check file size
check_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: File not found: $file${NC}"
        exit 1
    fi

    local line_count=$(wc -l < "$file" | tr -d ' ')
    local char_count=$(wc -c < "$file" | tr -d ' ')
    local token_count=$(estimate_tokens "$file")

    echo -e "${BLUE}📊 File Analysis: $file${NC}"
    echo "  Lines: $line_count"
    echo "  Characters: $char_count"
    echo "  Estimated Tokens: ~$token_count"

    # Check if exceeds limits
    local exceeds=0
    local suggested_strategy="$DEFAULT_STRATEGY"

    if [ "$line_count" -gt "$LINE_LIMIT" ]; then
        exceeds=1
        suggested_strategy="lines"
    fi

    if [ "$char_count" -gt "$CHAR_LIMIT" ]; then
        exceeds=1
        suggested_strategy="tokens"
    fi

    if [ "$token_count" -gt "$TOKEN_LIMIT" ]; then
        exceeds=1
        suggested_strategy="tokens"
    fi

    if [ "$exceeds" -eq 1 ]; then
        echo -e "  Status: ${YELLOW}⚠️  EXCEEDS_LIMIT (Recommended split)${NC}"
        echo "  Suggested Strategy: $suggested_strategy"
    else
        echo -e "  Status: ${GREEN}✅ WITHIN_LIMIT (No split needed)${NC}"
    fi
}

# Split file by chapter (Markdown headers)
split_by_chapter() {
    local file="$1"
    local output_prefix="$OUTPUT_DIR/file_"
    local part_num=1
    local current_file="${output_prefix}$(printf '%03d' $part_num).md"

    echo -e "${BLUE}📦 Splitting file: $file${NC}"
    echo "  Strategy: chapter"

    # Create first part
    > "$current_file"

    local line_num=0

    while IFS= read -r line; do
        line_num=$((line_num + 1))

        # Check for chapter header (## only, not ###)
        if [[ "$line" =~ ^##\  ]]; then
            # Start new part if not first line
            if [ "$line_num" -gt 1 ]; then
                part_num=$((part_num + 1))
                current_file="${output_prefix}$(printf '%03d' $part_num).md"
                > "$current_file"
            fi
        fi

        echo "$line" >> "$current_file"
    done < "$file"

    echo "  Parts: $part_num"

    # List output files
    for i in $(seq 1 $part_num); do
        local part_file="${output_prefix}$(printf '%03d' $i).md"
        echo "          $part_file"
    done

    echo -e "${GREEN}✅ Split complete${NC}"
}

# Split file by lines
split_by_lines() {
    local file="$1"
    local max_lines="$2"
    local output_prefix="$OUTPUT_DIR/file_"

    echo -e "${BLUE}📦 Splitting file: $file${NC}"
    echo "  Strategy: lines"
    echo "  Max lines per part: $max_lines"

    # Use split command
    split -l "$max_lines" -d -a 3 --additional-suffix=.md "$file" "${output_prefix}"

    # Rename files to have proper numbering
    local part_num=1
    for part in ${output_prefix}*.md; do
        local new_name="${output_prefix}$(printf '%03d' $part_num).md"
        mv "$part" "$new_name"
        part_num=$((part_num + 1))
    done

    echo "  Parts: $((part_num - 1))"

    # List output files
    for i in $(seq 1 $((part_num - 1))); do
        local part_file="${output_prefix}$(printf '%03d' $i).md"
        echo "          $part_file"
    done

    echo -e "${GREEN}✅ Split complete${NC}"
}

# Split file by tokens
split_by_tokens() {
    local file="$1"
    local max_tokens="$2"
    local max_chars=$((max_tokens * TOKEN_RATIO))
    local output_prefix="$OUTPUT_DIR/file_"

    echo -e "${BLUE}📦 Splitting file: $file${NC}"
    echo "  Strategy: tokens"
    echo "  Max tokens per part: $max_tokens"
    echo "  Max chars per part: $max_chars"

    # Use split command with byte count
    split -b "$max_chars" -d -a 3 --additional-suffix=.md "$file" "${output_prefix}"

    # Rename files to have proper numbering
    local part_num=1
    for part in ${output_prefix}*.md; do
        local new_name="${output_prefix}$(printf '%03d' $part_num).md"
        mv "$part" "$new_name"
        part_num=$((part_num + 1))
    done

    echo "  Parts: $((part_num - 1))"

    # List output files
    for i in $(seq 1 $((part_num - 1))); do
        local part_file="${output_prefix}$(printf '%03d' $i).md"
        echo "          $part_file"
    done

    echo -e "${GREEN}✅ Split complete${NC}"
}

# Split file
split_file() {
    local file="$1"
    local strategy="$2"
    local max_lines="$3"
    local max_tokens="$4"

    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: File not found: $file${NC}"
        exit 1
    fi

    # Clean output directory
    rm -f "${OUTPUT_DIR}/file_"*.md

    case "$strategy" in
        chapter)
            split_by_chapter "$file"
            ;;
        lines)
            if [ -z "$max_lines" ]; then
                max_lines=300
            fi
            split_by_lines "$file" "$max_lines"
            ;;
        tokens)
            if [ -z "$max_tokens" ]; then
                max_tokens=15000
            fi
            split_by_tokens "$file" "$max_tokens"
            ;;
        *)
            echo -e "${RED}Error: Unknown strategy: $strategy${NC}"
            exit 1
            ;;
    esac
}

# Process file
process_file() {
    local file="$1"
    local part_num="$2"

    # Check file size
    local line_count=$(wc -l < "$file" | tr -d ' ')
    local char_count=$(wc -c < "$file" | tr -d ' ')
    local token_count=$(estimate_tokens "$file")

    # Check if exceeds limits
    local needs_split=0
    if [ "$line_count" -gt "$LINE_LIMIT" ] || [ "$char_count" -gt "$CHAR_LIMIT" ] || [ "$token_count" -gt "$TOKEN_LIMIT" ]; then
        needs_split=1
    fi

    if [ "$needs_split" -eq 1 ]; then
        echo -e "${YELLOW}⚠️  File exceeds limits, splitting...${NC}"

        # Split file
        split_file "$file" "$DEFAULT_STRATEGY"

        # Process each part
        local parts=(${OUTPUT_DIR}/file_*.md)
        local total_parts=${#parts[@]}

        echo -e "${BLUE}🔄 Processing $total_parts parts...${NC}"

        for i in $(seq 1 $total_parts); do
            local part_file="${OUTPUT_DIR}/file_$(printf '%03d' $i).md"

            # If specific part requested, skip others
            if [ -n "$part_num" ] && [ "$i" -ne "$part_num" ]; then
                continue
            fi

            echo -e "${BLUE}  Processing part $i/$total_parts: $part_file${NC}"

            # Here you would call the actual processing function
            # For now, just echo the part info
            local part_lines=$(wc -l < "$part_file" | tr -d ' ')
            local part_chars=$(wc -c < "$part_file" | tr -d ' ')
            local part_tokens=$(estimate_tokens "$part_file")

            echo "    Lines: $part_lines, Chars: $part_chars, Tokens: ~$part_tokens"
        done

        echo -e "${GREEN}✅ Processing complete${NC}"
        echo -e "${BLUE}💡 Next step: Merge results with: $0 merge ${OUTPUT_DIR}/file_*.md${NC}"
    else
        echo -e "${GREEN}✅ File within limits, no split needed${NC}"
        echo -e "${BLUE}📊 File info: $line_count lines, $char_count chars, ~$token_count tokens${NC}"
    fi
}

# Merge files
merge_files() {
    local pattern="$1"
    local output_file="${OUTPUT_DIR}/merged_result.md"

    echo -e "${BLUE}🔗 Merging results...${NC}"

    # Get list of files
    local files=()
    while IFS= read -r -d '' file; do
        files+=("$file")
    done < <(find $(dirname "$pattern") -maxdepth 1 -name "$(basename "$pattern")" -print0 | sort -z)

    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${RED}Error: No files found matching pattern: $pattern${NC}"
        exit 1
    fi

    echo "  Parts: ${#files[@]}"

    # Merge files
    cat "${files[@]}" > "$output_file"

    echo "  Output: $output_file"
    echo -e "${GREEN}✅ Merge complete${NC}"
}

# Optimize output to prevent fatigue
optimize_output() {
    local file="$1"
    local max_output="$2"

    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: File not found: $file${NC}"
        exit 1
    fi

    if [ -z "$max_output" ]; then
        max_output="$MAX_OUTPUT_TOKENS"
    fi

    echo -e "${BLUE}🎯 Optimizing output: $file${NC}"

    # Get file stats
    local line_count=$(wc -l < "$file" | tr -d ' ')
    local char_count=$(wc -c < "$file" | tr -d ' ')
    local token_count=$(estimate_tokens "$file")

    echo "  Original length: $token_count tokens"
    echo "  Target length: $max_output tokens"

    # Check if optimization is needed
    if [ "$token_count" -le "$max_output" ]; then
        echo -e "${GREEN}✅ Output already within limits, no optimization needed${NC}"
        return
    fi

    # Calculate reduction ratio
    local reduction_ratio=$(echo "scale=2; $max_output / $token_count" | bc)
    local reduction_percent=$(echo "scale=0; (1 - $reduction_ratio) * 100" | bc)

    echo "  Reduction: ${reduction_percent}%"
    echo "  Strategy: smart-segmentation"

    # Create optimized output
    local output_file="${OUTPUT_DIR}/optimized_$(basename "$file")"

    if [ "$SMART_SEGMENTATION" = true ]; then
        # Smart segmentation: split by logical blocks
        awk -v segment_size="$OUTPUT_SEGMENT_SIZE" '
            BEGIN {
                segment = 0
                line_count = 0
            }
            /^## / {
                if (line_count > segment_size) {
                    segment++
                    line_count = 0
                    print "\n--- Segment " segment " ---\n"
                }
            }
            {
                print
                line_count++
            }
        ' "$file" > "$output_file"
    else
        # Simple truncation
        head -n "$((max_output * 2))" "$file" > "$output_file"
    fi

    # Get optimized stats
    local optimized_char_count=$(wc -c < "$output_file" | tr -d ' ')
    local optimized_token_count=$(estimate_tokens "$output_file")

    echo "  Optimized length: $optimized_token_count tokens"
    echo "  Output: $output_file"
    echo -e "${GREEN}✅ Optimization complete${NC}"
}

# Main
main() {
    if [ $# -lt 2 ]; then
        usage
        exit 1
    fi

    local command="$1"
    shift

    case "$command" in
        check)
            check_file "$@"
            ;;
        split)
            local strategy="$DEFAULT_STRATEGY"
            local max_lines=""
            local max_tokens=""
            local file=""

            while [[ $# -gt 0 ]]; do
                case "$1" in
                    --strategy)
                        strategy="$2"
                        shift 2
                        ;;
                    --max-lines)
                        max_lines="$2"
                        shift 2
                        ;;
                    --max-tokens)
                        max_tokens="$2"
                        shift 2
                        ;;
                    *)
                        file="$1"
                        shift
                        ;;
                esac
            done

            if [ -z "$file" ]; then
                echo -e "${RED}Error: No file specified${NC}"
                usage
                exit 1
            fi

            split_file "$file" "$strategy" "$max_lines" "$max_tokens"
            ;;
        process)
            local part_num=""
            local file=""

            while [[ $# -gt 0 ]]; do
                case "$1" in
                    --part)
                        part_num="$2"
                        shift 2
                        ;;
                    *)
                        file="$1"
                        shift
                        ;;
                esac
            done

            if [ -z "$file" ]; then
                echo -e "${RED}Error: No file specified${NC}"
                usage
                exit 1
            fi

            process_file "$file" "$part_num"
            ;;
        merge)
            merge_files "$@"
            ;;
        optimize)
            local max_output=""
            local file=""

            while [[ $# -gt 0 ]]; do
                case "$1" in
                    --max-output)
                        max_output="$2"
                        shift 2
                        ;;
                    *)
                        file="$1"
                        shift
                        ;;
                esac
            done

            if [ -z "$file" ]; then
                echo -e "${RED}Error: No file specified${NC}"
                usage
                exit 1
            fi

            optimize_output "$file" "$max_output"
            ;;
        *)
            echo -e "${RED}Error: Unknown command: $command${NC}"
            usage
            exit 1
            ;;
    esac
}

main "$@"
