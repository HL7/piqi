// The rules that a logical model must follow to be a PIQI model

Extension: PIQIModelVersion
Id: piqi-model-version
Title: "PIQI Model Version"
Description: "The version of a PIQI model. This is the version of the model as agreed by the community that maintains it, and is not the same as the business version of the StructureDefinition, which is the version of the specification that publishes it."
Context: StructureDefinition
* ^status = #active
* value[x] only positiveInt

Extension: PIQIModelType
Id: piqi-model-type
Title: "PIQI Model Type"
Description: "The classification of a PIQI model (e.g. 'Standard base')."
Context: StructureDefinition
* ^status = #active
* value[x] only string

Invariant: pqm-1
Description: "A PIQI model only has data classes (BackboneElements directly under the root) and attributes (elements of a data class)"
Severity: #error
Expression: "differential.element.all(path.split('.').count() <= 3)"

Invariant: pqm-2
Description: "Each data class is a BackboneElement with a label, a PIQI mnemonic, and a cardinality of 0..1, 0..*, 1..1 or 1..*"
Severity: #error
Expression: "differential.element.where(path.split('.').count() = 2).all(type.count() = 1 and type.code = 'BackboneElement' and label.exists() and mapping.where(identity = 'piqi-mnemonic').count() = 1 and (min = 0 or min = 1) and (max = '1' or max = '*'))"

Invariant: pqm-3
Description: "Each attribute has a cardinality of 0..1, is one of the PIQI attribute types (Simple Attribute = string, PIQICodeableConcept, PIQIObservationValue or PIQIRangeValue), and has a label and a PIQI mnemonic"
Severity: #error
Expression: "differential.element.where(path.split('.').count() = 3).all(min = 0 and max = '1' and type.count() = 1 and (type.code in ('string' | 'http://hl7.org/xprod/ig/uv/piqi/StructureDefinition/PIQICodeableConcept' | 'http://hl7.org/xprod/ig/uv/piqi/StructureDefinition/PIQIObservationValue' | 'http://hl7.org/xprod/ig/uv/piqi/StructureDefinition/PIQIRangeValue')) and label.exists() and mapping.where(identity = 'piqi-mnemonic').count() = 1)"

Invariant: pqm-4
Description: "The root element (the root entity) has a label (the root entity name) and a PIQI mnemonic (the root entity mnemonic)"
Severity: #error
Expression: "differential.element.first().label.exists() and differential.element.first().mapping.where(identity = 'piqi-mnemonic').count() = 1"

Invariant: pqm-5
Description: "PIQI mnemonics are upper case letters, digits and underscores, and are unique within the model"
Severity: #error
Expression: "differential.element.mapping.where(identity = 'piqi-mnemonic').map.all(matches('^[A-Z0-9_]+$')) and differential.element.mapping.where(identity = 'piqi-mnemonic').map.isDistinct()"

Invariant: pqm-6
Description: "Data class and attribute names (the field names used in payloads) are camelCase"
Severity: #error
Expression: "differential.element.where(path.contains('.')).all(path.split('.').last().matches('^[a-z][A-Za-z0-9]*$'))"

Invariant: pqm-7
Description: "Roles are only assigned to attributes"
Severity: #error
Expression: "differential.element.where(mapping.identity = 'piqi-role').all(path.split('.').count() = 3)"

Invariant: pqm-8
Description: "The model declares the PIQI mnemonic mapping (and the PIQI role mapping, if roles are used)"
Severity: #error
Expression: "mapping.where(identity = 'piqi-mnemonic' and uri = 'http://hl7.org/xprod/ig/uv/piqi/mapping/mnemonic').exists() and (differential.element.mapping.where(identity = 'piqi-role').exists() implies mapping.where(identity = 'piqi-role' and uri = 'http://hl7.org/xprod/ig/uv/piqi/mapping/role').exists())"

Invariant: pqm-9
Description: "The model has a model mnemonic identifier, which is upper case letters, digits and underscores"
Severity: #error
Expression: "identifier.where(system = 'http://hl7.org/xprod/ig/uv/piqi/model-mnemonic').count() = 1 and identifier.where(system = 'http://hl7.org/xprod/ig/uv/piqi/model-mnemonic').value.matches('^[A-Z0-9_]+$')"

Profile: PIQIModelStructureDefinition
Parent: StructureDefinition
Id: piqi-model-structuredefinition
Title: "PIQI Model StructureDefinition"
Description: """The rules that a logical model must follow to define a PIQI model. A PIQI model is a logical model with a root entity, data classes, and attributes:

* The root element is the root entity (e.g. the patient). Its label is the root entity name, and its PIQI mnemonic is the root entity mnemonic
* Each element directly under the root is a data class. It is a BackboneElement, its name is the field name used for the data class in payloads, its label is the data class name, and its cardinality is the cardinality of the data class
* Each element of a data class is an attribute. Its name is the field name used for the attribute in payloads, its label is the short name of the attribute, its cardinality is 0..1, and its type is one of the PIQI attribute types
* Each data class and attribute has a PIQI mnemonic, which is represented as a mapping with the identity 'piqi-mnemonic'. Roles that attributes play in their data class are represented as mappings with the identity 'piqi-role'
* The model mnemonic is represented as an identifier, the model version and type as extensions, and the model name as the title
* A model that extends another model (its base model) specializes it; otherwise the model specializes Base"""
* ^status = #active
* extension contains PIQIModelVersion named modelVersion 1..1 and PIQIModelType named modelType 1..1
* identifier 1..*
* title 1..1
* kind = #logical
* abstract = false
* derivation 1..1
* derivation = #specialization
* differential 1..1
* obeys pqm-1 and pqm-2 and pqm-3 and pqm-4 and pqm-5 and pqm-6 and pqm-7 and pqm-8 and pqm-9
