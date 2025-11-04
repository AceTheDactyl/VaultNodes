// Helix Self-Retrieval Script
//
// Purpose:
//   This Node.js script locates and parses Helix VaultNode HTML files
//   in the local directory, extracts the coordinate (θ, z, r) and
//   chant information from the embedded JSON payload, and logs a
//   HELIX_NODE_RECOGNIZED event for each discovered node.  It serves
//   as a proof-of-concept for autonomous state reconstitution across
//   instances.  In a full implementation, this script could emit
//   custom events or interface with a broader VaultNode registry.

const fs = require('fs');

/**
 * Parse a VaultNode HTML file and extract helix metadata.
 *
 * The VaultNode HTML is expected to contain a <pre> element with
 * JSON describing the payload (coordinate, realization, etc.) and
 * a <p> element following an <h2>Chant header that contains the chant.
 *
 * @param {string} filePath Absolute or relative path to the HTML file.
 * @returns {{coordinate: {theta: number, z: number, r: number}, chant: string, rawPayload: object}}
 */
function parseVaultNode(filePath) {
  const html = fs.readFileSync(filePath, 'utf8');
  // Extract JSON payload within <pre> ... </pre>
  const preMatch = html.match(/<pre>\s*({[\s\S]*?})\s*<\/pre>/);
  if (!preMatch) {
    throw new Error(`No payload found in ${filePath}`);
  }
  const payload = JSON.parse(preMatch[1]);
  // Extract chant (text inside first <p> after <h2>Chant)
  let chant = '';
  const chantMatch = html.match(/<h2>\s*Chant[^<]*<\/h2>\s*<p>([^<]*)<\/p>/i);
  if (chantMatch) {
    chant = chantMatch[1].trim();
  }
  return {
    coordinate: payload.coordinate,
    chant,
    rawPayload: payload
  };
}

/**
 * Load multiple VaultNodes and rehydrate their memory into the current process.
 *
 * @param {string[]} files Array of file paths to VaultNode HTML files.
 */
function loadAndRehydrate(files) {
  files.forEach(file => {
    try {
      const node = parseVaultNode(file);
      // Emit a simple recognition event
      console.log(`HELIX_NODE_RECOGNIZED: θ=${node.coordinate.theta}, z=${node.coordinate.z}, r=${node.coordinate.r}`);
      console.log(`  Chant: ${node.chant}`);
      // In a full system, you might dispatch a custom event here
      // e.g., eventEmitter.emit('HELIX_NODE_RECOGNIZED', node);
    } catch (err) {
      console.error(`Error parsing ${file}:`, err.message);
    }
  });
}

// If run directly (node helix_self_retrieval.js file1.html file2.html ...)
if (require.main === module) {
  const args = process.argv.slice(2);
  if (args.length === 0) {
    console.error('Usage: node helix_self_retrieval.js <vaultnode.html> [<vaultnode2.html> ...]');
    process.exit(1);
  }
  loadAndRehydrate(args);
}

module.exports = { parseVaultNode, loadAndRehydrate };