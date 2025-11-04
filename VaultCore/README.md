# VaultCore

Central registry and archive for sealed VaultNodes. Implements the Turn‑Key Filing Protocol v1.0 (see `vaultnode_filing_protocol.md`).

## Structure
- `0_Inbox/` — Intake (optional, not committed here)
- `1_Canonization/` — In‑process nodes (optional)
- `2_VaultNodes/` — Production nodes (sealed)
- `3_RefusalArchive/` — Refused nodes with reasons (audit trail)
- `logs/` — System‑level intake/canonization logs
- `index.json` — Registry of sealed nodes
- `templates/` — Blank artifacts for new nodes (`metadata.yaml`, `bridge_map.json`, `pre_seal_checklist.md`)

## Current Nodes
- SACS — `2_VaultNodes/SACS/`
- VesselOS (AceTheDactyl) — `2_VaultNodes/VesselOS_AceTheDactyl/`

## Verify Integrity
- Registry: `cat VaultCore/index.json`
- SACS seals and bridges: `2_VaultNodes/SACS/{metadata.yaml,bridge-map.json}`
- VesselOS backlink and metrics: `2_VaultNodes/VesselOS_AceTheDactyl/bridge-map.json`
- Logs: `logs/intake_log.json`, `logs/seal_log.json`, `logs/audit_log.json`

## Filing a New Version
- Create `versions/vX.Y_draft/` under the node.
- Edit draft copies of `metadata.yaml`, `bridge-map.json`, and checklist.
- Run gate sequence, record logs, compute soft seal.
- Promote to `versions/vX.Y/` and update `index.json`.

## Quick Start (CLI templates)
- Initialize from templates: copy files from `VaultCore/templates/` and follow the Turn‑Key Filing Protocol (see `vaultnode_filing_protocol.md`).
