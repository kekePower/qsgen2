#!/usr/bin/env zsh

# Script to help migrate message strings to the new format

set -e

# Configuration
SOURCE_DIR="$(dirname "$0")/.."
LANG_DIR="${SOURCE_DIR}/include/qsgen2/lang"
OUTPUT_FILE="${LANG_DIR}/message_migration.txt"

# Create output directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Initialize output file
cat > "$OUTPUT_FILE" << EOF
# Quick Site Generator 2 - Message Migration
# This file helps migrate from old message format to the new format
# Generated on: $(date)
#
# Format:
# OLD_ID = "message"
# NEW_ID = "new.message.id"
#
# [Additional notes]

EOF

# Find all _msg calls in the codebase
echo "# Messages from _msg calls" >> "$OUTPUT_FILE"
grep -r --include="*.zsh" --include="*.sh" -h "_msg " "$SOURCE_DIR" | \
  grep -o "_msg \w\+ \"[^\"]\+" | \
  sort -u | \
  while read -r line; do
    # Extract message type and content
    msg_type=$(echo "$line" | awk '{print $2}')
    msg_content=$(echo "$line" | cut -d'"' -f2)
    
    # Generate a message ID based on content
    msg_id=$(echo "$msg_content" | \
      tr '[:upper:]' '[:lower:]' | \
      sed 's/[^a-z0-9]/_/g' | \
      sed 's/__*/_/g' | \
      sed 's/^_//;s/_$//')
    
    # Add to output file
    echo "# $line" >> "$OUTPUT_FILE"
    echo "msg_${msg_id} = \"${msg_content}\"" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
done

# Find all existing message IDs in language files
echo -e "\n# Existing message IDs in language files" >> "$OUTPUT_FILE"
find "$LANG_DIR" -type f -name "*.en" -o -name "en_*" | while read -r langfile; do
  echo "## From $(basename "$langfile"):" >> "$OUTPUT_FILE"
  grep -o '"_\?[a-zA-Z0-9_]\+"' "$langfile" | \
    sort -u | \
    sed 's/^"//;s/"$//' >> "$OUTPUT_FILE"
  echo >> "$OUTPUT_FILE"
done

echo "Migration file created at: $OUTPUT_FILE"
echo "Please review and update the message IDs as needed."
