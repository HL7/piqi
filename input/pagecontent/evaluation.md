
**Evaluation Profiles**

The PIQI Framework assesses patient data in the PIQI Data Model using an **Evaluation Profile**.

The Evaluation Profile is a sequenced collection of **Evaluation Criteria**.

Each Evaluation Criteria is comprised of a specific **PIQI Model Entity** an assigned **Evaluation** an optional **Condition** and the **Scoring Effect.**

The PIQI Model Entity can be an attribute, element, data class or the entire patient.

The **Evaluation** and **Condition** are both configured **Simple Assessment Modules** (**SAMs**).

If the **Condition** is configured, the **Evaluation** is only processed if the conditional SAM passes.

Each Evaluation that is processed triggers the **Scoring Effect** based upon the pass or fail result of the underlying SAM. If the SAM returns an indeterminant result (could not assess) the Evaluation is skipped. This implies a condition within the implementation of the SAM itself was not met.

## Simple Assessment Modules

Simple assessment modules (SAMs) are composable service endpoints that follow a consistent interface pattern, evaluate a patient message, data class, element or attribute and return a simple ‘pass’, ‘fail’ or ‘could not assess’ result. For detailed information see [SAMS](sams.md)

## Evaluation Profiles

Evaluation profiles represent a collection of sequences SAM evaluations of specific entities in the PIQI Model along with the desired scoring effect.

# Anatomy of an Evaluation Profile

An Evaluation Profile is comprised of the following component:

## Evaluation Profile Mnemonic

The Profile Mnemonic is a mnemonic identifier that is used to identify a unique evaluation profile. This is the primary identifier to reference a given evaluation profile.

## Evaluation Profile Name

The name of the evaluation profile.

## Evaluation Profile Description

The description of the scope and purpose of the evaluation profile.

## Evaluation Profile Version

The version of the evaluation profile is an optional field for evaluation profiles that are versioned.

## Evaluation Profile Authority

The authoritative source or reference for the evaluation profile.

## Evaluation Profile Model

This is the specific version or extension of the PIQI Data Model.

Profile Model version mnemonic

Profile Model menmonic

Profile Model Version

Profile Model Extension mnemonic

## Evaluation Profile Source

This is the original source of the evaluation profile content.

PIQI Organization UID

PIQI Organization Name

## CreationDateTime

## ModifiedDateTime

## Evaluation Profile Criteria

Each evaluation profile contains a collection of criteria that are used for assessing and scoring patient messages. Each criterion has the following attributes:

### Criterion Sequence

This is the sequence order for the criteria in the collection. The criteria sequence is assigned automatically based on the data class and entity being assessed by the criteria.

### Criterion Description

This is a human readable description of the purpose or rationale for the criteria.

### Criterion Data Class

This is the Data Class in the PIQI model that is being assessed. This can be any data class in the PIQI data model or ‘Patient’ which indicates a complete patient

### Criterion Entity

This is the entity (element or attribute) being assessed by the criteria,

### Criterion SAM Mnemonic

This is the SAM that is being assigned in the criteria.

### Criterion Success Name Override

This is a profile specific override for the success alias for the SAM.

### Criterion Failure Name Override

This is a profile specific override for the Failure alias for the SAM.

### Criterion SAM Parameters

This field contains a collection of the parameters necessary to properly configure the SAM.

#### Criterion SAM Parameter Name

This field contains the name for a SAM parameter being configured.

#### Criterion SAM Parameter Value

This field contains the value for a SAM parameter being configured.

### Criterion Conditional SAM

This contains the SAM mnemonic for a conditional SAM If the criteria should only be run under a certain condition. If the criteria is not conditional, this field should be empty.

### Criterion Conditional SAM Parameters

If there is a conditional SAM and it requires a parameter, this is where that parameter collection can be populated.

#### Criterion Conditional SAM Parameter Name

This field contains the name for a SAM parameter being configured.

#### Criterion Conditional SAM Parameter Value

This field contains the value for a SAM parameter being configured.

### Criterion Scoring Effect

This field indicates if this criterion is ‘scoring’ or ‘informational’.

### Criterion Scoring Weight

This field has the weight for scoring criteria. For informational criteria it is set to ‘0’. For Scoring criteria, it defaults to ‘1’.

### Criterion Criticality Indicator

This field indicates whether this criterion is considered critical for the evaluation profile. It is set to ‘false’ for Informational criteria and defaults to ‘false’ for Scoring criteria.

# Example of Evaluation Profile Definition JSON

{

"evaluationProfile":\[

{"mnemonic": "Profile_001",

"name": "Sample Evaluation Profile",

"description": "This evaluation profile assesses patient data quality based on specific criteria.",

"version": "1.0",

"source": "PIQI Alliance",

"model": "PIQI_DataModel_ExtensionX",

"modelVersion": "2.5",

"criteria": \[

{

"sequence": 1,

"description": "Check if patient birth date is a valid date.",

"dataClass": "Patient",

"entity": "birthDate",

"SAMMnemonic": "Attr_IsValidDate",

"SAMShortName": "ValidDate",

"successNameOverride": "Valid Birth Date",

"failureNameOverride": "Invalid Birth Date",

"SAMParameters": \[

{

"parameterName": "DateFormat",

"parameterValue": "YYYY-MM-DD"

}

\],

"conditionalSAM": "Attr_IsPopulated",

"conditionalSAMParameters": \[

{

"parameterName": "FieldRequired",

"parameterValue": "true"

}

\],

"scoringEffect": "scoring",

"scoringWeight": 1,

"criticalityIndicator": false

},

{

"sequence": 2,

"description": "Verify if patient gender is populated.",

"dataClass": "Patient",

"entity": "gender",

"SAMMnemonic": "Attr_IsPopulated",

"SAMShortName": "GenderPopulated",

"successNameOverride": "Gender Present",

"failureNameOverride": "Gender Missing",

"SAMParameters": \[\],

"conditionalSAM": "",

"conditionalSAMParameters": \[\],

"scoringEffect": "informational",

"scoringWeight": 0,

"criticalityIndicator": false

}

\]}
