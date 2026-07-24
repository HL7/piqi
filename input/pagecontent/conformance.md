# PIQI Framework Scoring Endpoint — Conformance Guide

**Version:** 0.1 (Draft)
**Status:** Working Draft
**Audience:** Implementers integrating with, or building, a PIQI-conformant scoring service

Conformance verbs in this guide follow RFC 2119 usage (**MUST**, **SHOULD**, **MAY**), consistent with HL7 conformance conventions.

---

## 1. Purpose and Scope

This guide defines the conformance requirements for a **PIQI Framework Scoring Endpoint** — a service capable of:

1. Providing access to **PIQI Models** (the structured definitions of data classes, entities, and scoring logic)
2. Providing access to **Rubrics** (the scoring criteria, weighting, and SAM-based evaluation logic applied against a PIQI Model)
3. **Scoring messages** — evaluating a submitted message against a rubric and returning a structured PIQI score
4. **Auditing messages** — optionally returning a full attribute-level evidence trail alongside the score

This guide assumes a RESTful, JSON-based API as the reference implementation. Implementers using other transports **MUST** preserve the semantics defined here even if syntax differs.

Out of scope: the internal algorithms used within individual SAMs, and the specific clinical terminology bindings (SNOMED CT, LOINC, RxNorm) used within a given PIQI Model — these are model-author concerns, not endpoint-conformance concerns.

---

## 2. Core Resource Model

A conformant endpoint works with three core resources:

| Resource | Description |
|---|---|
| `PIQIModel` | Defines the data classes, entities, and structure of messages that can be evaluated |
| `Rubric` | Defines the SAM-based criteria, scoring weights, and criticality rules applied against a `PIQIModel` |
| `Message` | A submitted data payload evaluated synchronously against a `Rubric`, producing a scored result |

### 2.1 Relationships

```
PIQIModel (1) ──< Rubric (many)
Rubric (1) ──< Message evaluations (many) ──> Scoring Result
```

A `Rubric` **MUST** declare exactly one bound `PIQIModel`. A scoring request **MUST** declare both a rubric and the model the message conforms to. The model in the request **MUST** match the model bound to the rubric.

---

## 3. Conformance Requirements Summary

A conformant PIQI endpoint **MUST** accept a message and a rubric reference, evaluate the message against the rubric's SAM-based criteria, and return a scoring result in the defined PIQI format — containing at minimum a numerator, denominator, and computed score at the message level and per data class, in both weighted and unweighted form.

All other capabilities described in this guide represent what a good or production-grade implementation looks like.

| # | Requirement | Level |
|---|---|---|
| C1 | Accept a message and rubric reference, evaluate against SAM-based criteria, and return a score in the defined PIQI format | MUST |
| C2 | Models and rubrics must be available and fully resolved before accepting scoring requests | MUST |
| C3 | Produce an Audit Scorecard (full attribute-level evidence trail) | SHOULD |
| C4 | Support import of `PIQIModel` definitions via a dedicated endpoint | SHOULD |
| C5 | Support import of `Rubric` definitions bound to a valid `PIQIModel` | SHOULD |
| C6 | Support versioning of `PIQIModel` and `Rubric` resources | SHOULD |
| C7 | Validate model/rubric binding at scoring time — the model in the request MUST match the model bound to the rubric | MUST |
| C8 | Emit structured error responses with actionable diagnostics | SHOULD |
| C9 | Support `Informational` scoring effect criteria | SHOULD |
| C10 | Expose a capability/metadata endpoint describing supported models, rubrics, and SAMs | SHOULD |
| C11 | Support `Plausibility` scoring effect criteria | MAY |
| C12 | Support scorecard retrieval in human-readable (PDF/HTML) form | MAY |

---

## 4. Endpoint Definitions

### 4.1 Import a PIQI Model

```
POST /piqi/models
Content-Type: application/json
```

**Request body** — JSON reference data for a PIQIModel

**Responses**

| Status | Meaning |
|---|---|
| 200 OK | Model accepted and persisted |
| 400 Bad Request |	 Request body is missing or malformed |
| 409 Conflict | `mnemonic` + `version` already exists with different content |
| 422 Unprocessable Entity | Schema validation failure — response body **MUST** include the failing dimension/measure path |
| 500 Internal Server Error | Unexpected processing failure — response body includes error detail |

---

### 4.2 Import a Rubric

```
POST /piqi/rubrics
Content-Type: application/json
```

**Request body** — JSON reference data for a Rubric

**Responses**

| Status | Meaning |
|---|---|
| 200 OK | Rubric accepted and persisted |
| 400 Bad Request |	 Request body is missing or malformed |
| 409 Conflict | `mnemonic` + `version` already exists with different content |
| 422 Unprocessable Entity | Required related reference data not found |
| 500 Internal Server Error | Unexpected processing failure — response body includes error detail |


---

### 4.3 Score a Message

A conformant endpoint **MUST** provide a scoring endpoint and **SHOULD** provide a separate scoring-with-audit endpoint.

#### 4.3.1 Score Message

```
POST /PIQI/ScoreMessage
Content-Type: application/json
```

Evaluates a message against a rubric and returns a summary scoring result.

**Request body:**

```json
{
  "PIQIModelMnemonic": "PATIENT_V1",
  "EvaluationRubricMnemonic": "MY_RUBRIC",
  "MessageData": "{\"patient\":{\"demographics\":{\"birthSex\":{\"codings\":[{\"system\":\"http://hl7.org/fhir/administrative-gender\",\"code\":\"male\",\"display\":\"male\"}],\"text\":\"male\"},\"birthDate\":\"2009-01-01\",\"ethnicity\":{\"codings\":[{\"system\":\"urn:oid:2.16.840.1.113883.6.238\",\"code\":\"2135-2\",\"display\":\"Hispanic or Latino\"}],\"text\":\"Hispanic or Latino\"}}}}",
  "ContributorID": "contributor-001",
  "DataSourceID": "datasource-001",
  "MessageID": "msg-00042"
}
```

`MessageData` is a JSON-serialized string in PIQI message format. The structure of the message is defined by the PIQI model bound to the rubric. See the reference implementation's sample files for complete message examples.

| Field | Required | Description |
|---|---|---|
| `PIQIModelMnemonic` | Yes | Identifies the PIQI model the message conforms to |
| `EvaluationRubricMnemonic` | Yes | Identifies the rubric to evaluate against |
| `MessageData` | Yes | The raw message content to be evaluated |
| `ContributorID` | No | Identifier for the data contributor |
| `DataSourceID` | No | Identifier for the data source |
| `MessageID` | No | Identifier for the message |

**Response body:**

```json
{
  "succeeded": true,
  "elapsedTimeInMS": 142,
  "scoringData": {
    "contributorID": "contributor-001",
    "dataSourceID": "datasource-001",
    "messageID": "msg-00042",
    "evaluationRubric": "USCDI 3.1 Aligned Rubric",
    "processDate": "2026-07-23T10:00:00",
    "messageResults": {
      "numerator": 38,
      "denominator": 42,
      "piqiScore": 90,
      "weightedNumerator": 310,
      "weightedDenominator": 350,
      "weightedPIQIScore": 88,
      "criticalFailureCount": 0
    },
    "dataClassResults": [
      {
        "dataClassName": "Medications",
        "instanceCount": 5,
        "numerator": 12,
        "denominator": 14,
        "piqiScore": 85,
        "weightedNumerator": 95,
        "weightedDenominator": 110,
        "weightedPIQIScore": 86,
        "criticalFailureCount": 0
      }
    ],
    "informationalResults": [],
    "plausibilityResults": []
  }
}
```

**Responses:**

| Status | Meaning |
|---|---|
| 200 OK | Message evaluated successfully |
| 400 Bad Request | Request body is missing or malformed |
| 422 Unprocessable Entity | `PIQIModelMnemonic` does not match the model bound to the rubric, or `EvaluationRubricMnemonic` cannot be resolved |
| 500 Internal Server Error | Unexpected processing failure — response body includes error detail |

#### 4.3.2 Score and Audit Message

```
POST /PIQI/ScoreAuditMessage
Content-Type: application/json
```

Evaluates a message and returns both a summary scoring result and a full attribute-level audit trace. The request body is identical to `ScoreMessage`. The response includes the same `scoringData` plus an additional `auditedMessage` object.

**Additional response field — `auditedMessage`:**

```json
{
  "auditedMessage": {
    "entityModelMnemonic": "PAT_CLINICAL_V1",
    "contributorID": "contributor-001",
    "dataSourceID": "datasource-001",
    "messageID": "msg-00042",
    "audit": {
      "messageNumerator": 38,
      "messageDenominator": 42,
      "messageScore": 90,
      "messageNumeratorWeighted": 310,
      "messageDenominatorWeighted": 350,
      "messageScoreWeighted": 88,
      "messageCriticalFailureCount": 0
    },
    "root": {
      "rootName": "patient",
      "classes": [
        {
          "className": "demographics",
          "elements": [
            {
              "attributes": [
                {
                  "attributeName": "birthDate",
                  "data": { "$type": "tx", "text": "2009-01-01" },
                  "attributeAudit": {
                    "scoringData": { "attributeScore": 100, "attributeScoreWeighted": 100, "attributeCriticalFailureCount": 0, "attributeNumerator": 1, "attributeDenominator": 1 },
                    "assessmentItems": [
                      { "attributeMnemonic": "DEM_DOB", "attributeName": "birthDate", "assessment": "Date of birth is valid past date", "effect": "Scoring", "status": "Pass", "reason": "" }
                    ]
                  }
                }
              ]
            }
          ]
        }
      ]
    }
  }
}
```

The audit response traces every attribute of every element in the message, showing exactly which assessments passed or failed and why. This provides a complete evidence trail traceable to the field level.

---

## 5. Versioning

- `PIQIModel` and `Rubric` resources **SHOULD** carry a `MAJOR.MINOR` version identifier.
- A scoring request **MUST** specify the model mnemonic the message conforms to. The engine **MUST** validate that this matches the model bound to the rubric before evaluation proceeds.
- Breaking changes to a rubric's criteria or SAM logic **SHOULD** increment at least the MINOR version to preserve traceability of results over time.

---

## 6. Error Handling

All error responses **MUST** conform to a consistent structure:

```json
{
  "error": {
    "code": "MODEL_MISMATCH",
    "message": "PIQIModelMnemonic 'PATIENT_V2' does not match the model bound to rubric 'MY_RUBRIC'"
  }
}
```

When the error can be traced to a specific field in the request body, `path` **SHOULD** be included:

```json
{
  "error": {
    "code": "SAM_NOT_FOUND",
    "message": "No SAM registered for mnemonic 'RXNORM_CODED'",
    "path": "criteria[2].samMnemonic"
  }
}
```

| Field | Required | Description |
|---|---|---|
| `code` | Yes | A stable, machine-readable error identifier |
| `message` | Yes | A human-readable description of the error |
| `path` | No | The location within the request body where the error occurred. Include when the error relates to a specific field (e.g., import validation failures). Omit when the error is systemic or not tied to a specific location. |

Servers **SHOULD** use a stable, documented set of `code` values so client integrations can branch on error type rather than parsing `message` text.

---

## 7. Security and Access Control

Deployments of a PIQI scoring endpoint **SHOULD** ensure that access is controlled in a manner appropriate to the sensitivity of the data being evaluated and the regulatory context of the deployment. The specific mechanism — whether authentication, authorization, network controls, or organizational policy — is outside the scope of this conformance guide.

Deployments handling regulated data **SHOULD** ensure that access to audit-grade outputs is restricted consistent with applicable organizational and regulatory policies.

---

## 8. Capability Discovery

```
GET /piqi/metadata
```

A conformant endpoint **SHOULD** expose a capability discovery endpoint that allows consumers to inspect the service before attempting an integration. This mirrors the role a FHIR `CapabilityStatement` plays in FHIR-based systems.

The response **SHOULD** include:

| Field | Description |
|---|---|
| Supported models | The mnemonics and versions of PIQI models available on this endpoint |
| Supported rubrics | The mnemonics and versions of rubrics available, with their bound model |
| Registered SAMs | The mnemonics and descriptions of SAMs available for use in rubric criteria |
| Supported message formats | The message formats the endpoint can parse and evaluate |
| Supported scoring effects | Which of Scoring, Informational, Plausibility the endpoint supports |

---

## 9. SAM Architecture

### 9.1 What is a SAM?

A **SAM (Scoring and Assessment Method)** is the fundamental unit of scoring logic in PIQI. Each SAM is a discrete, named function that evaluates one aspect of a message element and returns a result of pass, fail, skip, or informational. SAMs are the mechanism by which rubric criteria are executed — every criterion in a rubric references exactly one SAM by its mnemonic.

Each SAM **MUST** operate as an autonomous unit: given the same inputs it **MUST** produce the same output, and it **MUST NOT** depend on the results of other SAMs. The internal implementation of a SAM is outside the scope of this standard.

### 9.2 SAM Input and Output

Each SAM **MUST** accept the message element being evaluated along with any parameters defined on the criterion. Parameters are name/value pairs that allow a single SAM to be configured differently per criterion (e.g., a minimum threshold value, a target code system).

Each SAM **MUST** return one of four outcomes:

| Outcome | Meaning |
|---|---|
| Pass | The element satisfies the criterion |
| Fail | The element does not satisfy the criterion |
| Skip | The criterion was not applicable and is excluded from scoring |
| Informational | The criterion produced an observation but has no pass/fail determination |

### 9.3 The SAM Registry and Extensibility

A conformant endpoint **MUST** maintain a registry of available SAMs, keyed by mnemonic. The SAM mnemonic declared on a rubric criterion **MUST** resolve to a registered SAM at evaluation time. If no matching SAM is found, the criterion **MUST** be treated as an error rather than silently skipped.

Implementations **SHOULD** support extending the SAM registry without modifying the core engine, allowing custom scoring logic to be added for domain-specific use cases.

### 9.4 Scoring Effect Types

Each criterion declares a scoring effect that controls how its result is counted and reported. There are four valid values:

| Effect | Behavior |
|---|---|
| `Scoring` | Contributes to the numerator/denominator and weighted score. Failures affect the overall score. A conformant endpoint **MUST** support this effect. |
| `Informational` | Evaluated and reported separately. Does **not** affect the score. Use for checks that provide diagnostic context without penalizing. A conformant endpoint **SHOULD** support this effect. |
| `Plausibility` | Evaluated for cross-field or cross-element consistency. Reported separately. Does **not** affect the score. A conformant endpoint **MAY** support this effect. |
| `Detection` | Identifies and counts message elements whose coded values match a defined detection value set. Does **not** affect the score. Detection criteria are not evaluated by a standard PIQI scoring endpoint — they are handled by compatible extended engines. A conformant endpoint **MUST** recognize this effect and ignore it without error. |

Rubric authors **MUST** assign the correct scoring effect to each criterion. A criterion intended as advisory that is accidentally set to `Scoring` will penalize messages and skew results.

### 9.5 Criticality

Each criterion **MAY** be flagged as critical. When a scoring criterion marked critical fails, the failure is counted separately as a **critical failure** in addition to the normal fail count. Critical failures **MUST** be surfaced at every level of the scoring output so they are visible regardless of which summary level a consumer inspects.

Critical failures are intended to flag failures that are categorically unacceptable regardless of overall score (e.g., a missing patient identifier, an invalid code system reference).

### 9.6 Conditional Evaluation

Each criterion **MAY** declare a condition — a secondary SAM that is evaluated first. If the condition is not met, the primary SAM is skipped entirely and the criterion is recorded as skipped rather than failed. This is the mechanism for expressing "only evaluate X if Y is true."

Skipped criteria **MUST** be excluded from the denominator and **MUST NOT** affect the score.

---

## 10. Reference Data Requirements

### 10.1 Model and Rubric Availability

A conformant endpoint **MUST** have all referenced models and rubrics available and validated before accepting evaluation requests. The mechanism for storing and managing models and rubrics — whether files, a database, an API, or another store — is left to the implementer.

### 10.2 Reference Data Lookups

A conformant endpoint **MUST** have access to all reference data required by its SAMs at evaluation time. This includes code system definitions, value lists, and any terminology or range data needed to validate message content. The backing store for this data is left to the implementer.

### 10.3 Message Format

The message submitted for evaluation **MUST** be interpretable by the PIQI model bound to the rubric. The supported message formats are determined by the model definition and **MUST** be documented by the implementer so that submitters know what formats are accepted.

### 10.4 External Service Dependencies

SAMs **MAY** depend on external services (e.g., a terminology server, a FHIR endpoint) to perform their evaluation. Any such dependencies **MUST** be available and responsive at evaluation time, and **SHOULD** be documented as part of the rubric or SAM definition so that operators know what infrastructure is required.

---

## 11. Summary Checklist for Implementers

- [ ] Models and rubrics are configured and validated before the service accepts requests
- [ ] Each rubric criterion references a valid, registered SAM mnemonic
- [ ] Scoring, Informational, Plausibility, and Detection effects are correctly assigned to criteria
- [ ] Criticality indicators are applied to criteria whose failure is categorically unacceptable
- [ ] Conditional SAM logic is used where criteria should only evaluate under specific conditions
- [ ] Scoring and Audit response views are both available and consistently derived from the same evaluation
- [ ] Scores are reported with raw numerator/denominator counts included
- [ ] Weighted scores are reported alongside unweighted scores at message and data class levels
- [ ] Plausibility results are reported separately from scoring results (if supported)
- [ ] Versioning is maintained across Model → Rubric lineage
- [ ] Errors are structured and coded, not just free-text
- [ ] Access to the service is controlled at a level appropriate to the deployment environment
- [ ] The SAM registry is populated and all SAM mnemonics referenced by loaded rubrics resolve at startup
- [ ] A capability discovery endpoint is available describing supported models, rubrics, and SAMs

---

*This is a working draft.*
