# Creating Themes for Quick Site Generator 2

This guide explains how to create and customize themes for Quick Site Generator 2 (qsgen2). The theming system is designed to be simple yet flexible, allowing you to create beautiful, responsive websites with minimal effort.

## Table of Contents

1. [Theme Structure](#theme-structure)
2. [Template Files](#template-files)
   - [pages.tpl](#pagestpl)
   - [blogs.tpl](#blogstpl)
   - [blog_index.tpl](#blog_indextpl)
   - [blog_list.tpl](#blog_listtpl)
3. [Template Variables](#template-variables)
4. [Creating a New Theme](#creating-a-new-theme)
5. [Best Practices](#best-practices)
6. [Example Theme](#example-theme)

## Theme Structure

A qsgen2 theme consists of the following files:

```
theme-name/
├── pages.tpl         # Template for regular pages
├── blogs.tpl         # Template for blog posts
├── blog_index.tpl    # Template for blog index page
├── blog_list.tpl     # Template for blog post listings
└── css/              # Stylesheets and assets
    ├── style.css     # Main stylesheet
    └── webfont.js    # Web font loader (optional)
```

## Template Files

### pages.tpl

This template is used for regular static pages. It should include the basic HTML structure, head section, and placeholders for dynamic content.

Key placeholders:
- `#sitename` - Site name from configuration
- `#pagetitle` - Title of the current page
- `#tagline` - Site tagline from configuration
- `BODY` - Main content area

### blogs.tpl

This template is used for individual blog posts. It includes placeholders for blog-specific content.

Key placeholders:
- `BLOGTITLE` - Title of the blog post
- `CALADAY` - Day of the month (numeric)
- `CALNDAY` - Day of the week (name)
- `CALMONTH` - Month name
- `CALYEAR` - Year
- `INGRESS` - Blog post excerpt/intro
- `BODY` - Main blog post content

### blog_index.tpl

This template is used for the blog index/archive page that lists all blog posts.

Key placeholders:
- `#sitename` - Site name from configuration
- `#tagline` - Site tagline from configuration
- `BODY` - Contains the list of blog posts (generated from blog_list.tpl)

### blog_list.tpl

This template defines how individual blog posts are displayed in the blog index.

Key placeholders:
- `BLOGURL` - URL of the blog post
- `BLOGTITLE` - Title of the blog post
- `INGRESS` - Blog post excerpt/intro
- `BLOGDATE` - Formatted date of the blog post

## Template Variables

These variables can be used in any template:

- `#sitename` - Site name from configuration
- `#tagline` - Site tagline from configuration
- `#pagetitle` - Current page title
- `#siteurl` - Base URL of the site
- `#currentyear` - Current year (for copyright notices)

## Creating a New Theme

1. **Create a new directory** in the `themes` folder with your theme name.

2. **Copy the template files** from the `minimal` theme as a starting point:
   ```bash
   cp -r themes/minimal/* themes/your-theme-name/
   ```

3. **Customize the templates**:
   - Edit the HTML structure in the `.tpl` files
   - Update the CSS in the `css` directory
   - Replace placeholder images with your own

4. **Test your theme** by setting it in your `site.conf`:
   ```ini
   theme = "your-theme-name"
   ```

5. **Build your site** to see the changes:
   ```bash
   ./qsgen2 build
   ```

## Best Practices

1. **Responsive Design**
   - Use responsive CSS frameworks or media queries
   - Test on different screen sizes

2. **Performance**
   - Minify CSS and JavaScript
   - Optimize images
   - Use web fonts sparingly

3. **Accessibility**
   - Use semantic HTML5 elements
   - Include alt text for images
   - Ensure sufficient color contrast

4. **Browser Compatibility**
   - Test in multiple browsers
   - Use vendor prefixes for CSS properties

## Example Theme

Here's a minimal example of a theme structure:

```
my-theme/
├── pages.tpl
├── blogs.tpl
├── blog_index.tpl
├── blog_list.tpl
└── css/
    └── style.css
```

### pages.tpl (example)
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>#sitename - #pagetitle</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <header>
        <h1>#sitename</h1>
        <p>#tagline</p>
        <nav>
            <a href="/">Home</a>
            <a href="/blog/">Blog</a>
        </nav>
    </header>
    
    <main>
        BODY
    </main>
    
    <footer>
        <p>&copy; #currentyear #sitename. All rights reserved.</p>
    </footer>
</body>
</html>
```

### blog_list.tpl (example)
```html
<article class="blog-post">
    <h2><a href="BLOGURL">BLOGTITLE</a></h2>
    <div class="post-meta">
        <time datetime="BLOGDATE">BLOGDATE</time>
    </div>
    <div class="post-excerpt">
        INGRESS
        <a href="BLOGURL" class="read-more">Read more →</a>
    </div>
</article>
```

## Conclusion

Creating themes for qsgen2 is straightforward once you understand the template system. Start with the minimal theme as a base, and customize it to match your design. Remember to test your theme thoroughly and follow web development best practices for the best results.

For more advanced theming options, refer to the official documentation or check out the source code of existing themes.
