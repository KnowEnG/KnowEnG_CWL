# KnowEnG_CWL

This repo contains CWL to run various KnowEnG pipelines.  It is
organized as one directory per pipeline.

Each pipeline directory has a `CWL` directory that has all the CWL
files needed for the pipeline (typically one for the overall workflow
and one for each tool in the workflow), as well as YML files with the
parameters for sample job runs of the pipeline.  These CWL files are
meant to be run with the
[CWL reference implementation runner, cwltool](https://github.com/common-workflow-language/cwltool).

The top level also has a `data` directory containing the files needed
for the sample runs.

Some of the pipeline directories also have a `CGC` directory that has
the CWL files from the Cancer Genomics Cloud (CGC) for that pipeline.
These CWL files are typically used on
[the CGC site](https://cgc.sbgenomics.com/),
but should be runnable on the command line using
[Rabix](https://github.com/rabix/bunny/).
(As of this writing the current version of `rabix` is 1.0.3, which
seems to have some bugs/issues that prevent it from running these CWL
files.)

Currently the repo contains directories for the following KnowEnG
pipelines:

  * GenePrioritization
  * GeneSetCharacterization

The sample runs use the `cwltool` reference CWL runner:

```
$ cwltool --version
/usr/bin/cwltool 1.0
```

The sample runs for GenePrioritization can be run as follows:

```
$ cd GenePrioritization/CWL
$ cwltool gp_workflow.cwl gp_workflow_job.yml 
$ cwltool gp_workflow.cwl gp_workflow_job.nonet.yml 
```

The sample runs for GeneSetCharacterization can be run as follows:

```
$ cd GeneSetCharacterization/CWL
$ cwltool gsc_workflow.cwl gsc_workflow_job.yml 
```

The following directories correspond to the like-named projects on the
CGC and contain CWL files for the apps in the project:

```
KnowEnG_GenePrioritization_Demo
KnowEnG_GenePrioritization_Dev
KnowEnG_GenePrioritization_Public
KnowEnG_GeneSetCharacterization_Demo
KnowEnG_GeneSetCharacterization_Dev
KnowEnG_GeneSetCharacterization_Public
KnowEnG_Samples_Clustering_Demo
KnowEnG_Samples_Clustering_Dev
KnowEnG_Samples_Clustering_Public
KnowEnG_Signature_Analysis_Demo
KnowEnG_Signature_Analysis_Dev
KnowEnG_Signature_Analysis_Public
KnowEnG_SpreadsheetBuilder_Demo
KnowEnG_SpreadsheetBuilder_Dev
KnowEnG_SpreadsheetBuilder_Public
Lung_Signatures_Public
```

These CWL files were copied from these projects on the CGC on 01/30/2019.
They were copied using [Rabix Composer](http://rabix.io/), using the
`Copy to Local` functionality available for an app (right-click on the
app name).

