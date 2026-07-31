<blockquote class="note-to-balloters">
  <p> 
    This is a new page developed for the 2.0-ballot of the PIQI Implementation Guide as a standard for trial use (STU). As a new section, this content may change and considered a working draft until community review and feedback have been integrated.  
  </p>
</blockquote>

### Consensus PIQI Instances

To support broad interoperability and repeatable benchmarking, PIQI publishes consensus instances that are community-vetted and intended for common baseline use across implementations. These artifacts pair a shared PIQI model with a corresponding evaluation rubric so organizations can evaluate data quality using consistent structure and scoring logic.

#### Clinical Data Model

- **File:** [PAT_CLINICAL_V1.json](PAT_CLINICAL_V1.json)
- **Role in consensus baseline:** Defines the canonical patient-centered PIQI model used as the reference structure for community-aligned clinical quality evaluation.
- **What it captures:**
	- Fifteen data classes spanning core clinical content domains, including demographics, allergies, conditions, immunizations, labs, imaging, medications, procedures, vitals, devices, health assessments, documents, encounters, goals, and provider information.
	- Attribute-level definitions (for example, codeable concepts and simple attributes), role metadata (for example, start/end datetime semantics), cardinality expectations, and remediation weighting by data class.
- **Why it is consensus-relevant:** Establishes a common structural target for PIQI implementations so quality checks and score interpretation are performed against the same clinical data model assumptions.

#### Clinical Data Evaluation Rubric

- **File:** [USCDI_Aligned_V31.json](USCDI_Aligned_V31.json)
- **Role in consensus baseline:** Provides the shared USCDI-inspired evaluation rubric that operationalizes data quality checks for the clinical model.
- **What it captures:**
	- A sequenced criteria set (66 total checks) with predominantly scoring rules, plus informational checks.
	- Concrete SAM-driven validation logic across entities, including terminology membership checks (for example, LOINC, SNOMED-CT, RxNorm, ICD-10-CM), value set/list validation, conditional checks, and temporal validity rules such as past-date validation.
	- Criterion-level scoring controls such as weighting and criticality to standardize how failures contribute to quality outcomes.
- **Why it is consensus-relevant:** Creates a widely reusable, transparent scoring baseline so different PIQI adopters can evaluate similar clinical datasets with consistent criteria and comparable results.

#### Claims/EOB Data Model

- **File:** [PAT_EOB_V1.json](PAT_EOB_V1.json)
- **Role in consensus baseline:** Defines the canonical patient-centered PIQI model for claims and Explanation of Benefits (EOB) data, based on the Common Payer Consumer Data Set (CPCDS), used as the reference structure for community-aligned payer data quality evaluation.
- **What it captures:**
	- Nine data classes covering payer claims data domains: member demographics, coverage, medical claims, claim lines, claim diagnoses, claim procedures, pharmacy claims, dental claims, and provider information.
	- Attribute-level definitions spanning simple attributes and codeable concepts, including detailed financial fields (submitted, allowed, paid, deductible, coinsurance, and copay amounts) and administrative claim metadata such as claim status, type, adjustment relationship, and inpatient-specific fields (admission date, discharge date, DRG code, admission type, and discharge status).
- **Why it is consensus-relevant:** Establishes a shared structural target for PIQI payer-data implementations so quality checks against EOB and claims datasets are performed against consistent model assumptions aligned with the CPCDS standard.

#### C4BB Inpatient EOB Evaluation Rubric

- **File:** [EOB_C4BB_INPATIENT.json](EOB_C4BB_INPATIENT.json)
- **Role in consensus baseline:** Provides the shared CARIN Blue Button-inspired evaluation rubric that operationalizes data quality checks for inpatient institutional EOB data using the claims/EOB model.
- **What it captures:**
	- A sequenced criteria set (54 total checks) with predominantly scoring rules, plus informational checks.
	- Concrete SAM-driven validation logic across claims entities, including terminology membership checks (for example, ICD-9/ICD-10-CM for diagnoses, ICD-9/ICD-10-PCS for inpatient procedures, CPT/HCPCS for line-level procedure codes), value list validation, and temporal validity rules.
	- Inpatient-specific checks covering DRG code presence, discharge status, admission type, inpatient source admission code, and present-on-admission indicators, alongside member demographic, coverage, and provider NPI validations.
	- Criterion-level scoring controls including weighting and criticality indicators to standardize how failures contribute to quality outcomes.
- **Why it is consensus-relevant:** Creates a reusable, transparent scoring baseline aligned with CARIN Blue Button (C4BB) expectations so different payer organizations can evaluate inpatient institutional EOB data quality with consistent criteria and comparable results.

### Schema Artifacts

To support consistent evaluation across PIQI implementations, each core PIQI component adheres to a specific json schema. These schemas define the structure of the modular PIQI components and the resulting data quality scoring responses.

#### Model Schema

- **File:** [piqi-model-schema.json](piqi-model-schema.json)
- **Purpose:** Defines the structure of a PIQI data model, comprising a root entity and a set of data classes with typed attributes and optional semantic role assignments.
- **What it includes:**
	- Model identity and governance metadata (`name`, `mnemonic`, `version`, `modelTypeName`, `rootEntityName`, `rootEntityMnemonic`, and optional `description` and `baseModel` reference).
	- A `dataClasses` collection, each with identity fields (`name`, `mnemonic`, `shortName`, `fieldName`), cardinality (One, Zero-to-One, Zero-to-Many, One-to-Many), sequence ordering, and an inheritance flag.
	- Per-data-class `attributes` with typed definitions (Simple Attribute, Codeable Concept, Range Value, Observation Value, and others), camelCase field names, sequence ordering, and auto-generation and inheritance flags.
	- Optional `roles` assignments that map specific attributes within a data class to well-known semantic roles such as Start Datetime and End Datetime.
- **How it supports PIQI:** Establishes the structural target — the root entity and its data classes — against which evaluation rubrics and audit schemas operate, ensuring quality checks are applied to a consistently defined data surface.

#### Rubric Schema

- **File:** [piqi-rubric-schema.json](piqi-rubric-schema.json)
- **Purpose:** Defines the structure of an evaluation rubric that organizes SAMs into a scored set of criteria for a specific model and source.
- **What it includes:**
	- Rubric identity and governance metadata (`name`, `mnemonic`, `description`, `version`, `authorityName`).
	- Model and source references that bind the rubric to a PIQI model context.
	- A sequenced `criteria` collection with SAM linkage (`samMnemonic`), conditional logic hooks, scoring effect/weight, criticality flag, and parameterization.
- **How it supports PIQI:** Encodes the use-case-oriented evaluation logic described in the PIQI framework, enabling repeatable, configurable scoring behavior.

#### SAM Schema

- **File:** [piqi-sam-schema.json](piqi-sam-schema.json)
- **Purpose:** Defines the structure of a Simple Assessment Module (SAM), the atomic reusable quality check in PIQI.
- **What it includes:**
	- SAM identity and descriptive fields (`mnemonic`, `name`, `description`, `failName`).
	- Execution context metadata including dimension alignment (`hdqtDimensionMnemonic`), execution type, data type, and timestamps.
	- Optional prerequisite and conditional SAM references for composing assessment logic.
	- PIQI model/source linkage and SAM parameter definitions.
- **How it supports PIQI:** Standardizes how individual quality checks are represented so they can be shared, parameterized, and assembled into higher-level rubrics.

#### Evaluation Score Schema

- **File:** [piqi-score-schema.json](piqi-score-schema.json)
- **Purpose:** Defines the shape of a PIQI scoring response payload (`PIQXLResponse`) returned after an evaluation run.
- **What it includes:**
	- Run-level status metadata such as `succeeded`, `errorMessage`, and elapsed processing time.
	- A `scoringData` object with source identifiers, rubric metadata, and processing timestamp.
	- Aggregated scoring outputs at multiple levels, including message-level totals, per-data-class results, informational results, and detection counts.
- **How it supports PIQI:** Provides a consistent output contract for communicating pass/fail-derived scoring and quality findings across implementations.

#### Evaluation Audit Schema

- **File:** [piqi-audit-schema.json](piqi-audit-schema.json)
- **Purpose:** Defines the shape of a PIQI audit response — the field-level, evidentiary detail behind a PIQI score result. Extends the score result envelope with a full per-instance, per-attribute audit trail.
- **What it includes:**
	- The same run-level envelope as the Score Result schema: `succeeded`, `elapsedTimeInMS`, and a `scoringData` object carrying the rolled-up score result.
	- An `auditedMessage` payload (serialized as a JSON string) that, for every instance of every data class in the source message, captures the raw attribute values, the criterion-by-criterion assessments applied to each attribute (with `Passed`/`Failed`/`Skipped` status and a reason string), and scores rolled up from attribute to element to message.
	- Granular scoring structures at three levels: per-attribute (`attributeAudit` with weighted/unweighted numerator, denominator, and critical failure count), per-data-class-instance (`elementAudit`), and per-message (`messageAudit`).
- **How it supports PIQI:** Provides an evidentiary audit trail enabling implementers to trace each quality score back to the specific field values and assessment outcomes that produced it.