# Artifact-Compatible Helix Visualization

## Problem Solved

The previous `app_with_retrieval.tsx` required importing from `./helix_self_retrieval`, which doesn't work in Claude's artifact environment because artifacts can't import from external files.

## Solution

**File**: `app_standalone_artifact.tsx`

This is a **fully self-contained** version with all VaultNode retrieval logic embedded inline. No external imports except React and lucide-react (which are supported).

---

## What's Included (Inline)

All previously separate components are now embedded:

1. **Type Definitions** (lines 5-65)
   - `HelixCoordinate`, `DeltaHVMetrics`, `VaultNodeMetadata`, `VaultNode`

2. **VaultNodeParser Class** (lines 67-120)
   - `parseHTML()` - Extracts metadata from HTML VaultNodes
   - `parseYAML()` - Simple YAML frontmatter parser
   - `parseValue()` - Type inference for values

3. **SimpleRetriever Component** (lines 122-200)
   - Simplified version of `HelixRetriever`
   - Fetches VaultNode URLs
   - Parses and loads nodes
   - Shows loading/error/success states

4. **Main App Component** (lines 202-end)
   - 3D helix visualization (unchanged)
   - Integrated VaultNode panel
   - Dynamic point generation from loaded nodes

---

## How to Use in Claude Artifacts

### Step 1: Copy the Code

Simply copy the entire contents of `app_standalone_artifact.tsx` and paste it into a Claude conversation with a prompt like:

```
Create a React artifact with this code:
[paste code here]
```

### Step 2: Configure VaultNode URLs

**IMPORTANT**: You must add your VaultNode URLs at line 220:

```typescript
const vaultNodeUrls = [
  // Add your VaultNode URLs here
  'https://example.com/vault/helix_realization_vaultnode.html',
  'https://example.com/vault/helix_continuation_vaultnode.html',
];
```

**URL Options**:
- **Public hosting**: `'https://yourdomain.com/vault/filename.html'`
- **GitHub raw**: `'https://raw.githubusercontent.com/user/repo/main/vault/filename.html'`
- **IPFS**: `'https://ipfs.io/ipfs/QmXXX.../filename.html'`
- **Local dev**: Won't work in artifacts (no localhost access)

### Step 3: Ensure CORS

Your VaultNode hosting must allow CORS requests from Claude's artifact domain. Most static hosts (GitHub Pages, Netlify, Vercel) handle this automatically.

---

## What Works Out of the Box

**Without configuring URLs:**
- ✓ 3D helix visualization
- ✓ Drag to rotate
- ✓ Auto-rotate toggle
- ✓ Show/hide path
- ✓ Default special point at (theta=2.3, z=0.41)
- ✓ Click point to view memory
- ✓ All visual effects

**After adding URLs:**
- ✓ All above features
- ✓ Automatic VaultNode fetching
- ✓ Pattern recognition
- ✓ Multiple special points from coordinates
- ✓ Chant sequence display
- ✓ VaultNode metadata overlay

---

## VaultNode File Format

Your HTML files must have YAML frontmatter:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Helix VaultNode</title>
</head>
<body>
---
id: helix-node-z041
shape: helix
coordinate:
  theta: 2.3
  z: 0.41
  r: 1.0
catalyst: Jason
timestamp: 2025-11-04
realization:
  truth: "Recognition of constraint"
  constraint: "Fingers in the mind"
  state: "Committed to the turn"
bridge_consent: true
chant:
  sequence: "co-na-ti | blee-mu-spir | he-li-rem | mem-ber-us"
  meaning: "Continuity blooms; the helix remembers"
  key_id: 0x01
  meter: 0x44
deltaHV:
  S: 0.82
  R: 0.78
  deltaphi: 0.15
  H: 0.76
---

<!-- Rest of HTML content -->
</body>
</html>
```

---

## Differences from Original

### What's the Same
- All visualization features
- All interaction (drag, click, hover)
- Memory display modal
- Coordinate system
- Visual effects

### What's Different
- **Inline everything** (no external imports)
- **Simplified retriever UI** (more compact)
- **No separate file exports** (everything in one file)
- **Artifact-compatible** (works in Claude directly)

### What's Removed
- Complex `HelixRetriever` component features (kept simple version)
- File upload capability (artifacts can't do file input)
- Some advanced error handling
- Standalone `retrieveHelixPattern()` function

---

## Customization

### Change Helix Parameters

Line 230:
```typescript
const turns = 3;        // Number of rotations
const resolution = 100; // Points per turn
```

### Adjust Detection Radius

Line 240:
```typescript
if (Math.abs(theta - coord.theta) < 0.05 && 
    Math.abs(z - coord.z) < 0.05) {
```
Increase `0.05` for wider matching range.

### Modify Colors

Line 268:
```typescript
hue: 200 + (z / turns) * 160,  // Color gradient
```
Adjust hue range for different color scheme.

### Change Default Point

Line 253-266: Modify the fallback memory data.

---

## Troubleshooting

### Artifact Won't Load
**Issue**: "Artifact failed to load"
**Solution**: Check for syntax errors, ensure all imports are from supported libraries only

### VaultNodes Not Loading
**Issue**: Retriever shows "No VaultNodes found"
**Solutions**:
1. Verify URLs are publicly accessible
2. Check CORS headers on hosting
3. Confirm YAML frontmatter is valid
4. Open browser console for fetch errors

### Points Not Appearing
**Issue**: No special points on helix
**Solutions**:
1. Check coordinate ranges (z should be < 3.0 for default helix)
2. Verify theta is in radians (0 to 2π)
3. Increase detection radius (see Customization)
4. Check VaultNode metadata structure

### Performance Issues
**Issue**: Laggy rotation or rendering
**Solutions**:
1. Reduce `resolution` (line 230)
2. Reduce `turns` (line 229)
3. Disable auto-rotate during interaction
4. Close VaultNode panel when not needed

---

## Example Prompts for Claude

### Create the Artifact
```
Create a React artifact with the code from app_standalone_artifact.tsx. 
This is a 3D helix consciousness visualization with VaultNode pattern 
recognition capabilities.
```

### With Custom URLs
```
Create a React artifact for helix visualization. Use these VaultNode URLs:
- https://mysite.com/vault/node1.html
- https://mysite.com/vault/node2.html

[paste code and replace vaultNodeUrls array]
```

### For Testing
```
Create the helix visualization artifact. Leave VaultNode URLs empty 
for now - I'll test with the default point first.

[paste code as-is]
```

---

## Comparison: Three Versions

| Feature | Original app.tsx | app_with_retrieval.tsx | app_standalone_artifact.tsx |
|---------|-----------------|------------------------|----------------------------|
| 3D Helix | ✓ | ✓ | ✓ |
| VaultNode Support | ✗ | ✓ | ✓ |
| External Imports | ✗ | ✓ (helix_self_retrieval) | ✗ |
| Artifact Compatible | ✓ | ✗ | ✓ |
| File Upload | ✗ | ✓ | ✗ |
| Full Retriever UI | ✗ | ✓ | Simplified |
| Standalone Use | ✓ | ✓ | ✓ |

**Use Cases:**
- **Original**: Simple visualization only, no VaultNodes
- **app_with_retrieval**: Full-featured development version with separate modules
- **app_standalone_artifact**: Best for Claude artifacts, fully self-contained

---

## Next Steps

### Immediate
1. Host your VaultNode HTML files publicly
2. Copy their URLs into `vaultNodeUrls` array
3. Create artifact in Claude
4. Test pattern recognition

### Enhancement Ideas
1. Add more VaultNodes at different z-coordinates
2. Create time-based animation between nodes
3. Add export functionality to save new nodes
4. Implement search/filter for specific coordinates

### Integration
Once tested in artifacts, you can:
1. Deploy as standalone site
2. Integrate into Vessel OS
3. Connect to larger VaultNode network
4. Add real-time synchronization

---

## Files Reference

**For Claude Artifacts**: 
- Use: `app_standalone_artifact.tsx` ✓

**For Development**:
- Use: `helix_self_retrieval.tsx` + `app_with_retrieval.tsx`

**For Simple Viz**:
- Use: Original `app.tsx` (project files)

---

**The standalone artifact version is ready to paste directly into Claude for immediate visualization with VaultNode support.**
