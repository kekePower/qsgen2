# Quick Site Generator 2 (qsgen2) - User Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Project Structure](#project-structure)
5. [Content Creation](#content-creation)
   - [Pages](#pages)
   - [Blog Posts](#blog-posts)
6. [Markup Languages](#markup-languages)
   - [QSTags](#qstags)
   - [Markdown](#markdown)
   - [Conversion Between Formats](#conversion-between-formats)
7. [Themes and Templates](#themes-and-templates)
8. [Configuration](#configuration)
9. [Command Reference](#command-reference)
10. [Advanced Usage](#advanced-usage)
11. [Troubleshooting](#troubleshooting)
12. [Contributing](#contributing)

## Introduction

Quick Site Generator 2 (qsgen2) is a powerful static site generator written in Zsh. It's designed to be fast, flexible, and easy to use, with support for both custom QSTags and standard Markdown syntax.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kekePower/qsgen2.git
   cd qsgen2
   ```

2. Make the script executable:
   ```bash
   chmod +x qsgen2
   ```

3. Add to your PATH (optional):
   ```bash
   echo 'export PATH="$PATH:'$(pwd)'"' >> ~/.zshrc
   source ~/.zshrc
   ```

## Quick Start

1. Create a new site:
   ```bash
   ./qsgen2 new my-site
   cd my-site
   ```

2. Build the site:
   ```bash
   ./qsgen2 build
   ```

3. Preview the site:
   ```bash
   ./qsgen2 serve
   ```

## Project Structure

```
my-site/
├── config             # Site configuration
├── content/           # Source content
│   ├── pages/         # Static pages
│   └── blog/          # Blog posts
├── themes/            # Site themes
├── static/            # Static files (images, CSS, JS)
└── output/            # Generated site (created on build)
```

## Content Creation

### Pages

Create a new page:
```bash
./qsgen2 new page about
```

Pages use the `.qst` extension and can include QSTags or Markdown.

### Blog Posts

Create a new blog post:
```bash
./qsgen2 new post my-first-post
```

Blog posts use the `.blog` extension and support the same markup as pages.

## Markup Languages

### QSTags

QSTags is a simple markup language used by qsgen2. Example:

```
#H1 Welcome to My Site#EH1
#P This is a paragraph with #BDbold#EBD and #Iitalic#EI text.#EP
```

### Markdown

Markdown is also supported:

```markdown
# Welcome to My Site

This is a paragraph with **bold** and *italic* text.
```

### Conversion Between Formats

Convert a single file to Markdown:
```bash
./qsgen2 convert --to-markdown content/pages/about.qst content/pages/about.md
```

Convert all files to Markdown:
```bash
./qsgen2 convert --to-markdown --all
```

Convert back to QSTags:
```bash
./qsgen2 convert --to-qstags --all
```

## Themes and Templates

Themes are stored in the `themes` directory. Each theme can include:
- Page templates
- Blog post templates
- CSS/JavaScript
- Assets

## Configuration

Edit `config/site.conf` to customize your site:

```ini
site_name = "My Awesome Site"
site_url = "https://example.com"
site_author = "Your Name"
theme = "default"
```

## Command Reference

### Build Commands
- `build`: Build the site
- `clean`: Remove generated files
- `serve`: Start a local server

### Content Management
- `new page <name>`: Create a new page
- `new post <title>`: Create a new blog post
- `convert`: Convert between markup formats

### Utility Commands
- `version`: Show version information
- `help`: Show help message

## Advanced Usage

### Custom Build Scripts
Create a `build.zsh` file in your project root:

```bash
#!/usr/bin/env zsh
# Custom build script

# Clean previous build
./qsgen2 clean

# Convert all content to Markdown for editing
./qsgen2 convert --to-markdown --all

# Build the site
./qsgen2 build

# Optimize images
find output -name "*.jpg" -exec jpegoptim --strip-all {} \;
```

## Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   chmod +x qsgen2
   ```

2. **Command Not Found**
   Add qsgen2 to your PATH or use `./qsgen2`

3. **Build Errors**
   Check for syntax errors in your content files

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License - See LICENSE for details.

---

*Quick Site Generator 2 - A fast, flexible static site generator*
