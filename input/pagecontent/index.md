<div style="width: 100%;" >
<h3 id="plain-language-summary-about-this-guide">Plain Language Summary about this Guide
  </h3>
  <button class="btn btn-info btn-lg collapsed" type="button" title="Click to Open or Close the Plain Language Summary" data-toggle="collapse" data-target="#plain-lang-summary" aria-expanded="false" aria-controls="collapseExample">
    Welcome! Thank you for wanting to learn about this guide.  Click Here to see the Plain Language Summary
  </button>
</div>
<div class="collapse" id="plain-lang-summary" aria-expanded="false" style="height: 0px;">
  <div class="card card-body" style="border:1px solid;border-color:#cccccc;padding:10px">

<a name="about-this-guide"> </a>
  <h3>About this Guide</h3>
<p>
The HL7 Informative Document: Patient Information Quality Improvement (PIQI) Framework, Edition 1 explains the components of the PIQI framework, and how to use it to define data quality criteria for health data messages. This guide is primarily designed for healthcare IT professionals, developers, or informaticists who are interested in pursuing consistent data quality rulesets across various representations of health data.
</p>
<p>
Organizations that adopt this framework will be able to computably define data quality expectations that can be applied to various health data exchanges, such as HL7 v2 messages, CDA documents or FHIR transactions.
</p>
<p>
As more data is exchanged, and in more formats, it becomes increasingly difficult to address data quality in representation-specific rules as we historically have done. This framework is intended to help the health data community pursue a more wholistic approach, assessing data quality in health data exchange messages using the same rules, even if the data representations vary.
</p>

  </div>
</div>

### Introduction

The Patient Information Quality Improvement Framework or PIQI Framework (pronounced ‘picky’) creates a standard approach for patient-centric health care information that prioritizes portability and reusability, enabling seamless integration into various systems irrespective of the data source. Health care data can be complex, heterogeneous, and dispersed across various systems and platforms. Moreover, the traditional database-centric approach often restricts the flexibility and portability required to accommodate the intricate nuances of patient-centric healthcare information. 

Data fitness is a specific construct of data quality where determination of data’s appropriateness for use in a specific context is ultimately declared by the person (data consumer) responsible for evaluating whether a dataset is adequate for its intended purpose. Evaluators of data fitness frequently do not have the requisite contextual basis to enable a judgement on a particular dataset, rendering the data inutile despite its potential to inform care quality. The data quality knowledge presented to an evaluator must have a high level of face validity to that person—which assumes the information presents a complete and accurate picture of their expectations for the data’s use.

Shifting the focus to standardized patient-centric information quality assessment models, the PIQI framework aims to enhance data quality at the structural, or data element level. Providing prespecified parameters for a simplified structural analysis increases the certainty and usability of healthcare data, empowering health care organizations to make well informed decisions quickly that ultimately provide improved patient care. The PIQI Framework provides the ability to assess data against standard models, such as USCDI v3, generating scorecards, and providing insights from the quality assessment process important to end users trusting the data is of sufficient quality. See the Table of Contents for more information.

### Informative Specification Overview
As an informative specification, no HL7 product specific resources are defined herein. 

The main sections of this informative specificaiton are:


*   [Background](background.html) - these pages provide background on the PIQI Framework
*   [Framework](piqi_framework.html) - these pages define the structure of the PIQI Framework with examples.
*   [Requirements and Use Case](requirements_and_use_case.html) - this pages describe known use cases and specific requirements for assessing data quality in various industry verticals
*   [Downloads](downloads.html) - this page provides links to downloadable artifacts.
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
*   Carmela Couderc, US Assistant Secretary for Technology Policy (ASTP_)
*   Gay Dolin, Namaste Informatics
*   Benjamin Hamlin, IPRO
*   Serafina Versaggi, Versaggi Health IT Consulting

### Acknowledgements

Thanks

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Dependency Table

{% include dependency-table.xhtml %}

### Globals Statements

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
