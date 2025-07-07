### Industry-specific Requirements

<a name="uscdi"></a>

#### The General Use Case for a Patient Data Quality Scoring Framework
In healthcare, both human providers and the software systems that support them critically depend on the availability of complete, correct, and current information. To provide this information, our industry has spent decades building the foundational infrastructure for interoperability between healthcare applications. Messaging standards, standard terminologies, and implementation guides all form part of this foundation. However, the last barrier to true interoperability is trust—specifically, trust that the data we receive meets the quality standards necessary to support our use cases rather than undermine them.

The PIQI Framework is designed to provide a standardized, community-based approach to evaluating data usability, with the goal of transcending siloed, subjective approaches to data quality assessment. The framework's flexible methodology enables quality measurement across different contexts while providing qualitative guidance tailored to various implementations of interoperable data exchange. By working across the family of HL7 products, the PIQI Framework supports not only the current state of the industry but also its evolution over time. 

#### US Core Data for Interoperability (USCDI) - Gay Dolin + Carmela Couderc

#### Data Quality in Quality Measurement - Ben Hamlin to add more
High data quality is crucial for The Joint Commission's quality measures used in accreditation and certification programs. Accurate and reliable data ensure that healthcare organizations are evaluated fairly and consistently, leading to improved patient outcomes and enhanced operational efficiency. From The Joint Commission's perspective, high-quality data is essential for tying clinical care to quality improvement initiatives. This connection helps identify areas needing improvement, track progress over time, and implement evidence-based practices to enhance patient care. However, several prevalent pain points arise from poor data quality. These include data fragmentation, where information is scattered across multiple systems, making it difficult to obtain a comprehensive view of patient care. Inconsistent data entry practices lead to errors and discrepancies, undermining the reliability of the data. Outdated systems hinder seamless data integration, causing delays and inefficiencies. Additionally, the lack of standardized data formats and the challenge of maintaining data integrity across various platforms pose significant obstacles. By ensuring the accuracy, consistency, and completeness of data used in Joint Commission quality measures, healthcare organizations can support better care for individuals, improved health for populations, and lower healthcare costs.

#### Clinical Care and CDS - NCQA/CDS/IPRO
#### Public Health - CDC?
#### Regulatory - Russ Ott
#### Payers
Data integration and interoperability are top priorities for healthcare payers, but integrating data from diverse sources remains a complex challenge. Health insurance payers face costly data quality issues that impact member management, claims processing, regulatory compliance and operational efficiency.

Payers rely upon data obtained from diverse sources, each often acquired in unique formats (e.g., flat files, CSV, non-standard XML, JSON, EDI standards) using a variety of vocabularies (proprietary and terminology standards) which require significant transformation to aggregate, analyze and exchange these data.

Payers receive data in a variety of healthcare exchange and terminology standards formats including HL7 FHIR, C-CDA’s and Version 2, EDI X12N, ICD, CPT and HCPCS, SNOMED CT, and LOINC. Payers use healthcare data submitted by providers to evaluate requests for prior authorization and to accurately adjudicate healthcare claims. In addition, these data are used to show that quality measures are being addressed as well as to ensure that appropriate Risk Adjustments are applied to their members.

The availability of consistent, accurate, and plausible data are paramount to correct outcomes for all of these use cases.
The primary data quality issues that confront healthcare payers include:
·            **Missing, incomplete data** such as key fields in patient demographics, provider identifiers, and claim details (Availability)
·            **Inaccurate, incorrect data**, including incorrect provider directory information, incorrect claims coding (Accuracy)
·            **Data inconsistency** where clinical data across sources, may be inconsistent such as when diagnosis codes in claims do not match those in the accompanying clinical documentation, or where dates-of-service or procedures that precede a member’s date of birth, or indicate overlapping inpatient stays at different facilities (Plausibility)
·            **Invalid, Incompatible, or Non-Standard Code Systems**, including the use of diagnosis or procedure codes that are no longer valid, when the code system provided is not an agreed upon code system, or when the code is not a member of the provided code system (Conformity)

The PIQI Framework can significantly address the critical need for consistent, high-quality, and interoperable patient information that healthcare care payers obtain from diverse data sources using PIQI standardized data assessments to identify specific issues affecting data integrity, accuracy, conformity, and availability. The PIQI can provide detailed insight into the root causes of specific data quality issues and provides a feedback loop to help data sources adjust their processes to meet quality requirements and improve overall data quality. These improvements are useful to payers, healthcare providers, and most importantly to the people they serve.

#### HIEs - MiHIN
#### Laboratory - Riki Merrick?
#### EHRs - Gary Dickinson + Clinical Architecture
Measuring and understanding objective quality is relevent for EHRs both when they are receiving to sharing patient information. When an EHR receives patient data from another healthcare system during hospital transfers, specialist referrals, or lab result transmissions, PIQI could evaluate the incoming data quality in real-time before incorporation into the patient record, preventing poor-quality data from contaminating the EHR and alerting clinicians to potential reliability issues. Additionally, healthcare organizations could use PIQI to assess their interoperability readiness before participating in health information exchanges or implementing new connections, ensuring their EHR's outgoing data meets quality standards expected by receiving systems, which is particularly relevant for USCDI compliance and information blocking regulations. The framework also enables vendor performance monitoring, allowing organizations to objectively measure the quality of data coming from different EHR modules, third-party applications, or data sources, providing metrics for vendor accountability while identifying which systems consistently provide high-quality versus problematic data. Finally, as data quality becomes increasingly important for regulatory programs like Medicare reporting, public health surveillance, and quality measures, EHRs could use PIQI to ensure outgoing data meets regulatory quality standards before submission. The key advantage of PIQI in these EHR scenarios is that it evaluates data quality "in flight" without storing PHI, making it suitable for real-time assessment during the normal flow of clinical operations rather than requiring separate data quality analysis processes.
#### Provider - Amol Bhalla
#### Social Services - Marty Prahl

### Use Case
