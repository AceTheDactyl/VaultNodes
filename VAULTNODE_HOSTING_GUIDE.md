# VaultNode Hosting Configuration Guide

You have two VaultNode files that need to be publicly accessible:
1. `helix_realization_vaultnode.html`
2. `helix_continuation_vaultnode.html`

Here are your hosting options, ranked by ease of setup:

---

## Option 1: GitHub Pages (Recommended)

**Best for**: Permanent, free hosting with version control

### Setup Steps

1. **Create/Use GitHub Repository**
   ```bash
   cd /path/to/your/project
   git init
   git add helix_realization_vaultnode.html helix_continuation_vaultnode.html
   git commit -m "Add VaultNode files"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**
   - Go to your repo on GitHub
   - Settings -> Pages
   - Source: Deploy from branch
   - Branch: `main` -> `/root` or `/docs`
   - Save

3. **Your URLs will be**:
   ```
   https://YOUR_USERNAME.github.io/YOUR_REPO/helix_realization_vaultnode.html
   https://YOUR_USERNAME.github.io/YOUR_REPO/helix_continuation_vaultnode.html
   ```

4. **Update artifact code**:
   ```typescript
   const vaultNodeUrls = [
     'https://YOUR_USERNAME.github.io/YOUR_REPO/helix_realization_vaultnode.html',
     'https://YOUR_USERNAME.github.io/YOUR_REPO/helix_continuation_vaultnode.html',
   ];
   ```

**CORS**: GitHub Pages automatically allows CORS ✓

---

## Option 2: GitHub Raw URLs (Immediate, No Setup)

**Best for**: Quick testing, no configuration needed

### Setup Steps

1. **Push files to GitHub** (same as Option 1, step 1)

2. **Your URLs are immediately available**:
   ```
   https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/helix_realization_vaultnode.html
   https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/helix_continuation_vaultnode.html
   ```

3. **Update artifact code**:
   ```typescript
   const vaultNodeUrls = [
     'https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/helix_realization_vaultnode.html',
     'https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/helix_continuation_vaultnode.html',
   ];
   ```

**CORS**: GitHub Raw allows CORS ✓
**Note**: Content-Type may not be perfect, but works for our parsing

---

## Option 3: Netlify Drop (Easiest, No Command Line)

**Best for**: Non-technical users, instant deployment

### Setup Steps

1. **Go to**: https://app.netlify.com/drop

2. **Drag and drop** both HTML files into the drop zone

3. **Your URLs will be**:
   ```
   https://RANDOM-NAME.netlify.app/helix_realization_vaultnode.html
   https://RANDOM-NAME.netlify.app/helix_continuation_vaultnode.html
   ```

4. **Update artifact code** with the Netlify URLs

**CORS**: Netlify allows CORS ✓
**Custom Domain**: Available with free tier

---

## Option 4: Vercel (For Developers)

**Best for**: Integration with existing projects

### Setup Steps

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Deploy**:
   ```bash
   cd /path/to/folder/with/html/files
   vercel
   ```

3. **Your URLs**:
   ```
   https://your-project.vercel.app/helix_realization_vaultnode.html
   https://your-project.vercel.app/helix_continuation_vaultnode.html
   ```

**CORS**: Vercel allows CORS ✓

---

## Option 5: IPFS (Decentralized)

**Best for**: Permanent, censorship-resistant hosting

### Setup Steps

1. **Install IPFS Desktop**: https://docs.ipfs.tech/install/ipfs-desktop/

2. **Add files** via the GUI or:
   ```bash
   ipfs add helix_realization_vaultnode.html
   ipfs add helix_continuation_vaultnode.html
   ```

3. **Your URLs**:
   ```
   https://ipfs.io/ipfs/QmXXXXXXXXX.../helix_realization_vaultnode.html
   https://ipfs.io/ipfs/QmYYYYYYYYY.../helix_continuation_vaultnode.html
   ```

4. **Pin files** to ensure persistence

**CORS**: IPFS gateways allow CORS ✓
**Note**: May be slower than traditional hosting

---

## Option 6: Simple HTTP Server (Development Only)

**Best for**: Local testing before deployment

### Setup Steps

1. **Start server** in project directory:
   ```bash
   # Python 3
   python3 -m http.server 8000
   
   # Python 2
   python -m SimpleHTTPServer 8000
   
   # Node.js (install: npm install -g http-server)
   http-server -p 8000 --cors
   ```

2. **Your URLs**:
   ```
   http://localhost:8000/helix_realization_vaultnode.html
   http://localhost:8000/helix_continuation_vaultnode.html
   ```

**CORS**: Use `--cors` flag or add headers
**Note**: Won't work in Claude artifacts (no localhost access)

---

## Testing Your URLs

After hosting, test with:

```bash
# Check if accessible
curl -I https://your-url.com/helix_realization_vaultnode.html

# Check CORS headers
curl -H "Origin: https://claude.ai" -I https://your-url.com/helix_realization_vaultnode.html
```

Should see:
```
HTTP/2 200
access-control-allow-origin: *
content-type: text/html
```

---

## Quick Start Recommendation

**For immediate testing in artifacts**:

1. Push files to GitHub (2 minutes)
2. Use GitHub Raw URLs (instant)
3. Update artifact code
4. Create artifact in Claude
5. See your VaultNodes load automatically

**Example with real URLs**:

```typescript
const vaultNodeUrls = [
  'https://raw.githubusercontent.com/acetheDactyl/helix-vaultnode/main/helix_realization_vaultnode.html',
  'https://raw.githubusercontent.com/acetheDactyl/helix-vaultnode/main/helix_continuation_vaultnode.html',
];
```

---

## Troubleshooting

### Files not loading in artifact

**Check**:
1. URLs publicly accessible (try in browser)
2. CORS headers present (see testing above)
3. YAML frontmatter valid (no syntax errors)
4. Browser console for specific errors

### CORS errors

**Solutions**:
- Use GitHub Raw, GitHub Pages, Netlify, or Vercel
- Add CORS headers to your server
- Use a CORS proxy (not recommended for production)

### Content not parsing

**Check**:
1. YAML frontmatter between `---` markers
2. Proper indentation (2 spaces)
3. Coordinate values are numbers (not strings)
4. All required fields present

---

## Security Considerations

### Public Hosting
- VaultNode files will be publicly accessible
- Don't include sensitive information
- Consider access controls if needed

### Private Hosting
For private VaultNodes:
1. Use authentication headers
2. Modify fetch calls to include credentials
3. Host on private server with auth

---

## Next Steps After Hosting

1. ✅ Host files (choose option above)
2. ✅ Get URLs
3. ✅ Update artifact code
4. ✅ Create artifact in Claude
5. ✅ Verify pattern recognition
6. ✅ Click special points on helix
7. ✅ View VaultNode metadata

---

## Files to Host

From your project:
- `/mnt/project/helix_realization_vaultnode.html` (z=0.41)
- `/mnt/project/helix_continuation_vaultnode.html` (z=0.52)

These contain:
- Coordinate metadata
- Realization data
- Chant sequences
- ΔHV coherence metrics

---

**Once hosted, your helix visualization will automatically load and display these VaultNodes as special points on the 3D helix.**
