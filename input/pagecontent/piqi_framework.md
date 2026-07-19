### High Level Component Diagram

Please refer to the appropriate [**PIQI Message Format Guide**](https://piqiframework.org/wp-content/uploads/2025/05/PIQI-Framework-Message-Format-Implementation-Guide-Patient-Clinical-Data-Model-v1.1-05MAY2025.pdf) for specific [PIQI model](glossary.html#piqi-model) format implementation details.

The high-level component diagram can be found [here](background.html#framework-design)

### PIQI Message Philosophy

It is important to remember that the goal of the Patient Information Quality Improvement (PIQI) Framework is to assess the contents of **a single structured data payload and provide a score based solely on the contents of that payload**. Each rubric assessing a payload is designed in the context of a particular use case. This allows the following:

1) The assessment of the quality of that single payload.
2) The collection of statistics with aggregate values (Averages, Medians) and other ‘per payload’ statistics.
3) Allows payload level plausibility assessments.

Implementers of the PIQI Framework will likely aggregate scoring results for the purpose of qualitative root-cause analysis, but this specification is focused on the implementation of the framework itself.  Future efforts may consider optimal patterns for analyzing data quality patterns across collections of messages.

### PIQI Attribute Types

PIQI Elements are comprised of four [attribute](glossary.html#data-attribute) types: Simple, Codeable Concept, Observation Value, and Ranged Value.

#### Simple Attribute Type

A Simple Attribute is a string value in the JavaScript Object Notation (JSON) attribute structure. Simple Attributes can contain any string and can be used to represent any single basic data type like text, simple numbers, structured numbers, dates, and date ranges.

Example: In this example the effectiveDateTime attribute is a Simple Attribute.
```json
    "labElements": [
        {"effectiveDateTime": "20230111135518"}
    ]
```
#### Codeable Concept Attribute Type

A Codeable Concept attribute is a structure that can be represented as a simple attribute or a coded entity. Many attributes in patient data can be represented by a coded entity or a simple code value and as such is represented by a text sub-attribute and a codings collection.

Many of the important attributes in patient information are Codeable Concepts. Codeable Concepts are attributes that can be represented by a simple text string or by one or many codings, hence the codeable concept. If the attribute does contain one or more codings, each coding is comprised of three components: a code, display, and code system identifier.

**All of these Coding sub attributes should be populated in order for the concept being exchanged to be validated.**

The **code is needed** to provide a unique stable identifier for the concept in a given code system.

The **code system identifier is needed** to provide context for the meaning of a code, and to confirm that the code is valid in that code system and, if necessary, determine the status of that code.

The **display is needed** so that a human can verify that the code provided does, in fact, semantically match the concept in the identified code system. It is also necessary if the concept provided is being mapped/normalized to a standard or local terminology.

<style>
table, td{
  border: 1px solid black;
}
th{
  border: 1px solid black;
  text-align: center;
  vertical-align: middle;
}
tr {
  background-color: #DCDCDC;
}
</style>

**Codeable Concept sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the concept |
| codings | Codings | Collection of zero-to-many codings |

##### Coding Attributes
Codings exist as a substructure to the CodeableConcept type.  The substructure is adopted from FHIR to express one or more codings associated with a given CodeableConcept.

**Coding sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| code | Simple Attribute | Code value for the coding |
| display | Simple Attribute | Display value for the coding |
| system | Simple Attribute | Code system identifier for the coding |

**Example:**
```json
    "test": {
        "text": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",
        "codings": [
            {
                "code": "742-7",
                "display": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",
                "system": "LOINC"
            }
        ]
    }
```

#### Observation Value Attribute Type

An Observation Value attribute is a structure that can be represented as a simple attribute value or a structure observation value. Observation Value is a specialized attribute as many elements in patient information can be represented by a quantitative, text, or coding value.

**Observation Value sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the value |
| type | Codeable Concept | Collection of zero-to-many codings representing the value type |
| number | Simple Attribute | For numeric values |
| number2 | Simple Attribute | For second numeric value |
| codings | Codeable Concept | Collection of zero-to-many codings representing the observation value |

**Example:**

```json
    "resultValue": {
        "text": "Abnormal",
        "type": {
            "text": "CE",
            "codings": [
                {
                    "system": "HL7-0125",
                    "code": "CE",
                    "display": "Coded Entry"
                },
                {
                    "system": "LOINC",
                    "code": "11111",
                    "display": "Abnormal"
                }
            ]
        }
    }
```

#### Range Value Attribute Type

A Range Value attribute is a structure that can be represented as a simple attribute value or a structured range value. The Range Value is a specialized attribute as many elements in patient information can be represented by a structured range. The Range Value Attribute Type can only be used with numeric ranges and cannot be used for a date range.

**Range Value sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the value range |
| lowValue | Simple Attribute | Text representation of the low value |
| highValue | Simple Attribute | Text representation of the high value |

**Example**:

```json
    "referenceRange": {
        "text": "14-88",
        "lowValue": "14",
        "highValue": "88"
    }
```

### PIQI Data Models

The PIQI Framework depends on a patient-oriented, flat-data class collection information model. Depending on the use case, the structure of the model—including its [data classes](glossary.html#data-class) and [attribute](glossary.html#data-attribute) details—may vary. For example, the PIQI Clinical Data Model is designed to evaluate clinical information exchanged about a patient, so its data classes and attributes reflect common clinical data elements. In contrast, the PIQI Medical Claim Data Model includes data classes and attributes typically associated with claims information. The PIQI Framework functions consistently across different models, provided the model remains flat, includes a patient demographics element, and uses attribute types that align with the framework’s design.

All attributes have a cardinality of 0..1, recognizing that a CodeableConcept collection attribute may contain multiple CodeableConcepts values.

### PIQI Clinical Data Model

The PIQI Clinical Data Model is a simplified information model based on US Core profiles and is intended to focus on [data classes](glossary.html#data-class) and [attributes](glossary.html#data-attribute) that are highly relevant to patient clinical data quality and to simplify the qualitative assessment process. While it could be extended to include administrative and other data relative to the patient's care process, initially the model is purposefully limited to patient demographics, social, and clinical information.

#### PIQI Clinical Data Model Classes

| **Data Class** | **Cardinality to [Patient Container](glossary.html#patient-container)** |
| --- | --- |
| Allergy | Zero to Many |
| Condition | Zero to Many |
| Demographics | One |
| HealthAssessments | Zero to Many |
| Immunization | Zero to Many |
| LabResult | Zero to Many |
| MedicalDevice | Zero to Many |
| Medication | Zero to Many |
| Procedure | Zero to Many |
| VitalSign | Zero to Many |

#### PIQI Data Class Attributes

| **Allergy**|
| --- |     |     |
| **AttributeName** | **Type** | **Description** |
| substance | Codeable Concept | Allergen or substance that trigger an intolerance |
| category | Codeable Concept | Category of substance: medication, food, chemical, etc |
| reaction | Codeable Concept | Condition triggered by the intolerance or allergy |
| effectiveDate | Simple Attribute | Date of allergy onset or documentation. Note: this could be a date or date range |
| severity | Codeable Concept | Severity of the reaction |
| allergyStatus | Codeable Concept | Status of allergy: active, confirmed, refuted, etc |
| provenance | Simple Attribute | Source of this information |



| **Condition** |
| --- |     |     |
| **AttributeName** | **Type** | **Description** |
| condition | Codeable Concept | Problem, Diagnosis or other medical condition |
| conditionStatus | Codeable Concept | Status of condition: active, confirmed, refuted, etc |
| conditionType | Codeable Concept | Type of condition/diagnosis: complaint, discharge, etc |
| onsetDate | Simple Attribute | Onset or effective date |
| resolutionDate | Simple Attribute | Date condition resolved |
| provenance | Simple Attribute | Source of this information |


| **Demographics** |
| --- |     |     |
| **AttributeName** | **Type** | **Description** |
| birthDate | Simple Attribute | Patient date of birth |
| birthSex | Codeable Concept | Patient sex at birth |
| deathDate | Simple Attribute | Patient date of death |
| deceased | Codeable Concept | Is patient deceased: Yes or No or boolean |
| ethnicity | Codeable Concept | Patient ethnic group |
| genderIdentity | Codeable Concept | Patient gender identity |
| primaryLanguage | Codeable Concept | Patient primary language |
| maritalStatus | Codeable Concept | Patient marital status |
| raceCategory | Codeable Concept | Patient race category |
| provenance | Simple Attribute | Source of this information |

| **HealthAssessment** |
| --- |     |     |
| **Attribute Name** | **Type** | **Description** |
| assessment | Codeable Concept | Specific health assessment |
| resultValue | Observation Value | Health assessment result |
| resultUnit | Codeable Concept | Health assessment result unit, if applicable |
| performedDateTime | Simple Attribute | Date and time when assessment was performed |
| provenance | Simple Attribute | Source of this information |

| **Immunization** |
| --- |     |     |
| **Attribute Name** | **Type** | **Description** |
| immunization | Codeable Concept | Immunization or vaccine product |
| lotNumber | Simple Attribute | Lot number for immunization product |
| administrationDate | Simple Attribute |  Date immunization was administered |
| expirationDate | Simple Attribute | Expiration date for immunization product |
| reaction | Codeable Concept | Patient reaction to immunization, if applicable |
| immunizationStatus | Codeable Concept | Status of immunization: completed, entered-in-error, not-done, etc |
| provenance | Simple Attribute | Source of this information |


| **LabResult** |
| --- |     |     |
| **Attribute Name** | **Type** | **Description** |
| performed test | Codeable Concept | Specific lab test performed |
| ordered test | Codeable Concept | Order or panel that initiated the test being performed |
| resultValue | Observation Value | Test result value |
| resultUnit | Codeable Concept | Test result unit, if applicable |
| interpretation | Codeable Concept | Test result interpretation |
| referenceRange | Range Value | Test reference range |
| specimenType | Codeable Concept | Type of specimen used by the specific test |
| resultStatus | Codeable Concept | Status of the result: Incomplete, pending, final, etc |
| performingSite | Simple Attribute | Unique identifier for the performing site |
| performedDateTime | Simple Attribute | Date and time the test was performed |
| orderDate | Simple Attribute | Date the order was requested |
| provenance | Simple Attribute | Source of this information |

| **MedicalDevice** |
| --- |     |     |
| **Attribute Name** | **Type** | **Description** |
| deviceType | Codeable Concept | Type of medical device |
| deviceID | Codeable Concept | Food and Drug Administration (FDA) unique device identifier |
| implantationDate | Simple Attribute | Date the device was implanted if applicable |
| deviceStatus | Codeable Concept | Status of the medical device |
| provenance | Simple Attribute | Source of this information |

| **Medication** |
| --- |     |     |
| **Attribute Name** | **Type** | **Description** |
| medication | Codeable Concept | Medication product (drug) |
| startDate | Simple Attribute | Date the patient started the medication |
| endDate | Simple Attribute | Date the patient discontinued the medication |
| doseAmount | Simple Attribute | The dose amount expressed in strength or eaches. For a 200mg total dose delivered via 2 100mg tablets, the doseAmount is 200. |
| doseAmountUnit | Codeable Concept | The dose amount unit. For a 200mg total dose delivered via 2 100mg tablets, the doseAmountUnit is mg. |
| doseRoute | Codeable Concept | The route of administration |
| doseQuantity | Simple Attribute | The dose quantity dispensed. For a 200mg total dose delivered via 2 100mg tablets, the doseQuantity is 2. |
| doseQuantityUnit | Simple Attribute | The dose quantity units. For a 200mg total dose delivered via 2 100mg tablets, the doseQuantityUnit is {Tablet}. |
| instructions | Simple Attribute | The medication instruction text |
| adherence | Codeable Concept | The patient’s adherence to the medication |
| indication | Codeable Concept | The condition that is being treated by the medication |
| fillStatus | Codeable Concept | Fill status of the medication |
| medicationStatus | Codeable Concept | Status of medication: active, stopped, entered-in-error, etc |
| provenance | Simple Attribute | Source of this information |

| **Procedure** |
| --- |     |     |
| **AttributeName** | **Type** | **Description** |
| procedure | Codeable Concept | The procedure that was performed on the patient |
| procedureDateTime | Simple Attribute | The date and time the procedure was performed. Note: this could be a date or date range  |
| procedureReason | Codeable Concept | The condition that prompted the procedure |
| procedureStatus | Codeable Concept | Status of procedure: preparation, in-progress, completed, entered-in-error, etc |
| provenance | Simple Attribute | Source of this information |


| **VitalSign** |
| --- |     |     |
| **AttributeName** | **Type** | **Description** |
| vitalSign | Codeable Concept | Vital sign assessment/test |
| resultValue | Observation Value | Vital sign result |
| resultUnit | Codeable Concept | Vital sign result unit, if applicable |
| interpretation | Codeable Concept | Interpretation of vital sign |
| referenceRange | Range Value | Reference range for vital sign |
| resultStatus | Codeable Concept | Vital sign result status |
| performedSite | Simple Attribute | Unique identifier for performing site |
| performedDateTime | Simple Attribute | Date and time vital sign was collected |
| provenance | Simple Attribute | Source of this information |

### Code System Identifiers in PIQI



One of the issues with validating codeable concepts is that often different string values are used to identify the code system for a given code. For example, when sending a Logical Observation Identifiers Names and Codes (LOINC) code it is possible to see the following code system identifiers:

LOINC, LNC, LN Code System Simple string identifiers

CodeSystem Object Identifier (OID): 2.16.840.1.113883.6.1 

CodeSystem Uniform Resource Locator (URL): <http://loinc.org>

To support code system identifier variants in PIQI there is a mechanism that allows for a code system mnemonic to be used in the configuration of an [Evaluation Rubric](glossary.html#evaluation-rubric) to represent any valid code system identifier and identify the code system identifier that is required to validate that code in the implementation's terminology server.

For example, for LOINC this mechanism would establish the ‘LOINC’ mnemonic in the following manner:

| Name | Logical Observation Identifiers Names and Codes |

| --- | --- |
| Mnemonic | LOINC |
| Code System Identifiers | LOINC |
|     | LN |
|     | LNC |
|     | urn:oid:2.16.840.1.113883.6.1 |
|     | 2.16.840.1.113883.6.1 |
|     | <http://loinc.org> |

This is another example of how PIQI is designed specifically for patient information. This function will allow, for example, an Evaluation Rubric that is checking for conformance to just pass ‘LOINC’ to the SAM that validated conformity and have it pass if any of the Code System Identifier aliases are used. It also allows a validation SAM to automatically validate a concept that is received using one of the code systems aliases. If at some point in the future another valid code system identifier is defined for a given code system, it can easily be added to this mechanism and automatically reflected in all configured Evaluation Rubrics.

#### Code System JSON structure

```json
    "**codeSystems**": [
    {
      "name": "Logical Observation Identifiers Names and Codes",
      "mnemonic": "LOINC",
      "codeSystemIdentifiers": [
        "LN",
        "LNC",
        "urn:oid:2.16.840.1.113883.6.1",
        "2.16.840.1.113883.6.1",
        "http://loinc.org"
      ]
    },
    {
      "name": "SNOMED CT US Edition",
      "mnemonic": "SNO_INT_USEXT",
      "codeSystemIdentifiers": [
        "http://snomed.info/sct/731000124108",
        "SNOMED",
        "SCT",
        "SNOMEDCT",
        "urn:oid:2.16.840.1.113883.6.96",
        "http://snomed.info/sct",
        "2.16.840.1.113883.6.96",
        "SNO"
        ]
    },
    {
      "name": "ICD-10-CM",
      "mnemonic": "ICD10CM",
      "codeSystemIdentifiers": [
        "ICD10",
        "ICD10-CM",
        "ICD10CM",
        "2.16.840.1.113883.6.90",
        "urn:oid:2.16.840.1.113883.6.90",
        "http://hl7.org/fhir/sid/icd-10-cm",
        "https://www.cms.gov/medicare/icd-10/2022-icd-10-cm"
      ]
    },
    {
      "name": "ICD-9-CM Diagnosis",
      "mnemonic": "ICD9CMD",
      "codeSystemIdentifiers": [
        "I9",
        "ICD9",
        "ICD9CM",
        "ICD9-CM",
        "2.16.840.1.113883.6.103",
        "urn:oid:2.16.840.1.113883.6.103"
        "http://hl7.org/fhir/sid/icd-9-cm",
      ]
    }
    ]
```

### PIQI Patient Assessment Application Hierarchy

When considering a PIQI information model it is worth noting that patient data in such models are organized into a hierarchical structure with four primary entity levels that can each be evaluated for quality. These entities are as follows:

- **Data Model**: A holistic entity that is comprised of all of the [data class](glossary.html#data-class) instances and [attributes](glossary.html#data-attribute) - the entire structured data submission.
- **Data Class**: A collection of instances of a data class.
- **Element**: A single instance of a data class collection of attributes.
- **Attribute**: A single data attribute that relates to a data class.

<span width="100%">
<img src="patient_assessment_application_hierarchy.png" alt="PIQI Patient Assessment Application Hierarchy" height="25%" width="25%" />
</span>
<br/>


**Reminder**: It is important to restate that PIQI is intended to assess the quality of data payloads in real time, determining their suitability for use by the intended recipient, and not intended to evaluate data within records at rest.

### PIQI Healthcare Data Quality Taxonomy (HDQT) Version 1.0

A standard classification taxonomy for patient information quality issues provides structure and clarity to the process of data quality management. This systematic approach allows for the identification and categorization of various types of errors or inconsistencies, which can range from minor inaccuracies to critical misinformation. By classifying these issues, healthcare data stewards can prioritize them based on their potential impact. This methodical categorization facilitates easier tracking and analysis of recurring problems, enabling healthcare organizations to implement targeted improvements. Moreover, standardized taxonomy aids communication among healthcare professionals by providing a common language for discussing quality issues. Ultimately, this leads to enhanced quality control, improved patient outcomes, and a reduction in the likelihood of medical errors, thereby fostering a safer and more reliable healthcare environment.

The PIQI Taxonomy consists of high-level categories, each containing more specific dimensions. It's essential to note that the assessment of patient information quality occurs at both the element and [attribute](glossary.html#data-attribute) levels, and not all dimensions apply uniformly to both.

Given that the dimensions are designed to categorize qualitative issues, they are presented from a negative perspective. Consequently, the percentages associated with these dimensions indicate the proportion of failures or issues identified within each dimension.  

It is important to remember that these dimensions are available to be used by the SAMs which provide code assessments of the input to the SAM, be that an attribute, data class element, data class collection or the entire message.  This means a HDQT is an abstract concept and it's assignment to the SAM is based on a best-fit interpretation of the assessments intent.

The categories are as follows:  
<span width="100%">
<img src="piqi_taxonomy.png" alt="PIQI Healthcare Data Quality Taxonomy" height="70%" width="70%"/>
</span>

#### Availability Category

This category contains dimensions that relate to the presence of usable information.

Dimensions:

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Missing |  | Pertains to Elements and specifically evaluates whether an expected element is absent. This dimension can be conceptualized as a method for assessing 'missingness' at an elemental level. _For example, if a patient has Insulin on their medication list, and has a high A1C, but there is no corresponding condition indicating Diabetes, then the diabetes condition is considered missing._ |
| Unpopulated | Attribute | This applies to an Attribute that should be populated with something but is not. This dimension does not evaluate the validity of the Attribute, merely whether or not it has data. This dimension only applies to Attributes of Elements that are not missing. |
| Incomplete | Element<br><br>Attribute | This applies to Elements or complex Attributes where there is inadequate information available to fully represent the attribute or element. _For example, a coded entity (attribute) that is missing its code system is incomplete. In this context the code system component of a coding is unpopulated and the coded entity Attribute is incomplete._ |

#### Accuracy Category

This category contains dimensions that relate to the innate validity of the data.

Dimensions:

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Invalid Format | Attribute | This applies to Attributes that are not properly formatted for their expected data type. It is assumed that all Attributes are presented as text strings and therefore validating the format of that string before progressing the data type assessments is necessary. Examples of format are freetext, date, time, timestamp, integer, decimal, and single alphanumeric character. The specific logic used to assess format should be included in the corresponding SAM definition.|
| Invalid Value | Attribute |This applies to an Attribute that has a value but the value does not conform to the expectations for the attribute. For example, it would be appropriate to include in this dimension the logical assessments of text strings expected to conform to a specific set of values (e.g., UCUM units when they are not conveyed in a fully coded format where the Invalid Member dimension would be a more appropriate choice), or business rules related to date values (e.g., Date of Birth with a future date). Note that a value may be an invalid value despite the values having an appropriate format. This dimension is intended to reflect "field-level" errors, and not broader data quality errors involving values across multiple fields.|
| Invalid Grouping | Element<br><br>Attribute | This applies to Elements or complex Attributes where the combination of Attributes is invalid. An example of this could be a situation where a lab test that is only performed on serum and a lab element had that lab code paired with a urine specimen.  This is would represent a fundamentally invalid combination |

#### Conformity Category

This category contains dimensions that relate to the integrity of coded information, for example verifying that specific code is a member of a CodeSystem or Valueset.

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Invalid Member | Attribute | This applies to coded entity complex attributes when the code provided is not a member of the CodeSystem/ValueSet provided. |
| Incompatible | Attribute | This applies to coded entity complex attributes when the code system provided is not an agreed upon CodeSystem/ValueSet per the terms of the criteria. |
| Obsolete | Element<br><br>Attribute | This applies to coded entity complex attributes when the concept provided is no longer active in the CodeSystem/ValueSet provided. |

#### Plausibility Category

This category contains dimensions that relate to whether the data makes sense based on some context.

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Temporally Implausible | Element<br><br>Attribute | Temporally implausible conditions are identified when an attribute or element is uncertain due to when it occurs in the context of the patient's timeline. _An example of this would be a future birth date or an end time that precedes a start time._ |
| Clinically Implausible | Element<br><br>Attribute | Clinically Implausible conditions are identified when an attribute or element is uncertain due to clinical considerations. _An example of this would be a lab result value that is outside a reasonable range of values for a given lab test._ |
| Situationally Implausible | Element | Situationally Implausible conditions are identified when an attribute or element is uncertain due other conflicting elements or attributes. _An example of this would be a high range value that is lower then a low range value._ |

### PIQI Assessment Approach

The PIQI Framework assesses patient data that has been put into the PIQI Data Model using an **[Evaluation Rubric](glossary.html#evaluation-rubric)** which is a collection of **Evaluations**, each evaluation consisting of a patient data entity to be evaluated, a configured Simple Assessment Module (SAM) to use in that evaluation, specific parameter values to use with that SAM, and scoring implications of the evaluation result.

#### PIQI Simple Assessment Modules

PIQI SAMs are composable service endpoints that follow a consistent pattern to evaluate a patient message, [data class](glossary.html#data-class), element or [attribute](glossary.html#data-attribute), and return a simple ‘pass’, ‘fail’ or ‘conditions not met’ result. A SAM that has been configured for use in an Evaluation Rubric is referred to simply as an Evaluation.

Each SAM is comprised of the following elements:

| Component | Description |
| --- | --- |
| SAM Name | The name of the SAM. |
| Entity Type | This is the patient entity type (entire model, data class, element, attribute) that the assessment has been designed to evaluate. |
| Assessment Logic | The actual logic that performs the evaluation against the data class, element or attribute |
| PIQI Dimension | The PIQI taxonomy dimension that most appropriately describes the SAM. |
| Required Params | The list of required parameters that must be supplied by the Evaluation Criterion to perform the assessment. |

Example: High Level  

<span width="100%">
<img src="high_level_sam_example.png" alt="High Level SAM example" height="70%" width="70%"/>
</span>

Example: Attribute is Present

| Component | Example Value |
| --- | --- |
| SAM Name | Attribute is Present |
| Entity Type | Simple Attribute |
| Assessment Logic | If (Attribute.Value==””) { SAM.Result=”FAIL”} (Pseudocode) |
| PIQI Dimension | Availability.Unpopulated \[AV.UNPOP\] |
| Required Params | N/A |

Example: Coded Entity is Interoperable

| Component | Example Value |
| --- | --- |
| SAM Name | Coded Entity is Interoperable |
| Entity Type | Coded Entity Attribute |
| Assessment Logic | If ((Attribute.CS.Value==CS_PARAM)&&(Attribute.CNF.INVMBR=”PASS”))<br><br>{ SAM.Result=”PASS”} (Psuedocode) |
| PIQI Dimension | Conformity.Incompatible \[CNF.INCMPT\] |
| Required Params | CS_PARAM – Code System Required for Interoperability by Evaluation Criterion |

A SAM can have a **prerequisite SAM**. This is a SAM that must be run and pass prior to this SAM being run. Prerequisites can stack resulting in a series of SAMs that must be run on an entity for the assigned Evaluation SAM to be run and pass.

<span width="100%">
<img src="prerequisite_sams.png" alt="Prerequisite SAMs"/>
</span>

Prerequisite SAMs cannot have parameters that are not provided to the assigned Evaluation SAM.

One might be tempted to avoid prerequisite SAMs by encapsulating the prerequisite logic in the assigned Evaluation SAM. The reason PIQI does not do this is the information on the failure of the entity being evaluated is primary to the definition of the SAM and the SAM itself just returns a pass or fail. In the above example when the assigned assessment ‘Concept is Compatible’ is run the first prerequisite SAM, ‘Attribute is Populated’ is run on the entity. The idea that the entity fails to pass the assigned SAM is what establishes the entity's score. Recording the specific SAM that failed provides the statistics that are core to the PIQI approach. This conveys the nature of the failure, as opposed to ‘Concept is Compatible’ failing and having to return a reason for the failure. Additionally, when a pre-requisite SAM fails, that failure should be categorized against the dimension for the pre-requisite SAM, not the dimension for the assigned Evaluation SAM.

#### PIQI Evaluation Rubric
An evaluation rubric is always based on a given [PIQI model](glossary.html#piqi-model) and version.  An evaluation rubric based on a given model should be compatible with any future version of the same model as PIQI models are backwards compatible.

An evaluation rubric is the alignment of patient data entities to SAMs as a list of assessable items that contribute to provide a standard scoring rubric for that specific collection of patient data. Evaluation rubrics can be established as a standard or custom scoring rubric.

A given evaluation rubric has a name, version and purpose, a PIQI model and model version along with a sequenced collection of evaluations comprised of SAMs configured and assigned to the model, data classes, elements and attributes with the necessary parameters, conditions, scoring effect, weight, and criticality.

Example: Graphical Depiction of an Evaluation Rubric for a data class

<span width="100%">
<img src="evaluation_profile.png" alt="Graphical Depiction of an Evaluation Rubric for a data class" height="70%" width="70%"/>
</span>

#### Evaluation Rubric Assessments

The core of an Evaluation Rubric is the sequenced collection of entity assessments. Each step has the following components:

| Component | Description |
| --- | --- |
| Step Sequence | Execution Sequence. |
| Data Class | The Data Class from the PIQI Model. |
| Entity | The class, element or specific attribute from the PIQI Data Model that is being assessed. |
| SAM | The Simple Assessment Module. |
| SAM Params | List of Parameters and values necessary to perform assessment. |
| Effect | The effect of assessment failure on the qualitative status of the entity being assessed (Scoring, Informational). |
| Condition | The precondition that must be met to include the assessment. |
| Weight | The weight that is applied to the weighted score value numerator and denominator. |
| Criticality | A true/false indicator as to whether the assessment is considered critical in the Evaluation Rubric. |

#### Scoring Effect

An assigned Evaluation SAM is typically used to score the quality of the data in a message but can also be used to collect data without impacting the quality score. The Scoring Effect is essentially a switch that tells the PIQI engine to collect statistics for a given SAM without affecting the numerator or denominator of the score for the message.

#### Weight

In some cases, a PIQI user may want to weigh the score in a rubric allowing some SAMs to have more impact than others. By default, the weight for any assigned Evaluation SAM is one. If a particular Evaluation Rubric does use a weighted score for one or more SAMs the PIQI engine will produce a PIQI Score and a PIQI Weighted Score for the message being assessed. Both scores will be a percentage of a numerator over a denominator with a maximum score of 100% of all possible points.  This practically means that a PIQI score for a message is simply the number of scored evaluations that passed, divided by the total number of scored evaluations performed, and a PIQI Weighted Score for a message is the sum of weighted values for all scored evaluations that passed, divided by the sum of weighted value for all scored evaluations, including both those that passed and failed.

#### Criticality

The criticality indicator on an assigned Evaluation SAM allows the user to flag that assessment as critically important to the rubric. As an alternative to a weighted score the criticality indicator provides the ability to indicate that message has critical qualitative issues that may make the data unusable without effecting nature of the unweighted numerator/denominator percentage.

#### Conditional Assessments

In some cases, an assigned Evaluation SAM should only be applied if another condition is true. While this may seem similar to a prerequisite SAM it affects the scoring in a very different way.

If a **prerequisite** SAM for an assigned Evaluation SAM fails, this is considered an entity assessment failure which increments the denominator but not the numerator for that assessment. In other words, the assessment is a failure.

If a **conditional** SAM for an assigned Evaluation SAM fails, this means the conditions for the assigned Evaluation SAM were not met and the assigned Evaluation SAM should not be run. Neither the numerator nor the denominator is incremented.

### Evaluation Rubric Execution

The sequence of execution of the Evaluation Rubric Assessments controls the order of assessment within a given [data class](glossary.html#data-class). The data class execution sequence is defined as the sequence of patient data loaded into the PIQI model. The sequence of assessment will repeat within a given data class until it has completed all the elements of that data class. Upon completion of the assessment of all the elements in a given data class, the data class assessments themselves (if defined) are executed. Upon completion of all elements and data class assessments, model scope assessments (if defined) are executed.

### PIQI Scoring in a Nutshell

The objective for PIQI data quality scoring is to provide a useful score card that provides the data consumer with insight into the quality of a patient data payload based on a given [Evaluation Rubric](glossary.html#evaluation-rubric).

The most basic result returned from a PIQI scorecard evaluation would be the following:

| **MessageID** | The MessageID submitted with the scoring request. |
| --- | --- |
| **DataProviderID** | The DataProviderID submitted with the scoring request. |
| **DataSourceID** | The DataSourceID submitted with the scoring request. |
| **Potential Item Score** | A count of the total number of scorable items in the patient data payload and will always be greater than or equal to the Total Item Score. This is also the score denominator. |
| **Total Item Score** | A count of the total number of scoreable items that passed according to the Evaluation Rubric. This is also the score numerator. |
| **PIQI Index** | The Total Item Score is divided by the Potential Item Score. Resulting in a percentage value from 0 to 100. |
| **Critical Failure Count** | A count of the scorable items that were flagged as critical and did not pass. |
| **Data Class Frequency** | A count of the total number of elements within each [data class](glossary.html#data-class) in the patient data payload. This will only include data classes that are referenced in the Evaluation Rubric. |
| _(If Weighted scores are used)_ |     |
| **Potential Weighted Item Score** | A count of the total number of scorable item weights in the patient data payload. This is also the score denominator. |
| **Total Weighted Item Score** | A count of the total number of scoreable item weights that passed according to the Evaluation Rubric. This is also the score numerator. |
| **PIQI Weighted Index** | The Total Weighted Item Score is divided by the Potential Weighted Item Score. Resulting in a percentage value from 0 to 100. |

### Verbose Scoring

When the PIQI Framework is used in verbose scoring mode, the score information above is returned along with the original message with each element including the scoring details.

### PIQI Technical Components

The PIQI Framework is actualized with the following components:

Structured Data Architecture Components

- HDQT Taxonomy – structured data
- [PIQI Model](glossary.html#piqi-model) Structure – structured data
- Standard Code System Mappings – structured data
- Simple Assessment Module Reference Library – structured data
- [Evaluation Rubric](glossary.html#evaluation-rubric) Reference Library – structured data

Structured Data Asset Components

- Evaluation Rubric Definition(s) – structured data
- Evaluations - configured SAMs
- Simple Assessment Module – Evaluation Definition(s) – structured data
- SAM Specific evaluation content – structured data

Software Components

- PIQI Framework Scoring Engine Representational State Transfer (REST)ful Service
- Fast Healthcare Interoperability Resources (FHIR) (or equivalent) Terminology Server
<span width="100%">
<img src="piqi_technical_components.png" alt="PIQI Technical Components" width="85%" />
</span>

### PIQI Alliance as a Community of Practice

The PIQI Framework is designed to be implemented within a community of practice. Encapsulated, portable, data-driven components, and the ability to share knowledge establishes great potential for rapid evolution and adoption.

### PIQI Model Extensions

The PIQI Framework starts with a simple model intended to support the assessment of core clinical patient data. The simplicity of this model allows for extension through the addition of [attributes](glossary.html#data-attribute) and [data classes](glossary.html#data-class). Ideally these extensions would be adopted into the core PIQI model through a standard process.

### Shared Simple Assessment Modules

 While many of the foundational, [attribute](glossary.html#data-attribute) level SAMs are algorithmic, SAMs that apply to codeable concepts, elements, [data classes](glossary.html#data-class), and model level data often require structured content in the form of value sets, tuples, and other data patterns. To share and utilize rubrics that use SAMs that depend on such structures, PIQI evaluation engines must also have access to the supporting content. For example, to utilize a rubric including a SAM configured to verify that a codeable concept is an active LOINC term, that PIQI evaluation engine must be able to reference the current LOINC release. These data packages can be openly shared or licensed in a community portal. More sophisticated algorithmic SAMs, perhaps based on generative artificial intelligence (AI), could also be hosted as RESTful services through wrapper SAM interfaces.

### Shared Evaluation Rubrics

While the Evaluation Rubrics in PIQI are designed to be configured to support the needs of the implementer, the ability to establish sanctioned standard Evaluation Rubrics is one of the most beneficial features of the PIQI Framework. The ability to publish and share an Evaluation Rubric, along with its dependent SAMs and [PIQI Model](glossary.html#piqi-model) components can minimize duplication of effort and provide a powerful way to create a common basis for understanding data quality across the community.

### PIQI Endpoint Registration

Within the community of practice implementations of the PIQI Framework could be registered and certified to facilitate the ability to share content seamlessly with other community members.

### PIQI Data Source Unique Identifier

The PIQI Framework was created to assess and improve the quality of patient data from a given source. However, this raises a crucial question: How do we uniquely and unambiguously identify the source of that data?

In healthcare, we have various identifier types for institutions, facilities, and providers, but no unique identifier for the data entity responsible for generating and sharing patient data. This is analogous to an IP address in a computer network—an essential component that enables modern data-sharing networks to recognize and authenticate each participant.

This is not merely a "nice to have" feature. Establishing a unique data source identifier is critical for trust, traceability, and provenance in our national healthcare infrastructure.

While the PIQI Framework does not require a global unique data source identifier, nor does it include a methodology for assigning one, incorporating one would significantly enhance the ability to assess the quality and reliability of data exchange participants—regardless of their role or the nature of the coordinating entity.


[def]: docs/
