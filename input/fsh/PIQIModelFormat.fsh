// The PIQI model definition format: the JSON format in which PIQI models are exchanged
// between PIQI implementations (formerly described by piqi-model-schema.json)

Invariant: pqi-mnemonic
Description: "Mnemonics are upper case letters, digits and underscores"
Severity: #error
Expression: "matches('^[A-Z0-9_]+$')"

Invariant: pqi-fieldname
Description: "Field names are camelCase: a lower case letter followed by letters and digits"
Severity: #error
Expression: "matches('^[a-z][A-Za-z0-9]*$')"

CodeSystem: PIQICardinality
Id: piqi-cardinality
Title: "PIQI Cardinality"
Description: "The cardinality of a data class in a PIQI model"
* ^status = #active
* ^caseSensitive = true
* ^experimental = false
* #ONE "One" "Exactly one element of the data class is present"
* #ZERO_TO_ONE "Zero to One" "At most one element of the data class is present"
* #ZERO_TO_MANY "Zero to Many" "Any number of elements of the data class may be present"
* #ONE_TO_MANY "One to Many" "At least one element of the data class is present"

ValueSet: PIQICardinalityVS
Id: piqi-cardinality
Title: "PIQI Cardinality"
Description: "The cardinality of a data class in a PIQI model"
* ^status = #active
* ^experimental = false
* include codes from system PIQICardinality

CodeSystem: PIQIAttributeType
Id: piqi-attribute-type
Title: "PIQI Attribute Type"
Description: "The type of an attribute in a PIQI model. Data Class and Element are pseudo-attribute types used for the data class itself and for a single element of the data class"
* ^status = #active
* ^caseSensitive = true
* ^experimental = false
* #CLS "Data Class" "The data class itself (the collection of elements)"
* #ELM "Element" "A single element of the data class"
* #ATR "Simple Attribute" "A simple string value"
* #CC "Codeable Concept" "A Codeable Concept: text, and zero or more codings"
* #RV "Range Value" "A numeric range"
* #OBSVAL "Observation Value" "A value that may be quantitative, text, or coded"

ValueSet: PIQIAttributeTypeVS
Id: piqi-attribute-type
Title: "PIQI Attribute Type"
Description: "The type of an attribute in a PIQI model"
* ^status = #active
* ^experimental = false
* include codes from system PIQIAttributeType

Logical: PIQIModelDefinition
Id: PIQIModelDefinition
Title: "PIQI Model Definition"
Description: "The format in which a PIQI model is defined and exchanged between PIQI implementations: a root entity and a set of data classes, each with attributes and optional attribute roles. In this specification, PIQI models are defined as logical models that conform to the [PIQI Model StructureDefinition](StructureDefinition-piqi-model-structuredefinition.html) profile; the PIQI model definition format can be generated from those logical models."
* ^status = #active
* name 1..1 string "Human-readable name of the model" "Human-readable name of the model."
* mnemonic 1..1 string "Short, unique, upper-case code identifying the model" "Short, unique, upper-case code identifying the model (e.g. PAT_CLINICAL_V1)."
* mnemonic obeys pqi-mnemonic
* description 1..1 string "Description of the model" "Free-text description of the model, its scope, and review status. The property is always present, but may be null."
* insert JsonNullable(description)
* version 1..1 positiveInt "Version of the model" "Integer version number of the model."
* modelTypeName 1..1 string "Classification of the model type" "Classification of the model type (e.g. 'Standard base')."
* baseModel 1..1 string "The base model this model extends" "Name/reference of the base model this model extends. The property is always present, and is null if the model does not extend another model."
* insert JsonNullable(baseModel)
* rootEntityName 1..1 string "Name of the root entity" "Human-readable name of the root entity represented by this model (e.g. 'patient')."
* rootEntityMnemonic 1..1 string "Mnemonic for the root entity" "Mnemonic code for the root entity (e.g. PATIENT)."
* rootEntityMnemonic obeys pqi-mnemonic
* dataClasses 1..* BackboneElement "The data classes that make up the model" "The set of data classes that make up the model."
* dataClasses.name 1..1 string "Name of the data class" "Human-readable name of the data class (e.g. Demographics)."
* dataClasses.mnemonic 1..1 string "Mnemonic for the data class" "Short, unique mnemonic code for the data class."
* dataClasses.mnemonic obeys pqi-mnemonic
* dataClasses.description 1..1 string "Description of the data class" "Free-text description of the data class. The property is always present, but may be null."
* insert JsonNullable(dataClasses.description)
* dataClasses.shortName 1..1 string "Abbreviated name of the data class" "Abbreviated display name for the data class."
* dataClasses.fieldName 1..1 string "Property name in payloads" "camelCase field/property name used for the data class in data payloads."
* dataClasses.fieldName obeys pqi-fieldname
* dataClasses.isInherited 1..1 boolean "Inherited from the base model?" "Whether the data class is inherited from a base model."
* dataClasses.sequence 1..1 positiveInt "Order of the data class" "Ordering position of the data class within the model."
* dataClasses.cardinality 1..1 BackboneElement "Cardinality of the data class" "The cardinality of the data class in the root entity."
* dataClasses.cardinality.name 1..1 string "Cardinality name" "Human-readable cardinality label (One, Zero to One, Zero to Many, One to Many)."
* dataClasses.cardinality.mnemonic 1..1 code "Cardinality code" "Mnemonic code for the cardinality."
* dataClasses.cardinality.mnemonic from PIQICardinalityVS (required)
* dataClasses.attributes 1..* BackboneElement "The attributes of the data class" "The attributes belonging to this data class. These include two pseudo-attributes, of type Data Class and Element, which describe the data class itself and a single element of the data class."
* dataClasses.attributes.name 1..1 string "Name of the attribute" "Human-readable name of the attribute."
* dataClasses.attributes.mnemonic 1..1 string "Mnemonic for the attribute" "Short, unique mnemonic code for the attribute."
* dataClasses.attributes.mnemonic obeys pqi-mnemonic
* dataClasses.attributes.shortName 1..1 string "Abbreviated name of the attribute" "Abbreviated display name for the attribute."
* dataClasses.attributes.fieldName 1..1 string "Property name in payloads" "camelCase field/property name used for the attribute in data payloads."
* dataClasses.attributes.fieldName obeys pqi-fieldname
* dataClasses.attributes.description 1..1 string "Description of the attribute" "Free-text description of the attribute's meaning. The property is always present, but may be null."
* insert JsonNullable(dataClasses.attributes.description)
* dataClasses.attributes.sequence 1..1 positiveInt "Order of the attribute" "Ordering position of the attribute within its data class."
* dataClasses.attributes.autoGenerated 1..1 boolean "System generated?" "Whether the attribute is system-generated (e.g., the implicit Data Class / Element entries) rather than user-defined."
* dataClasses.attributes.isInherited 1..1 boolean "Inherited from the base model?" "Whether the attribute is inherited from a base model/data class."
* dataClasses.attributes.attributeType 1..1 BackboneElement "Type of the attribute" "The type of the attribute."
* dataClasses.attributes.attributeType.name 1..1 string "Attribute type name" "Human-readable attribute type label (Data Class, Element, Simple Attribute, Codeable Concept, Range Value, Observation Value)."
* dataClasses.attributes.attributeType.mnemonic 1..1 code "Attribute type code" "Mnemonic code for the attribute type."
* dataClasses.attributes.attributeType.mnemonic from PIQIAttributeTypeVS (required)
* dataClasses.roles 0..* BackboneElement "Roles that attributes play in the data class" "Semantic role assignments mapping specific attributes in this data class to well-known roles (e.g., start/end datetime). The property is always present, but the array may be empty."
* insert JsonEmptyArrayPresent(dataClasses.roles)
* dataClasses.roles.roleTypeName 1..1 string "Name of the role" "Human-readable name of the semantic role played by the referenced attribute (e.g. Start Datetime)."
* dataClasses.roles.roleTypeMnemonic 1..1 string "Mnemonic for the role" "Mnemonic code for the role type (e.g. START_DATETIME)."
* dataClasses.roles.roleTypeMnemonic obeys pqi-mnemonic
* dataClasses.roles.attributeName 1..1 string "Attribute that plays the role" "Name of the attribute (within this data class) that fulfills the role."
* dataClasses.roles.attributeMnemonic 1..1 string "Mnemonic of the attribute that plays the role" "Mnemonic of the attribute (within this data class) that fulfills the role."
* dataClasses.roles.attributeMnemonic obeys pqi-mnemonic
