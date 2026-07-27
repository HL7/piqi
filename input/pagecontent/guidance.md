This page provides implementation guidance for authors of PIQI Models, [Evaluation Rubrics](glossary.html#evaluation-rubric), and [Simple Assessment Modules (SAMs)](glossary.html#simple-assessment-module-sam), as well as for implementers deploying PIQI-based evaluation services. The guidance is organized into four areas: model design, Evaluation Rubric design, implementation architectures, and advanced SAM patterns.

### Model Design

#### Data Format Conventions

The PIQI [Simple Attribute](glossary.html#simple-attribute) type represents all scalar values — including dates, identifiers, and numeric strings — as plain strings. Because PIQI does not enforce strong typing in the model, implementers are responsible for establishing and documenting data format conventions for their deployment. Three areas require particular attention:

##### Date Formats

Date and datetime values are exchanged as Simple Attributes. The `Attr_IsValidDate` SAM validates these values by attempting to parse them as a DateTime; the set of accepted formats depends on the SAM's configuration and the underlying implementation. Rubric authors should define the expected date format(s) for each date attribute in the model and configure validation SAMs accordingly. Standardizing on ISO 8601 representations (e.g., `YYYYMMDD` or `YYYY-MM-DDThh:mm:ss`) is recommended to ensure consistent behavior across PIQI evaluation engines.

##### Null and Empty Values

The PIQI [Healthcare Data Quality Taxonomy (HDQT)](glossary.html#healthcare-data-quality-taxonomy-hdqt) distinguishes between two related but distinct availability conditions:

- **Unpopulated**: An [attribute](glossary.html#data-attribute) exists in the model but contains no value (empty string or null). Assessed via the `Availability.Unpopulated` dimension.
- **Missing**: An expected element is entirely absent from the [Data Class](glossary.html#data-class) collection. Assessed via the `Availability.Missing` dimension.

Implementations must define how null, empty string, and absent fields are represented in the PIQI payload before authoring rubrics that assess availability. An attribute transmitted as an empty string is treated as Unpopulated; an element that is entirely absent from the payload is treated as Missing. Conflating these two conditions leads to incorrect HDQT dimension assignment and inaccurate scoring.

##### Code System Representation Variants

A persistent challenge in healthcare interoperability is that the same code system may be referenced by different identifiers across source systems. For example, LOINC may appear as `LNC`, `LOINC`, `2.16.840.1.113883.6.40`, or `http://loinc.org` depending on the sending system and standard version. The PIQI framework addresses this through [Code System Identifiers](glossary.html#code-system-identifiers) — a set of known aliases defined for each code system in the PIQI implementation.

Rubric authors should review the Code System Identifiers configured in their PIQI instance and ensure that all representation variants expected from source systems are included. SAMs that assess coded concepts (e.g., `Concept_IsValid`, `Concept_IsActive`) rely on these aliases to normalize coding representations before evaluation. Missing aliases will cause valid codings to fail code system validation checks.

#### Mapping FHIR Choice Elements

FHIR defines many data elements as choice types (e.g., `onset[x]` may be represented as `onsetDateTime`, `onsetAge`, `onsetRange`, or `onsetPeriod`). When mapping FHIR resources to a PIQI [PIQI Model](glossary.html#piqi-model), implementers must design the model to accommodate all choice representations present in the source data.

The recommended approach is:

1. Identify all choice representations used by the source system(s) for each element of interest.
2. Define distinct PIQI attributes to capture each relevant representation (e.g., `onsetDateTime` as a Simple Attribute, `onsetAgeValue` and `onsetAgeUnit` as Simple Attributes).
3. Ensure that the transformation layer populating the PIQI payload correctly maps each FHIR choice representation to its corresponding PIQI attribute.
4. Author SAMs that account for which representation is present. Conditional SAMs are well suited to this pattern: a conditional SAM checks whether a specific attribute is populated before a type-specific evaluation SAM is executed, preventing spurious failures when a choice element is expressed in a different form.

Failure to account for all choice representations in both the model and the rubric is a common source of false positives in PIQI evaluations.

#### Handling Polymorphic and Heterogeneous Data

FHIR Observations illustrate a recurring interoperability challenge: a single resource type can represent structurally different categories of data — laboratory results, vital signs, clinical assessments, survey responses, and others. PIQI quality assessment depends on applying the right evaluations to the right kind of data, which requires a strategy for distinguishing data categories at the model level.

Two patterns are recommended:

**Type-based separation** is the preferred approach when data categories have distinct attribute structures and quality criteria. Map each logical category of data to a separate PIQI Data Class. The PIQI Clinical Data Model already implements this pattern: `LabResult`, `VitalSign`, and `HealthAssessment` are distinct Data Classes, each with attributes tailored to its content. Rubrics that target a specific Data Class can then apply type-appropriate SAMs without conditional logic.

**Conditional evaluation** is appropriate when full separation is not practical. In this pattern, a single Data Class holds all variants of the polymorphic data, and conditional SAMs within the Evaluation Rubric gate type-specific evaluations. A conditional SAM inspects a type-identifying attribute (such as a LOINC observation category code) and, if the condition passes, allows the associated evaluation SAM to run. If the data is of a different type, the evaluation is skipped without affecting the rubric score. This keeps the rubric applicable to a heterogeneous collection while ensuring that evaluations are applied only to the appropriate data.

---

### Evaluation Rubric Design

#### Cross-Data-Class Evaluation

Each Evaluation Criterion in an Evaluation Rubric independently assesses a single model entity — an [attribute](glossary.html#data-attribute), element, [Data Class](glossary.html#data-class), or [Patient Container](glossary.html#patient-container). Clinical data quality, however, often requires evaluating relationships across multiple Data Classes simultaneously. The PIQI framework supports this through **Patient-level SAMs**: SAMs with an input type of `Patient`, which receive the complete patient payload and can traverse any Data Class within it.

Cross-data-class evaluations should be modeled as Patient-level criteria in the Evaluation Rubric, with the Criterion Entity set to `Patient`. The underlying Patient-level SAM implements the multi-class logic.

**Example 1: Medication and Patient Education Coherence**

An Evaluation Rubric may include a criterion that assesses whether appropriate patient education was provided for a specific medication. A Patient-level SAM implementing this criterion would:

1. Search the `Medication` Data Class for the target medication code.
2. If the medication is present, verify that a corresponding patient education record exists in the appropriate Data Class.
3. Return `pass` if the education record is found, `fail` if the medication is present but the education record is absent, or `skip` if the medication is not present (precondition not met).

The `skip` result in step 3 can also be implemented using a conditional SAM: configure a medication presence check as the conditional SAM, so that the education verification SAM is only evaluated when the condition passes.

**Example 2: Multi-Attribute Plausibility within a Lab Result**

Plausibility checks that span multiple attributes of a single element — for example, verifying that a LabResult's LOINC code, specimen type, and reference range are mutually consistent — are implemented as element-level SAMs (input type `Element`). The SAM receives a single LabResult element and evaluates the relationships among its attributes. This is a cross-attribute evaluation scoped within a Data Class, distinct from cross-Data-Class evaluation, but follows the same principle of using the broadest-scope input type needed to access all relevant data.

These element-level plausibility SAMs are assigned to the `Plausibility` category in the HDQT and are a primary mechanism for detecting contextually implausible combinations that would not be caught by single-attribute validation.

---

### PIQI Implementation Architectures

PIQI evaluation services can be deployed in two primary patterns depending on latency requirements, data volume, and downstream processing needs.

#### Bulk Data Profiling

Bulk profiling is the most common pattern for population-level data quality assessment. In this architecture, PIQI evaluates large collections of patient records asynchronously, producing aggregate statistics used for data governance, trend analysis, and root cause investigation.

Key design considerations for bulk profiling:

- **Patient-level serialization**: Serialize one complete patient record per PIQI payload to ensure that each evaluation operates on a coherent, self-contained representation of the patient's data. Mixing records across patients in a single payload is not recommended.
- **Asynchronous processing**: Results are produced asynchronously and do not block upstream data workflows. Design the aggregation layer to consume evaluation results as they become available.
- **Aggregate output**: Rubric scores from individual patient evaluations are aggregated to compute population-level statistics (pass rates, average scores, failure distributions by criterion). These statistics are the primary output of the profiling use case.
- **Rubric scope**: Bulk profiling rubrics can be comprehensive, as throughput is less constrained than in real-time gating scenarios.

#### Real-Time Data Gating

Real-time data gating uses PIQI to evaluate individual patient records as they are ingested, conditioning downstream processing on the result of the quality evaluation.

Key design considerations for real-time gating:

- **Asynchronous with queue monitoring**: Evaluation is asynchronous from the receiver's perspective. The receiving system submits the patient payload to the PIQI evaluation service and monitors a result queue; processing advances only after a score is available. This decouples the evaluation latency from the critical path of data ingestion.
- **Batch scoring for performance**: Submitting multiple payloads for evaluation simultaneously, rather than one at a time, substantially improves throughput. Design the submission layer to batch messages before sending to the evaluation endpoint.
- **Exclude predictable failures**: Criteria that universally fail for a given data source (e.g., a field that the sending system never populates) add scoring overhead without producing actionable information. Identify and exclude such criteria from real-time rubrics, or configure them as informational rather than scoring criteria, to reduce unnecessary processing.
- **Inbound filtering**: Not all inbound data may warrant the same level of evaluation. Consider filtering the inbound stream to route specific subsets of messages (e.g., records from identified low-quality sources, records for high-risk patients, or records associated with a particular use case) to higher-intensity rubrics, while applying a lighter rubric to the general population. This preserves throughput while focusing quality scrutiny where it is most needed.

---

### CQL-Based SAMs

Clinical Quality Language (CQL) is a standards-based expression language defined by HL7 for clinical logic. The PIQI team assessed CQL as an execution pattern for SAMs requiring complex clinical logic, validating the approach against open-source CQL engines.

A CQL SAM is a SAM with an execution type of `RESTful_Service` or `Stored_Procedure` whose underlying logic is implemented in CQL. The SAM accepts a CQL library reference as a parameter (using the `Content_Asset_Mnemonic` parameter type) and executes the referenced CQL library against the patient payload, returning a pass, fail, or skip result consistent with the standard SAM interface.

This pattern is particularly well-suited for:

- SAMs that require complex multi-criterion clinical logic that cannot be expressed through the standard primitive logic or value set execution types.
- Assessments that reuse existing CQL expression libraries, such as those already developed for electronic Clinical Quality Measures (eCQMs), allowing PIQI rubrics to leverage established, validated clinical logic.
- Deployments operating in environments that maintain CQL-enabled terminology services or clinical reasoning engines (such as those aligned with the Tinkar specification for standardized terminology knowledgebases).

Implementers considering CQL-based SAMs should account for the following:

- The CQL execution service must expose an endpoint that conforms to the SAM RESTful service interface for the input type being assessed.
- The CQL library's data model must be compatible with or mappable from the PIQI payload structure for the relevant Data Class or Patient Container.
- CQL library versioning should be managed as part of the PIQI [SAM Library](glossary.html#sam-library), with the library mnemonic referenced in the SAM's `Content_Asset_Mnemonic` parameter serving as the stable identifier for a given version of the logic.
