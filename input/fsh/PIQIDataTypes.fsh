// The PIQI attribute types. A Simple Attribute is represented as a plain string, so has no type here.

Logical: PIQICoding
Id: PIQICoding
Title: "PIQI Coding"
Description: "A single code from a code system. Adopted from the FHIR Coding type, but the system is a PIQI code system identifier (e.g. a mnemonic such as LOINC, an OID, or a URL), not necessarily a URI."
* ^status = #active
* code 0..1 string "Code value for the coding" "Code value for the coding"
* display 0..1 string "Display value for the coding" "Display value for the coding"
* system 0..1 string "Code system identifier for the coding" "Code system identifier for the coding. See Code System Identifiers in PIQI."

Logical: PIQICodeableConcept
Id: PIQICodeableConcept
Characteristics: #can-bind
Title: "PIQI Codeable Concept"
Description: "A concept, represented as text and/or zero or more codings"
* ^status = #active
* text 0..1 string "Text representation of the concept" "Text representation of the concept"
* codings 0..* PIQICoding "Collection of zero-to-many codings" "Collection of zero-to-many codings"

Logical: PIQIObservationValue
Id: PIQIObservationValue
Title: "PIQI Observation Value"
Description: "A value that may be quantitative, text, or coded, with a type that describes which kind of value it is"
* ^status = #active
* text 0..1 string "Text representation of the value" "Text representation of the value"
* type 0..1 PIQICodeableConcept "The value type" "A text representation of the value type and an optional collection of zero-to-many coded concepts representing the coded value types (e.g. HL7 v2 table 0125: ST, CE, NM, NR)"
* number 0..1 string "For numeric values" "For numeric values"
* number2 0..1 string "For second numeric value" "For the second numeric value (e.g. the high end of a numeric range)"
* codings 0..* PIQICoding "Coded value" "Collection of zero-to-many codings representing the observation value if it is a coded value"

Logical: PIQIRangeValue
Id: PIQIRangeValue
Title: "PIQI Range Value"
Description: "A numeric range. Cannot be used for a date range"
* ^status = #active
* text 0..1 string "Text representation of the value range" "Text representation of the value range"
* lowValue 0..1 string "Text representation of the low value" "Text representation of the low value"
* highValue 0..1 string "Text representation of the high value" "Text representation of the high value"
