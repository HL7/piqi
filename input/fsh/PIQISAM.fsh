// The PIQI Simple Assessment Module (SAM) definition format: the JSON format in which SAM definitions
// are exchanged between PIQI implementations. Based on piqi-sam-schema.json, with the properties that
// the 'Anatomy of a SAM' (sams.md) describes but the schema omits added as optional properties.
// This logical model is the definition of the JSON format: element names are JSON property names

CodeSystem: PIQISAMInputType
Id: piqi-sam-input-type
Title: "PIQI SAM Input Type"
Description: "The type of entity that a SAM expects as input"
* ^status = #active
* ^caseSensitive = true
* ^experimental = false
* #Simple_Attribute "Simple Attribute" "A simple string attribute"
* #Codeable_Concept_Attribute "Codeable Concept Attribute" "A codeable concept attribute"
* #Observation_Value "Observation Value" "An observation value attribute"
* #Ranged_Value "Ranged Value" "A range value attribute"
* #Element "Element" "An element (a single instance of a data class): a collection of attributes"
* #Data_Class "Data Class" "A data class: a collection of elements"
* #Patient "Patient" "The entire patient container"

ValueSet: PIQISAMInputTypeVS
Id: piqi-sam-input-type
Title: "PIQI SAM Input Type"
Description: "The type of entity that a SAM expects as input"
* ^status = #active
* ^experimental = false
* include codes from system PIQISAMInputType

CodeSystem: PIQISAMExecutionType
Id: piqi-sam-execution-type
Title: "PIQI SAM Execution Type"
Description: "The nature of the machinery that executes a SAM"
* ^status = #active
* ^caseSensitive = true
* ^experimental = false
* #Primitive_Logic "Primitive Logic" "The execution is primitive logic that is hard wired into the PIQI Framework"
* #Regex_Pattern "Regex Pattern" "The execution is primitive logic that uses a regular expression to match reference data"
* #Stored_Procedure "Stored Procedure" "The execution uses a Structured Query Language (SQL) stored procedure"
* #RESTful_Service "RESTful Service" "The execution calls a RESTful service"
* #Value_Set_Enum "Value Set (Enumerated)" "The execution uses a value set of enumerated strings"
* #Value_Set_Code "Value Set (Coded)" "The execution uses a value set of codings"

ValueSet: PIQISAMExecutionTypeVS
Id: piqi-sam-execution-type
Title: "PIQI SAM Execution Type"
Description: "The nature of the machinery that executes a SAM"
* ^status = #active
* ^experimental = false
* include codes from system PIQISAMExecutionType

Logical: PIQISAM
Id: PIQISAM
Title: "PIQI Simple Assessment Module"
Description: "The format in which the definition of a PIQI Simple Assessment Module (SAM) is exchanged between PIQI implementations. This logical model defines the JSON format: the names of the elements are the JSON property names, and a SAM definition is a JSON object that conforms to this model."
* ^status = #active
* mnemonic 1..1 string "Mnemonic identifying the SAM" "The mnemonic that identifies the SAM. The mnemonic is intended to be universal so that common SAMs can be referenced across implementations in the PIQI community; it is the primary identifier for the SAM, and is what Evaluation Rubrics use to refer to it."
* uid 0..1 string "Implementation specific identifier" "An optional implementation specific unique identifier for the SAM. This identifier can vary from implementation to implementation."
* name 1..1 string "Name of the SAM" "The name of the SAM, in the context of the SAM passing (e.g. 'Attribute is populated')."
* successName 0..1 string "Label used when the SAM passes" "The alias for the SAM that is used when communicating that the SAM has passed (e.g. 'Is populated')."
* description 1..1 string "Description of the SAM" "A brief description of the purpose of the SAM, with a detailed explanation of the logic used to perform the assessment. The property is always present, but may be null."
* insert JsonNullable(description)
* inputType 1..1 code "Type of entity the SAM assesses" "The type of entity that the SAM expects as input. The property is always present, but may be null."
* inputType from PIQISAMInputTypeVS (extensible)
* insert JsonNullable(inputType)
* failName 1..1 string "Label used when the SAM fails" "The alias for the SAM that is used when communicating that the SAM has failed. This is typically the reciprocal of the success name (e.g. 'Is not populated'). The property is always present, but may be null."
* insert JsonNullable(failName)
* prerequisiteSamMnemonic 1..1 string "SAM that must pass before this one runs" "The mnemonic of the SAM that must pass before this SAM can run. If the prerequisite SAM fails, this SAM is considered to have failed. The property is always present, and is null if there is no prerequisite."
* insert JsonNullable(prerequisiteSamMnemonic)
* conditionalSamMnemonic 1..1 string "SAM that must pass for this one to be applicable" "The mnemonic of a SAM that must pass for this SAM to be applicable. If the conditional SAM fails, this SAM is not run, and is neither a pass nor a fail. The property is always present, and is null if there is no condition."
* insert JsonNullable(conditionalSamMnemonic)
* hdqtDimensionMnemonic 1..1 string "HDQT dimension the SAM assesses" "The Healthcare Data Quality Taxonomy (HDQT) dimension that this SAM is bound to (e.g. Availability.Populated)."
* executionTypeMnemonic 1..1 code "How the SAM is executed" "The nature of the machinery that executes the SAM."
* executionTypeMnemonic from PIQISAMExecutionTypeVS (extensible)
* executionReference 0..1 string "Information needed to execute the SAM" "The information necessary to execute the SAM, depending on the execution type: blank for Primitive_Logic, the stored procedure name for Stored_Procedure, the endpoint URL for RESTful_Service, and the value set identifier for the value set execution types. May be null."
* insert JsonNullable(executionReference)
* createdDateTime 1..1 string "When the SAM was created" "The date and time the SAM was created. The property is always present, but may be null (e.g. for primitive SAMs)."
* insert JsonNullable(createdDateTime)
* modifiedDateTime 1..1 string "When the SAM was last updated" "The date and time the SAM was last updated. The property is always present, but may be null (e.g. for primitive SAMs)."
* insert JsonNullable(modifiedDateTime)
* piqiModel 1..1 BackboneElement "The PIQI model the SAM requires" "The minimum PIQI model and version required to provide the SAM with the attributes it needs. This is required for SAMs whose input type is Element or Data_Class; otherwise the properties are null."
* piqiModel.name 1..1 string "Name of the model" "Name of the PIQI model. The property is always present, but may be null."
* insert JsonNullable(piqiModel.name)
* piqiModel.mnemonic 1..1 string "Mnemonic of the model" "Mnemonic of the PIQI model (e.g. PAT_CLINICAL_V1). The property is always present, but may be null."
* insert JsonNullable(piqiModel.mnemonic)
* piqiModel.version 1..1 string "Version of the model" "Version of the PIQI model. The property is always present, but may be null."
* insert JsonNullable(piqiModel.version)
* source 1..1 BackboneElement "Author of the SAM" "The author of the SAM and related reference resources."
* source.name 1..1 string "Name of the source" "The name of the source of the SAM (e.g. PIQI Alliance)."
* source.mnemonic 1..1 string "Mnemonic of the source" "The mnemonic of the source of the SAM (e.g. PIQI.ALLIANCE)."
* source.mnemonic obeys pqr-mnemonic
* source.memberUid 0..1 string "PIQI Alliance member identifier" "The PIQI Alliance member unique identifier of the source."
* source.memberUid obeys pqr-uuid
* parameters 0..* BackboneElement "Parameters the SAM accepts" "The parameters that the SAM accepts. When the SAM is used in an Evaluation Rubric, the rubric criterion provides values for these parameters. The property is always present, but the array may be empty."
* insert JsonEmptyArrayPresent(parameters)
* parameters.samParameterMnemonic 1..1 string "Mnemonic identifying the parameter" "The mnemonic that identifies the parameter. Evaluation Rubrics use this mnemonic when they provide a value for the parameter (e.g. CODE_SYSTEM_CSV)."
* parameters.parameterName 1..1 string "Name of the parameter" "Human-readable display name of the parameter."
* parameters.parameterDescription 0..1 string "Description of the parameter" "The description of the nature and purpose of the parameter."
* parameters.parameterValueTypeName 1..1 code "Code System | Content Set | Simple List (CSV)" "The data/value type of the parameter, indicating how the value provided for the parameter should be interpreted."
* parameters.parameterValueTypeName from PIQIParameterValueTypeVS (required)
