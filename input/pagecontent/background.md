### Framework Design

The PIQI Framework is structured into four distinct functional but interrelated components: 1) the taxonomy for categorizing dimensions 2) the patient-centric information model for organizing data elements, 3) simple assessment modules (SAMs) to measure quality, and 4) the evaluation criteria to organize and interpret the measures relative to an overarching use case. Together, these components provide a structured and adaptable approach to assess and enhance the quality of patient-oriented healthcare data, ultimately increasing the certainty and usability of this critical information. Implementers can choose to deploy evaluative logic in accordance with the framework to assess and report the usability of the data relative to a specific rubric. A rubric may include weighting of a specific criterion if it is relative to assessing certain evaluations over others.

<span width="100%">
<img src="PIQI_High_Level_Component_Diagram.png" alt="PIQI Framework High Level Component Diagram" height="70%" width="70%"/>
</span>


#### Taxonomy of Dimensions

This component establishes a well-organized taxonomy that categorizes the various dimensions to be measured in healthcare data quality assessment. A PIQI dimension may be accuracy, completeness, consistency, timeliness or reliability, among others. The taxonomy serves as a structured framework for classifying the aspects of data quality that need to be evaluated. A dimension is an aspect of data quality that provides insight into the nature of a data quality failure. By categorizing these dimensions, it enables a clear understanding of what aspects of data quality are being assessed, providing a standardized and consistent foundation for the assessment process.

#### Information Model

This component of the framework defines the patient data elements and characteristics assessed for a use case (e.g., USCDI, CACDI, billing). There is no single PIQI information model - implementers define the model to suit the use case. It represents a simplified information model that defines and organizes the patient-centric data elements that are most important to ensuring the accurate representation of a given patient, ensuring alignment with the evolving needs of healthcare information models. A PIQI information model serves as the core data structure against which data quality assessments are performed. It may include the data elements related to patient demographics, medical history, treatment records, and any other pertinent healthcare information. The model facilitates the mapping of these elements to the taxonomy of dimensions, ensuring that each data element is assessed against relevant criteria.

#### Simple Assessment Module (SAM)

A [simple assessment module (SAM)](sams.html) is a logical measurement aligned to a dimension of quality applied to a model element or characteristic according to a pattern. The input parameters of the module are based on the pattern of the assessment, but the returned result is always a ‘pass’ or ‘fail’ (or 0/1). These modules are intended to be organized into one or many hierarchical collections of SAMs to collectively paint a larger qualitative picture as defined by a given use case.

#### Evaluation Criteria

The [Evaluation Criteria](evaluation.html) component represents a use case oriented hierarchical collection of simple assessments aligned to the patient information model. It is the function of the evaluation criteria to describe the relevance of each assessment to the acceptability of each characteristic, element, and essential patient data submission in its entirety, relative to a given use case.

### Framework Benefits

#### Standardized

A healthcare specific taxonomy or dimension of quality applied to a patient-centric information model can establish a common way of expressing and understanding the scope and nature of quality concerns that currently inhibit interoperability partners’ ability to trust patient information, regardless of whether it is local or received from an external entity.

#### Relevant

Being aligned to patient information specifically, rather than being a generic quality-oriented framework, provides the benefit of highly relevant, fit-for-purpose, prioritizable results.

#### Shareable and Portable

The use of a standardized information model coupled with a standard taxonomy as a basis for the deployment of modular assessments should allow for portable evaluation libraries that should function the same regardless of the source of patient information. The evaluation libraries are portable assets that can be shared across institutions and deployed centrally in a transactional manner.

### PIQI Community of Practice

The **PIQI Framework** is designed to be implemented by a **collaborative user community (a "community of practice")**, a network of stakeholders such as public health agencies, providers, EHR vendors, and analysts who share a common interest in improving patient data quality. Within this community, participants use encapsulated, portable, data-driven components; share knowledge and lessons learned; and evolve practices together. This collaborative approach creates strong potential for rapid refinement, broader adoption, and sustained improvement of the framework.
#### Localized PIQI Models
The PIQI Framework is designed to use simple models. Those models can be localized through the addition of data classes and attributes important to use cases.
#### Shared Simple Assessment Modules
Many foundational, attribute level SAMs are algorithmic, but SAMs that apply to codeable concepts, elements, data classes, and patient level data often require more structured content. This may take the form of value sets, tuples (ordered sets of related values treated as a single unit, such as patient identifier, date, and result value), or other data patterns. To share and utilize rubrics that use SAMs that depend on such structures, PIQI evaluation engines must also have access to the supporting content. For example, to utilize a rubric including a SAM configured to verify that a codeable concept is an active LOINC term, that PIQI evaluation engine must be able to reference the current LOINC release. Packages of SAMs and their related content can be openly shared or licensed through a community portal. More advanced algorithmic SAMs, potentially powered by generative AI, could also be hosted as RESTful services via wrapper SAM interfaces.
#### Shared Evaluation Rubrics
The PIQI Framework assesses patient data using collections of data quality criteria, referred to as Evaluation Rubrics. While the Evaluation Rubrics in PIQI are designed to be configured to support the needs of the implementer, the ability to establish sanctioned standard Evaluation Rubrics is one of the most beneficial features of the PIQI Framework.  The ability to publish and share evaluation Rubrics, along with its dependent SAMs and PIQI components can minimize duplication of effort and provide a powerful way to create a common basis for understanding data quality across the community.

The community is still establishing how the sanctioned, standard Evaluation Rubrics may be developed and shared, as well as what common practices should be followed in their usage.
