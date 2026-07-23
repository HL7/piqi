
**PIQI [Evaluation Rubric](glossary.html#evaluation-rubric)**

The Patient Information Quality Improvement (PIQI) Framework assesses patient data in the PIQI Data Model using an **[Evaluation Rubric](glossary.html#evaluation-rubric)**.

The Evaluation Rubric is a sequenced collection of **Evaluation Criteria**.

Each Evaluation Criterion is comprised of a specific **[PIQI Model](glossary.html#piqi-model) Entity** an assigned **Evaluation** an optional **Condition** and the **Scoring Effect.**

The PIQI Model Entity can be an [attribute](glossary.html#data-attribute), element, [data class](glossary.html#data-class) or the entire patient.

The **Evaluation** and **Condition** are both configured **Simple Assessment Modules** (**SAMs**).

If the **Condition** is configured, the **Evaluation** is only processed if the conditional SAM passes.

Each Evaluation that is processed triggers the **Scoring Effect** based upon the pass or fail result of the underlying SAM. If the SAM returns an indeterminant result (skip) the Evaluation is skipped. This implies a condition within the implementation of the SAM itself was not met.

### Simple Assessment Modules

A SAM is a logical test that measures a specific data quality dimension for a model element or characteristic, following a defined pattern. The inputs depend on the pattern, but the output is always a simple result: pass, fail, or skip. SAMs can be grouped into hierarchical collections, allowing multiple checks to be combined in order to provide a broader picture of data quality for a given use case. Given that interaction with a PIQI evaluation endpoint is at the Rubric level, and not at the SAM level, the actual format for conveying these responses (e.g., "pass/fail" vs. "true/false" vs. "1/0") is an implementation decision that is outside the scope of this standard. For detailed information see [SAMS](sams.html)

### Evaluation Rubrics

Evaluation Rubrics represent a collection of sequenced SAM evaluations of specific entities in the [PIQI Model](glossary.html#piqi-model) along with the desired scoring effect.

### Anatomy of an Evaluation Rubric

An Evaluation Rubric is comprised of the following components:

#### Evaluation Rubric Mnemonic

The Rubric Mnemonic is a mnemonic identifier that is used to identify a unique Evaluation Rubric. This is the primary identifier to reference a given Evaluation Rubric.

#### Evaluation Rubric Name

The name of the Evaluation Rubric.

#### Evaluation Rubric Description

The description of the scope and purpose of the Evaluation Rubric.

#### Evaluation Rubric Version

The version of the Evaluation Rubric is an optional field to support versioned rubrics.

#### Evaluation Rubric Authority

The authoritative source or reference for the Evaluation Rubric. This should contain both any organizations that have endorsed the rubric (to convey trustworthiness) as well as context on known production usage of the rubric.

#### Evaluation Rubric Model

This is the PIQI Data Model required for the rubric. It is envisioned that there may be many versions of a given model, as well as extensions based upon those versions. Given the tight relationship between the model and the rubric, all of these sub-attributes are necessary to uniquely identify the specific model required.

- Rubric Model version mnemonic

- Rubric Model mnemonic

- Rubric Model Version

- Rubric Model Extension mnemonic

#### Evaluation Rubric Source

This is the original source of the Evaluation Rubric content, containing both a unique identifier as well as a human readable name for the organization.

- PIQI Organization UID

- PIQI Organization Name

#### CreationDateTime

The date and time the Evaluation Rubric was originally created.

#### ModifiedDateTime

The date and time the Evaluation Rubric was most recently modified.

#### Evaluation Rubric Criteria

Each Evaluation Rubric contains a collection of criteria that are used for assessing and scoring patient messages. Each criterion has the following attributes:

##### Criterion Sequence

This is the sequence order for the criteria in the collection. The criteria sequence is assigned automatically based on the [data class](glossary.html#data-class) and entity being assessed by the criteria.

##### Criterion Description

This is a human readable description of the purpose or rationale for the criteria.

##### Criterion Data Class

This is the Data Class in the [PIQI model](glossary.html#piqi-model) that is being assessed. This can be any data class in the PIQI information model or ‘Patient’ which indicates a complete patient

##### Criterion Entity

This is the entity (element or [attribute](glossary.html#data-attribute)) being assessed by the criteria,

##### Criterion SAM Mnemonic

This is the SAM that is being assigned in the criteria.

##### Criterion Success Name Override

This is a profile specific override for the success alias for the SAM.

##### Criterion Failure Name Override

This is a profile specific override for the Failure alias for the SAM.

##### Criterion SAM Parameters

This field contains a collection of the parameters necessary to properly configure the SAM.

##### Criterion SAM Parameter Name

This field contains the name for a SAM parameter being configured.

##### Criterion SAM Parameter Value

This field contains the value for a SAM parameter being configured.

##### Criterion Conditional SAM

This contains the SAM mnemonic for a conditional SAM If the criteria should only be run under a certain condition. If the criteria is not conditional, this field should be empty.

##### Criterion Conditional SAM Parameters

If there is a conditional SAM and it requires a parameter, this is where that parameter collection can be populated.

##### Criterion Conditional SAM Parameter Name

This field contains the name for a SAM parameter being configured.

##### Criterion Conditional SAM Parameter Value

This field contains the value for a SAM parameter being configured.

##### Criterion Scoring Effect

This field indicates if this criterion is ‘scoring’ or ‘informational’.

##### Criterion Scoring Weight

This field has the weight for scoring criteria. For informational criteria it is set to ‘0’. For Scoring criteria, it defaults to ‘1’.

##### Criterion Criticality Indicator

This field identifies a criterion as critical, meaning that if this criterion fails, the entire patient message is considered to have failed the rubric regardless of the scores from all other criteria. Informational criteria cannot be critical and this value is always ‘false’ for them. For Scoring criteria, this value defaults to ‘false’; set it to ‘true’ only for criteria whose failure must disqualify the message as a whole.

### Example of Evaluation Rubric Definition JSON

```json
{
    "evaluationRubric": [
        {
            "mnemonic": "Rubric_001",
            "name": "Sample Evaluation Rubric",
            "description": "This evaluation rubric assesses patient data quality based on specific criteria.",
            "version": "1.0",
            "source": "PIQI Alliance",
            "model": "PIQI_DataModel_ExtensionX",
            "modelVersion": "2.5",
            "criteria": [
                {
                    "sequence": 1,
                    "description": "Check if patient birth date is a valid date.",
                    "dataClass": "Patient",
                    "entity": "birthDate",
                    "SAMMnemonic": "Attr_IsValidDate",
                    "SAMShortName": "ValidDate",
                    "successNameOverride": "Valid Birth Date",
                    "failureNameOverride": "Invalid Birth Date",
                    "SAMParameters": [],
                    "conditionalSAM": "Attr_IsPopulated",
                    "conditionalSAMParameters": [
                        {
                            "parameterName": "FieldRequired",
                            "parameterValue": "true"
                        }
                    ],
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
                    "SAMParameters": [],
                    "conditionalSAM": "",
                    "conditionalSAMParameters": [],
                    "scoringEffect": "informational",
                    "scoringWeight": 0,
                    "criticalityIndicator": false
                }
            ]
        }
    ]
}
```
