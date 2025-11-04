#!/bin/bash

# Quick VaultNode Deployment Script for GitHub Pages

echo "🌀 Helix VaultNode Deployment Script"
echo "======================================"
echo ""

# Check if we're in a git repo
if [ ! -d .git ]; then
    echo "❌ Not a git repository. Initializing..."
    git init
    echo "✅ Git repository initialized"
fi

# Check if VaultNode files exist
if [ ! -f "helix_realization_vaultnode_with_yaml.html" ] || [ ! -f "helix_continuation_vaultnode_with_yaml.html" ]; then
    echo "❌ VaultNode files not found in current directory"
    echo "Please copy the files with YAML frontmatter to this directory:"
    echo "  - helix_realization_vaultnode_with_yaml.html"
    echo "  - helix_continuation_vaultnode_with_yaml.html"
    exit 1
fi

echo "✅ VaultNode files found"
echo ""

# Get GitHub username and repo name
read -p "Enter your GitHub username: " USERNAME
read -p "Enter repository name (e.g., helix-vaultnode): " REPONAME

echo ""
echo "Configuration:"
echo "  Username: $USERNAME"
echo "  Repository: $REPONAME"
echo "  Files to deploy: 2 VaultNodes"
echo ""

read -p "Continue? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "Cancelled"
    exit 0
fi

# Add files
echo "📦 Adding files..."
git add helix_realization_vaultnode_with_yaml.html helix_continuation_vaultnode_with_yaml.html
git add README.md 2>/dev/null || echo "No README.md found, skipping"

# Commit
echo "💾 Committing..."
git commit -m "Add Helix VaultNodes with YAML frontmatter for pattern recognition"

# Set up remote (if not exists)
if ! git remote get-url origin >/dev/null 2>&1; then
    echo "🔗 Setting up remote..."
    git remote add origin "https://github.com/$USERNAME/$REPONAME.git"
fi

# Set branch to main
git branch -M main

# Push
echo "🚀 Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Your VaultNode URLs will be:"
echo "  https://raw.githubusercontent.com/$USERNAME/$REPONAME/main/helix_realization_vaultnode_with_yaml.html"
echo "  https://raw.githubusercontent.com/$USERNAME/$REPONAME/main/helix_continuation_vaultnode_with_yaml.html"
echo ""
echo "To enable GitHub Pages:"
echo "1. Go to: https://github.com/$USERNAME/$REPONAME/settings/pages"
echo "2. Source: Deploy from branch"
echo "3. Branch: main -> / (root)"
echo "4. Save"
echo ""
echo "Then your URLs will also be available at:"
echo "  https://$USERNAME.github.io/$REPONAME/helix_realization_vaultnode_with_yaml.html"
echo "  https://$USERNAME.github.io/$REPONAME/helix_continuation_vaultnode_with_yaml.html"
echo ""
echo "Update your artifact code with these URLs!"
