#!/usr/bin/env zsh

# Script to migrate hardcoded messages to the message system

set -e

# Configuration
SOURCE_DIR="$(dirname "$0")/.."
LANG_FILE="${SOURCE_DIR}/include/qsgen2/lang/qsgen2.en"
TEMP_FILE="${SOURCE_DIR}/.qsgen2.tmp"

# Create a backup of the original file
backup_file() {
    local file="$1"
    local backup="${file}.bak.$(date +%s)"
    cp "$file" "$backup"
    echo "Created backup at: $backup"
}

# Replace a message in the code
replace_message() {
    local old_msg="$1"
    local new_key="$2"
    local file="$3"
    
    # Escape special characters for sed
    local escaped_old=$(printf '%s\n' "$old_msg" | sed 's/[&/\^$*.]/\\&/g')
    local escaped_new="_msg i18n \"$new_key\""
    
    # Handle messages with parameters
    if [[ "$old_msg" == *"%s"* ]]; then
        escaped_new="${escaped_new} \"\${1:-\"\"}\""
    fi
    
    # Replace in file
    sed -i "s/_msg \(info\|warning\|error\|debug\|other\) \"$escaped_old\"/$escaped_new/g" "$file"
}

# Process a single file
process_file() {
    local file="$1"
    echo "Processing file: $file"
    
    # Create a backup
    backup_file "$file"
    
    # Replace messages
    while IFS= read -r line; do
        if [[ "$line" =~ ^([a-z.]+)[[:space:]]*=[[:space:]]*"([^"]+)" ]]; then
            local key="${match[1]}"
            local msg="${match[2]}"
            
            # Skip comments and empty lines
            [[ "$key" == "#"* ]] && continue
            [[ -z "$key" ]] && continue
            
            # Replace in file
            replace_message "$msg" "$key" "$file"
        fi
    done < "$LANG_FILE"
}

# Find all shell scripts in the project
find "$SOURCE_DIR" -type f \( -name "*.zsh" -o -name "*.sh" \) -not -path "*/.*" | while read -r file; do
    process_file "$file"
done

echo "Migration complete. Please review the changes and test the application."
