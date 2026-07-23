Glossary of PIQI Framework Terms

The following terms are used throughout the Patient Information Quality Improvement (PIQI) Framework documentation.

### Code System Identifiers

A collection of string values that are considered valid for identifying a given code system. May also be referred to as code system aliases.

### Codeable Concept Attribute

A **Simple** attribute with an optional codings collection.  If codings are populated each coding can have a code system, code and display.  

### Data Attribute

A single typed data field belonging to an Element. Each attribute in the PIQI Framework uses one of four attribute types: **Simple** (a plain string value such as a date, number, or text), **Codeable Concept** (display text plus a codings array with code, display, and system), **Observation Value** (text, a type code, and a numeric result), or **Range Value** (text, a low value, and a high value). An attribute is always referred to as an attribute regardless of whether it is a model reference or a populated instance.

### Data Class

A domain-specific, named collection of typed attributes representing a category of patient health information. Within a PIQI payload, a Data Class contains a collection of **Elements** (individual instances of that class). For example, The PIQI Clinical Data Model defines a collection of clinically oriented Data Classes: Allergy, Condition, Demographics, HealthAssessment, Immunization, LabResult, MedicalDevice, Medication, Procedure, and VitalSign. Data Classes can be added to a [PIQI Model](#piqi-model) to localize it for a specific use case.

### Data Class Element

A single instance of a member of a data class. The term **Data Class** refers to a patient specific data pattern and the entire collection of all instances of that pattern; when referring to a single instance of that pattern for assessment purposes the term **Data Class Element** or **Element** is used.

### Evaluation Criteria

A combination of a **PIQI model entity reference**, a **Simple Assessment Module**, and necessary SAM parameters and the **Scoring Effect**, **Scoring Weight** and **Failure Criticality indicator**.

### Evaluation Rubric

A versioned, use-case-specific collection of configured Simple Assessment Modules (SAMs) aligned to a [PIQI Model](#piqi-model). Each criterion in an Evaluation Rubric specifies a [Data Class](#data-class), an entity scope ([attribute](#data-attribute), element, data class, or patient), an assigned SAM, scoring weight, and criticality indicator. Evaluation Rubrics can be shared through the PIQI Community of Practice to establish common data quality standards.


### Failure Criticality indicator

In an **Evaluation criteria** this defines if the criteria is considered critical to the use case contemplated in the **Evaluation Rubric**.

### Healthcare Data Quality Taxonomy (HDQT)

This is a taxonomy designed to categorize and identify dimensions for qualitative issues in healthcare data in order to provide insight into root causes and remediation.

### Patient Container

The top-level entity in a PIQI payload that holds all Data Class collections for a single patient. The Patient Container is the root of the [PIQI Model](#piqi-model) hierarchy: Patient Container → [Data Class](#data-class) (collection of elements) → Element (single instance) → [Attribute](#data-attribute) (typed data field).

### PIQI Framework Assessment Service

An instance of a service that follows the PIQI Framework methodology for healthcare data scoring and assessment.

### PIQI Model

A flat, patient-centric structured information model that defines the shape of the data payload evaluated by the PIQI Framework. A PIQI Model is comprised of a [Patient Container](#patient-container) and a collection of [Data Classes](#data-class) with their typed attributes. Models may be standardized (e.g., the PIQI Clinical Data Model or PIQI Medical Claim Data Model) or localized through the addition of Data Classes and attributes relevant to a specific use case. [Evaluation Rubrics](#evaluation-rubric) are always associated with a specific PIQI Model and version.

### PIQI Model Entity Reference

A reference to any defined **Data Attribute**, **Data Class Element**, **Data Class** in a PIQI Model, including the entire **Patient Container**.

### Prerequisite SAM

A **Simple Assessment Module** that must pass in order for a given SAM to run.

### Observation Value

A **Simple** attribute with a type codeable concept to provide information on the nature of the value, a set of numeric simple attributes for single or ranged quantitative results and a codings collection for qualitative result values.

### Range Value

A **Simple** attribute with a set of numeric simple attributes for single or ranged quantitative values.

### SAM Library

A collection of available **Simple Assessment Modules** in a **PIQI Framework Assessment Service**.

### Scoring Effect

In an **Evaluation criteria** this defines how the success or failure impacts the scoring model for the **Evaluation Rubric**.

### Scoring Weight

In an **Evaluation criteria** this defines the weight of the numerator and denominator for the **Evaluation Rubric**, if the criterion's effect is **scoring**.

### Simple Assessment Module (SAM)

A logical test that measures a specific data quality dimension in the **Healthcare Data Quality Taxonomy** for a model element or characteristic (**Data Attribute**, **Data Class Element**, **Data Class**, **Patient Container**), following a defined pattern. The inputs depend on the pattern, but the output is always a simple result: **pass**, **fail**, or **skip**, with an optional reason for the result. SAMs can be grouped into hierarchical collections, allowing multiple checks to be combined in order to provide a broader picture of data quality for a given use case. A SAM may have a **Prerequisite SAM** that must pass in order for the SAM to be run.

### Simple Attribute

A simple string value that is used to represent any classic data type in an information model. PIQI does not use strong types in the model since part of its function is to assess if the data in the model payload complies with the type expectations of the use case.  For the purposes of higher order assessments, like **Is Populated**, all **Data Attributes** can be assessed as **Simple** attributes 














