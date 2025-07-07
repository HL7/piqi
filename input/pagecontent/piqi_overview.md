### High Level Component Diagram

Please refer to the appropriate **PIQI Message Format Guide** for specific PIQI model format implementation details.

### PIQI Message Philosophy

It is important to remember that the goal of the PIQI Framework is to assess and assign a **score to a single message in flight**, not a collection of messages. Each message being evaluated should be a one episode based on the use case, be that a clinical summary, lab report, claim or other patient centric message. This allows the following:

1. The assessment of the quality of that single message
2. The collection of statistics with aggregate values (Averages, Medians) and other ‘per message’ statistics.
3. Allows patient level plausibility assessments that assess a single episode.

### PIQI Attribute Types

PIQI Elements are comprised of four attribute types: Simple Attribute, CodeableConcept, ObservationValue and RangedValue.

#### Simple Attribute Type

A simple attribute is a string value in the JSON attribute structure. Simple attributes can contain any string and can be used to represent any single basic data type like text, simple numbers, structured numbers and dates.

Example: In this example the effectiveDateTime attribute is a simple attribute.
```json
    "labElements": [
        {"effectiveDateTime": "20230111135518"}
    ]
```
#### CodeableConcept Attribute Type

A Codeable Concept attribute is a structure that can be represented as a simple attribute or a coded entity. Many attributes in patient data can be represented by a coded entity or a simple code value and as such is represented by a text sub-attribute and a codings collection.

**CodeableConcept sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the concept |
| codings | Codings | Collection of zero-to-many codings |

**Coding sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| code | Simple Attribute | Code value for the coded concept |
| display | Simple Attribute | Display value for the coded concept |
| system | Simple Attribute | Code system identifier for the codec concept |

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

#### ObservationValue Attribute Type

An ObservationValue attribute is a structure that can be represented as a simple attribute value or a structure observation value. ObservationValue is a specialized attribute as many elements in patient information can be represented by a quantitative, text or coded concepts value.

**Observation Value sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the value |
| type | Codeable concept | Collection of zero-to-many coded concepts representing the value type |
| number | Simple Attribute | For numeric values |
| number2 | Simple Attribute | For second numeric value |
| codings | Codeable concept | Collection of zero-to-many coded concepts representing the observation value |

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

#### RangeValue Attribute Type

A RangeValue attribute is a structure that can be represented as a simple attribute value or a structure ranged value. The RangeValue is a specialized attribute as many elements in patient information can be represented by a structured range.

**RanegValue sub-attributes**

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

The PIQI Framework is based on a patient-oriented, flat-element collection data model. Depending on the use case, the structure of the model—including its data classes and element details—may vary. For example, the PIQI Clinical Data Model is designed to evaluate clinical information exchanged about a patient, so its data classes reflect common clinical data elements. In contrast, the PIQI Medical Claim Data Model includes data classes and attributes typically associated with claims information. The PIQI Framework functions consistently across different models, provided the model remains flat, includes a patient demographics element, and uses attribute types that align with the framework’s design.

### PIQI Clinical Data Model

The PIQI Clinical Data Model is a simplified canonical data model based on US Core profiles and is intended to focus on elements and characteristics that are highly relevant to patient clinical data quality and simplify the qualitative assessment process. While it could be extended to include administrative and other data relative to the patients care process, initially the model is purposefully limited to patient demographics, social and clinical information.

#### Initial PIQI Clinical Data Model Classes

| **Data Class** | **Cardinality to Patient Container** |
| --- | --- |
| Patient | One |
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

#### Initial PIQI Data Class Attributes

| **Allergy** |     |     |     |     |
| --- |     |     |     |     | --- | --- |
| **AttributeName** | **Type** |     |     | **Description** |
| substance | Codeable concept |     |     | Allergen or substance that trigger an intolerance |
| category | Codeable concept |     |     | Category of substance: medication, food, chemical, etc |
| reaction | Codeable concept |     |     | Condition triggered by the intolerance or allergy |
| effectiveDate | Simple attribute |     |     | Date of allergy onset or documentation |
| severity | Codeable concept |     |     | Severity of the reaction |
| **Condition** |     |     |     |     |
| **AttributeName** | **Type** | **Description** |     |     |
| condition | Codeable concept | Problem, Diagnosis or other medical condition |     |     |
| conditionStatus | Codeable concept | Status of condition: active, confirmed, refuted, etc |     |     |
| conditionType | Codeable concept | Type of condition/diagnosis: complaint, discharge, etc |     |     |
| onsetDate | Simple Attribute | Onset or effective date |     |     |
| resolutionDate | Simple Attribute | Date condition resolved |     |     |
| **Demographics** |     |     |     |     |
| **AttributeName** | **Type** | **Description** |     |     |
| birthDate | Simple Attribute | Patient date of birth |     |     |
| birthSex | Codeable concept | Patient gender at birth |     |     |
| deathDate | Simple Attribute | Patient date of death |     |     |
| deceased | Codeable concept | Is patient deceased: Yes or No or boolean |     |     |
| ethnicity | Codeable concept | Patient ethnic group |     |     |
| genderIdentity | Codeable concept | Patient gender identity |     |     |
| primaryLanguage | Codeable concept | Patient primary language |     |     |
| maritalStatus | Codeable concept | Patient marital status |     |     |
| race | Codeable concept | Patient race |     |     |
| **HealthAssessment** |     |     |     |     |
| **Attribute Name** | **Type** |     | **Description** |     |
| assessment | Codeable concept |     | Specific health assessment |     |
| resultValue | ObservationValue |     | Health assessment result |     |
| resultUnit | Codeable concept |     | Health assessment result unit, if applicable |     |
| performedDatetime | Simple Attribute |     | Date and time when assessment was performed |     |
| **Immunization** |     |     |     |     |
| **Attribute Name** | **Type** |     | **Description** |     |
| immunization | Codeable concept |     | Immunization or vaccine product |     |
| lotNumber | Simple Attribute |     | Lot number for immunization product |     |
| administrationDate | Simple Attribute |     | Date immunization was administered |     |
| expirationDate | Simple Attribute |     | Expiration date for immunization product |     |
| reaction | Codeable concept |     | Patient reaction to immunization, if applicable |     |
| **LabResult** |     |     |     |     |
| **Attribute Name** | **Type** |     |     | **Description** |
| test | Codeable concept |     |     | Specific lab test performed |
| order | Codeable concept |     |     | Order or panel that initiated the test being performed |
| resultValue | Observation Value |     |     | Test result value |
| resultUnit | Codeable concept |     |     | Test result unit, if applicable |
| interpretation | Codeable concept |     |     | Test result interpretation |
| referenceRange | RangeValue |     |     | Test reference range |
| specimenType | Codeable concept |     |     | Type of specimen used by the specific test |
| resultStatus | Codeable concept |     |     | Status of the result: Incomplete, pending, final, etc |
| performingSite | Codeable concept |     |     | Unique identifier for the performing site |
| performedDateTime | Simple Attribute |     |     | Date and time the test was performed |
| orderDate | Simple Attribute |     |     | Date the order was requested |
| **MedicalDevice** |     |     |     |     |
| **Attribute Name** | **Type** |     |     | **Description** |
| deviceType | Codeable concept |     |     | Type of implantable device |
| deviceID | Codeable concept |     |     | FDA Unique device identifier |
| implantationDate | Simple attribute |     |     | Date the device was implanted |
| deviceStatus | Codeable concept |     |     | Status of the medical device |
| **Medication** |     |     |     |     |
| **Attribute Name** | **Type** |     |     | **Description** |
| medication | Codeable concept |     |     | Medication product (drug) |
| startDate | Simple attribute |     |     | Date the patient started the medication |
| endDate | Simple attribute |     |     | Date the patient discontinued the medication |
| doseAmount | Simple attribute |     |     | the dose amount expressed in strength or eaches |
| doseAmountUnit | Codeable concept |     |     | The dose amount unit |
| doseRoute | Codeable concept |     |     | The route of administration |
| doseQuantity | Simple attribute |     |     | The dose quantity dispensed |
| doseQuantityUnit | Simple attribute |     |     | The dose quantity units |
| instructions | Simple attribute |     |     | The medication instruction text |
| adherence | Codeable concept |     |     | The patient’s adherence to the medication |
| indication | Codeable concept |     |     | The condition the is being treated by the medication |
| fillStatus | Codeable concept |     |     | Fill status of the medication |
| **Procedure** |     |     |     |     |
| **AttributeName** | **Type** |     |     | **Description** |
| procedure | Codeable concept |     |     | The procedure that was performed on the patient |
| procedureDateTime | Simple Attribute |     |     | The date and time the procedure was performed |
| procedureReason | Codeable concept |     |     | The condition that prompted the procedure |
| **VitalSign** |     |     |     |     |
| **AttributeName** | **Type** |     |     | **Description** |
| vitalSign | Codeable concept |     |     | Vital sign assessment/test |
| resultValue | Observation Value |     |     | Vital sign result |
| resultUnit | Codeable concept |     |     | Vital sign result unit, if applicable |
| interpretation | Codeable concept |     |     | Interpretation of vital sign |
| referenceRange | RangeValue |     |     | Reference range for vital sign |
| resultStatus | Codeable concept |     |     | Vital sign result status |
| performingSite | Codeable concept |     |     | Unique identifier for performing site |
| performedDateTime | Simple Attribute |     |     | Date and time vital sign was collected |

### Code System Identifiers in PIQI

Many of the important attributes in patient information are codeable concepts. Codeable concepts are attributed that can be represented by a simple text string or a one or many coded concepts, hence the code**able** concept. If the attribute does contain one or more coded concepts, each coded concept is comprised of three components: a code, display and code system identifier.

**All of these sub attributes must be populated in order for the concept being exchanged to be valid.**

The **code is required** to provide a unique stable identifier for the concept in a given code system.

The **code system identifier is required** to confirm that the code is valid in that code system and, if necessary, determine the status of that code.

The **display is required** so that a human can verify that the code provided does, in fact, semantically match the term has that code in the identified code system. It is also necessary if the concept provided is being mapped/normalized to a standard or local terminology.

One of the issues with validating coded concepts is that often different string values are used to identify the code system for a given code. For example, when sending a LOINC code it is possible to see the following code system identifiers:

LOINC, LNC, LN Code System Simple string identifiers

1.3.6.1.4.1.12009 Codesystem OID

<http://loinc.org> URL

To support code system identifier variants in PIQI there will be a mechanism that will allow for a code system mnemonic that can be used in the configuration of an evaluation profile to represent any valid code system identifier for a given code system and identify the code system identifier that is required to validate that code in the implementations terminology server.

For example, for LOINC this mechanism would establish the ‘LOINC’ mnemonic in the following manner:

| Mnemonic | LOINC |
| --- | --- |
| Description | Logical Observation Identifiers Names and Codes |
| Organization | Regenstrief Institute |
| Code System Identifiers | LOINC |
|     | LNC |
|     | LN  |
|     | 1.3.6.1.4.1.12009 |
|     | <http://loinc.org> |
| Validation Code System | 1.3.6.1.4.1.12009 |

This is another example of how PIQI is designed specifically for patient information. This function will allow, for example, an evaluation profile that is checking for conformance to just pass ‘LOINC’ to the SAM that validated conformity and have it pass if any of the Code System Identifier aliases are used. It also allows a validation SAM to automatically validate a concept that is received using one of the code systems aliases. If at some point in the future another valid code system identifier is defined for a given code system, it can easily be added to this mechanism and automatically reflected in all configured evaluation profiles.

#### Code System JSON structure

```json
    "**codeSytems**": [
        {
            "mnemonic": "LOINC",
            "name": "Logical Observation Identifiers Names and Codes",
            "identifier": "<http://loinc.org>",
            "aliases": [
                "LOINC",
                "LOINC Code",
                "<http://loinc.org>",
                "urn:oid:2.16.840.1.113883.6.1"
            ],
            "terminologyServerStatus": "active"
        },
        {
            "mnemonic": "SNOMEDCT",
            "name": "SNOMED Clinical Terms",
            "identifier": "<http://snomed.info/sct>",
            "aliases": [
                "SNOMED CT",
                "SNOMEDCT",
                "sct",
                "urn:oid:2.16.840.1.113883.6.96"
            ],
            "terminologyServerStatus": "active"
        },
        {
            "mnemonic": "ICD10CM",
            "name": "International Classification of Diseases, Tenth Revision, Clinical Modification",
            "identifier": "<http://hl7.org/fhir/sid/icd-10-cm>",
            "aliases": [
                "ICD-10-CM",
                "ICD10CM",
                "urn:oid:2.16.840.1.113883.6.90"
            ],
            "terminologyServerStatus": "active"
        },
        {
            "mnemonic": "ICD9CM",
            "name": "International Classification of Diseases, Ninth Revision, Clinical Modification",
            "identifier": "<http://hl7.org/fhir/sid/icd-9-cm>",
            "aliases": [
                "ICD-9-CM",
                "ICD9CM",
                "urn:oid:2.16.840.1.113883.6.42"
            ],
            "terminologyServerStatus": "deprecated"
        }
    ]
```

### PIQI Patient Assessment Application Hierarchy

When considering the PIQI information model it is worth nothing that patient data in this model organizes itself into a hierarchical structure with four primary entity levels that can each be evaluated for quality. These entities are as follows:

- **Patient**: A holistic entity that is comprised of all of the characteristics and elements.
- **Data Class**: A collection of data elements with the same attributes representing domain specific items.
- **Element**: A class specific entity that is comprised of a collection of data attributes which represents a discreet item.
- **Element Attribute**: A single data characteristic that relates to the patient or an domain specific element.

<span width="100%">
<img src="patient_assessment_application_hierarchy.png" alt="PIQI Patient Assessment Application Hierarchy" height="25%" width="25%" />
</span>
<br/>


**Reminder**: It is important to restate that PIQI is intended to review a patient message payload representing a single current summary or episode, not a patient’s entire medical history. Large historical patient messages will impact the performance of the assessments, especially assessments at the patient level.

### PIQI Healthcare Data Quality Taxonomy Version 1.0

A standard classification taxonomy for patient information quality issues provides structure and clarity to the process of quality management. This systematic approach allows for the identification and categorization of various types of errors or inconsistencies, which can range from minor inaccuracies to critical misinformation. By classifying these issues, healthcare data stewards can prioritize them based on their potential impact. This methodical categorization facilitates easier tracking and analysis of recurring problems, enabling healthcare organizations to implement targeted improvements. Moreover, standardized taxonomy aids communication among healthcare professionals by providing a common language for discussing quality issues. Ultimately, this leads to enhanced quality control, improved patient outcomes, and a reduction in the likelihood of medical errors, thereby fostering a safer and more reliable healthcare environment.

The PIQI Taxonomy consists of high-level categories, each containing more specific dimensions. It's essential to note that the assessment of patient information quality occurs at both the element and attribute levels, and not all dimensions apply uniformly to both.

Given that the dimensions are designed to categorize qualitative issues, they are presented from a negative perspective. Consequently, the percentages associated with these dimensions indicate the proportion of failures or issues identified within each dimension.

The categories are as follows:  
<span width="100%">
<img src="piqi_taxonomy.png" alt="PIQI Healthcare Data Quality Taxonomy" height="70%" width="70%"/>
</span>

#### Availability Category

This category contains dimensions that relate to the presence of usable information.

Dimensions:

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Missing | Element | Pertains to Elements and specifically evaluates whether an expected element is absent. This dimension can be conceptualized as a method for assessing 'missingness' at an elemental level. _For example, if a patient is diabetic but there is no corresponding element indicating this condition, then the diabetes element is considered missing._ |
| Unpopulated | Attribute | This applies to an Attributes that should be populated with something but are not. This dimension does not evaluate the validity of the Attribute, merely whether or not it has data. This dimension only applies to Attributes of Elements that are not missing. |
| Incomplete | Element<br><br>Attribute | This applies to Elements or complex Attributes where there is inadequate information available to fully represent the attribute or element. _For example, a coded entity (attribute) that is missing its code system is incomplete. In this context the code system Attribute is unpopulated and the coded entity Attribute is incomplete._ |

#### Accuracy Category

This category contains dimensions that relate to the innate validity of the data.

Dimensions:

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Invalid Format | Attribute | This applies to Attributes that are not properly formatted for their expected data type. It is assumed that all Attributes are presented as text strings and therefore validating the format of that string before progressing the data type assessments is necessary. Examples of format is freetext, date, time, timestamp, integer, decimal, single alphanumeric character, etc… |
| Invalid Value | Attribute | This applies to an Attribute that has a value but the value does not conform to the expected set of values for the attribute. This can apply to numeric values, enumerated values that are inappropriate. |
| Invalid Grouping | Element<br><br>Attribute | This applies to Elements or complex Attributes where the combination of Attributes are invalid. |

#### Conformity Category

This category contains dimensions that relate to coded information or referential validity of the data.

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Invalid Member | Attribute | This applies to coded entity complex attributes when the code provided is not a member of the code system provided |
| Incompatible | Attribute | This applies to coded entity complex attributes when the code system provided is not an agreed upon code system per the terms of the criteria. |
| Obsolete | Element<br><br>Attribute | This applies to coded entity complex attributes when the concept provided is no longer active in the code system provided. |

#### Plausibility Category

This category contains dimensions that relate to whether the data makes sense based some context.

| Dimension | Applies to | Definition |
| --- | --- | --- |
| Temporally Implausible | Element<br><br>Attribute | Temporally implausible conditions are identified when an attribute or element is uncertain due to when it occurs in the context of the patients timeline. _An example of this would be a future birth date or a end time that precedes a start time._ |
| Clinically Implausible | Element<br><br>Attribute | Clinically Implausible conditions are identified when an attribute or element is uncertain due to clinical considerations. _An example of this would be a lab result value that is outside a reasonable range of values for a given lab test._ |
| Situationally Implausible | Element | Situationally Implausible conditions are identified when an attribute or element is uncertain due other conflicting elements or attributes. _An example of this would be a high range value that is lower then a low range value._ |

### PIQI Assessment Approach

The PIQI Framework assess patient data that has been put into the PIQI Data Model using an **Evaluation Rubric** which is collection of **Evaluations**, each evaluation a configured **Simple Assessment Module** (SAM) with specific parameters and their individual scoring effects of the evaluation result for each patient data entity.

#### PIQI Simple Assessment Modules

PIQI Simple assessment modules (SAMs) are composable service endpoints that follow a consistent pattern to evaluate a patient message, data class, element or attribute and return a simple ‘pass’, ‘fail’ or ‘conditions not met’ result.  A SAM that has been configured for use in a Evaluation Rubric is referred to simply as an Evaluation.

Each SAM is comprised of the following elements:

| Component | Description |
| --- | --- |
| SAM Name | The name of the SAM |
| Entity Type | This is the patient entity type (entire patient, data class, element, attribute) that the assessment has been designed to evaluate. |
| Assessment Logic | The actual logic that performs the evaluation against the |
| PIQI Dimension | The PIQI taxonomy dimension that most appropriately describes the SAM |
| Required Params | The list of required parameters that must be supplied by the Evaluation Criteria to perform the assessment |

Example: High Level  

<span width="100%">
<img src="high_level_sam_example.png" alt="High Level SAM example" height="70%" width="70%"/>
</span>

Example: Attribute is Present

| Component | Example Value |
| --- | --- |
| SAM Name | Attribute is Present |
| Entity Type | Simple Attribute |
| Assessment Logic | If (Attribute.Value==””) { SAM.Result=”FAIL”} (Psuedocode) |
| PIQI Dimension | Availability.Unpopulated \[AV.UNPOP\] |
| Required Params | N/A |

Example: Coded Entity is Interoperable

| Component | Example Value |
| --- | --- |
| SAM Name | Coded Entity is Interoperable |
| Entity Type | Coded Entity Attribute |
| Assessment Logic | If ((Attribute.CS.Value==CS_PARAM)&&(Attribute.CNF.INVMBR=”PASS”))<br><br>{ SAM.Result=”PASS”} (Psuedocode) |
| PIQI Dimension | Conformity.Incompatible \[CNF.INCMPT\] |
| Required Params | CS_PARAM – Code System Required for Interoperability by Evaluation Criteria |

A SAM can have a **prerequisite SAM**. This is a SAM that must be run and pass prior to this SAM being run. Prerequisites can stack resulting in a series of SAMs that must be run on an entity before in order for the assigned SAM to be run and pass.

<span width="100%">
<img src="prerequisite_sams.png" alt="Prerequisite SAMs"/>
</span>

Prerequisite SAMs cannot have parameters that are not provided to the assigned SAM.

One might be tempted to avoid prerequisite SAMs by encapsulating the prerequisite logic in the assigned SAM. The reason PIQI does not do this is the information on the failure of the entity being evaluated in primary to the definition of the SAM and the SAM itself just returns a pass or fail. In the above example when the assigned assessment ‘Concept is Compatible’ is run the first prerequisite SAM, ‘Attribute is Populated’ is run on the entity. If it fails, the ‘Attribute is Populated’ fails and not the ‘Concept is Compatible’. This conveys the nature of the failure, as opposed to ‘Concept is Compatible’ failing and having to return a reason for the failure.

The idea that the entity fails to pass the assigned SAM is what establishes the entity’s score, but the SAM or prerequisite SAM failure provides the statistics is a core principle of the PIQI approach.

#### PIQI Evaluation Rubric
An evaluation rubric is always based on a given PIQI model and version.  A evaluation rubric based on a given model should be compatible with any future version of the same model as PIQI models are backwards compatible.

An evaluation rubric is the alignment of patient data entities to SAMs as a list of assessable items that contribute to provide a standard scoring rubric for that profile. Evaluation rubrics can be established as a standard or custom scoring rubric.

An given evaluation rubric has a name, version and purpose, A PIQI model and model version along with a sequenced collection of evaluations comprised of SAMs configured and assigned to the patient, data classes, elements and attributes with the necessary parameters, conditions, scoring effect, weight and criticality.

Example: Graphical Depiction of an Evaluation profile for a data class

<span width="100%">
<img src="evaluation_profile.png" alt="Graphical Depiction of an Evaluation profile for a data class" height="70%" width="70%"/>
</span>

#### Evaluation Rubric Assessments

The core of an Evaluation Criteria is the sequenced collection of entity assessments. Each step has the following components:

| Component | Description |
| --- | --- |
| Step Sequence | Execution Sequence |
| Data Class | The Data Class from the PIQI Model |
| Entity | The class, element or specific attribute from the PIQI Data Model that is being assessed |
| SAM | The Simple Assessment Module |
| SAM Params | List of Parameters and values necessary to perform assessment |
| Effect | The effect of assessment failure on the qualitative status of the entity being assessed (Scoring, Informational) |
| Condition | The precondition that must be met to include the assessment |
| Weight | The weight that is applied to the weighted score value numerator and denominator |
| Criticality | A true/false indicator as to whether the assessment is considered critical in the evaluation profile. |

#### Scoring Effect

An assigned SAM is typically used to score the quality of the data in a message but can also be used to collect data without impacting the quality score. The Scoring Effect is essentially a switch that tells the PIQI engine to collect statistics for a given SAM without effecting the numerator or denominator of the score for the message.

#### Weight

In some cases, a PIQI user may want to weigh the score in a rubric allowing some SAMs to have more impact than others. By default, the weight for any assigned SAM is one. If a particular evaluation profile does use a weighted score for one or more SAMs the PIQI engine will produce a PIQI Score and a PIQI Weighted Score for the message being assessed. Both scores will be a percentage of a numerator over a denominator with a maximum score of 100% of all possible points, weighted or unweighted.

#### Criticality

The criticality indicator on an assigned SAM allows the user to flag that assessment as critically important to the rubric. As an alternative to a weighted score the criticality indicator provides the ability to indicate that message has critical qualitative issues that may make the data unusable without effecting nature of the unweighted numerator/denominator percentage.

#### Conditional Assessments

In some cases, an assigned SAM should only be applied if another condition is true. While this may seem similar to a prerequisite SAM it affects the scoring in a very different way.

If a **prerequisite** SAM for an assigned SAM fails, this is considered an entity assessment failure which increments the denominator but not the numerator for that assessment. In other words, the assessment is a failure.

If a **conditional** SAM for an assigned SAM fails, this means the conditions for the assigned SAM were not met and the assigned SAM should not be run. Neither the numerator nor the denominator is incremented.

### Evaluation Criteria Execution

The sequence of execution of the Evaluation Criteria Assessments controls the order of assessment within a given data class. The data class execution sequence is defined as the sequence of patient data loaded into the PIQI model. The sequence of assessment will repeat within a given data class until it has completed all the elements of that data class. Upon completion of the assessment of all the elements in a given data class, the data class assessments themselves (if defined) are executed. Upon completion of all elements and data class assessments, patient scope assessments (if defined) are executed.

### PIQI Scoring in a Nutshell

The objective for PIQI data quality scoring is to provide a useful score card that provides the data consumer with insight into the quality of a patient data payload based on a given evaluation profile.

The most basic result returned from a PIQI scorecard evaluation would be the following:

| **MessageID** | The MessageID submitted with the scoring request |
| --- | --- |
| **DataProviderID** | The DataProviderID submitted with the scoring request |
| **DataSourceID** | The DataSourceID submitted with the scoring request |
| **Potential Item Score** | A count of the total number of scorable items in the patient data payload. This is also the score denominator. |
| **Total Item Score** | A count of the total number of scoreable items that passed according to the evaluation profile rubric. This is also the score numerator. |
| **PIQI Index** | The Total Item Score is divided by the Potential Item Score. Resulting in a value from 0 to 100. |
| **Critical Failure Count** | A count of the scorable items that were flagged as critical and did not pass |
| **Data Class Frequency** | a count of the total number of elements within each data class in the patient data payload. This will only include data classes that are referenced in the evaluation profile. |
| _(If Weighted scores are used)_ |     |
| **Potential Weighted Item Score** | A count of the total number of scorable item weights in the patient data payload. This is also the score denominator. |
| **Total Weighted Item Score** | A count of the total number of scoreable item weights that passed according to the evaluation profile rubric. This is also the score numerator. |
| **PIQI Weighted Index** | The Total Weighted Item Score is divided by the Potential Weighted Item Score. Resulting in a value from 0 to 100. |

### Verbose Scoring

When the PIQI Framework is used in verbose scoring mode, the score information above is returned along with the original message with each element including the scoring details.

### PIQI Technical Components

The PIQI Framework is actualized with the following components:

Structured Data Architecture Components

- HDQT Taxonomy – structured data
- PIQI Model Structure – structured data
- Standard Code System Mappings – structured data
- Simple Assessment Module Reference Library – structured data
- Evaluation Rubric Reference Library – structured data

Structured Data Asset Components

- Evaluation Rubric Definition(s) – structured data
- Evaluations - configured SAMs
- Simple Assessment Module – Evaluation Definition(s) – structured data
- SAM Specific evaluation content – structured data

Software Components

- PIQI Framework Scoring Engine RESTful Service
- FHIR (or equivalent) Terminology Server
<span width="100%">
<img src="piqi_technical_components.png" alt="PIQI Technical Components" width="85%" />
</span>

### PIQI Alliance as a Community of Practice

The PIQI Framework is designed to be implemented within a community of practice. With encapsulated, portable, content driven components, the ability to share knowledge and evolve establishes great potential for rapid evolution and adoption.

### PIQI Model Extensions

PIQI Framework starts with a simple model intended to support the assessment of core clinical patient data. The simplicity of this model allows for extension through the addition of attributes and data classes. Ideally these extensions would be adopted into the core PIQI model through a standard process.

### Shared Simple Assessment Modules

While many of the foundational, attribute level SAMs are algorithmic, SAMs that apply to codeable concepts, elements, data classes and patient level data often require structured content in the form of value sets, tuples and other data patterns. These data packages can be openly shared or licensed in a community portal. More sophisticated algorithmic SAMs, perhaps based on generative AI, could also be hosted as RESTful services through wrapper SAM interfaces.

### Shared Evaluation Profiles

While the Evaluation Profiles in PIQI are designed to be configured to support the needs of the implementer, the ability to establish sanctioned standard evaluation profiles is one of the most beneficial features of the PIQI Framework. The ability to publish and share an evaluation profile, along with its dependent SAMs and PIQI Model components can minimize duplication of effort and provide a powerful way to create a common basis for understanding data quality across the community.

### PIQI Endpoint Registration

Within the community of practice implementations of the PIQI Framework could be registered and certified to facilitate the ability to share content seamlessly with other community members.

### PIQI Data Source Unique Identifier

The PIQI Framework was created to assess and improve the quality of patient data from a given source. However, this raises a crucial question: How do we uniquely and ubiquitously identify the source of that data?

In healthcare, we have various identifier types for institutions, facilities, and providers, but no unique identifier for the data entity responsible for generating and sharing patient data. This is analogous to an IP address in a computer network—an essential component that enables modern data-sharing networks to recognize and authenticate each participant.

This is not merely a "nice to have" feature. Establishing a unique data source identifier is critical for trust, traceability, and provenance in our national healthcare infrastructure.

While the PIQI Framework does not mandate a global unique data source identifier, incorporating one would significantly enhance our ability to assess the quality and reliability of data exchange participants—regardless of their role or the nature of the coordinating entity.
