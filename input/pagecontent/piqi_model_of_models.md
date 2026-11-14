Every PIQI model - whether one of the models in this specification, or a model agreed by some other community - is built from the same parts, and follows the same rules. Those parts and rules are themselves described by a model: the PIQI model of models. This page describes the model of models, and the two ways it is represented in this specification:

- The logical model [PIQI Model Definition](StructureDefinition-PIQIModelDefinition.html) describes the format in which PIQI models are defined and exchanged between PIQI implementations
- The profile [PIQI Model StructureDefinition](StructureDefinition-piqi-model-structuredefinition.html) enforces the model of models on logical models, so that a PIQI model can be defined as a FHIR logical model, as the models in this specification are

### The Parts of a PIQI Model

A PIQI model consists of:

- **A root entity** - the [Patient Container](glossary.html#patient-container) - which holds all the data about a single patient (or member) in a payload. The root entity has a name (e.g. `patient`) and a mnemonic (e.g. `PATIENT`)
- **Data classes** - each [data class](glossary.html#data-class) is a collection of elements of the same kind (e.g. Allergies, Lab Results). Each data class has a name, a mnemonic, a field name that is used for the data class in payloads, and a cardinality in the root entity: One, Zero to One, Zero to Many, or One to Many
- **Attributes** - each element of a data class has a set of [attributes](glossary.html#data-attribute). Each attribute has a name, a mnemonic, a field name that is used for the attribute in payloads, and one of the four PIQI [attribute types](#piqi-attribute-types): Simple Attribute, Codeable Concept, Observation Value, or Range Value. Attributes always have a cardinality of 0..1
- **Roles** - an attribute may be assigned a role that it plays within its data class (e.g. Start Datetime)

The model as a whole has a name, a mnemonic that identifies it (e.g. `PAT_CLINICAL_V1`), a version, and a model type. A model may extend another model (its base model), adding data classes and attributes to it.

The mnemonics of the data classes and attributes are unique within the model, and are the names by which [Evaluation Rubrics](glossary.html#evaluation-rubric) refer to the parts of the model.

### PIQI Model Definition Format

PIQI implementations exchange model definitions in a JSON format, which is described by the [PIQI Model Definition](StructureDefinition-PIQIModelDefinition.html) logical model. The model definitions for the [PIQI Clinical Data Model](piqi_model_clinical.html) and the [PIQI Claims Data Model](piqi_model_claims.html) are available in this format on the [PIQI Artifacts](artifacts.html) page.

In this format, each data class has two additional pseudo-attributes, with the attribute types Data Class (`CLS`) and Element (`ELM`), that describe the data class itself and a single element of the data class.

{% include StructureDefinition-PIQIModelDefinition-diff.xhtml %}

### PIQI Attribute Types

PIQI Elements are comprised of four [attribute](glossary.html#data-attribute) types: Simple, Codeable Concept, Observation Value, and Range Value. All attributes have a cardinality of 0..1, recognizing that a Codeable Concept collection attribute may contain multiple coding values.

The JSON fragments in this section are illustrative only. They show how attributes of each type might logically contain, but this specification does not define an exchange format for PIQI payloads.

#### Simple Attribute Type

A Simple Attribute is a string value. Simple Attributes can contain any string and can be used to represent any single basic data type like text, simple numbers, structured numbers, dates, and date ranges.

**Illustrative example:** the effectiveDate attribute is a Simple Attribute.
```json
    "Allergies": [
        {"effectiveDate": "20230111"}
    ]
```
#### Codeable Concept Attribute Type

A Codeable Concept attribute is a structure that can be represented as a simple attribute or a coded entity. Many attributes in patient data can be represented by a coded entity or a simple code value and as such is represented by a text sub-attribute and a codings collection.

Many of the important attributes in patient information are Codeable Concepts. Codeable Concepts are attributes that can be represented by a simple text string or by one or many codings, hence the codeable concept. If the attribute does contain one or more codings, each coding is comprised of three components: a code, display, and code system identifier.

**All of these Coding sub attributes should be populated in order for the concept being exchanged to be validated.**

The **code is needed** to provide a unique stable identifier for the concept in a given code system.

The **code system identifier is needed** to provide context for the meaning of a code, and to confirm that the code is valid in that code system and, if necessary, determine the status of that code.

The **display is needed** so that a human can verify that the code provided does, in fact, semantically match the concept in the identified code system. It is also necessary if the concept provided is being mapped/normalized to a standard or local terminology.

**Codeable Concept sub-attributes** (see [PIQI Codeable Concept](StructureDefinition-PIQICodeableConcept.html))

{% include StructureDefinition-PIQICodeableConcept-diff.xhtml %}

##### Coding Attributes
Codings exist as a substructure to the CodeableConcept type.  The substructure is adopted from Fast Healthcare Interoperability Resources (FHIR) to express one or more codings associated with a given CodeableConcept.

**Coding sub-attributes** (see [PIQI Coding](StructureDefinition-PIQICoding.html))

{% include StructureDefinition-PIQICoding-diff.xhtml %}

**Illustrative example:**
```json
    "performedTest": {
        "text": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",
        "codings": [
            {
                "code": "742-7",
                "display": "MONOCYTES:NCNC:PT:BLD:QN:AUTOMATED COUNT",
                "system": "LOINC"
            }
        ]
    }
```

#### Observation Value Attribute Type

An Observation Value attribute is a structure that can be represented as a simple attribute value or a structure observation value. Observation Value is a specialized attribute as many elements in patient information can be represented by a quantitative, text, or coding value.

**Observation Value sub-attributes** (see [PIQI Observation Value](StructureDefinition-PIQIObservationValue.html))

{% include StructureDefinition-PIQIObservationValue-diff.xhtml %}

**Illustrative example of ResultValue Text Only:**

```json
    "resultValue": {
        "text": "NEG",
        "type": {
            "text": "ST"
        }
    }
```

**Illustrative example of ResultValue Coding Sub-Attribute:**

```json
    "resultValue": {
        "text": "Negative",
        "type": {
            "text": "CE",
            "codings": [
                {
                    "system": "HL7-0125",
                    "code": "CE",
                    "display": "Coded element"
                }
            ]
        },
        "codings": [
            {
                "system": "SNOMEDCT",
                "code": "260385009",
                "display": "Negative"
            }
        ]
    }
```

**Illustrative example of ResultValue Number Value Sub-Attribute:**

```json
    "resultValue": {
        "text": "100",
        "type": {
            "text": "NM",
            "codings": [
                {
                    "system": "HL7-0125",
                    "code": "NM",
                    "display": "Numeric"
                }
            ]
        },
        "number": "100"
    }
```
**Illustrative example of ResultValue Numeric Range Sub-Attribute:**

```json
    "resultValue": {
        "text": "3.5-4.5",
        "type": {
            "text": "NR",
            "codings": [
                {
                    "system": "HL7-0125",
                    "code": "NR",
                    "display": "Numeric range"
                }
            ]
        },
        "number": "3.5",
        "number2": "4.5"
    }
```

#### Range Value Attribute Type

A Range Value attribute is a structure that can be represented as a simple attribute value or a structured range value. The Range Value is a specialized attribute as many elements in patient information can be represented by a structured range. The Range Value Attribute Type can only be used with numeric ranges and cannot be used for a date range.

**Range Value sub-attributes** (see [PIQI Range Value](StructureDefinition-PIQIRangeValue.html))

{% include StructureDefinition-PIQIRangeValue-diff.xhtml %}

**Illustrative example:**

```json
    "referenceRange": {
        "text": "14-88",
        "lowValue": "14",
        "highValue": "88"
    }
```

### PIQI Models as Logical Models

In this specification, PIQI models are defined as FHIR logical models, which allows them to be published, rendered, and related to FHIR and other specifications in the same way as other FHIR artifacts. A logical model that defines a PIQI model conforms to the [PIQI Model StructureDefinition](StructureDefinition-piqi-model-structuredefinition.html) profile, which enforces the model of models on the logical model. The parts of a PIQI model are represented as follows:

| PIQI Model Definition | Logical Model |
| --- | --- |
| Model name | `StructureDefinition.title` |
| Model mnemonic | `StructureDefinition.identifier`, with the system `http://hl7.org/xprod/ig/uv/piqi/model-mnemonic` |
| Model version | The [PIQI Model Version](StructureDefinition-piqi-model-version.html) extension. Note that this is not the same as `StructureDefinition.version`, which is the version of the specification that publishes the model |
| Model type | The [PIQI Model Type](StructureDefinition-piqi-model-type.html) extension |
| Model description | `StructureDefinition.description` |
| Base model | `StructureDefinition.baseDefinition`: the model specializes its base model, or `Base` if it has none |
| Root entity name and mnemonic | The `label` and `piqi-mnemonic` mapping of the root element |
| Data class | An element directly under the root, of type BackboneElement. Its name is the field name, its `label` is the data class name, its `min` and `max` are the cardinality of the data class, and its `definition` is the description of the data class |
| Attribute | An element of a data class, with a cardinality of 0..1. Its name is the field name, its `label` is the short name of the attribute, its `definition` is the description of the attribute, and its type is `string` (Simple Attribute), [PIQICodeableConcept](StructureDefinition-PIQICodeableConcept.html), [PIQIObservationValue](StructureDefinition-PIQIObservationValue.html), or [PIQIRangeValue](StructureDefinition-PIQIRangeValue.html) |
| Data class and attribute mnemonics | A mapping on the element with the identity `piqi-mnemonic` |
| Roles | A mapping on the attribute with the identity `piqi-role`, where the map is the role mnemonic, and the comment is the role name |
| Sequence | The order of the elements |

The profile has invariants that check these rules, including that the mnemonics are unique within the model, and that a logical model only contains data classes and attributes.
