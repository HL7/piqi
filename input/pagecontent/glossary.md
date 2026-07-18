### Glossary of PIQI Framework Terms

### Data Class

A domain-specific, named collection of typed attributes representing a category of patient health information. Within a PIQI payload, a Data Class contains a collection of **Elements** (individual instances of that class). The PIQI Clinical Data Model defines ten standard Data Classes: Allergy, Condition, Demographics, HealthAssessment, Immunization, LabResult, MedicalDevice, Medication, Procedure, and VitalSign. Data Classes can be added to a [PIQI Model](#piqi-model) to localize it for a specific use case.

### Data Attribute

A single typed data field belonging to an Element. Each attribute in the PIQI Framework uses one of four attribute types: **Simple** (a plain string value such as a date, number, or text), **Codeable Concept** (display text plus a codings array with code, display, and system), **Observation Value** (text, a type code, and a numeric result), or **Range Value** (text, a low value, and a high value). An attribute is always referred to as an attribute regardless of whether it is a model reference or a populated instance.

### PIQI Model

A flat, patient-centric structured information model that defines the shape of the data payload evaluated by the PIQI Framework. A PIQI Model is comprised of a [Patient Container](#patient-container) and a collection of [Data Classes](#data-class) with their typed attributes. Models may be standardized (e.g., the PIQI Clinical Data Model or PIQI Medical Claim Data Model) or localized through the addition of Data Classes and attributes relevant to a specific use case. [Evaluation Rubrics](#evaluation-rubric) are always associated with a specific PIQI Model and version.

### Evaluation Rubric

A versioned, use-case-specific collection of configured Simple Assessment Modules (SAMs) aligned to a [PIQI Model](#piqi-model). Each criterion in an Evaluation Rubric specifies a [Data Class](#data-class), an entity scope ([attribute](#data-attribute), element, data class, or patient), an assigned SAM, scoring weight, and criticality indicator. Evaluation Rubrics can be shared through the PIQI Community of Practice to establish common data quality standards.

### Patient Container

The top-level entity in a PIQI payload that holds all Data Class collections for a single patient. The Patient Container is the root of the [PIQI Model](#piqi-model) hierarchy: Patient Container → [Data Class](#data-class) (collection of elements) → Element (single instance) → [Attribute](#data-attribute) (typed data field).
