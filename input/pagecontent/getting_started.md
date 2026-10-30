

<p style="font-size:22.4px">
PIQI answers a simple question: <b>How good is this patient data for a given use case, and what problems does it have?</b> 
<br/>
<br/>
The figure and descriptions below walk through the five steps of data evaluation and highlight the key artifacts used by the PIQI Framework.
</p>

<span width="100%">
<img src="piqi_quick.png" alt="PIQI Parts Overview" height="100%" width="100%"/>
</span>


### Step 1: Source Data for Evaluation

Patient data arrives in different formats, such as FHIR, C-CDA, or custom formats. It's like getting the same recipe written in different languages. Before checking the data, PIQI transforms it from one or more source formats into a common layout called a [PIQI Model](./glossary.html#piqi-model). This means every check works the same way, regardless of where the data came from. The model is intended for temporary use, not long-term data storage. Different use cases may use different PIQI Models.

<span width="100%">
<img src="piqi1.png" alt="PIQI Framework High Level Component Diagram Part 1" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> The patient data being evaluated.
  </p>
</blockquote>

### Step 2: Transformation to Temporary Model 

Think of the model like a filing cabinet. Each **[data class](./glossary.html#data-class)** is a drawer, such as medications or lab results. Each **[element](./glossary.html#data-class-element)** is one folder in that drawer, such as a specific lab result. Each **[attribute](./glossary.html#data-attribute)** is a detail written in the folder, such as the test name, value, or unit. A drawer can hold many folders, which is why "Data Class A" appears twice.

<span width="100%">
<img src="piqi2.png" alt="PIQI Framework High Level Component Diagram Part 2" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> The model organizes data into groups, records, and details.
  </p>
</blockquote>

### Step 3: Assess and Evaluate

#### Step 3a: Assessing Data Quality Through Rubrics 

A rubric works like one a teacher uses to grade a paper. It lists the **[criteria](./glossary.html#evaluation-criteria)**, or the specific things to check, and says which drawer, folder, or detail each criterion applies to. It can also give more weight to checks that matter more for a particular use, such as public health reporting or billing. Criteria can also be used to count data rather than score it.

<span width="100%">
<img src="piqi3a.png" alt="PIQI Framework High Level Component Diagram Part 3a" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> A grading sheet that specifies what gets checked and how much each check counts.
  </p>
</blockquote>


#### Step 3b: Simple Assessment Module (SAM) Operation

Each [SAM](./glossary.html#simple-assessment-module-sam) asks one yes-or-no-style question, such as "Is this field filled in?" or "Is this a real lab code?" The answer is always pass, fail, or skip (meaning the check did not apply). SAMs are like reusable building blocks, so the same test can be used by multiple criteria and rubrics. While new SAMs can be created, a [library of common SAMs](./sams.html) are included in this guide.  

<span width="100%">
<img src="piqi3b.png" alt="PIQI Framework High Level Component Diagram Part 3b" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> Small, single-purpose tests that do the actual checking.
  </p>
</blockquote>

### Step 4: Outputs to Improve Data Quality

- **Score:** An overall score, such as 67%, showing how usable the data is for the selected use case.
- **Root cause:** The specific checks that failed, which helps identify what to fix.
- **Dimension pattern:** Recurring types of problems, such as mostly missing data or incorrect formats, that point to an underlying issue to fix rather than individual records.

<span width="100%">
<img src="piqi4.png" alt="PIQI Framework High Level Component Diagram Part 4" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> The final outputs, including a score and details about issues.
  </p>
</blockquote>

### Step 5: Categorizing Feedback into Healthcare Data Quality Taxonomy (HDQT)

Every SAM is labeled with a type of data quality problem based on the **[taxonomy](./piqi_framework.html#piqi-healthcare-data-quality-taxonomy-hdqt)** defined in PIQI. Availability asks whether the data is present. Accuracy asks whether it is correct. Conformity asks whether it follows the expected format or code system. Plausibility asks whether it makes sense; for example, a body temperature of 150°F would fail. Sorting failures this way shows patterns, not just a list of errors.

<span width="100%">
<img src="piqi5.png" alt="PIQI Framework High Level Component Diagram Part 5" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> Categories that describe <i>what kind</i> of problem a failure represents.
  </p>
</blockquote>

### Example: Following One Check 

A lab result comes in with a glucose value of 95 but no unit. The rubric includes a criterion to check lab units, so it runs a SAM that asks, "Does this result have a valid unit?" The answer is fail. The failure is labeled as a Conformity issue under the taxonomy, appears as a root cause, and lowers the overall score.

<span width="100%">
<img src="piqi6.png" alt="PIQI Framework High Level Component Diagram Part 6" height="70%" width="70%"/>
</span>

<blockquote style="background-color: rgb(237, 250, 250); border: 2px solid navy; border-radius: 8px; padding: 5px;">
  <p>
    <b>What is it?</b> Following a check through a rubric to a categorized issue.
  </p>
</blockquote>

### Where Next?

This brief introduction shows the key processes and components of the PIQI Framework, but this guide includes much more detail. Here are some places to explore next:

- **Ready for a deeper dive?** Visit [PIQI Background](./background.html) and [PIQI Framework](./piqi_framework.html) to learn more about the PIQI approach.
- **What's already available?** Visit the [PIQI Clinical Model/Rubric](./clinical_model_rubric.html) and [PIQI Claims Model/Rubric](./claims_model_rubric.html) to see how existing models and rubrics can be applied to your use case.
- **Need to build a PIQI implementation?** See the [implementation guidance](./guidance.html), [operation conformance](./conformance-operation.html), [endpoint conformance](./conformance-endpoint.html), and [implementer checklist](checklist.html) for the PIQI Framework.
- **Ready to design PIQI artifacts?** Visit the [PIQI Model](./piqi_model.html) and [PIQI Rubric](./evaluation.html) pages to view the artifact schemas. If you design artifacts for sharing, you can bring them to the [PIQI Alliance](/alliance.html).
- **Need to understand PIQI output?** Visit [FHIR Artifacts](./fhir_artifacts.html) to learn how scoring data and audit logs can be shared.
