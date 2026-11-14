// The PIQI Evaluation Rubric format: the JSON format in which evaluation rubrics are exchanged
// between PIQI implementations (formerly described by piqi-rubric-schema.json).
// This logical model is the definition of the JSON format: element names are JSON property names

RuleSet: JsonNullable(path)
* {path} ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-nullable"
* {path} ^extension[=].valueBoolean = true

RuleSet: JsonEmptyArrayPresent(path)
* {path} ^extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/json-empty-behavior"
* {path} ^extension[=].valueCode = #present

Invariant: pqr-mnemonic
Description: "Rubric and source mnemonics are upper case letters, digits, underscores and dots"
Severity: #error
Expression: "matches('^[A-Z0-9_.]+$')"

Invariant: pqr-uuid
Description: "The tenant UID is a UUID"
Severity: #error
Expression: "matches('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')"

Invariant: pqr-weight
Description: "The scoring weight is not negative"
Severity: #error
Expression: "$this >= 0"

CodeSystem: PIQIScoringEffect
Id: piqi-scoring-effect
Title: "PIQI Scoring Effect"
Description: "The effect that the outcome of an evaluation rubric criterion has on the score"
* ^status = #active
* ^caseSensitive = true
* ^experimental = false
* #Scoring "Scoring" "The outcome of the criterion contributes to the numerator and denominator of the score"
* #Informational "Informational" "Statistics are collected for the criterion, but its outcome does not affect the numerator or denominator of the score"

ValueSet: PIQIScoringEffectVS
Id: piqi-scoring-effect
Title: "PIQI Scoring Effect"
Description: "The effect that the outcome of an evaluation rubric criterion has on the score"
* ^status = #active
* ^experimental = false
* include codes from system PIQIScoringEffect

CodeSystem: PIQIParameterValueType
Id: piqi-parameter-value-type
Title: "PIQI SAM Parameter Value Type"
Description: "How the value of a SAM parameter is to be interpreted"
* ^status = #active
* ^caseSensitive = true
* ^experimental = false
* #"Code System" "Code System" "The value is a code system mnemonic, or a comma separated list of code system mnemonics"
* #"Content Set" "Content Set" "The value is the mnemonic of a content set (e.g. an external list or value set)"
* #"Simple List (CSV)" "Simple List (CSV)" "The value is a comma separated list of values"

ValueSet: PIQIParameterValueTypeVS
Id: piqi-parameter-value-type
Title: "PIQI SAM Parameter Value Type"
Description: "How the value of a SAM parameter is to be interpreted"
* ^status = #active
* ^experimental = false
* include codes from system PIQIParameterValueType

Logical: PIQIRubric
Id: PIQIRubric
Title: "PIQI Evaluation Rubric"
Description: "The format in which a PIQI Evaluation Rubric is exchanged between PIQI implementations: a versioned, authority-aligned set of criteria that are evaluated against the entities of a PIQI model, used to score data quality. This logical model defines the JSON format: the names of the elements are the JSON property names, and a rubric is a JSON object that conforms to this model."
* ^status = #active
* name 1..1 string "Name of the rubric" "Human-readable name of the rubric (e.g. 'USCDI v3.1 Aligned Rubric')."
* mnemonic 1..1 string "Mnemonic identifying the rubric" "Short, unique, upper-case code identifying the rubric (e.g. USCDI_V31)."
* mnemonic obeys pqr-mnemonic
* tenantUid 1..1 string "Tenant that owns the rubric" "UUID of the tenant that owns this rubric."
* tenantUid obeys pqr-uuid
* description 1..1 string "Description of the rubric" "Free-text description of the rubric's purpose and scope. The property is always present, but may be null."
* insert JsonNullable(description)
* version 1..1 integer "Version of the rubric" "Rubric version, typically encoded as a date-like integer (e.g. YYYYMM)."
* authorityName 1..1 string "Authority the rubric is aligned to" "Name of the standards authority or program the rubric is aligned to (e.g. USCDI)."
* model 1..1 BackboneElement "The model the rubric applies to" "Reference to the PIQI model that this rubric's criteria are evaluated against."
* model.name 1..1 string "Name of the model" "Human-readable name of the referenced model."
* model.mnemonic 1..1 string "Mnemonic of the model" "Mnemonic code of the referenced model (e.g. PAT_CLINICAL_V1)."
* model.mnemonic obeys pqi-mnemonic
* model.version 1..1 positiveInt "Version of the model" "Version number of the referenced model."
* source 1..1 BackboneElement "Publisher of the rubric" "The organization or body that published/maintains this rubric."
* source.name 1..1 string "Name of the source organization" "Human-readable name of the source organization (e.g. PIQI Alliance)."
* source.mnemonic 1..1 string "Mnemonic of the source organization" "Mnemonic code of the source organization (e.g. PIQI.ALLIANCE)."
* source.mnemonic obeys pqr-mnemonic
* criteria 1..* BackboneElement "The criteria of the rubric" "The ordered set of scoring criteria that make up the rubric. Each criterion applies a Simple Assessment Module (SAM) to an entity of the model, optionally gated by a conditional SAM."
* criteria.sequence 1..1 positiveInt "Order of the criterion" "Ordering position of the criterion within the rubric."
* criteria.description 1..1 string "Description of the criterion" "Free-text description of the criterion. The property is always present, but may be an empty string or null."
* insert JsonNullable(criteria.description)
* criteria.entity 1..1 string "The model entity that is evaluated" "Mnemonic of the model data class, element or attribute that this criterion evaluates (e.g. ALG_REACT)."
* criteria.entity obeys pqi-mnemonic
* criteria.samMnemonic 1..1 string "The SAM that evaluates the entity" "Mnemonic identifying the Simple Assessment Module (SAM) used to evaluate the entity (e.g. CONCEPT_ISVALIDMEMBER)."
* criteria.samNameOverride 1..1 string "Label for the passing condition" "Human-readable label describing the passing condition of this criterion, shown in scorecards."
* criteria.failureNameOverride 1..1 string "Label for the failing condition" "Human-readable label describing the failing condition of this criterion, shown in scorecards."
* criteria.conditionalSam 1..1 string "SAM that must pass for the criterion to be evaluated" "Mnemonic of a SAM that must evaluate true before this criterion is scored (e.g., only score if the attribute is populated). The property is always present, and is null if the criterion is unconditional."
* insert JsonNullable(criteria.conditionalSam)
* criteria.scoringEffect 1..1 code "Scoring | Informational" "How this criterion affects the overall score."
* criteria.scoringEffect from PIQIScoringEffectVS (required)
* criteria.scoringWeight 1..1 decimal "Weight of the criterion" "Relative weight applied to this criterion's contribution to the overall score."
* criteria.scoringWeight obeys pqr-weight
* criteria.criticalityIndicator 1..1 boolean "Is failure critical?" "Whether failing this criterion is considered a critical (high-severity) failure."
* criteria.samParameters 0..* BackboneElement "Parameters for the SAM" "Parameters configuring the SAM referenced by samMnemonic. The property is always present, but the array may be empty."
* insert JsonEmptyArrayPresent(criteria.samParameters)
* criteria.samParameters.samParameterMnemonic 1..1 string "Which SAM parameter this is" "Mnemonic code identifying which SAM parameter this is (e.g. CODE_SYSTEM_CSV)."
* criteria.samParameters.parameterValue 1..1 string "Value of the parameter" "The value supplied for the parameter. May be a single value or a comma-separated list depending on parameterValueTypeName."
* criteria.samParameters.parameterValueTypeName 1..1 code "Code System | Content Set | Simple List (CSV)" "The data/value type of the parameter, indicating how parameterValue should be interpreted."
* criteria.samParameters.parameterValueTypeName from PIQIParameterValueTypeVS (required)
* criteria.samParameters.parameterName 1..1 string "Name of the parameter" "Human-readable display name of the parameter."
* criteria.conditionalSamParameters 0..* contentReference http://hl7.org/xprod/ig/uv/piqi/StructureDefinition/PIQIRubric#PIQIRubric.criteria.samParameters "Parameters for the conditional SAM" "Parameters configuring the conditional SAM referenced by conditionalSam. The property is always present, but the array may be empty."
* insert JsonEmptyArrayPresent(criteria.conditionalSamParameters)
