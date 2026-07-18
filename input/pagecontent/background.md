### Framework Design

The Patient Information Quality Improvement (PIQI) Framework is structured into four distinct functional but interrelated components: 1) the taxonomy for categorizing dimensions 2) the patient-centric information model for organizing data elements, 3) simple assessment modules (SAMs) to measure quality, and 4) the [evaluation rubric](glossary.html#evaluation-rubric) to organize and interpret the measures relative to an overarching use case. Together, these components provide a structured and adaptable approach to assess and enhance the quality of patient-oriented healthcare data, ultimately increasing the certainty and usability of this critical information. Implementers can choose to deploy evaluative logic in accordance with the framework to assess and report the usability of the data relative to a specific rubric. A rubric may include weighting of a specific criterion if it is relative to assessing certain evaluations over others.

<span width="100%">
<img src="PIQI_High_Level_Component_Diagram_07172026.png" alt="PIQI Framework High Level Component Diagram" height="70%" width="70%"/>
</span>


#### Taxonomy of Dimensions

This component establishes a well-organized taxonomy that categorizes the various dimensions to be measured in healthcare data quality assessment. A PIQI dimension may be accuracy, completeness, consistency, timeliness or reliability, among others. The taxonomy serves as a structured framework for classifying the aspects of data quality that need to be evaluated. A dimension is an aspect of data quality that provides insight into the nature of a data quality failure. By categorizing these dimensions, it enables a clear understanding of what aspects of data quality are being assessed, providing a standardized and consistent foundation for the assessment process.

Further details can be found here: [PIQI Healthcare Data Quality Taxonomy (HDQT) Version 1.0](https://build.fhir.org/ig/HL7/piqi/en/piqi_framework.html#piqi-healthcare-data-quality-taxonomy-hdqt-version-10)

#### Information Model

The model component of the framework focuses on the patient [data classes](glossary.html#data-class) and their [attributes](glossary.html#data-attribute) assessed for a use case (e.g., United States Core Data for Interoperability (USCDI), Canadian Core Data for Interoperability (CACDI), billing). A [PIQI model](glossary.html#piqi-model) can be used to represent a simplified information model that defines and organizes the patient-centric data elements that are most important to ensuring the accurate representation of a given patient in a particular use context, ensuring alignment with the evolving needs of healthcare information models. Each information model serves as the core data structure against which data quality assessments are performed. It may include the data classes related to patient demographics, medical history, treatment records, and any other pertinent healthcare information. Each model facilitates the mapping of these data classes and their attributes to the taxonomy of dimensions, ensuring that each data class and attribute is assessed against relevant criteria.  A populated instance of a data class will be referred to as an element of said data class.  An attribute is always referred to as an attribute regrdless if it is a model reference or a populated instance.  This distinction allows an assessment in a evaluation rubric to be scoped to evaluate a single element in a data class (an element) or be evaluate entire data class collection (data class). For example, there might be a simple assessment that determines if a lab elements unit of measure matches the lab test (single element evaluation) and another simple assessment that determines if the lab data class has duplicate entries (data class evaluation).

The implied hierarchy of the information model for evaluation purposes is: model (entire PIQI payload), data class (data class collection), element (instance of data class), attribute (attribute of an element in a data class)

Further details can be found here: [PIQI Data Models](https://build.fhir.org/ig/HL7/piqi/en/piqi_framework.html#piqi-data-models)

#### Simple Assessment Module (SAM)

A [simple assessment module](sams.html) is a logical measurement aligned to a dimension of quality applied to a model data class or attribute according to a pattern. The input parameters of the module are based on the pattern of the assessment, but the returned result is always a ‘pass’ or ‘fail’ (or 0/1) or could not assess. These modules are intended to be organized into one or many hierarchical collections of SAMs to collectively paint a larger qualitative picture as defined by a given use case.

#### Evaluation Rubric

The [Evaluation Rubric](evaluation.html) component is a use case-oriented collection of simple assessments, organized hierarchically and aligned to the information model. Its role is to describe how each assessment relates to the acceptability of individual instance of an attribute, data class, data class lement, and the overall data model submission for a given use case.

### Framework Benefits

#### Standardized

A healthcare specific taxonomy or dimension of quality applied to a patient-centric information model can establish a common way of expressing and understanding the scope and nature of quality concerns that currently inhibit interoperability partners’ ability to trust patient information, regardless of whether it is local or received from an external entity.

#### Relevant

Being aligned to patient information specifically, rather than being a generic quality-oriented framework, provides the benefit of highly relevant, fit-for-purpose, prioritizable results.

#### Shareable and Portable

The use of a standardized information model coupled with a standard taxonomy as a basis for the deployment of modular assessments should allow for portable evaluation rubrics that should function the same regardless of the source of patient information. The evaluation rubrics are portable assets that can be shared across institutions and deployed centrally in a transactional manner.

### PIQI Community of Practice

The **PIQI Framework** is designed to be implemented by a **collaborative user community (a "community of practice")**, a network of stakeholders such as public health agencies, providers, electronic health record (EHR) vendors, and analysts who share a common interest in improving patient data quality. Within this community, participants use encapsulated, portable, data-driven components; share knowledge and lessons learned; and evolve practices together. This collaborative approach creates strong potential for rapid refinement, broader adoption, and sustained improvement of the framework.

#### Localized PIQI Models
The PIQI Framework is designed to use simple models. Those models can be localized through the addition of [data classes](glossary.html#data-class) and [attributes](glossary.html#data-attribute) important to use cases.
#### Shared Simple Assessment Modules
Many foundational, attribute level SAMs are algorithmic, but SAMs that apply to codeable concepts, elements, data classes, and patient level data often require more structured content. This may take the form of value sets, tuples (ordered sets of related values treated as a single unit, such as patient identifier, date, and result value), or other data patterns. To share and utilize rubrics that use SAMs that depend on such structures, PIQI evaluation engines must also have access to the supporting content. For example, to utilize a rubric including a SAM configured to verify that a codeable concept is an active Logical Observation Identifiers Names and Codes (LOINC) term, that PIQI evaluation engine must be able to reference the current LOINC release. Packages of SAMs and their related content can be openly shared or licensed through a community portal. More advanced algorithmic SAMs, potentially powered by generative artificial intelligence (AI), could also be hosted as Representational State Transfer (REST)ful services via wrapper SAM interfaces.
#### Shared Evaluation Rubrics
The PIQI Framework assesses patient data using collections of data quality criteria, referred to as [Evaluation Rubrics](glossary.html#evaluation-rubric). While the Evaluation Rubrics in PIQI are designed to be configured to support the needs of the implementer, the ability to establish sanctioned standard Evaluation Rubrics is one of the most beneficial features of the PIQI Framework.  The ability to publish and share Evaluation Rubrics, along with their dependent SAMs and PIQI components can minimize duplication of effort and provide a powerful way to create a common basis for understanding data quality across the community.

The community is still establishing how the sanctioned, standard Evaluation Rubrics may be developed and shared, as well as what common practices should be followed in their usage.
