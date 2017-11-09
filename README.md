# KnowEnG_CWL

This repo contains CWL to run various KnowEnG pipelines.  It is
organized as one directory per pipeline.  Each pipeline directory has
a CWL directory that has all the CWL files needed for the pipeline
(typically one for the overall workflow and one for each tool in the
workflow), as well as YML files with parameters for sample job runs
of the pipeline.

The top level also has a data directory containing the files needed
for the sample runs.

Some of the pipeline directories also have a CGC directory that has
the CWL files from the CGC for that pipeline.  (These CWL files are
typically used on the CGC site, and might not be runnable on the
command line.)

Currently the repo contains directories for the following KnowEnG
pipelines:

  * GenePrioritization
  * GeneSetCharacterization

The sample runs use the cwltool reference CWL runner:

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
