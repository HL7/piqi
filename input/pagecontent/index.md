### Introduction

The ongoing digitization of healthcare has resulted in significant growth in the volume and diversity of patient-centric data, including electronic health records (EHRs), clinical registries, administrative claims, and digital health applications. While these data are foundational to interoperable exchange and secondary use, their utility is frequently constrained by variation in data representation, conformance to standards, and governance across systems.

The Patient Information Quality Improvement (PIQI) Framework (pronounced “picky”) defines a standardized, transportable, and reusable approach for assessing the quality of patient-centric health data. The framework is designed to operate as an ingestion, or “in-line,” data quality assessment capability, in which data quality evaluation is performed during data acquisition, transformation, or exchange. This approach supports near real-time assessment at points of data movement, enabling early detection and remediation of data quality issues and improving downstream reliability and reuse. Data usability is fundamentally subjective and specific to a use case. In the PIQI framework an evaluation rubric uses evaluation criteria to assess usability of the data for the evaluation rubric's use case.Data usability is fundamentally subjective and specific to a use case. In the PIQI framework an evaluation rubric uses evaluation criteria to assess usability of the data for the evaluation rubric's use case.

The PIQI Framework defines a structured taxonomy of data quality dimensions that integrates both structural and contextual perspectives. Conventional data quality frameworks within healthcare interoperability primarily emphasize structural assessment, including validation of data element conformance to defined formats, value sets, and profiles. Common structural dimensions include completeness, conformance, consistency, and syntactic validity. These checks are necessary to ensure alignment with implementation guides and specifications; however, they do not determine whether data are suitable for a specific use case.

In addition to comprehensive structural assessment, PIQI enables contextual data quality assessment aligned to intended use. Data fitness is one component of data quality where determination of data’s appropriateness for use in a specific context is ultimately declared by the person (data consumer) responsible for evaluating whether a dataset is adequate for its intended purpose. Fitness for use assessment evaluates characteristics such as relevance, timeliness, and interpretability within a defined clinical, operational, or analytical context. These dimensions are dependent on the data consumer’s role and use case and are not fully captured by structural validation alone. As such, data that conform to a standard (e.g., FHIR resource profiles) may still be insufficient for decision-making if they lack required context or fitness for use

This approach supports a more comprehensive evaluation of data quality and directly addresses a core requirement for interoperable exchange: confidence in the reliability and trustworthiness of exchanged data. By presenting quality assessment outputs in a manner aligned to user expectations and use-case requirements, PIQI improves the interpretability and actionable value of data quality information.

The PIQI Framework is aligned with HL7 interoperability standards, including Fast Healthcare Interoperability Resources (FHIR), and supports evaluation against defined artifacts such as profiles and implementation guides, as well as nationally recognized data standards such as the United States Core Data for Interoperability (USCDI). This alignment enables consistent application across systems participating in standards-based exchange.

By embedding data quality assessment within ingestion and exchange workflows, PIQI supports scalable implementation across heterogeneous environments without dependency on specific infrastructure. This enables implementers to incorporate data quality evaluation as a core component of interoperability workflows. Through its emphasis on standards alignment, portability, and use-case-driven assessment, PIQI provides a foundation for improving trust in exchanged patient data and supporting high-quality, data-driven healthcare delivery.

### Informative Document Overview and Scope
The HL7 Cross Project Group (CPG) sponsored PIQI project is two-phased. This Informative Document is the first phase, in which, the PIQI Framework, it's components and approach to data quality evaluation are described. As an Informative Document, no HL7 product specific resources are defined herein. The second phase will encompass a cross-paradigm implementation guide (CP IG), which defines how the PIQI Framework and approach can be utilized across formats, namely the HL7 V2, CCDA and FHIR, will be produced in the second phase. Therefore specifics about how PIQI Framework relates to each HL7 product family is out of scope for the Informative Document and will be addressed in the PIQI CP IG.

The main sections of this Informative Document include:

*   [PIQI Background](background.html) - These pages provide background on the PIQI Framework.
*   [Data Quality Use Cases](requirements_and_use_case.html) - This pages describe known use cases and specific requirements for assessing data quality in various industry verticals.
*   [PIQI Framework](piqi_framework.html) - These pages define the structure of the PIQI Framework with examples.
*   [Change Notes](changes.html) - This page documents the changes across the versions of the Terminology Change Set IG.

Achieving higher data quality involves careful review and action throughout different stages of the health data lifecycle. However, the PIQI framework is primarily designed to objectively assess data quality at the point of data exchange—which is when data receivers first encounter the data. When PIQI-based assessments uncover data quality issues, organizations should work to address these problems by consulting comprehensive, end-to-end standards for health record data quality, such as the following:

- [HL7/ISO 21089:2018 - Health Informatics - Trusted End-to-End Information Flows](https://www.iso.org/standard/66936.html)
- [HL7/ISO 10781:2023 Electronic Health Record System Functional Model Release 1 (EHR-S FM)](http://www.hl7.org/implement/standards/product_brief.cfm?product_id=528), Record Infrastructure (RI) Section
- [HL7/ISO 16527:2023 Personal Health Record System Functional Model Release 2 (PHR-S FM)](http://www.hl7.org/implement/standards/product_brief.cfm?product_id=88), Record Infrastructure (RI) Section
- [HL7 FHIR R5 Record Lifecycle Event Implementation Guide (FHIR RLE IG - 2023)](http://hl7.org/fhir/uv/ehrs-rle/Informative1/)
- [HL7/ASTM E2147-18 - Standards Specification for Audit and Disclosure Logs for Use in Health Information Systems](https://confluence.hl7.org/download/attachments/212760223/E2147-18%20copy.pdf?version=1&modificationDate=1736787249656&api=v2)

It's important to note that PIQI is not intended to assess clinical judgement or accuracy of the processes of the data source. Rather, PIQI can ensure that the data being utilized in decision support has been evaluated based on metrics important for the use cases.

### Authors

This Informative Document was made possible by the thoughtful contributions of the following people and organizations:

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

{% lang-fragment cross-version-analysis.xhtml %}

### Dependency Table

{% lang-fragment dependency-table.xhtml %}

### Globals Statements

{% lang-fragment globals-table.xhtml %}

### IP Statements

{% lang-fragment ip-statements.xhtml %}
