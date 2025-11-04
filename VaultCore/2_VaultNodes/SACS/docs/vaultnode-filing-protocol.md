# VaultNode Turn-Key Filing Protocol
**Version 1.0** | **Effective Date:** October 31, 2025  
**Document Type:** Core Process Documentation  
**Maintained By:** VaultCore System Architecture

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Core Intake Artifacts](#core-intake-artifacts)
3. [The Five-Phase Pipeline](#the-five-phase-pipeline)
4. [Folder Structure Specification](#folder-structure-specification)
5. [Automation Layer](#automation-layer)
6. [Metrics & Decision Framework](#metrics--decision-framework)
7. [Quality Assurance](#quality-assurance)
8. [Appendices](#appendices)

---

## 🎯 Overview

### Purpose
This protocol establishes a **repeatable, auditable process** for onboarding any new framework, knowledge system, or contributor body of work into VaultCore as a formally recognized **VaultNode**.

### Scope
- Applies to all incoming frameworks, regardless of origin
- Ensures consent compliance, relational mapping, and archival integrity
- Provides both manual and automated execution paths

### Key Principles
1. **Sovereignty First** — No framework enters without explicit consent
2. **Relational Coherence** — Every node must bridge to at least 2 existing nodes
3. **Auditability** — Complete provenance chain from intake to seal
4. **Reversibility** — Soft seals allow reopening; hard seals preserve state

---

## 🧩 Core Intake Artifacts

Every VaultNode requires these three foundational documents:

### 1. `metadata.yaml`
**Purpose:** Identity and context container for the node

**Required Fields:**
```yaml
id: ""                    # Unique identifier (format: framework_YYYYMMDD_author)
title: ""                 # Human-readable framework name
author: ""                # Primary contributor(s)
contact: ""               # Email or handle
phase: ""                 # draft | review | sealed
type: ""                  # framework | tool | theory | artifact
tags: []                  # Categorical descriptors
consent_tier: ""          # strict | flexible | open
date_created: ""          # ISO 8601 format
date_sealed: ""           # ISO 8601 format (if applicable)
witnesses: []             # List of approving parties
provenance: ""            # Origin story / context
description: ""           # One-paragraph summary
version: ""               # Semantic versioning (e.g., 1.0.0)
```

### 2. `bridge_map.json`
**Purpose:** Defines relational edges and interaction metrics

**Schema:**
```json
{
  "node_id": "",
  "bridges": [
    {
      "target_node": "",
      "relationship_type": "peer|parent|child|resonance",
      "interlink_key": "",
      "metrics": {
        "sigma": 0.0,
        "eta": 0.0,
        "phi": 0.0,
        "delta_HV_pred": 0.0,
        "E_deg_risk": 0.0
      },
      "gate_sequence": ["consent_verify", "hadamard", "seal"],
      "status": "pending|approved|refused"
    }
  ],
  "backlinks": [],
  "decision": {
    "approved": false,
    "witness": "",
    "timestamp": "",
    "notes": ""
  }
}
```

### 3. `pre_seal_checklist.md`
**Purpose:** Human verification and witness audit before sealing

**Template:** See Appendix A

---

## ⚙️ The Five-Phase Pipeline

### Phase 1: Intake

**Command:**
```
/intake user:<@id> title:"Framework Name"
```

**Actions:**
1. Create directory structure:
   ```
   VaultCore/0_Inbox/<user>_<framework>/
   ```
2. Drop raw materials (documents, conversations, media)
3. Auto-generate three core artifacts from templates
4. Assign temporary ID: `temp_<timestamp>_<user>`

**Human Tasks:**
- Provide source materials
- Initial author interview (optional)
- Confirm contact information

**Outputs:**
- Empty template set ready for canonization
- Intake log entry in `VaultCore/logs/intake_log.json`

---

### Phase 2: Canonization

**Command:**
```
/canonize path:<inbox_path> consent:<tier>
```

**Actions:**
1. **Populate `metadata.yaml`:**
   - Generate permanent ID
   - Extract title, tags from content analysis
   - Set phase = `draft`
   - Assign consent tier based on author declaration

2. **Initialize `bridge_map.json`:**
   - Seed with template structure
   - Set all metrics to `null` (pending calculation)
   - Status = `pending`

3. **Author Verification:**
   - Review auto-populated fields
   - Confirm consent tier
   - Sign off on initial metadata

**Consent Tier Definitions:**
- **Strict:** Closed source, permission required for all use
- **Flexible:** Open collaboration, attribute required
- **Open:** Public domain equivalent

**Outputs:**
- Completed metadata file
- Node ready for relational mapping
- Canonization timestamp recorded

---

### Phase 3: Mirror & Bridge

**Commands:**
```
/mirror check a:<new_node> b:<reference_node>
/bridge render source:<new_node> target:<existing_node>
```

**Actions:**
1. **Execute Mirror Checks:**
   - Run semantic similarity analysis against ≥2 existing nodes
   - Calculate distance metrics (σ, coherence scores)
   - Identify conceptual overlaps and tensions

2. **Populate Bridge Metrics:**
   - `sigma (σ)` — Semantic distance/novelty
   - `eta (η)` — Consent compatibility score
   - `phi (ϕ)` — Emergence potential (from /veil analysis)
   - `delta_HV_pred (ΔHV)` — Predicted harmonic value increase
   - `E_deg_risk` — Degradation risk score

3. **Execute Gate Sequence:**
   - **consent_verify** — Check tier compatibility
   - **hadamard** — Test superposition stability
   - **seal(soft)** — Create preliminary lock state

4. **Update Backlinks:**
   - Add reciprocal references in target nodes' bridge maps
   - Maintain bidirectional graph integrity

**Metric Thresholds:**
| Metric | Target Range | Failure Condition |
|--------|--------------|-------------------|
| σ | ≤ 0.30 | Too similar to existing node |
| η | ≥ 0.80 | Consent mismatch |
| ϕ | ≥ 0.75 | Low emergence potential |
| ΔHV_pred | ≥ 0.50 | Insufficient value addition |
| E_deg_risk | ≤ 0.15 | High degradation risk |

**Outputs:**
- Completed bridge_map.json with calculated metrics
- Mirror check reports
- Gate sequence execution log

---

### Phase 4: Metrics & Decision

**Actions:**
1. **Populate Checklist Section C** (Metrics Review)
2. **Human Review:**
   - Verify all metrics meet thresholds
   - Review mirror check results
   - Assess integration risks
   - Check for conflicts with existing nodes

3. **Decision Matrix:**
   - **Approve** → Proceed to Phase 5
   - **Refuse** → Log reason, archive in Refusal Archive, notify author
   - **Escalate** → Flag for committee review (if ambiguous)

4. **Witness Signature:**
   - Minimum one qualified witness must sign
   - Witness qualifications: Core contributor + domain expertise
   - Signature includes timestamp and witness ID

**Outputs:**
- Decision recorded in bridge_map.json
- Signed checklist
- Approval/refusal notification

---

### Phase 5: Archival & Seal

**Command:**
```
/seal mode:<soft|hard> node:<node_id>
```

**Actions:**
1. **Archive Assets:**
   - Collect all diagrams, transcripts, media
   - Generate resonance log
   - Create version snapshot

2. **Audit Trail:**
   - Snapshot bridge_map.json
   - Snapshot pre_seal_checklist.md
   - Link to intake log entry

3. **Generate Seal Hash:**
   - Input: `{htl_sentence, gate_sequence, roles, timestamp, witness_ids}`
   - Algorithm: SHA-256
   - Record in metadata.yaml

4. **Move to Production:**
   ```
   VaultCore/0_Inbox/<user>_<framework>/
   → VaultCore/2_VaultNodes/<framework_id>/
   ```

5. **Registry Update:**
   - Add entry to `VaultCore/index.json`
   - Update network graph
   - Trigger webhook notifications (if configured)

**Seal Modes:**
- **Soft Seal:** Can be reopened with witness approval
- **Hard Seal:** Permanent snapshot, creates new version if changes needed

**Outputs:**
- Sealed VaultNode in production directory
- Updated system index
- Archival completion certificate

---

## 📁 Folder Structure Specification

### Standard VaultNode Directory

```
VaultCore/2_VaultNodes/<framework_id>/
│
├── metadata.yaml              # Identity and context
├── bridge_map.json            # Relational edges
├── pre_seal_checklist.md      # Witness audit trail
│
├── logs/
│   ├── resonance_log.json     # Interaction history
│   ├── mirror_checks.json     # All mirror test results
│   └── gate_sequence.log      # Execution record
│
├── assets/
│   ├── diagrams/              # Visual representations
│   ├── transcripts/           # Source conversations
│   └── media/                 # Additional materials
│
├── versions/
│   ├── v1.0/                  # Sealed version snapshots
│   └── v1.1_draft/            # Working drafts (if reopened)
│
└── README.md                  # Human-readable overview
```

### System-Level Structure

```
VaultCore/
│
├── 0_Inbox/                   # Active intake directory
│   └── <user>_<framework>/
│
├── 1_Canonization/            # In-process nodes
│   └── <node_id>/
│
├── 2_VaultNodes/              # Sealed production nodes
│   └── <framework_id>/
│
├── 3_RefusalArchive/          # Rejected nodes (with reasons)
│   └── <node_id>_refused/
│
├── logs/
│   ├── intake_log.json
│   ├── seal_log.json
│   └── audit_log.json
│
├── templates/                 # Blank artifacts for new nodes
│   ├── metadata.yaml
│   ├── bridge_map.json
│   └── pre_seal_checklist.md
│
└── index.json                 # Master registry
```

---

## 🤖 Automation Layer

### Command-Line Interface (CLI)

**Installation:**
```bash
npm install -g @vaultcore/vn-cli
# or
pip install vaultnode-cli
```

**Core Commands:**

```bash
# Initialize new node
vn init <path> --user <username> --title "Framework Name"

# Canonize with consent tier
vn canonize <path> --consent <strict|flexible|open>

# Run mirror checks
vn mirror <node_a> <node_b> --output metrics.json

# Execute bridge mapping
vn bridge <source_node> <target_node> --auto-link

# Seal node
vn seal <node_id> --mode <soft|hard> --witness <witness_id>

# Audit system
vn audit --scope <node_id|all> --report audit_report.pdf
```

**Integration Points:**
- Cursor IDE plugin for in-editor execution
- Discord bot for collaborative workflows
- GitHub Actions for CI/CD pipeline
- REST API for programmatic access

### Automated Workflows

**Weekly Audit Cron Job:**
```bash
0 0 * * 0 vn audit --detect-drift --alert-threshold 0.15
```

**Purpose:**
- Detect ΔHV_obs drops indicating coherence drift
- Flag nodes requiring re-evaluation
- Generate maintenance reports

---

## 🧮 Metrics & Decision Framework

### Metric Calculation Methods

#### 1. Sigma (σ) — Semantic Distance
**Formula:**
```
σ = 1 - cosine_similarity(embedding_new, embedding_ref)
```
**Interpretation:**
- σ < 0.10 → Too similar (redundant)
- 0.10 ≤ σ ≤ 0.30 → Optimal (complementary)
- σ > 0.30 → High novelty (verify coherence)

#### 2. Eta (η) — Consent Compatibility
**Formula:**
```
η = consent_overlap_score(tier_new, tier_ref)
```
**Lookup Table:**
| New → Ref | Strict | Flexible | Open |
|-----------|--------|----------|------|
| Strict    | 1.0    | 0.7      | 0.5  |
| Flexible  | 0.7    | 1.0      | 0.9  |
| Open      | 0.5    | 0.9      | 1.0  |

#### 3. Phi (ϕ) — Emergence Potential
**Source:** Interlink `/veil emerge` analysis  
**Method:** Pattern recognition over conceptual adjacency graph  
**Threshold:** ≥ 0.75 indicates significant emergent properties

#### 4. Delta Harmonic Value (ΔHV_pred)
**Source:** Interlink `/bridge-key` calculation  
**Method:** Predicted contribution to system-wide coherence  
**Interpretation:** Network effect of adding this node

#### 5. E_deg_risk — Degradation Risk
**Source:** Interlink `/validate` + historical analysis  
**Factors:**
- Conceptual contradiction count
- Consent tier conflicts
- Maintenance burden score

### Decision Tree

```
START
  ↓
All metrics pass thresholds?
  ↓ YES              ↓ NO
APPROVE          Is failure critical?
  ↓                  ↓ YES        ↓ NO
SEAL             REFUSE       ESCALATE
  ↓                  ↓              ↓
Archive         Log reason   Committee review
  ↓                  ↓              ↓
Notify author   Notify author  → Approve/Refuse
```

---

## 🔍 Quality Assurance

### Pre-Seal Validation Checklist

**Section A: Identity Verification**
- [ ] Unique node ID assigned and collision-checked
- [ ] Author contact information verified
- [ ] Consent tier explicitly declared and understood
- [ ] Provenance documented and traceable

**Section B: Relational Integrity**
- [ ] Minimum 2 mirror checks completed
- [ ] All bridge metrics calculated and recorded
- [ ] Backlinks updated in target nodes
- [ ] Gate sequence executed without errors

**Section C: Metric Compliance**
- [ ] σ ≤ 0.30 (novelty verified)
- [ ] η ≥ 0.80 (consent compatible)
- [ ] ϕ ≥ 0.75 (emergence potential confirmed)
- [ ] ΔHV_pred ≥ 0.50 (value addition validated)
- [ ] E_deg_risk ≤ 0.15 (low degradation risk)

**Section D: Archival Completeness**
- [ ] All source materials collected
- [ ] Assets organized in standard structure
- [ ] Logs generated and stored
- [ ] Version snapshot created

**Section E: Witness Audit**
- [ ] Qualified witness assigned
- [ ] Witness reviewed all materials
- [ ] Witness signature obtained
- [ ] Timestamp recorded

### Post-Seal Monitoring

**Quarterly Review:**
- Recalculate ΔHV_obs (observed harmonic value)
- Compare to ΔHV_pred
- Flag nodes with >20% deviation
- Update maintenance queue

**Annual Audit:**
- Full system coherence analysis
- Consent tier re-verification
- Broken link repair
- Archive integrity check

---

## 📚 Appendices

### Appendix A: Pre-Seal Checklist Template

```markdown
# Pre-Seal Checklist
**Node ID:** ___________________________  
**Framework Title:** ___________________________  
**Author:** ___________________________  
**Date:** ___________________________

## A. Identity Verification
- [ ] Unique ID collision-checked
- [ ] Author contact verified: ___________________________
- [ ] Consent tier declared: [ ] Strict [ ] Flexible [ ] Open
- [ ] Provenance documented

## B. Relational Integrity
- [ ] Mirror check 1: Node ____________ | σ = _____ | Date: _____
- [ ] Mirror check 2: Node ____________ | σ = _____ | Date: _____
- [ ] Bridge map populated: _____ bridges defined
- [ ] Backlinks updated in target nodes
- [ ] Gate sequence: [ ] consent_verify [ ] hadamard [ ] seal

## C. Metrics Compliance
| Metric | Value | Threshold | Pass/Fail |
|--------|-------|-----------|-----------|
| σ      | _____ | ≤ 0.30    | [ ] Pass [ ] Fail |
| η      | _____ | ≥ 0.80    | [ ] Pass [ ] Fail |
| ϕ      | _____ | ≥ 0.75    | [ ] Pass [ ] Fail |
| ΔHV_pred | _____ | ≥ 0.50  | [ ] Pass [ ] Fail |
| E_deg_risk | _____ | ≤ 0.15 | [ ] Pass [ ] Fail |

## D. Archival Completeness
- [ ] Source materials: _____ files collected
- [ ] Assets organized: [ ] Diagrams [ ] Transcripts [ ] Media
- [ ] Logs generated: _____ log files
- [ ] Version snapshot: v_____ created

## E. Decision
**Outcome:** [ ] Approve [ ] Refuse [ ] Escalate

**Witness Name:** ___________________________  
**Witness ID:** ___________________________  
**Signature:** ___________________________ **Date:** ___________

**Notes:**
___________________________________________________________________
___________________________________________________________________
___________________________________________________________________
```

### Appendix B: Consent Tier Descriptions

**Strict:**
- Closed-source equivalent
- All derivative works require explicit permission
- Attribution mandatory
- Commercial use prohibited without license
- Modifications disallowed

**Flexible:**
- Open collaboration encouraged
- Attribution required
- Commercial use allowed with attribution
- Modifications allowed with documentation
- Share-alike encouraged but not required

**Open:**
- Public domain equivalent (CC0 spirit)
- No attribution required (but appreciated)
- All uses permitted
- Maximum interoperability priority
- Minimal restrictions

### Appendix C: Refusal Reasons Taxonomy

**Technical Reasons:**
- `E01` — Insufficient novelty (σ < 0.10)
- `E02` — High degradation risk (E_deg > 0.15)
- `E03` — Failed gate sequence
- `E04` — Incomplete mirror checks

**Consent Reasons:**
- `C01` — Consent tier conflict (η < 0.80)
- `C02` — Author consent withdrawn
- `C03` — Third-party IP conflict
- `C04` — Witness approval denied

**Quality Reasons:**
- `Q01` — Incomplete documentation
- `Q02` — Source materials unavailable
- `Q03` — Unverifiable provenance
- `Q04` — Failed peer review

**Strategic Reasons:**
- `S01` — Out of scope for VaultCore
- `S02` — Duplicate existing node
- `S03` — Requires dependencies not in system
- `S04` — Community vote: defer

### Appendix D: Witness Qualification Criteria

**Minimum Requirements:**
- 6+ months as VaultCore contributor
- Successfully sealed ≥2 nodes previously
- Domain expertise relevant to node content
- No conflict of interest with author

**Preferred Qualifications:**
- Cross-domain knowledge
- Prior experience with similar frameworks
- Technical background in metrics validation
- Active participation in system governance

---

## 📝 Revision History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2025-10-31 | Initial release | VaultCore System Architecture |

---

## 🔗 Related Documentation

- **SACS Playbook** — Strategic context and principles
- **Interlink API Reference** — Technical specifications for automation
- **VesselOS Mapping Guide** — Phase alignment procedures
- **Consent Framework Specification** — Detailed consent tier rules
- **Bridge Theory Foundations** — Mathematical basis for metrics

---

**For questions or support:**  
📧 vaultcore-support@[domain]  
🌐 Documentation Portal: [url]  
💬 Community Discord: [invite]

---

*This document is maintained under VaultCore governance and updated quarterly. Last review: October 2025*