## Summary Checklist for Implementers

- [ ]  Models and rubrics are configured and validated before the service accepts requests
- [ ]  Each rubric criterion references a valid, registered SAM mnemonic
- [ ]  Scoring, Informational, Plausibility, and Detection effects are correctly assigned to criteria
- [ ]  Criticality indicators are applied to criteria whose failure is categorically unacceptable
- [ ]  Conditional SAM logic is used where criteria should only evaluate under specific conditions
- [ ]  Scoring and Audit response views are both available and consistently derived from the same evaluation
- [ ]  Scores are reported with raw numerator/denominator counts included
- [ ]  Weighted scores are reported alongside unweighted scores at message and data class levels
- [ ]  Plausibility results are reported separately from scoring results (if supported)
- [ ]  Versioning is maintained across Model → Rubric lineage
- [ ]  Errors are structured and coded, not just free-text
- [ ]  Access to the service is controlled at a level appropriate to the deployment environment
- [ ]  The SAM registry is populated and all SAM mnemonics referenced by loaded rubrics resolve at startup
- [ ]  A capability discovery endpoint is available describing supported models, rubrics, and SAMs
