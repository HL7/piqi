### Simple Assessment Modules (SAMS)

**Patient Information Quality Improvement Framework**

**SAM Guide**

Version 1.1

May 1, 2025

Charles Harp – PIQI Alliance

Contents

[PIQI Assessment Approach 5](#_Toc197421510)

[Simple Assessment Modules 5](#_Toc197421511)

[Anatomy of a Simple Assessment Module (SAM) 6](#_Toc197421512)

[SAM Mnemonic 6](#_Toc197421513)

[SAM UID 6](#_Toc197421514)

[SAM Name 6](#_Toc197421515)

[SAM Success Alias 6](#_Toc197421516)

[SAM Failure Alias 6](#_Toc197421517)

[SAM Description 6](#_Toc197421518)

[SAM Input Type 6](#_Toc197421519)

[SAM PIQI Model 7](#_Toc197421520)

[SAM Parameters 7](#_Toc197421521)

[SAM Parameter Name 7](#_Toc197421522)

[SAM Parameter Description 7](#_Toc197421523)

[SAM Parameter Type 7](#_Toc197421524)

[SAM Prerequisite SAM Mnemonic 7](#_Toc197421525)

[SAM HDQT Dimension Mnemonic 7](#_Toc197421526)

[SAM Execution Type 8](#_Toc197421527)

[SAM Execution Reference 8](#_Toc197421528)

[SAM Creation DateTime 8](#_Toc197421529)

[SAM Modification DateTime 8](#_Toc197421530)

[SAM Source 8](#_Toc197421531)

[Source Name 8](#_Toc197421532)

[PIQI Alliance Member UID 8](#_Toc197421533)

[Examples of SAM Definition JSON 9](#_Toc197421534)

[Standard Simple Assessment Modules 10](#_Toc197421535)

[Simple Attribute SAMs 10](#_Toc197421536)

[Attribute is Populated 11](#_Toc197421537)

[Attribute is Numeric 11](#_Toc197421538)

[Attribute is Integer 11](#_Toc197421539)

[Attribute is Decimal 12](#_Toc197421540)

[Attribute is Positive Number 12](#_Toc197421541)

[Attribute is Negative Number 12](#_Toc197421542)

[Attribute is Date 13](#_Toc197421543)

[Attribute is Future Date 13](#_Toc197421544)

[Attribute is Past Date 13](#_Toc197421545)

[Attribute is Time 14](#_Toc197421546)

[Attribute is TimeStamp 14](#_Toc197421547)

[Attribute is Timestamp with Time Zone 14](#_Toc197421548)

[Attribute Matches Regex 15](#_Toc197421549)

[Attribute Is In List 15](#_Toc197421550)

[Codable Concept SAMs 16](#_Toc197421551)

[Codable Concept has Code 17](#_Toc197421552)

[Codable Concept has Code System 17](#_Toc197421553)

[Codable Concept has Display 17](#_Toc197421554)

[Codable Concept Is Complete 18](#_Toc197421555)

[Codable Concept Is Valid Concept 18](#_Toc197421556)

[Codable Concept Is Active 18](#_Toc197421557)

[Codable Concept Is Valid Member 19](#_Toc197421558)

[Codable Concept Is Semantically Consistent 19](#_Toc197421559)

[Observation Value SAMs 20](#_Toc197421560)

[Observation Value Type in List 21](#_Toc197421561)

[Observation Value Matches Type 21](#_Toc197421562)

[Observation Value is Qualitative 21](#_Toc197421563)

[Range Value SAMs 22](#_Toc197421564)

[Range Value Is Complete 22](#_Toc197421565)

[Range Value Is Valid 22](#_Toc197421566)

[Element SAMs 23](#_Toc197421567)

[Element is Clean 23](#_Toc197421568)

[Lab Result Unit Matches Test 23](#_Toc197421569)

[Lab Result Value Is Plausible 24](#_Toc197421570)

[Condition Is Sex Plausible 24](#_Toc197421571)

[Data Class SAMs 25](#_Toc197421572)

[Data Class Has Duplicates 25](#_Toc197421573)

[Patient Message SAMs 26](#_Toc197421574)

[Patient is Undocumented Diabetic 26](#_Toc197421575)

# PIQI Assessment Approach

The PIQI Framework assesses patient data in the PIQI Data Model using an **Evaluation Profile**.

The Evaluation Profile is a sequenced collection of **Evaluation Criteria**.

Each Evaluation Criteria is comprised of a specific **PIQI Model Entity** an assigned **Evaluation** an optional **Condition** and the **Scoring Effect.**

The PIQI Model Entity can be an attribute, element, data class or the entire patient.

The **Evaluation** and **Condition** are both configured **Simple Assessment Modules** (**SAMs**).

If the **Condition** is configured, the **Evaluation** is only processed if the conditional SAM passes.

Each Evaluation that is processed triggers the **Scoring Effect** based upon the pass or fail result of the underlying SAM. If the SAM returns an indeterminant result (could not assess) the Evaluation is skipped. This implies a condition within the implementation of the SAM itself was not met.

INSERT A diagram of a model entity

## Simple Assessment Modules

Simple assessment modules (SAMs) are composable service endpoints that follow a consistent interface pattern, evaluate a patient message, data class, element or attribute and return a simple ‘pass’, ‘fail’ or ‘could not assess’ result.

# Anatomy of a Simple Assessment Module (SAM)

A SAM is comprised of the following component:

## SAM Mnemonic

The SAMID is a mnemonic identifier that is used to identify a unique SAM. The Mnemonic is intended to be universal so that common SAMs can be referenced across implementations in the PIQI community. This is the primary identifier to reference a given SAM.

## SAM UID

The SAMUID is an optional implementation specific unique identifier. This identifier can vary from implementation to implementation.

## SAM Name

The name of the SAM. This name should be in the context of the SAM passing. For example, if the SAM is assessing if a attribute is populated the same name would be ‘Is populated’.

## SAM Success Alias

The alias for the SAM that is used when communicating that the SAM has passed. For example, in the SAM name is ‘Attribute is populated’ the SAM Success Alias would be ‘Is populated’.

## SAM Failure Alias

The alias for the SAM that is used when communicating that the SAM has failed. This is typically the reciprocal of the SAM Success Alias. For example, in the SAM name is ‘Is populated’ the SAM Failure Alias would be ‘Is not populated’.

## SAM Description

This is a brief description of the purpose of the SAM.

## SAM Input Type

This is the entity type that the SAM expects as input. The initial Input types are as follows:

**Simple_Attribute** A simple string attribute JSON string

**Codable_Concept_Attribute** A codable concept attribute JSON string

**Observation_Value** a observation value JSON string

**Ranged_Value** A ranged value JSON string

**Element** A domain element JSON collection

**Data_Class** A domain data class, element JSON collection

**Patient** The entire patient JSON collection

For the Element and Data Class input Types the PIQI Model is required.

## SAM PIQI Model

SAMs that use elements as input types will have a requirement to specify the minimum PIQI model and minimum version that is required to provide the SAM with the necessary attribute components in the body of the element. It has the following components:

### PIQI Model Mnemonic

The standard mnemonic for the PIQI model

### PIQI Model Version

The numeric version of the PIQI Model

### PIQI Model Mnemonic

The mnemonic for the specific standard model version.

## SAM Parameters

This is a list of parameters that the SAM accepts each parameter has multiple components:

### SAM Parameter Name

This is the name of the parameter in the parameter. This name is used in in the parameter JSON that is passed to the SAM.

### SAM Parameter Description

This is the description of the nature and purpose of the parameter.

### SAM Parameter Type

This is the parameter type and can be one of the following values. The specific parameter types can be used to simplify SAM configuration. All SAM parameters are passed to the SAM as a JSON collection on execution.

**Code_System_Identifier** A code system or value set identifier

**Demographic_Attribute** A patient demographic attribute

**Content_Asset_Mnemonic** A defined content asset in the content library

**Simple_Text_Parameter** A simple free text vale.

## SAM Prerequisite SAM Mnemonic

This is the SAM Mnemonic for the SAM that must pass before this SAM can run. This is an optional property.

## SAM HDQT Dimension Mnemonic

This defined the healthcare data quality taxonomy dimension that this SAM is bound to. The mnemonic is from the HDQT dimension list.

## SAM Execution Type

This defines the nature of the machinery of the SAM and can have the following values.

**Primitive_Logic** The execution is primitive logic that is hard wired into the PIQI framework.

**Regex_Pattern** The execution is primitive logic that uses regex to match reference data

**Stored_Procedure** The execution is using a SQL stored procedure.

**RESTful_Service** The execution is calling a RESTful service.

**Value_Set_Enum** The execution is using a Value Set on enumerated strings

**Value_Set_Code** The execution is using a value set of codings

For the Stored_Procedure and RESTful_Service execution types the assumption is they have an interface that matches the SAM interface for the input type.

## SAM Execution Reference

This is the meta-data that describes the information necessary to execute the SAM based on the execution type.

- If the execution type is Primitive_Logic, this property is blank.
- If the execution type is Stored_Procedure, this would be the stored procedure name.
- If the execution type is RESTful_Service, this would be the URL for the RESTful service endpoint.
- If the execution type is Value_Set, this would be the value set identifier in the repository.

## SAM Creation DateTime

The date and time the SAM was created. This is optional for primitive SAMs.

## SAM Modification DateTime

The date and time the SAM was last updated.

## SAM Source

The author of the SAM and related reference resources. This is optional for primitive SAMs.

### Source Name

The name of the source of the SAM

### PIQI Alliance Member UID

The PIQI Alliance Member unique identifier.

## Examples of SAM Definition JSON

A primitive SAM for Attribute is Valid Date:

{

"SAMs": \[{

"mnemonic": "Attr_IsValidDate",

"uniqueID": " 5ea00021-24ce-40c2-a1f7-02875b7732f0",

"name": "Attribute is valid date",

"successAlias": "Valid date",

"failureAlias": "Invalid date",

"description": "Determines if a simple attribute is a valid date",

"inputType": "SimpleAttribute",

"parameters": \[\],

"prerequisiteSAMMnemonic": "Attr_IsPopulated",

"HDQTDimensionMnemonic": "Accuracy.InvalidFormat",

"executionType": "Primitive_Logic",

"executionReference": "",

"createdDateTime": "",

"modifiedDateTime": "",

“Source”: \[

{ "Name": "PIQI Alliance",

"PIQIAllianceMemberUID": ”f0f3de6d-c3d8-483c-a8ff-004a66dbc551"}\]

}\]

}

A Stored Procedure SAM for lab result unit plausibility based on LOINC:

{

"SAMs": \[

{

"mnemonic": " Lab_PlausibleUnit_LOINC_V1",

"uniqueID": "2241d12c-58a4-4596-ae0f-e983b0ba5209",

"name": " Lab Result Unit is plausible (LOINC) – V1",

"success_Alias": " plausible unit ",

"failure_Alias": " implausible unit",

"description": " Evaluates a populated result unit against a valid LOINC Code",

"PIQIModel": {

"mnemonic": "PAT",

"version": 1,

"versionMnemonic": "PAT_V1"

}

"input_Type": "Element:LabResult",

"parameters": \[\],

"prerequisiteSAMMnemonic": "",

"HDQTDimensionMnemonic": "Plausibility.Clinical ",

"executionTypeMnemonic": " Stored_Procedure ",

"execution_Reference": " spLOINC_UnitPlausibility ",

"createdDateTime": "20250315",

"modifiedDateTime": "20250315",

"source": \[

{

"name": "PIQI Alliance",

"PIQIAllianceMemberUID": "f0f3de6d-c3d8-483c-a8ff-004a66dbc551"

}

\]

}

\]

}

# Standard Simple Assessment Modules

The standard SAMs are those that operate against attributes that use primitive logic for performance.

## Simple Attribute SAMs

A **simple attribute** is a string value in the JSON attribute structure. Simple attributes can contain any string and can be used to represent any single basic data type like text, simple numbers, structured numbers and dates.

Example: In this example the EffectiveDateTime attribute is a simple attribute.

"labElements": \[

{

"effectiveDateTime": "20230111135518",

For the purposes of a SAM complex attribute type like Codable Concepts, Ranged Values and Observation values can be treated like simple attributes.

A **codable concept** attribute is a structure that can be represented as a simple attribute or a coded entity. Many attributes in patient data can be represented by a coded entity or a simple code value and as such is represented by a text sub-attribute and a codings collection.

**Example:** In this Test example the highlighted text is considered the simple attribute value of the codable concept.

"test":

{

"text": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",

"codings": \[

{

"code": "742-7",

"display": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",

"system": "LOINC"

}\]},

Each complex attribute has a similar **text** field at the root level of its JSON structure. This **text** value is what is assessed by **simple attribute** SAMs.

The most common simple attribute SAM is ‘**Is Populated**’ which is used as a prerequisite for many downstream SAMs.

### Attribute is Populated

This SAM is designed to assess if a simple attribute has content. For complex attribute types it assesses the ‘Text’ sub property which should include the entire source field the complex attribute us derived from.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsPopulated |
| Success Alias | is populated |
| Failure Alias | Is not populated |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | \-  |
| HDQT Dimension | Availablity.Populated |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Numeric

This SAM is designed to assess if a simple attribute is a number. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsNumeric |
| Success Alias | is numeric |
| Failure Alias | Is not numeric |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Integer

This SAM is designed to assess if a simple attribute is an integer. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsInteger |
| Success Alias | is an integer |
| Failure Alias | Is not an integer |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Decimal

This SAM is designed to assess if a simple attribute is a decimal. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsDecimal |
| Success Alias | is a decimal |
| Failure Alias | Is not a decimal |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Positive Number

This SAM is designed to assess if a simple attribute is a positive number. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsPositiveNumber |
| Success Alias | is a positive number |
| Failure Alias | Is not a positive number |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Negative Number

This SAM is designed to assess if a simple attribute is a negative number. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsNegativeNumber |
| Success Alias | is a negative number |
| Failure Alias | Is not a negative number |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Date

This SAM is designed to assess if a simple attribute is a date. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsDate |
| Success Alias | is a date |
| Failure Alias | Is not a date |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Future Date

This SAM is designed to assess if a simple attribute is a date in the future. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsFutureDate |
| Success Alias | is a future date |
| Failure Alias | Is not a future date |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Past Date

This SAM is designed to assess if a simple attribute is a date in the future. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsPastDate |
| Success Alias | is a past date |
| Failure Alias | Is not a past date |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Time

This SAM is designed to assess if a simple attribute is a time. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsTime |
| Success Alias | is a time |
| Failure Alias | Is not a time |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is TimeStamp

This SAM is designed to assess if a simple attribute is a timestamp including a date and time. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsTimestamp |
| Success Alias | is a timestamp |
| Failure Alias | Is not a timestamp |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute is Timestamp with Time Zone

This SAM is designed to assess if a simple attribute is a timestamp including a date, time and time zone. This should only apply to simple attributes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_IsTimestampTz |
| Success Alias | is a timestamp with time zone |
| Failure Alias | Is not a timestamp with time zone |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Attribute Matches Regex

This SAM is designed to assess if a simple attribute matches the regex pattern provided in the parameter. This should only apply to simple attributes and is intended to handle situations in an evaluation profile not covered by standard pattern SAMS.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_MatchesRegex |
| Success Alias | matches the regex pattern |
| Failure Alias | does not match the regex pattern |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | Paramter_1:Regular Expression |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidFormat |
| Execution Type | Regular_Expression |
| Execution Reference | (provided in Parameter_1) |
| Source | PIQI Alliance |

### Attribute Is In List

This SAM is designed to assess if a simple attribute is a member of a list of enumerate values.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Attr_InList |
| Success Alias | Is in list |
| Failure Alias | Is not in list |
| Input Type | Simple attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | Paramter_1:Enumerated_Valueset_Mnemonic |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Value |
| Execution Reference | (provided in Parameter_1) |
| Source | PIQI Alliance |

## Codable Concept SAMs

A Codable Concept attribute is a structure that can be represented as a simple attribute or a coded entity. Many attributes in patient data can be represented by a coded entity or a simple code value and as such is represented by a text sub-attribute and a codings collection.

**CodableConcept sub-attributes**

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

"test":

{

"text": " MONOCYTES, Serum",

"codings": \[

{

"code": "MONO100",

"display": "MONOS",

"system": "LCL"

},

{

"code": "742-7",

"display": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",

"system": "LOINC"

},

{

"code": "123456789",

"display": "MONOCYTES, Serum",

"system": ""

}\]},

For SAMs assessing **codable concepts**, the coding collection is critical and is assessed as an aggregate. Since a **codable concept** attribute can have more than one code in the **codings** collection an assessment is evaluating the entire collection looking for the best-case scenario.

In the above example there are three **codings** in the collection. The SAMs that assess the **codings** like **has code**, **has code system** and **has display** provide the best-case scenario based on all of the **codings**. So, for the above example each of those SAMs would pass. The **Is Complete** assesses if at least **one coding** has all three parts. So, it would also pass because the second **coding** is complete. The **Is Valid Member** SAM would take the code system from each complete coding and attempt to validate that coding using the terminology server. If the code system is published to the terminology server and the code is valid it would also pass. The **Is Compatible** SAM with the LOINC parameter would also pass since at least one of the codings in the collection is valid and has a recognized representation of the LOINC code system.

It is also worth noting that **Codable Concepts SAMs** also work with **Observation Value** attributes since they can contain a **codings** collection.

### Codable Concept has Code

This SAM is designed to assess if a codable concept attribute has at least ONE code value in its codings collection.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_HasCode |
| Success Alias | has code |
| Failure Alias | does not have code |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Availability.IsPopulated |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept has Code System

This SAM is designed to assess if a codable concept attribute has at least ONE code system value in its codings collection.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_HasCodeSystem |
| Success Alias | has code system |
| Failure Alias | does not have code system |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Availability.IsPopulated |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept has Display

This SAM is designed to assess if a codable concept attribute has at least ONE code system value in its codings collection.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_HasDisplay |
| Success Alias | has display |
| Failure Alias | does not have display |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Availability.IsPopulated |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept Code System is Recognized

This SAM is designed to assess if a codable concept attribute has at least ONE code system that is recognized by the environment.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_HasRecognizedCodeSystem |
| Success Alias | code system recognized |
| Failure Alias | code system not recognized |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.ValidValue |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept Is Complete

This SAM is designed to assess if a codable concept attribute has at least ONE complete coding (code, code system and display) in its codings collection.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_IsComplete |
| Success Alias | Is complete |
| Failure Alias | Is not complete |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Availability.Complete |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept Is Valid Concept

This SAM is designed to assess if a codable concept attribute has at least ONE complete coding (code, code system and display) in its codings collection that is a valid member of is provided code system.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_IsValid |
| Success Alias | Is a valid concept |
| Failure Alias | Is not a valid concept |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Concept_IsComplete |
| HDQT Dimension | Conformance.Invalid |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept Is Valid Member

This SAM is designed to assess if a codable concept attribute has at least ONE complete coding (code, code system and display) in its codings collection that is a valid member of the code system or value set provided in the parameter. This is used to determine if the concept is compatible.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_IsValidMember |
| Success Alias | Is a valid member |
| Failure Alias | Is not a valid member |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | Parameter_1: Codesystem/Valueset Mnemonic |
| Prerequisite SAM | Concept_IsComplete |
| HDQT Dimension | Conformance.Incompatible |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept Is Semantically Consistent

This SAM is designed to assess if a codable concept attribute’s text value is consistent with the compatible codings display as it is represented in the terminology server.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_IsConsistent |
| Success Alias | Is semantically consistent |
| Failure Alias | Is not semantically consistent |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) | Parameter_1: Similarity Tolerance Percentage |
| Prerequisite SAM | Concept_IsValidMember |
| HDQT Dimension | Accuracy.InvalidValue |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Codable Concept Is Active

This SAM is designed to assess if a codable concept attribute has at least ONE complete coding (code, code system and display) in its codings collection that is an active member of is provided code system.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Concept_IsActive |
| Success Alias | Is a active concept |
| Failure Alias | Is a obsolete concept |
| Input Type | Codable Concept Attribute |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | Concept_IsValidConcept |
| HDQT Dimension | Conformance.Obsolete |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

## Observation Value SAMs

An **Observation Value** attribute is a structure that can be represented as a simple attribute value or a structure observation value. **Observation Value** is a specialized attribute as many elements in patient information can be represented by quantitative, text or coded concepts value. It is important to remember that simple attribute SAMs, codable concept SAMs and range value SAMs can all be applied to an **Observation Value** attribute

**Observation Value sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the value |
| type | Codable concept | Collection of zero-to-many coded concepts representing the value type |
| number | Simple Attribute | For numeric values |
| number2 | Simple Attribute | For second numeric value – used for structured numrics like ranges and ratios |
| codings | Codable concept | Collection of zero-to-many coded concepts representing the observation value |

Example:

"resultValue": {

"text": "Abnormal",

“number”: ””,

“number2”: “”,

"type": {

“text”: “CE”,

“codings”: \[

{

“system” : “HL7-0125”,

“code” : “CE”,

“display” : “Coded Entry”

}

},

"codings": \[

{

"system": "LOINC",

"code": "11111",

"display": "Abnormal"

}

\]

}

}

<table><tbody><tr><th><p><strong>Typical Value Types</strong></p><ul><li>CE Coded Entry</li><li>CWE Coded Entry with Exceptions</li><li>ST String</li><li>DT Date</li><li>ED Encapsulated Data</li><li>FT Formatted Text</li></ul></th><th><ul><li>NM Numeric</li><li>SN Structured Numeric</li><li>RP Reference Pointer</li><li>TM Time</li><li>TS TimeStamp</li><li>TX Text Data</li></ul></th></tr></tbody></table>

### Observation Value Type in List

This SAM is designed to assess if an observation result value type is contained in the comma separated list of value type codes.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | ObservationValueType_InList |
| Success Alias | Value type in list |
| Failure Alias | Value type not in list |
| Input Type | Observation_Value |
| Domain Mnemonic | \-  |
| Parameter(s) | Parameter1:ValueTypeMnemonicLCSVList |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Accuracy.InvalidValue |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Observation Value Matches Type

This SAM is designed to assess if an observation result value is consistent with the expressed value type.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | ObservationValue_MatchesType |
| Success Alias | Value matches type |
| Failure Alias | Value does not match type |
| Input Type | Observation_Value |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | ObservationValue_HasType |
| HDQT Dimension | Accuracy.InvalidValue |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Observation Value is Qualitative

This SAM is designed to assess if an observation result value type is a qualitative result. This SAM is used as a conditional SAM for assessing the coding of qualitative results. It is hardwired to use value types of CE, CWE, CD, and ST.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | ObservationValue_IsQualitative |
| Success Alias | Value is qualitative |
| Failure Alias | Value is not qualitative |
| Input Type | Observation_Value |
| Domain Mnemonic | \-  |
| Parameter(s) |     |
| Prerequisite SAM | ObservationValue_HasType |
| HDQT Dimension | Accuracy.InvalidValue |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

## Range Value SAMs

A RangeValue attribute is a structure that can be represented as a simple attribute value or a structure ranged value. The RangeValue is a specialized attribute as many elements in patient information can be represented by a structured range.

**RanegValue sub-attributes**

| **AttributeName** | **Type** | **Description** |
| --- | --- | --- |
| text | Simple Attribute | Text representation of the value range |
| lowValue | Simple Attribute | Text representation of the low value |
| highValue | Simple Attribute | Text representation of the high value |

**Example**:

"referenceRange": {

“text": "14-88",

"lowValue": "14",

"highValue": "88"

}

### Range Value Is Complete

This SAM is designed to assess if a range value has both numeric components.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | RangeValue_IsComplete |
| Success Alias | Is complete |
| Failure Alias | Is not complete |
| Input Type | Range_Value |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | Attr_IsPopulated |
| HDQT Dimension | Availability.IsComplete |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Range Value Is Valid

This SAM is designed to assess if a range value’s numeric components are logically valid.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | RangeValue_IsValid |
| Success Alias | Is valid |
| Failure Alias | Is not valid |
| Input Type | Range_Value |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | RangeValue_IsComplete |
| HDQT Dimension | Accuracy.InvalidValue |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

## Element SAMs

An Element is a data class specific collection of attributes based on the PIQI Data Model specification. An Element SAMs has an input type that is the JSON for that element including all of its constituent attributes and audit information for those attributes.

While most attribute SAMs are primitive, it is expected that element level attributes will be based on content and require that the constituent attribute SAMs have passed.

Here are some examples of Element SAMs.

### Element is Clean

This SAM is designed to assess if an element constituent attribute SAMs have all passed. The term ‘Clean’ in PIQI parlance means that all of the scoring evaluations for something have passed.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Element_IsClean |
| Success Alias | Is clean |
| Failure Alias | Is not clean |
| Input Type | Element |
| Domain Mnemonic | &lt;any&gt; |
| Parameter(s) | \-  |
| Prerequisite SAM | \-  |
| HDQT Dimension | Availability.Incomplete |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

### Lab Result Unit Matches Test

This SAM is designed to assess if a lab result unit (or lack of unit) is plausible based on a valid LOINC Code.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | LabResult_UnitIsPlausible |
| Success Alias | Unit is plausible |
| Failure Alias | UNit is not plausible |
| Input Type | Element |
| Domain Mnemonic | LabResult |
| Parameter(s) | \-  |
| Prerequisite SAM | Element_IsClean |
| HDQT Dimension | Plausibility.ClinicallyImplausible |
| Execution Type | Stored_Procedure |
| Execution Reference | spLabResUnit_IsPlausible |
| Source | PIQI Alliance |

### Lab Result Value Is Plausible

This SAM is designed to assess if a lab result value is plausible based on a valid LOINC Code and unit of measure.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | LabResult_ValueIsPlausible |
| Success Alias | Value is plausible |
| Failure Alias | Value is not plausible |
| Input Type | Element |
| Domain Mnemonic | LabResult |
| Parameter(s) | \-  |
| Prerequisite SAM | LabResult_UnitIsPlausible |
| HDQT Dimension | Plausibility.ClinicallyImplausible |
| Execution Type | Stored_Procedure |
| Execution Reference | spLabResValue_IsPlausible |
| Source | PIQI Alliance |

### Condition Is Sex Plausible

This SAM is designed to assess if a condition is plausible based on the birth sex from the patient demographics. It would also assume the condition code in the element is coded to SNOMEDCT.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Condition_SexPlausible |
| Success Alias | Is plausible for patient birth sex |
| Failure Alias | Is implausible for patient birth sex |
| Input Type | Element |
| Domain Mnemonic | Condition |
| Parameter(s) | \-  |
| Prerequisite SAM | Element_IsClean |
| HDQT Dimension | Plausibility.ClinicallyImplausible |
| Execution Type | Stored_Procedure |
| Execution Reference | spCondition_IsPlausibleForSex |
| Source | PIQI Alliance |

## Data Class SAMs

A **Data Class** represents a domain specific collection of attributes that are instantiated in Elements. A **Data Class** SAM is intended to evaluate scenarios across its collection of elements. Typically, this type of SAM is used to identify inconsistency, duplication or disjoint conditions.

Here is an example of **Data Class** SAM.

### Data Class Has Duplicates

This SAM is designed to assess if a **Data Class** collection has duplicates. The attributes used to identify duplication are passed in the parameters.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Class_HasDuplicates |
| Success Alias | Has duplicates |
| Failure Alias | Does not have duplicates |
| Input Type | Data Class |
| Domain Mnemonic | &lt;any&gt; |
| Parameter(s) | &lt;Identity Attrbutes – comma delimited&gt; |
| Prerequisite SAM | \-  |
| HDQT Dimension | Availability.Duplication |
| Execution Type | Primitive_Logic |
| Execution Reference | \-  |
| Source | PIQI Alliance |

## Patient Message SAMs

A SAM that evaluates the entire patient message, including all of its data classes and elements, is contemplated in the PIQI framework. This type of SAM can be used to look for gaps in information and other message level plausibility concerns. Careful consideration should be given to this type of SAM as the message payload JSON could be quite large and could significantly impact the performance of the gateway. SAMs that perform **Data Class** specific assessments but require patient information should be element level SAMs that use a patient demographics parameter. (see [Condition is Sex Plausible](#_Condition_Is_Sex) example)

Here is an example of a patient level SAM.

### Patient is Undocumented Diabetic

This SAM is designed to process the patient message with a multi-data class inference that determines if the patient has Type 2 Diabetes Mellitus based on labs, medications and comorbidities, but does have no mention of Diabetes on their condition list. This SAM would return a ‘condition not met’ if the patient has diabetes in their conditions list or does meet the criteria for the evaluation.

| **Property** | **Value** |
| --- | --- |
| SAM Mnemonic | Patient_IsUndocumentedDiabetic |
| Success Alias | Is undocumented diabetic |
| Failure Alias | Is not undocumented diabetic |
| Input Type | Patient |
| Domain Mnemonic | \-  |
| Parameter(s) | \-  |
| Prerequisite SAM | \-  |
| HDQT Dimension | Availability.Missing |
| Execution Type | RESTful Service |
| Execution Reference | \-  |
| Source | PIQI Alliance |
