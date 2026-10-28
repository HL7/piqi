
PIQI answers a simple question: how good is this patient data, and if it has problems, what are they? The figure and descriptions below walks through the five steps of data evaluation and cover the key artifacts for creating and executing PIQI evaluation.

<span width="100%">
<img src="piqi_quick.png" alt="PIQI Parts Overview" height="100%" width="100%"/>
</span>


## Step 1: Source Data for Evaluation

Patient data arrives in different formats, such as FHIR, C-CDA or custom formats. It's like getting the same recipe written in different languages. Before PIQI checks anything, it rewrites the data into one common layout (the PIQI Model) form one or multiple difference types. That way, every check works the same no matter where the data came from.

<span width="100%">
<img src="piqi1.png" alt="PIQI Framework High Level Component Diagram Part 1" height="70%" width="70%"/>
</span>

## Step 2: Transformation to Temporary Model 

Think of the model like a filing cabinet. Each data class is a drawer, such as Medications or Lab Results. Each element is one folder in that drawer, such as one specific lab result. Each attribute is a detail written in the folder, such as the test name, the value, or the unit. A drawer can hold many folders, which is why Data Class A appears twice.

<span width="100%">
<img src="piqi2.png" alt="PIQI Framework High Level Component Diagram Part 2" height="70%" width="70%"/>
</span>

## Step 3a: Assessing Data Quality Through Rubrics 

A rubric works just like one a teacher uses to grade a paper. It lists the criteria, which are the specific things to check, and it says which drawer, folder, or detail each one applies to. It can also give more weight to checks that matter more for a particular use, such as public health reporting or billing.

<span width="100%">
<img src="piqi3a.png" alt="PIQI Framework High Level Component Diagram Part 3a" height="70%" width="70%"/>
</span>

## Step 3b: SAM Operation

Each SAM asks one yes-or-no style question, such as "Is this field filled in?" or "Is this a real lab code?" The answer is always pass, fail, or skip (skip means the check didn't apply). SAMs are like reusable building blocks, so the same test can be used by many different criteria and rubrics.

<span width="100%">
<img src="piqi3b.png" alt="PIQI Framework High Level Component Diagram Part 3b" height="70%" width="70%"/>
</span>

## Step 4: Outputs to Improve Data Quality

Score: one overall grade, like 67%, showing how usable the data is for the chosen use.
Root cause: the exact checks that failed, so you know what to fix.
Dimension pattern: the kinds of problems that keep showing up, such as mostly missing data or mostly wrong formats, so you can fix the underlying issue rather than one record at a time.

<span width="100%">
<img src="piqi4.png" alt="PIQI Framework High Level Component Diagram Part 4" height="70%" width="70%"/>
</span>

## Step 5: Categorizing Feedback into Healthcare Data Quality Taxonomy (HDQT)

Every SAM is labeled with a type of data quality problem. Availability asks whether the data is there. Accuracy asks whether it's correct. Conformity asks whether it follows the expected format or code system. Plausibility asks whether it makes sense, so a body temperature of 150°F would fail. Sorting failures this way shows patterns, not just a list of errors.

<span width="100%">
<img src="piqi5.png" alt="PIQI Framework High Level Component Diagram Part 5" height="70%" width="70%"/>
</span>


