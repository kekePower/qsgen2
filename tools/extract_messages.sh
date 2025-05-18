#!/usr/bin/env zsh

# Script to extract and organize user-facing strings from the codebase

set -e

# Configuration
SOURCE_DIR="$(dirname "$0")/.."
LANG_DIR="${SOURCE_DIR}/include/qsgen2/lang"
OUTPUT_FILE="${LANG_DIR}/extracted_messages.txt"

# Create output directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Initialize output file
cat > "$OUTPUT_FILE" << 'EOF'
# Quick Site Generator 2 - Extracted Messages
# This file contains all user-facing strings extracted from the codebase
# Generated on: $(date)

# Format:
# [message_id] = "message"
# Where message_id is in the format: category_subject_description
# Example: error_file_not_found = "File not found: %s"

# Categories:
# - config: Configuration related messages
# - file: File operation messages
# - build: Build process messages
# - blog: Blog system messages
# - page: Page system messages
# - error: Error messages
# - warning: Warning messages
# - info: Informational messages
# - debug: Debug messages

# Message Dictionary
[messages]

EOF

# Function to add a message to the output file
add_message() {
    local category="$1"
    local subject="$2"
    local description="$3"
    local message="$4"
    
    # Generate message ID
    local msg_id="${category}_${subject}_${description}"
    
    # Clean up the message ID
    msg_id=$(echo "$msg_id" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | sed 's/[^a-z0-9_]/_/g' | sed 's/__*/_/g' | sed 's/^_//;s/_$//')
    
    # Add to output file
    echo "${msg_id} = \"${message}\"" >> "$OUTPUT_FILE"
}

# Extract messages from _msg calls
echo "# Extracting messages from _msg calls..."

grep -r --include="*.zsh" --include="*.sh" -h "_msg " "$SOURCE_DIR" | \
  grep -v '^\s*#' | \
  grep -v '^\s*$' | \
  while read -r line; do
    # Extract message type and content
    msg_type=$(echo "$line" | awk -F'"' '{print $1}' | awk '{print $NF}' | tr -d ' ')
    msg_content=$(echo "$line" | sed -E 's/.*_msg[[:space:]]+[^[:space:]]+[[:space:]]+["]([^"]+)["].*/\1/')
    
    # Skip if we couldn't extract content
    if [[ "$msg_content" == "$line" ]]; then
        continue
    fi
    
    # Determine category based on message type
    case "$msg_type" in
        error)
            category="error"
            ;;
        warning)
            category="warning"
            ;;
        info|other)
            category="info"
            ;;
        debug)
            category="debug"
            ;;
        *)
            category="info"
            ;;
    esac
    
    # Generate a description from the message content
    description=$(echo "$msg_content" | \
        head -n 1 | \
        tr '[:upper:]' '[:lower:]' | \
        sed 's/[^a-z0-9 ]/ /g' | \
        sed 's/  */ /g' | \
        cut -c1-30 | \
        tr ' ' '_' | \
        sed 's/_$//')
    
    # Add the message
    add_message "$category" "general" "$description" "$msg_content"
done

# Extract messages from echo/print statements
echo "# Extracting messages from echo/print statements..."

grep -r --include="*.zsh" --include="*.sh" -h -E 'echo|printf|print' "$SOURCE_DIR" | \
  grep -v '^\s*#' | \
  grep -v '^\s*$' | \
  grep -v '\\n' | \
  grep -v '\$\|`' | \
  grep -E '".*[a-z].*"' | \
  while read -r line; do
    # Extract message content
    msg_content=$(echo "$line" | grep -o '"[^"]*"' | head -n 1 | tr -d '"')
    
    # Skip if no content
    if [[ -z "$msg_content" ]]; then
        continue
    fi
    
    # Skip common debug/technical messages
    if [[ "$msg_content" =~ ^[^a-zA-Z]*$ ]]; then
        continue
    fi
    
    # Add as an info message
    description=$(echo "$msg_content" | \
        head -n 1 | \
        tr '[:upper:]' '[:lower:]' | \
        sed 's/[^a-z0-9 ]/ /g' | \
        sed 's/  */ /g' | \
        cut -c1-30 | \
        tr ' ' '_' | \
        sed 's/_$//')
    
    add_message "info" "general" "$description" "$msg_content"
done

echo "Message extraction complete. Review the output in $OUTPUT_FILE"
