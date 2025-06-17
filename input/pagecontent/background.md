# Introduction

## Background

In today's rapidly evolving healthcare landscape, the need for a healthcare data quality assessment framework that transcends a database-centric approach has become increasingly evident. Healthcare data can be complex, heterogeneous, and dispersed across various systems and institutions. Moreover, the traditional database-centric approach often restricts the flexibility and portability required to accommodate the intricate nuances of patient-centric information models. As healthcare transitions towards patient-centered care, the demand for a more abstract and adaptable data quality assessment framework has intensified. Such a framework would enable healthcare organizations to evaluate data quality in a manner that aligns seamlessly with the evolving needs of patient-oriented information models, fostering greater interoperability, accuracy, and usability of healthcare data. By shifting the focus from rigid database structures to a patient-centric perspective, this framework would ultimately enhance the overall quality of healthcare data, facilitating improved patient care, research, and decision-making in the modern healthcare ecosystem.

## Purpose

The goal of the Patient Information Quality Improvement Framework or PIQI (pronounced ‘picky’) Framework is to create a standard approach that prioritizes portability and reusability, enabling assessments that can be applied universally, irrespective of the data source. By shifting the focus to simplified patient-centric information models, this framework aims to enhance data quality on an individual patient level. This approach will increase the certainty and usability of healthcare data, empowering healthcare organizations to make more informed decisions, conduct research with confidence, and ultimately, provide improved patient care.



# Overview

## Framework Design

The proposed healthcare data quality assessment framework is structured into four distinct functional components, each serving a vital role in ensuring comprehensive and systematic data quality assessment:

### Taxonomy of Dimensions

This foundational component establishes a well-organized taxonomy that categorizes the various dimensions to be measured in healthcare data quality assessment. These dimensions encompass a wide range of attributes, such as accuracy, completeness, consistency, timeliness, and reliability, among others. The taxonomy serves as a structured framework for classifying the aspects of data quality that need to be evaluated. By categorizing these dimensions, it enables a clear understanding of what aspects of data quality are being assessed, providing a standardized and consistent foundation for the assessment process.

### Information Model

This component of the framework focuses on the patient data elements and characteristics that are being assessed. It represents a simplified information model that defines and organizes the patient-centric data elements that are most important to ensuring the accurate representation of a given patient, ensuring alignment with the evolving needs of healthcare information models. This information model serves as the core data structure against which data quality assessments are performed. It includes the data elements related to patient demographics, medical history, treatment records, and any other pertinent healthcare information. The model facilitates the mapping of these elements to the taxonomy of dimensions, ensuring that each data element is assessed against relevant criteria.

### Simple Assessment Module (SAM)

A simple assessment module (SAM) is a logical measurement aligned to a qualitative dimension applied to a model element or characteristic according to a pattern. The input parameters of the module are based on the pattern of the assessment, but the returned result is always a ‘pass’ or ‘fail’ (or 0/1). These modules are intended to be organized into one or many hierarchical collections to collectively paint a larger qualitative picture as defined by a given use case.

### Evaluation Criteria

The Evaluation Criteria component represents a use case oriented hierarchical collection of simple assessments aligned to the patient information model. It is the function of the evaluation criteria to describe the relevance of each assessment to the acceptability of each characteristic, element and essential patient data submission in its entirety, relative to a given use case..

In summary, this design approach for patient data quality assessment separates the framework into distinct but interrelated components: the taxonomy for categorizing dimensions, the patient-centric information model for organizing data elements, simple assessment modules to measure quality and the evaluation criteria to organize and interpret the measures relative to an overarching use case. Together, these components provide a structured and adaptable approach to assess and enhance the quality of patient-oriented healthcare data, ultimately increasing the certainty and usability of this critical information.

## Framework Benefits

### Standardized

A healthcare specific taxonomy or qualitative dimensions applied to a patient-centric information model can establish a common way of expressing and understanding the scope and nature of quality concerns that currently inhibit the trusting patient information, regardless of whether it is local or external.

### Relevant

Being aligned to patient information specifically, rather than being a generic quality-oriented framework, provides the benefit of highly relevant, prioritizable results.

### Shareable and Portable

The use of a standard information model coupled with a standard taxonomy as a basis for the deployment of modular assessments should allow for portable evaluation libraries that should function the same regardless of the source of patient information. This means that these evaluation libraries are portable assets that can be shared across institutions and deployed centrally in a transactional manner.

## Additional Information

TBD

## Boundaries and Applicability of Framework

TBD

# PIQI Community

The PIQI Framework is designed to be implemented within a community of practice.  With encapsulated, portable, content driven components, the ability to share knowledge and evolve establishes great potential for rapid evolution and adoption. 
## PIQI Model Extensions
PIQI Framework starts with a simple model intended to support the assessment of core clinical patient data.  The simplicity of this model allows for extension through the addition of attributes and data classes.  Ideally these extensions would be adopted into the core PIQI model through a standard process.
## Shared Simple Assessment Modules
While many of the foundational, attribute level SAMs are algorithmic, SAMs that apply to codable concepts, elements, data classes and patient level data often require structured content in the form of value sets, tuples and other data patterns.  These data packages can be openly shared or licensed in a community portal.  More sophisticated algorithmic SAMs, perhaps based on generative AI, could also be hosted as RESTful services through wrapper SAM interfaces. 
## Shared Evaluation Profiles
While the Evaluation Profiles in PIQI are designed to be configured to support the needs of the implementer, the ability to establish sanctioned standard evaluation profiles is one of the most beneficial features of the PIQI Framework.  The ability to publish and share an evaluation profile, along with its dependent SAMs and PIQI Model components can minimize duplication of effort and provide a powerful way to create a common basis for understanding data quality across the community.
