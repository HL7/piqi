The PIQI Claims Data Model is a patient-centered model of the claims and Explanation of Benefits (EOB) data that payers in the United States make available about their members. It is defined in this specification as the logical model [PIQI EOB Model](StructureDefinition-PIQIEOBModel.html), and is identified in PIQI artifacts by the model mnemonic `PAT_EOB_V1`.

This model is one of the two US-specific models provided by this specification; see [PIQI Models in this Specification](piqi_framework.html#piqi-models-in-this-specification).

### Use of the Model

The PIQI Claims Data Model is based on the Common Payer Consumer Data Set (CPCDS), which defines the claims data that payers in the United States provide to their members, for example through the CMS Patient Access API. Many of the attribute descriptions in the model carry the CPCDS data element numbers that the attributes correspond to.

A payload that conforms to this model carries the information about a single member: the [Patient Container](glossary.html#patient-container) holds exactly one Member element, along with the member's coverages, the claims (medical, pharmacy and dental) with their lines, diagnoses and procedures, and the providers involved in those claims. Every attribute has a cardinality of 0..1, and has one of the four PIQI [attribute types](piqi_model_of_models.html#piqi-attribute-types).

Payers and the systems that receive claims data will typically produce a payload in this model by transforming the claims data they exchange into the model, so that the same [Evaluation Rubrics](glossary.html#evaluation-rubric) can be applied regardless of how the data was exchanged. The consensus [C4BB Inpatient EOB Evaluation Rubric](artifacts.html#c4bb-inpatient-eob-evaluation-rubric) is written against this model.

The model contains the following data classes:

{% include StructureDefinition-PIQIEOBModel-diff.xhtml %}

### Relationship to FHIR

The PIQI Claims Data Model is not a FHIR format: it is a simpler, flatter model that is used for assessing data quality, and data in FHIR format must be transformed into it before it can be assessed.

In FHIR, CPCDS is represented by the [CARIN Consumer Directed Payer Data Exchange (CARIN Blue Button)](http://hl7.org/fhir/us/carin-bb/) implementation guide, which profiles the ExplanationOfBenefit resource for each type of claim, along with the Patient, Coverage, Organization and Practitioner resources that the claims refer to. The data classes in this model relate to FHIR as follows:

- The Member, Coverage and Provider data classes correspond to the Patient, Coverage and Practitioner resources. Their definitions are those of the corresponding [US Core](http://hl7.org/fhir/us/core/) elements, and where US Core binds an element to a value set, the corresponding PIQI attribute has the same binding.
- The Medical Claim, Pharmacy Claim and Dental Claim data classes correspond to the ExplanationOfBenefit resource. In FHIR, the lines, diagnoses and procedures of a claim are parts of the ExplanationOfBenefit resource; in this model they are separate data classes in the Patient Container.
- Where a claims attribute corresponds to a base FHIR ExplanationOfBenefit element, its definition is taken from that element. Many claims attributes - including most of the amounts, and the inpatient information such as the DRG and admission details - correspond to the supporting information and adjudication elements that are defined by CARIN Blue Button; these attributes keep their CPCDS definitions, and are not yet mapped to FHIR.
- Where a FHIR element is a complex data type, the PIQI model usually splits it into separate attributes - for example, a period becomes start and end dates.

The following table summarizes which FHIR resources each data class is based on:

| Data Class | FHIR | Attributes also drawn from |
| --- | --- | --- |
| Member | [Patient](http://hl7.org/fhir/us/core/StructureDefinition-us-core-patient.html) | [Birth Sex extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-birthsex.html), [Ethnicity extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-ethnicity.html), [Race extension](http://hl7.org/fhir/us/core/StructureDefinition-us-core-race.html) |
| Coverage | [Coverage](http://hl7.org/fhir/us/core/StructureDefinition-us-core-coverage.html) |  |
| Medical Claim | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4) |  |
| Claim Line | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4) (`ExplanationOfBenefit.item`) |  |
| Claim Diagnosis | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4) (`ExplanationOfBenefit.diagnosis`) |  |
| Claim Procedure | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4) (`ExplanationOfBenefit.procedure`) |  |
| Pharmacy Claim | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4) |  |
| Dental Claim | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4) |  |
| Provider | [Practitioner](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitioner.html) | [ExplanationOfBenefit](http://hl7.org/fhir/R4/explanationofbenefit.html) (FHIR R4), [PractitionerRole](http://hl7.org/fhir/us/core/StructureDefinition-us-core-practitionerrole.html) |

The mappings below show, for each data class and attribute, the PIQI mnemonic that is used to refer to it in Evaluation Rubrics, and the corresponding FHIR element (the comment on the FHIR mapping identifies the US Core 9.0.0 profile, or the FHIR R4 structure, that the element is from).

{% include StructureDefinition-PIQIEOBModel-maps.xhtml %}
