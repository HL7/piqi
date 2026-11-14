The PIQI Clinical Data Model is a patient-centered model of the clinical information that is exchanged about a patient in the United States. It is defined in this specification as the logical model [PIQI Clinical Model](StructureDefinition-PIQIClinicalModel.html), and is identified in PIQI artifacts by the model mnemonic `PAT_CLINICAL_V1`. The model was developed and reviewed by the PIQI Alliance Patient Clinical Data Class Model work group.

This model is one of the two US-specific models provided by this specification; see [PIQI Models in this Specification](piqi_framework.html#piqi-models-in-this-specification).

### Use of the Model

The PIQI Clinical Data Model is a simplified information model that focuses on the [data classes](glossary.html#data-class) and [attributes](glossary.html#data-attribute) that are highly relevant to the quality of patient clinical data, in order to simplify the qualitative assessment process. Its scope follows the [United States Core Data for Interoperability (USCDI)](https://www.healthit.gov/isp/united-states-core-data-interoperability-uscdi), the baseline set of data elements for nationwide health information exchange in the United States, and its content is based on the corresponding profiles in [US Core](http://hl7.org/fhir/us/core/).

A payload that conforms to this model carries the information about a single patient: the [Patient Container](glossary.html#patient-container) holds exactly one Demographics element, and zero or more elements of each of the other data classes. Every attribute has a cardinality of 0..1, and has one of the four PIQI [attribute types](piqi_model_of_models.html#piqi-attribute-types).

Systems that exchange clinical data will typically produce a payload in this model by transforming the data they actually exchange - FHIR resources, C-CDA documents, HL7 v2 messages, or proprietary formats - into the model. Because every source is reduced to the same model, the same [Evaluation Rubrics](glossary.html#evaluation-rubric) can be applied to clinical data regardless of how it was exchanged, and the scores are comparable across sources. The consensus [USCDI Aligned Evaluation Rubric](artifacts.html#clinical-data-evaluation-rubric) is written against this model.

The model contains the following data classes:

{% include StructureDefinition-PIQIClinicalModel-diff.xhtml %}

### Relationship to FHIR

The PIQI Clinical Data Model is not a FHIR format: it is a simpler, flatter model that is used for assessing data quality, and data in FHIR format must be transformed into it before it can be assessed. However, the model was derived from US Core, and each data class corresponds to a US Core profile:

- Each data class corresponds to a FHIR resource, as profiled by US Core. Some data classes also carry a few attributes from closely related resources - for example, Lab Results carries attributes of the specimen, the order, and the performer.
- Each attribute corresponds to a FHIR element. Where a FHIR element is a complex data type, the PIQI model usually splits it into separate attributes: a period becomes start and end dates, a quantity becomes a result value and a result unit, and a reference to a practitioner becomes the practitioner's name and identifier.
- The definitions of the data classes and attributes are those of the corresponding US Core (or FHIR) elements, adapted where needed to fit the PIQI model.
- Where US Core binds an element to a value set, the corresponding PIQI attribute has the same binding, with the same strength. Note that a PIQI coding identifies its code system with a [code system identifier](piqi_framework.html#code-system-identifiers-in-piqi), which is not necessarily the FHIR URI for the code system.
- FHIR elements that are not relevant to the quality assessments are not represented in the model.

The following table summarizes which US Core profiles each data class is based on:

| Data Class | US Core Profile | Attributes also drawn from |
| --- | --- | --- |
| Demographics | [Patient](http://hl7.org/fhir/us/core/StructureDefinition-us-core-patient.html) | [Birth Sex extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-birthsex.html), [Ethnicity extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-ethnicity.html), [Gender Identity extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-genderIdentity.html), [Observation Sexual Orientation](http://hl7.org/fhir/us/core/StructureDefinition-us-core-observation-sexual-orientation.html), [Race extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-race.html), [Tribal Affiliation extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-tribal-affiliation.html) |
| Allergies | [AllergyIntolerance](http://hl7.org/fhir/us/core/StructureDefinition-us-core-allergyintolerance.html) |  |
| Conditions | [Condition Problems and Health Concerns](http://hl7.org/fhir/us/core/StructureDefinition-us-core-condition-problems-health-concerns.html) | [condition-assertedDate](http://hl7.org/fhir/R4/extension-condition-asserteddate.html) (FHIR R4) |
| Immunizations | [Immunization](http://hl7.org/fhir/us/core/StructureDefinition-us-core-immunization.html) |  |
| Lab Results | [Laboratory Result Observation](http://hl7.org/fhir/us/core/StructureDefinition-us-core-observation-lab.html) | [DiagnosticReport for Laboratory Results Reporting](http://hl7.org/fhir/us/core/StructureDefinition-us-core-diagnosticreport-lab.html), [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html), [ServiceRequest](http://hl7.org/fhir/us/core/StructureDefinition-us-core-servicerequest.html), [Specimen](http://hl7.org/fhir/us/core/StructureDefinition-us-core-specimen.html) |
| Medications | [MedicationRequest](http://hl7.org/fhir/us/core/StructureDefinition-us-core-medicationrequest.html) | [MedicationStatement](http://hl7.org/fhir/R4/medicationstatement.html) (FHIR R4), [Medication Adherence extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-medication-adherence.html), [MedicationDispense](http://hl7.org/fhir/us/core/StructureDefinition-us-core-medicationdispense.html) |
| Procedures | [Procedure](http://hl7.org/fhir/us/core/StructureDefinition-us-core-procedure.html) |  |
| Vital Signs | [Vital Signs](http://hl7.org/fhir/us/core/StructureDefinition-us-core-vital-signs.html) |  |
| Diagnostic Imaging | [DiagnosticReport for Report and Note Exchange](http://hl7.org/fhir/us/core/StructureDefinition-us-core-diagnosticreport-note.html) | [DiagnosticReport](http://hl7.org/fhir/R4/diagnosticreport.html) (FHIR R4), [Observation Clinical Result](http://hl7.org/fhir/us/core/StructureDefinition-us-core-observation-clinical-result.html), [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html) |
| Medical Devices | [Device](http://hl7.org/fhir/us/core/StructureDefinition-us-core-device.html) |  |
| Health Assessments | [Observation Screening Assessment](http://hl7.org/fhir/us/core/StructureDefinition-us-core-observation-screening-assessment.html) | [Extension Questionnaire URI](http://hl7.org/fhir/us/core/StructureDefinition-us-core-extension-questionnaire-uri.html), [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html) |
| Clinical Documents | [DocumentReference](http://hl7.org/fhir/us/core/StructureDefinition-us-core-documentreference.html) | [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html) |
| Encounters | [Encounter](http://hl7.org/fhir/us/core/StructureDefinition-us-core-encounter.html) | [Condition Encounter Diagnosis](http://hl7.org/fhir/us/core/StructureDefinition-us-core-condition-encounter-diagnosis.html) |
| Goals | [Goal](http://hl7.org/fhir/us/core/StructureDefinition-us-core-goal.html) |  |
| Care Plans | [CarePlan](http://hl7.org/fhir/us/core/StructureDefinition-us-core-careplan.html) |  |
| Practitioners | [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html) | [PractitionerRole](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitionerrole.html) |
| Clinical Tests | [Observation Clinical Result](http://hl7.org/fhir/us/core/StructureDefinition-us-core-observation-clinical-result.html) | [DiagnosticReport for Report and Note Exchange](http://hl7.org/fhir/us/core/StructureDefinition-us-core-diagnosticreport-note.html), [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html) |
| Coverage | [Coverage](http://hl7.org/fhir/us/core/StructureDefinition-us-core-coverage.html) |  |
| Provenance | [Provenance](http://hl7.org/fhir/us/core/StructureDefinition-us-core-provenance.html) |  |

The mappings below show, for each data class and attribute, the PIQI mnemonic that is used to refer to it in Evaluation Rubrics, the roles that attributes play within their data class, and the corresponding FHIR element (the comment on the FHIR mapping identifies the US Core 9.0.0 profile, or the FHIR R4 structure, that the element is from).

{% include StructureDefinition-PIQIClinicalModel-maps.xhtml %}
