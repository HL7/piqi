
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

| Field | Description | Notes |
| --- | --- | --- |
| Mnemonic | A mnemonic identifier used to uniquely identify the Evaluation Rubric. This is the primary identifier for referencing a given Evaluation Rubric. | |
| Name | The name of the Evaluation Rubric. | |
| Description | The description of the scope and purpose of the Evaluation Rubric. | |
| Version | The version of the Evaluation Rubric. | Optional |
| Authority | The authoritative source or reference for the Evaluation Rubric. Should include organizations that have endorsed the rubric and context on known production usage. | |
| Model | The [PIQI Model](glossary.html#piqi-model) required for the rubric. All sub-attributes are required to uniquely identify the specific model and version: Rubric Model Mnemonic, Rubric Model Version Mnemonic, Rubric Model Version, Rubric Model Extension Mnemonic. | |
| Source | The original source of the Evaluation Rubric content. Sub-attributes: PIQI Organization UID, PIQI Organization Name. | |
| CreationDateTime | The date and time the Evaluation Rubric was originally created. | |
| ModifiedDateTime | The date and time the Evaluation Rubric was most recently modified. | |
| Criterion | The specific rules to use to assess a specific PIQI Model Entity and associated scoring implications. For full attributes of each Criterion, see [Evaluation Rubric Criteria](evaluation.html#evaluation-rubric-criteria) | Repeats |


#### Evaluation Rubric Criteria

Each Evaluation Rubric contains a collection of criteria used for assessing and scoring patient messages. Each criterion has the following fields:

| Field | Description | Notes |
| --- | --- | --- |
| Sequence | The sequence order for the criterion in the collection. Assigned automatically based on the [Data Class](glossary.html#data-class) and entity being assessed. | |
| Description | A human-readable description of the purpose or rationale for the criterion. | |
| Data Class | The [Data Class](glossary.html#data-class) in the [PIQI Model](glossary.html#piqi-model) being assessed. May be any Data Class in the PIQI information model, or `Patient` to indicate the entire patient record. | |
| Entity | The entity (element or [attribute](glossary.html#data-attribute)) being assessed by the criterion. | |
| SAM Mnemonic | The mnemonic of the SAM assigned to this criterion. | |
| Success Name Override | A rubric-specific override for the success alias of the assigned SAM. | Optional |
| Failure Name Override | A rubric-specific override for the failure alias of the assigned SAM. | Optional |
| SAM Parameters | A collection of name/value pairs (`parameterName`, `parameterValue`) used to configure the assigned SAM. | Optional |
| Conditional SAM | The mnemonic of a conditional SAM. If configured, the assigned evaluation SAM is only processed if this SAM passes. Leave empty if the criterion is not conditional. | Optional |
| Conditional SAM Parameters | A collection of name/value pairs (`parameterName`, `parameterValue`) used to configure the conditional SAM. | Optional |
| Scoring Effect | Indicates whether this criterion is `scoring` or `informational`. | |
| Scoring Weight | The weight applied to the criterion for scoring. Set to `0` for informational criteria; defaults to `1` for scoring criteria. | |
| Criticality Indicator | If `true` and this criterion fails, the entire patient message is considered to have failed the Evaluation Rubric regardless of all other scores. Always `false` for informational criteria. Defaults to `false` for scoring criteria; set to `true` only for criteria whose failure must disqualify the message as a whole. | |

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
