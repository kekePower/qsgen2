<img src="qsg2-square.png" width="150" align="left">

# Quick Site Generator 2

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Quick Site Generator 2 is a powerful static website generator written in Zsh, inspired by [Nikola](https://github.com/getnikola/nikola). It's designed to be fast, flexible, and easy to use, with support for both custom QSTags and standard Markdown syntax.

## Features

- 🚀 Blazing fast static site generation
- 📝 Supports both QSTags and Markdown content
- 🌍 Multi-language support (en_US, en_UK, es_ES, fr_FR, nb_NO)
- 🎨 Themeable with custom templates
- 📱 Responsive design ready
- 🔍 SEO friendly
- 🔄 Automatic rebuild on file changes

## Quick Start

1. **Installation**
   ```bash
   git clone https://github.com/kekePower/qsgen2.git
   cd qsgen2
   chmod +x qsgen2
   ```

2. **Create a new site**
   ```bash
   ./qsgen2 new my-site
   cd my-site
   ```

3. **Build and serve**
   ```bash
   ./qsgen2 build
   ./qsgen2 serve
   ```

For detailed documentation, see the [HOWTO.md](HOWTO.md) guide.

## Recent Changes

- Added Norwegian (nb_NO) language support
- Improved internationalization (i18n) system
- Cleaned up temporary and backup files
- Updated documentation
- Added comprehensive HOWTO guide

## Requirements

- Zsh 5.8 or later
- Pandoc (for Markdown support)
- Basic Unix tools (sed, grep, etc.)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting pull requests.

## Support

For support, please [open an issue](https://github.com/kekePower/qsgen2/issues) on GitHub.

---

*Created with ❤️ by kekePower*
