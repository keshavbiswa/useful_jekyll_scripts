# Useful Jekyll Scripts

This repository contains a collection of Ruby scripts designed to assist with common tasks when managing a Jekyll blog. These scripts help ensure your posts, redirects, and dates are consistent and correctly formatted.

## Scripts

### 1. `update_redirect_pages.rb`
==Note: This script is particularly useful if you host your Jekyll site on Cloudflare Pages and need to manage redirects for any reason.==
This script scans through your Jekyll posts and updates any outdated or improperly formatted slugs in the `_redirects` file.

**Features:**
- Sanitizes slugs to remove invalid characters.
- Generates 301 redirects for any posts with updated slugs.
- Outputs a list of redirects found and writes them to the `_redirects` file.

**Usage:**
- Update the `BASE_URL` and `FILE_PATH` in the script.
- Execute the script
```bash
./scripts/update_redirect_pages.rb
```

### 2. check_inconsistent_dates.rb
This script checks for inconsistencies between the date in a post's filename and the date specified in its YAML front matter.

**Features:**
- Compares the date from the filename with the date in the front matter.
- Reports any inconsistencies found.

**Usage:**

```bash
./scripts/check_inconsistent_dates.rb
```

### 3. Check Redirects
==Note: This script is also particularly useful if you host your Jekyll site on Cloudflare Pages and need to verify that redirects are working correctly.==
This script verifies the redirects in your `_redirects` file by making HTTP requests to the original URLs and checking the response codes.

**Features:**
- Makes requests to the original routes to ensure they redirect as expected.
- Reports any mismatches in status codes or errors encountered.

**Usage:**

```bash
./scripts/check_redirects.rb
```

## How to Use

### 1. Clone the repository:

```bash
git clone https://github.com/keshavbiswa/useful_jekyll_scripts.git
cd jekyll-utilities
```

### 2. Make the scripts executable:

```bash
chmod +x scripts/*
```

### 3. Run the scripts as needed.

## Contributing
Feel free to add new ones or improve existing!
