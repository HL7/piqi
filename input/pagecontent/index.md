### Introduction

The Patient Information Quality Improvement Framework or PIQI Framework (pronounced ‘picky’) creates a standard approach to evaluating data quality of patient-centric healthcare information. PIQI prioritizes portability and reusability, enabling seamless integration into various systems irrespective of the data source. Healthcare data can be complex, heterogeneous, and dispersed across various systems and platforms. Moreover, the traditional database-centric approach often restricts the flexibility and portability required to accommodate the intricate nuances of patient-centric healthcare information. 

Data fitness is one component of data quality where determination of data’s appropriateness for use in a specific context is ultimately declared by the person (data consumer) responsible for evaluating whether a dataset is adequate for its intended purpose. Evaluators of data fitness frequently do not have the requisite contextual basis to enable a judgement on a particular dataset, rendering the data inutile despite its potential to inform care quality. The data quality knowledge presented to an evaluator must have a high level of face validity to that person—which assumes the information presents a complete and accurate picture of their expectations for the data’s use.

Shifting the focus to standardized patient-centric information quality assessment models, the PIQI Framework aims to support evaluation of data quality at the structural, or data element level. Providing prespecified parameters for a simplified structural analysis increases the certainty and usability of healthcare data, empowering healthcare organizations to make well informed decisions quickly that ultimately provide improved patient care. The PIQI Framework provides the ability to assess data against standard models, such as USCDI v3, generating scorecards, and providing insights from the quality assessment process important to end users trusting the data is of sufficient quality. See the Table of Contents for more information.

### Informative Specification Overview and Scope
The Cross Project Group (CPG) sponsored PIQI project is two-phased. This Informative Specification is the first phase, in which, the PIQI Framework, it's components and approach to data quality evaluation are described. A cross-paradigm implementaiton guide (CP IG), which defines how the PIQI Framework and approach can be utilized across formats, namely the HL7 V2, CCDA and FHIR, will be produced in the second phase. Therefore specifics about how PIQI Framework relates to each HL7 product family is out of scope for this informative specification and will be addressed in the PIQI CP IG.

As an informative specification, no HL7 product specific resources are defined herein. 

The main sections of this informative specificaiton are:

*   [PIQI Background](background.html) - these pages provide background on the PIQI Framework
*   [Data Quality Use Cases](requirements_and_use_case.html) - this pages describe known use cases and specific requirements for assessing data quality in various industry verticals
*   [PIQI Framework](piqi_framework.html) - these pages define the structure of the PIQI Framework with examples.
*   [Change Notes](changes.html) - this page documents the changes across the versions of the Terminology Change Set IG.


### Authors

This Informative Specfification was made possible by the thoughtful contributions of the following people and organizations:

Primary Authors:
*   Charlie Harp, Clinical Architecture, LLC
*   Carol Macumber, Clinical Architecture, LLC
*   Russell Ott, Deloitte Consulting LLP
*   Mark Roberts, Leavitt Partners, LLC

Contributing Authors:
*   Lisa Anderson, The Joint Commission
*   Amol Bhalla, IMO Health
*   Carmela Couderc, US Assistant Secretary for Technology Policy (ASTP)
*   John D'Amore, More Informatics
*   Gay Dolin, Namaste Informatics
*   Benjamin Hamlin, IPRO
*   Gena Jarosch, Michigan Health Information Netork (MiHIN)
*   Jon Lowe, CommonSpirit Health
*   Craig Newman, J Michael Consulting
*   Riki Merrick, Association of Public Health Laboratories (APHL)
*   Serafina Versaggi, Versaggi Health IT Consulting
*   Andrew Sills, Deloitte Consulting LLP

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Dependency Table

{% include dependency-table.xhtml %}

### Globals Statements

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
