hints: []
inputs:
  - label: Species Taxon ID
    'sbg:x': 63
    description: >-
      The species taxon ID (e.g., 9606 for human).See
      https://knoweng.org/kn-data-references/ for possible values (KN Contents
      by Species).
    'sbg:y': 237
    'sbg:includeInPorts': true
    id: '#taxonid'
    type:
      - 'null'
      - string
  - label: Samples File
    'sbg:x': 55
    description: The samples file
    'sbg:y': 50
    'sbg:includeInPorts': true
    id: '#samples_file'
    type:
      - File
  - label: Dont Map Samples Flag
    'sbg:x': 149
    description: 'If set, the names will not be mapped'
    'sbg:y': 133
    'sbg:includeInPorts': true
    id: '#dont_map_samples'
    type:
      - 'null'
      - boolean
  - label: Signatures File
    'sbg:x': 66
    description: The signatures file
    'sbg:y': 368
    'sbg:includeInPorts': true
    id: '#signatures_file'
    type:
      - 'null'
      - File
  - label: Dont Map Signatures Flag
    'sbg:x': 158
    description: 'If set, the names will not be mapped'
    'sbg:y': 456
    'sbg:includeInPorts': true
    id: '#dont_map_signatures'
    type:
      - 'null'
      - boolean
  - label: Similarity Measure
    'sbg:x': 75
    description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
    'sbg:y': 558
    'sbg:includeInPorts': true
    id: '#similarity_measure'
    type:
      - 'null'
      - symbols:
          - cosine
          - pearson
          - spearman
        name: similarity_measure
        type: enum
cwlVersion: 'sbg:draft-2'
'sbg:toolkitVersion': v1.0
'sbg:canvas_x': 14
'sbg:revisionNotes': Added "Analysis" category.
'sbg:canvas_zoom': 0.8499999999999999
'sbg:canvas_y': 22
outputs:
  - label: Clean Samples
    'sbg:x': 1187.254997702206
    description: The clean samples file
    'sbg:y': 204.5098338407629
    source:
      - '#Signature_Analysis.clean_samples_file'
    'sbg:includeInPorts': true
    id: '#clean_samples_file'
    required: false
    type:
      - 'null'
      - File
  - label: Clean Signatures
    'sbg:x': 1272.0262235753678
    description: The clean signatures file
    'sbg:y': 309.67317468979786
    source:
      - '#Signature_Analysis.clean_signatures_file'
    'sbg:includeInPorts': true
    id: '#clean_signatures_file'
    required: false
    type:
      - 'null'
      - File
  - label: Similarity Matrix File
    'sbg:x': 1182.5684311810664
    description: The signature similarity results
    'sbg:y': 396.4510210822611
    source:
      - '#Signature_Analysis.similarity_matrix'
    'sbg:includeInPorts': true
    id: '#similarity_matrix'
    required: false
    type:
      - 'null'
      - File
  - label: Similarity Matrix Binary
    'sbg:x': 1278.8509593290441
    description: The signature similarity matrix (binary; one 1 per row/gene/feature)
    'sbg:y': 500.3956155215994
    source:
      - '#Signature_Analysis.similarity_matrix_binary'
    'sbg:includeInPorts': true
    id: '#similarity_matrix_binary'
    required: false
    type:
      - 'null'
      - File
  - label: SA run_params_yml
    'sbg:x': 1275.8431468290444
    description: The configuration parameters specified for the SA run
    'sbg:y': 677.8823673023899
    source:
      - '#Signature_Analysis.run_params_yml'
    'sbg:includeInPorts': true
    id: '#run_params_yml'
    required: false
    type:
      - 'null'
      - File
  - label: README
    'sbg:x': 1186.1437988281252
    description: The README file that describes the output files
    'sbg:y': 578.627498851103
    source:
      - '#Signature_Analysis.readme'
    'sbg:includeInPorts': true
    id: '#readme'
    required: false
    type:
      - 'null'
      - File
  - label: Gene Map File
    'sbg:x': 1185.8823529411768
    description: The gene map file
    'sbg:y': 57.64705882352942
    source:
      - '#Signature_Analysis_Renamer.gene_map_file_out'
    'sbg:includeInPorts': true
    id: '#gene_map_file_out'
    required: false
    type:
      - 'null'
      - File
description: >-
  This [KnowEnG](https://knoweng.org/) workflow matches genomic profiles from a
  user-supplied query spreadsheet to a library of genomic signatures determined
  in previous studies.  The query genomic profiles will come from different
  biological samples under investigation and will often be measurement of gene
  expression.  The library of signatures must be provided by the user and should
  contain similarly derived measurement for specific conditions or treatments. 
  In this Signature Analysis Pipeline, we find the list of common genomic
  features between the query and library and then rank the library signatures in
  order of the selected Similarity Measure for each query.


  ### Required inputs


  This workflow has two required file inputs:


  1. Samples File (ID: *samples_file*, type: file), a spreadsheet containing the
  query signatures.  Rows are gene labels, columns are sample labels, and
  entries can be genomic measurements such as gene expression levels (e.g.,
  z-scores).


  2. Signatures File (ID: *signatures_file*, type: file), a spreadsheet
  containing the library signatures.  Rows are gene labels, columns are
  signature labels, and entries are genomic measurements analogous to the ones
  in the samples file.


  There is one required input parameters.


  1. Similarity Measure (ID: *similarity_measure*, type: enum ["cosine",
  "pearson", "spearman"]).  The similarity measure to use in the signature
  analysis.



  ### Optional inputs


  There are three optional input parameters.


  1. Species Taxon ID (ID: *taxonid*; type: string, default: "9606").  The ID of
  the species to be used in the analysis, e.g., "9606" for human.  Possible
  values are listed in parentheses in the first column of the [KnowEnG Supported
  Species](https://knoweng.org/kn-data-references/#kn_contents_by_species) table
  ("KN Contents by Species").  This value is only needed if gene name mapping is
  going to be done on either the samples or signatures files.


  2. Dont Map Samples Flag (ID: *dont_map_samples*, type: boolean, default:
  False).  If set, do not perform gene mapping on the samples file.  (The
  default is False, i.e., mapping will be done.)


  3. Dont Map Signatures Flag (ID: *dont_map_signatures*, type: boolean,
  default: False).  If set, do not perform gene mapping on the signatures file. 
  (The default is False, i.e., mapping will be done.)



  ### Outputs


  This workflow generates up to seven output files.  These are outlined below. 
  The structure and order specified here may not match what's listed on the
  completed task page.  The README output file goes into more detail on the
  purpose and the contents of the various output files.  That file can also be
  found
  [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-SA.md).


  #### Results


  * Similarity Matrix File (file name: `similarity_matrix.tsv`).


  * Similarity Matrix Binary File (file name: `similarity_matrix.binary.tsv`). 
  This file is similar to the Similarity Matrix File, with each row (sample)
  containing a 1 in the column for the signature with the highest similarity
  score, 0's in all the other columns.


  * README (file name: `README-SA.md`).  This file describes the various output
  files.


  #### Mapping


  * Clean Samples File (file name: `clean_samples_matrix.tsv`).


  * Clean Signatures File (file name: `clean_signatures_matrix.tsv`).


  * Gene Mapping File (file name: `gene_map.txt`).  (This file will only be
  produced if mapping was done on at least one of the input files.)


  #### Metadata and run info


  * Signature Analysis Run Params yml (file name: `run_params.yml`).



  ### Additional Resources


  [Quickstart
  Guide](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf)
  for this workflow


  [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
  knowledge-guided analysis


  [YouTube Tutorial](https://youtu.be/Vp76-Oz-Yuc) for this workflow in KnowEnG
  Platform


  [Additional Pipelines](https://knoweng.org/pipelines/) supported by KnowEnG



  ### Acknowledgements


  The KnowEnG BD2K center is supported by grant U54GM114838 awarded by NIGMS
  through funds provided by the trans-NIH Big Data to Knowledge (BD2K)
  initiative.


  Questions or comments can be sent to knoweng-support@illinois.edu.



  ### References


  Liu, Rui, et al. "The prognostic role of a gene signature from tumorigenic
  breast-cancer cells." New England Journal of Medicine 356.3 (2007): 217-226.



  ### Demo Data


  Demo samples and signatures files are provided for this workflow.  Below is a
  description of these files and how they were obtained.  These files can also
  be found
  [here](https://github.com/KnowEnG/quickstart-demos/blob/master/demo_files/).


  #### Demo samples file: name: `demo_SA.samples.txt`


  This file is a set of sample expression values from the TCGA GRCh38 data set. 
  It was created from data in the CGC, using the following steps:


  1. In the CGC Data Browser, select a set of files using a query like the
  following:

  ```

  Dataset: TCGA GRCh38
    Entity: File
      Properties:
        Data category: Transcriptome Profiling
        Data format: TXT
    Entity: Investigation
      Properties:
        Disease type: Lung Squamous Cell Carcinoma
  ```


  This yields 1,653 files, with names of the form `*.htseq.counts.tz`,
  `*.FPKM-UQ.txt`, and `*.FPKM.txt`.  Copy these files to a project.  (Things
  will be easier if you tag the files when you copy them.)


  2. Looking at these files in the project, remove those that match the first
  two of these patterns, leaving only those of the form `*.FPKM.txt` (551
  files).


  3. Run the [Spreadsheet
  Builder](https://cgc.sbgenomics.com/u/mepstein/geneprioritization/apps/#mepstein/geneprioritization/spreadsheet-builder/25)
  (SB) with these files as the input files.  (Leave all of the parameters blank,
  i.e., use the default settings.  In particular this means that a z-score
  normalization will have been done on the output that is generated.)


  The *Genomic Spreadsheet File* output file of this run is basically this demo
  samples file, but a couple of additional steps were necessary to reduce the
  file size to allow it to be stored on github:


  1. Round the values, using a line of code (using the python pandas library)
  like the following: `df.to_csv(output_file , sep="\t", float_format="%g")`.


  2. Compress the file using `bzip2`.


  #### Demo signatures file: name: `demo_SA.signatures.txt`


  This file was taken from this publication (original name
  `predictor.centroids.csv`):


  Wilkerson, M.D. et al. (2010) Lung squamous cell carcinoma mRNA expression
  subtypes are reproducible, clinically important and correspond to normal cell
  types.


  Available at
  [http://cancer.unc.edu/nhayes/publications/scc/](http://cancer.unc.edu/nhayes/publications/scc/).


  (For convenience, the [github
  repo](https://github.com/KnowEnG/quickstart-demos/blob/master/demo_files/)
  containing these files includes a version named
  `demo_SA.signatures.mapped.txt`, in which the gene names have already been
  mapped.)
'sbg:projectName': KnowEnG_Signature_Analysis_Dev
label: Signature Analysis Workflow
class: Workflow
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/signature-analysis-workflow/24.png
requirements: []
'sbg:categories':
  - Analysis
steps:
  - inputs:
      - source:
          - '#taxonid'
        id: '#Data_Cleaning_Preprocessing.taxonid'
      - id: '#Data_Cleaning_Preprocessing.source_hint'
        default: ''''''
      - id: '#Data_Cleaning_Preprocessing.redis_port'
        default: 6379
      - id: '#Data_Cleaning_Preprocessing.redis_pass'
        default: KnowEnG
      - id: '#Data_Cleaning_Preprocessing.redis_host'
        default: knowredis.knoweng.org
      - id: '#Data_Cleaning_Preprocessing.pipeline_type'
        default: signature_analysis_pipeline
      - source:
          - '#Mapper_Workflow_1.output_file'
        id: '#Data_Cleaning_Preprocessing.phenotypic_spreadsheet_file'
      - source:
          - '#Mapper_Workflow.output_file'
        id: '#Data_Cleaning_Preprocessing.genomic_spreadsheet_file'
      - id: '#Data_Cleaning_Preprocessing.geneset_characterization_impute'
      - id: '#Data_Cleaning_Preprocessing.gene_prioritization_corr_measure'
    outputs:
      - id: '#Data_Cleaning_Preprocessing.gene_unmap_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_exceptions_file'
      - id: '#Data_Cleaning_Preprocessing.cmd_log_file'
      - id: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
      - id: '#Data_Cleaning_Preprocessing.cleaning_log_file'
      - id: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Data_Cleaning_Preprocessing.clean_genomic_file'
    'sbg:x': 741
    run:
      hints:
        - class: DockerRequirement
          dockerPull: 'knowengdev/data_cleanup_pipeline:04_11_2018'
        - outdirMin: 512000
          class: ResourceRequirement
          coresMin: 1
          ramMin: 5000
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
      inputs:
        - type:
            - 'null'
            - string
          label: Species Taxon ID
          description: 'The species taxon ID (e.g., 9606 for human)'
          'sbg:toolDefaultValue': '9606'
          required: false
          'sbg:includeInPorts': true
          id: '#taxonid'
          doc: taxon id of species related to genomic spreadsheet
          default: '9606'
        - 'sbg:toolDefaultValue': ''''''
          label: ID Source Hint
          description: The source hint for the redis queries (can be '')
          type:
            - 'null'
            - string
          id: '#source_hint'
          doc: >-
            suggestion for ID source database used to resolve ambiguities in
            mapping
          default: \'\'
        - 'sbg:toolDefaultValue': 6379
          label: RedisDB Port
          description: The redis DB port
          type:
            - 'null'
            - int
          id: '#redis_port'
          doc: port for Redis db
          default: 6379
        - 'sbg:toolDefaultValue': KnowEnG
          label: RedisDB Password
          description: The redis DB password
          type:
            - 'null'
            - string
          id: '#redis_pass'
          doc: password for Redis db
          default: KnowEnG
        - 'sbg:toolDefaultValue': knowredis.knoweng.org
          label: RedisDB Host
          description: The redis DB host name
          type:
            - 'null'
            - string
          id: '#redis_host'
          doc: url of Redis db
          default: knowredis.knoweng.org
        - label: Name of Pipeline
          description: >-
            The name of the pipeline that will be run (i.e., data cleaning is
            pipeline-specific)
          id: '#pipeline_type'
          doc: >-
            keywork name of pipeline from following list
            ['gene_prioritization_pipeline', 'samples_clustering_pipeline',
            'geneset_characterization_pipeline']
          type:
            - string
        - 'sbg:toolDefaultValue':
            class: File
            location: /bin/sh
          label: Phenotypic Spreadsheet File (optional)
          doc: 'the phenotypic spreadsheet input for the pipeline [may be optional]'
          description: The phenotypic spreadsheet file (optional)
          type:
            - 'null'
            - File
          id: '#phenotypic_spreadsheet_file'
          required: false
          default:
            class: File
            location: /bin/sh
        - label: Genomic Spreadsheet File
          description: The genomic spreadsheet file
          doc: the genomic spreadsheet input for the pipeline
          id: '#genomic_spreadsheet_file'
          required: true
          type:
            - File
        - label: GSC Imputation Strategy
          id: '#geneset_characterization_impute'
          description: >-
            How to handle missing values in the input data (e.g., remove rows,
            fill in with row average, reject)
          type:
            - 'null'
            - symbols:
                - remove
                - average
                - reject
              name: geneset_characterization_impute
              type: enum
        - label: GP Correlation Measure
          description: 'The correlation measure to be used for GP (e.g., t_test or pearson)'
          type:
            - 'null'
            - symbols:
                - pearson
                - t_test
              name: gene_prioritization_corr_measure
              type: enum
          'sbg:stageInput': null
          id: '#gene_prioritization_corr_measure'
          doc: >-
            if pipeline_type=='gene_prioritization_pipeline', then must be one
            of either ['t_test', 'pearson']
          default: missing
      'sbg:modifiedOn': 1524112841
      'sbg:contributors':
        - mepstein
      cwlVersion: 'sbg:draft-2'
      x: 741
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: InlineJavascriptRequirement
        - class: ShellCommandRequirement
        - class: CreateFileRequirement
          fileDef:
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >
                  str = ""


                  str += "pipeline_type: " + $job.inputs.pipeline_type + "\n";

                  str += "spreadsheet_name_full_path: " +
                  $job.inputs.genomic_spreadsheet_file.path + "\n";

                  str += "taxonid: " + $job.inputs.taxonid + "\n";

                  str += "redis_credential:\n";

                  str += "  host: " + $job.inputs.redis_host + "\n";

                  str += "  password: " + $job.inputs.redis_pass + "\n";

                  str += "  port: " + $job.inputs.redis_port + "\n";

                  str += "source_hint: " + $job.inputs.source_hint + "\n";

                  str += "results_directory: ./\n";


                  if ($job.inputs.phenotypic_spreadsheet_file &&
                  $job.inputs.phenotypic_spreadsheet_file.name != "sh") {
                      //str += "phenotype_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
                      if ($job.inputs.pipeline_type == "signature_analysis_pipeline") {
                          str += "signature_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
                      }
                      else {
                          str += "phenotype_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
                      }
                  }


                  if ($job.inputs.pipeline_type ==
                  "gene_prioritization_pipeline") {
                      str += "correlation_measure: " + $job.inputs.gene_prioritization_corr_measure + "\n";
                  }

                  else if ($job.inputs.pipeline_type ==
                  "geneset_characterization_pipeline") {
                      str += "impute: " + $job.inputs.geneset_characterization_impute + "\n";
                  }


                  //str2 = "echo \"" + str + "\" > run_cleanup.yml"

                  //str2 = "echo \"" + str + "\" > run_cleanup.yml && touch
                  log_X_pipeline.yml && touch GX_ETL.tsv && touch PX_ETL.tsv &&
                  touch X_MAP.tsv && touch X_UNMAPPED.tsv"

                  str2 = "echo \"" + str + "\" > run_cleanup.yml && date &&
                  python3 /home/src/data_cleanup.py -run_directory ./ -run_file
                  run_cleanup.yml && date"


                  str2;
              filename: run_dc.cmd
      arguments: []
      'sbg:validationErrors': []
      'sbg:cmdPreview': sh run_dc.cmd
      'sbg:createdBy': mepstein
      label: Data Cleaning/Preprocessing
      stdout: ''
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-signature-analysis-dev/data-cleaning-copy/2
      'sbg:latestRevision': 2
      baseCommand:
        - sh
        - run_dc.cmd
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:job':
        inputs:
          geneset_characterization_impute: remove
          gene_prioritization_corr_measure: pearson
          genomic_spreadsheet_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/file.tsv
          pipeline_type: geneset_characterization_pipeline
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        Clean/preprocess input data (genomic and optionally phenotypic) for use
        with other tools/pipelines.
      outputs:
        - label: Gene Unmapped File
          description: The genes that were not mapped
          outputBinding:
            glob: '*_UNMAPPED.tsv'
          id: '#gene_unmap_file'
          doc: two columns for original gene ids and unmapped reason code
          type:
            - 'null'
            - File
        - label: Gene Map File
          description: The gene map file
          outputBinding:
            glob: '*_MAP.tsv'
          id: '#gene_map_file'
          doc: two columns for internal gene ids and original gene ids
          type:
            - 'null'
            - File
        - label: Gene Map Exceptions File
          description: The gene map exceptions file
          id: '#gene_map_exceptions_file'
          outputBinding:
            glob: '*_User_To_Ensembl.tsv'
          type:
            - 'null'
            - File
        - label: Command Log File
          description: The log of the data cleaning command
          id: '#cmd_log_file'
          outputBinding:
            glob: run_dc.cmd
          type:
            - 'null'
            - File
        - label: Cleaning Parameters File
          description: The configuration parameters specified for the data cleaning run
          outputBinding:
            glob: run_cleanup.yml
          id: '#cleaning_parameters_yml'
          doc: data cleaning parameters in yaml format
          type:
            - 'null'
            - File
        - label: Cleaning Log File
          description: The log of the data cleaning run
          outputBinding:
            glob: log_*_pipeline.yml
          id: '#cleaning_log_file'
          doc: information on souce of errors for cleaning pipeline
          type:
            - 'null'
            - File
        - label: Clean Phenotypic Spreadsheet
          description: The clean phenotypic spreadsheet
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                function basename(path) {
                    var basename;

                    var ix = path.lastIndexOf('.');
                    if (ix == -1) {
                        basename = path;
                    }
                    else {
                        basename = path.substr(0, ix);
                    }

                    ix = basename.lastIndexOf('/')
                    if (ix != -1) {
                        basename = basename.substr(ix + 1);
                    }

                    return basename;
                }

                if ($job.inputs.phenotypic_spreadsheet_file) {
                    basename($job.inputs.phenotypic_spreadsheet_file.name) + "_ETL.tsv";
                }
                else {
                    "NONE_ETL.tsv";
                }
          id: '#clean_phenotypic_file'
          doc: phenotype file prepared for pipeline
          type:
            - 'null'
            - File
        - label: Clean Genomic Spreadsheet
          description: The clean genomic spreadsheet
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: >
                function basename(path) {
                    var basename;

                    var ix = path.lastIndexOf('.');
                    if (ix == -1) {
                        basename = path;
                    }
                    else {
                        basename = path.substr(0, ix);
                    }

                    ix = basename.lastIndexOf('/')
                    if (ix != -1) {
                        basename = basename.substr(ix + 1);
                    }

                    return basename;
                }


                basename($job.inputs.genomic_spreadsheet_file.name) +
                "_ETL.tsv";
          id: '#clean_genomic_file'
          doc: matrix with gene names mapped and data cleaned
          type:
            - 'null'
            - File
      'sbg:modifiedBy': mepstein
      'sbg:revision': 2
      'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/21
      'sbg:sbgMaintained': false
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      class: CommandLineTool
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'y': 224
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
      id: mepstein/knoweng-signature-analysis-dev/data-cleaning-copy/2
      'sbg:image_url': null
      successCodes: []
      'sbg:createdOn': 1522093713
      'sbg:publisher': sbg
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/19
          'sbg:modifiedOn': 1522093713
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/20
          'sbg:modifiedOn': 1522098998
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
          'sbg:modifiedOn': 1524112841
          'sbg:revision': 2
      doc: checks the inputs of a pipeline for potential sources of errors
    'sbg:y': 224
    id: '#Data_Cleaning_Preprocessing'
  - inputs:
      - source:
          - '#taxonid'
        id: '#Mapper_Workflow.taxon'
      - id: '#Mapper_Workflow.source_hint'
      - id: '#Mapper_Workflow.output_filename'
        default: samples_mapped.tsv
      - source:
          - '#samples_file'
        id: '#Mapper_Workflow.input_file'
      - source:
          - '#dont_map_samples'
        id: '#Mapper_Workflow.dont_do_mapping'
    outputs:
      - id: '#Mapper_Workflow.output_file_1'
      - id: '#Mapper_Workflow.output_file'
    'sbg:x': 431
    run:
      hints: []
      inputs:
        - label: taxon
          'sbg:x': 81
          'sbg:y': 326
          'sbg:includeInPorts': true
          id: '#taxon'
          required: false
          type:
            - 'null'
            - string
        - label: source_hint
          'sbg:x': 86
          'sbg:y': 464
          'sbg:includeInPorts': true
          id: '#source_hint'
          required: false
          type:
            - 'null'
            - string
        - label: output_filename
          'sbg:x': 87
          'sbg:y': 596
          'sbg:includeInPorts': true
          id: '#output_filename'
          required: true
          type:
            - string
        - label: input_file
          'sbg:x': 80
          'sbg:y': 62
          id: '#input_file'
          required: true
          type:
            - File
        - label: dont_do_mapping
          'sbg:x': 83
          'sbg:y': 199
          'sbg:includeInPorts': true
          id: '#dont_do_mapping'
          required: false
          type:
            - 'null'
            - boolean
      'sbg:modifiedOn': 1526497729
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:canvas_zoom': 0.95
      x: 431
      'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Mapper Workflow
      'sbg:id': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      cwlVersion: 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      'sbg:sbgMaintained': false
      outputs:
        - label: map_file
          'sbg:x': 1145.2631578947369
          'sbg:y': 170.52628366570724
          source:
            - '#KN_Mapper.output_file'
          'sbg:includeInPorts': true
          id: '#output_file_1'
          type:
            - 'null'
            - File
        - label: output_file
          'sbg:x': 1148.9473684210527
          'sbg:y': 360.105269582648
          source:
            - '#Map_Names.output_file'
          'sbg:includeInPorts': true
          id: '#output_file'
          required: false
          type:
            - 'null'
            - File
      'sbg:modifiedBy': mepstein
      'sbg:revision': 2
      'sbg:latestRevision': 2
      description: ''
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:canvas_x': 0
      class: Workflow
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'y': 75.99999999999999
      'sbg:contributors':
        - mepstein
      $namespaces:
        sbg: 'https://sevenbridges.com'
      requirements: []
      steps:
        - inputs:
            - source:
                - '#taxon'
              id: '#KN_Mapper.taxon'
            - source:
                - '#source_hint'
              id: '#KN_Mapper.source_hint'
            - id: '#KN_Mapper.redis_port'
            - id: '#KN_Mapper.redis_pass'
            - id: '#KN_Mapper.redis_host'
            - id: '#KN_Mapper.output_name'
            - source:
                - '#input_file'
              id: '#KN_Mapper.input_file'
            - source:
                - '#dont_do_mapping'
              id: '#KN_Mapper.dont_do_mapping'
            - id: '#KN_Mapper.dont_cut_first_line'
          outputs:
            - id: '#KN_Mapper.output_file'
          'sbg:x': 495
          run:
            hints:
              - value: 1
                class: 'sbg:CPURequirement'
              - value: 1000
                class: 'sbg:MemRequirement'
              - class: DockerRequirement
                dockerImageId: ''
                dockerPull: 'knoweng/kn_mapper:latest'
            inputs:
              - label: Species Taxon ID
                description: The species taxon id
                inputBinding:
                  prefix: '-t'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:includeInPorts': true
                id: '#taxon'
                required: false
                type:
                  - 'null'
                  - string
              - label: Source Hint
                description: The source hint
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:includeInPorts': true
                id: '#source_hint'
                required: false
                type:
                  - 'null'
                  - string
              - label: Redis Port
                description: The redis port
                inputBinding:
                  prefix: '-p'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#redis_port'
                type:
                  - 'null'
                  - string
              - label: Redis Password
                description: The redis password
                inputBinding:
                  prefix: '-P'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#redis_pass'
                type:
                  - 'null'
                  - string
              - label: Redis Host
                description: The redis host
                inputBinding:
                  prefix: '-h'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#redis_host'
                type:
                  - 'null'
                  - string
              - label: Output Filename
                description: The output file name
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#output_name'
                type:
                  - 'null'
                  - string
              - label: Input File
                description: The input file
                inputBinding:
                  prefix: '-i'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#input_file'
                required: true
                type:
                  - File
              - label: Dont Do Mapping Flag
                inputBinding:
                  prefix: '-n'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  If present, the names won't be mapped, instead a dummy map
                  (with the two columns identical) will be created
                'sbg:includeInPorts': true
                'sbg:stageInput': null
                id: '#dont_do_mapping'
                required: false
                type:
                  - 'null'
                  - boolean
              - label: Dont Cut First Line Flag
                description: >-
                  If the input file is a list of gene names rather than a
                  genomic spreadsheet, you might want to use this (i.e., the
                  first line won't be column headers)
                inputBinding:
                  prefix: '-F'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:stageInput': null
                id: '#dont_cut_first_line'
                type:
                  - 'null'
                  - boolean
            'sbg:modifiedOn': 1524842883
            'sbg:contributors':
              - mepstein
            cwlVersion: 'sbg:draft-2'
            x: 495
            'sbg:revisionNotes': Added dont_do_mapping input/behavior.
            arguments: []
            'sbg:validationErrors': []
            'sbg:createdBy': mepstein
            label: KN Mapper
            description: Map the genes in a spreadsheet/file.
            stdout: ''
            temporaryFailCodes: []
            'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
            baseCommand:
              - sh
              - kn_mapper.sh
            id: mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            'sbg:job':
              inputs:
                redis_port: redis_port-string-value
                output_name: output_name-string-value
                redis_host: redis_host-string-value
                input_file:
                  class: File
                  secondaryFiles: []
                  size: 0
                  path: /path/to/input_file.ext
                taxon: taxon-string-value
                redis_pass: redis_pass-string-value
                source_hint: source_hint-string-value
                dont_cut_first_line: true
                dont_do_mapping: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:sbgMaintained': false
            outputs:
              - label: The Output File
                description: The output file (the gene name map)
                id: '#output_file'
                outputBinding:
                  glob: names.node_map.txt
                type:
                  - 'null'
                  - File
            'sbg:modifiedBy': mepstein
            'sbg:revision': 3
            'sbg:latestRevision': 3
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            class: CommandLineTool
            'sbg:image_url': null
            'y': 171
            'sbg:appVersion':
              - 'sbg:draft-2'
            $namespaces:
              sbg: 'https://sevenbridges.com'
            requirements:
              - class: CreateFileRequirement
                fileDef:
                  - fileContent: |-
                      # Defaults
                      OUTNAME=names.node_map.txt
                      # This is actually how many initial lines to cut
                      #CUTFIRSTLINE=
                      CUTFIRSTLINE=1
                      DONT_DO_MAPPING=
                      HOST=
                      PORT=
                      PASS=
                      SOURCEHINT=
                      TAXON=

                      # Process options
                      #while getopts :fFh:i:o:p:P:s:t: option
                      while getopts :f:Fh:i:no:p:P:s:t: option
                      do
                          case "$option" in
                          f)
                              #CUTFIRSTLINE=1
                              CUTFIRSTLINE=$OPTARG
                              ;;
                          F)
                              CUTFIRSTLINE=
                              ;;
                          h)
                              HOST=$OPTARG
                              ;;
                          i)
                              INFILE=$OPTARG
                              ;;
                          n)
                              DONT_DO_MAPPING=1
                              ;;
                          o)
                              OUTNAME=$OPTARG
                              ;;
                          p)
                              PORT=$OPTARG
                              ;;
                          P)
                              PASS=$OPTARG
                              ;;
                          s)
                              SOURCEHINT=$OPTARG
                              ;;
                          t)
                              TAXON=$OPTARG
                              ;;
                          *)
                              echo "An invalid option was received."
                              #echo "The recognized options are: -h, -i, -o, -p, -P, -s, -t"
                              echo "The recognized options are: -f -h, -i, -o, -p, -P, -s, -t"
                              #echo "The recognized flags are: -f -F -n"
                              echo "The recognized flags are: -F -n"
                              echo "The required options are: -i"
                              echo ""
                              ;;
                              esac
                      done

                      # Check the required options
                      if [ -z "$INFILE" ]
                      then
                          echo "The input file is not specified; use the -i option."
                          exit
                      fi

                      TMPFILE=names.$$.txt

                      if [ -z "$CUTFIRSTLINE" ]
                      then
                          CMD="cat $INFILE | cut -f 1 > $TMPFILE"
                      else
                          CMD="tail -n +$(($CUTFIRSTLINE+1)) $INFILE | cut -f 1 > $TMPFILE"
                      fi
                      echo $CMD
                      eval $CMD

                      if [ -n "$DONT_DO_MAPPING" ]
                      then
                          paste $TMPFILE $TMPFILE > $OUTNAME
                          exit
                      fi

                      OPTS=
                      if [ -n "$HOST" ]
                      then
                          OPTS="$OPTS --redis_host $HOST"
                      fi
                      if [ -n "$PORT" ]
                      then
                          OPTS="$OPTS --redis_port $PORT"
                      fi
                      if [ -n "$PASS" ]
                      then
                          OPTS="$OPTS --redis_pass $PASS"
                      fi
                      if [ -n "$SOURCEHINT" ]
                      then
                          OPTS="$OPTS --source_hint $SOURCEHINT"
                      fi
                      if [ -n "$TAXON" ]
                      then
                          OPTS="$OPTS --taxon $TAXON"
                      fi
                      if [ -n "$OUTNAME" ]
                      then
                          OPTS="$OPTS --outfile $OUTNAME"
                      fi
                      CMD="python3 /home/src/kn_mapper.py $TMPFILE$OPTS"
                      echo $CMD
                      eval $CMD
                    filename: kn_mapper.sh
            successCodes: []
            'sbg:createdOn': 1524681212
            'sbg:publisher': sbg
            stdin: ''
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1524681212
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:modifiedOn': 1524681994
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Fixed typo in tail command in kn_mapper.sh.
                'sbg:modifiedOn': 1524687186
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added dont_do_mapping input/behavior.
                'sbg:modifiedOn': 1524842883
                'sbg:revision': 3
          'sbg:y': 171
          id: '#KN_Mapper'
        - inputs:
            - id: '#Map_Names.switch_mapped_order'
              default: true
            - source:
                - '#output_filename'
              id: '#Map_Names.output_filename'
            - id: '#Map_Names.names_are_columns'
            - source:
                - '#KN_Mapper.output_file'
              id: '#Map_Names.map_file'
            - source:
                - '#input_file'
              id: '#Map_Names.input_file'
            - id: '#Map_Names.drop_unmapped_names'
              default: true
          outputs:
            - id: '#Map_Names.output_file'
          'sbg:x': 782
          run:
            hints:
              - value: 1
                class: 'sbg:CPURequirement'
              - value: 1000
                class: 'sbg:MemRequirement'
              - class: DockerRequirement
                dockerImageId: ''
                dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
            inputs:
              - label: Switch Mapped Order
                description: >-
                  If present, the order in the map file is original name/mapped
                  name
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:stageInput': null
                id: '#switch_mapped_order'
                type:
                  - 'null'
                  - boolean
              - label: Output Filename
                description: Output Filename
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:includeInPorts': true
                id: '#output_filename'
                required: true
                type:
                  - string
              - label: Names are Columns
                description: >-
                  If present, the names to be mapped in the input file are
                  columns, not rows
                inputBinding:
                  prefix: '-c'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:stageInput': null
                id: '#names_are_columns'
                type:
                  - 'null'
                  - boolean
              - label: Map File
                description: >-
                  Map files with orginal/mapped names in first two columns
                  (default is mapped in first, original in second)
                inputBinding:
                  prefix: '-m'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#map_file'
                required: true
                type:
                  - File
              - label: Input File
                description: Input file to be mapped
                inputBinding:
                  prefix: '-i'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#input_file'
                required: true
                type:
                  - File
              - label: Drop Unmapped Names Flag
                description: 'If present, any names that are unmapped will be dropped'
                inputBinding:
                  prefix: '-u'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#drop_unmapped_names'
                type:
                  - 'null'
                  - boolean
            'sbg:modifiedOn': 1524716022
            'sbg:contributors':
              - mepstein
            cwlVersion: 'sbg:draft-2'
            x: 782
            'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
            arguments: []
            'sbg:validationErrors': []
            'sbg:createdBy': mepstein
            label: Map Names
            description: Map the names in the input file based on the map file.
            stdout: ''
            temporaryFailCodes: []
            'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
            'sbg:cmdPreview': >-
              python3 map_names.py -i /path/to/input_file.ext -m
              /path/to/map_file.ext -o output_filename-string-value
            baseCommand:
              - python3
              - map_names.py
            id: mepstein/knoweng-signature-analysis-dev/map-names/5
            'sbg:job':
              inputs:
                input_file:
                  class: File
                  secondaryFiles: []
                  size: 0
                  path: /path/to/input_file.ext
                drop_unmapped_names: true
                map_file:
                  class: File
                  secondaryFiles: []
                  size: 0
                  path: /path/to/map_file.ext
                switch_mapped_order: true
                output_filename: output_filename-string-value
                names_are_columns: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:sbgMaintained': false
            outputs:
              - label: Output File
                description: Output File
                id: '#output_file'
                outputBinding:
                  glob:
                    class: Expression
                    engine: '#cwl-js-engine'
                    script: $job.inputs.output_filename
                type:
                  - 'null'
                  - File
            'sbg:modifiedBy': mepstein
            'sbg:revision': 5
            'sbg:latestRevision': 5
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            class: CommandLineTool
            'sbg:image_url': null
            'y': 361
            'sbg:appVersion':
              - 'sbg:draft-2'
            $namespaces:
              sbg: 'https://sevenbridges.com'
            requirements:
              - class: CreateFileRequirement
                fileDef:
                  - fileContent: |-
                      #!/usr/bin/env python3


                      import argparse
                      import sys
                      import pandas as pd


                      def parse_args():
                          parser = argparse.ArgumentParser()

                          parser.add_argument("-i", "--input_file", required=True)
                          parser.add_argument("-m", "--map_file", required=True)
                          parser.add_argument("-o", "--output_file", required=True)
                          # default for map_file is mapped_name\torig_name
                          # use -s/--switch_mapped_order for orig_name\tmapped_name
                          parser.add_argument("-s", "--switch_mapped_order", action='store_true')
                          # default is names to be mapped are rows
                          # use -c/--names_are_cols if they are columns
                          parser.add_argument("-c", "--names_are_cols", action='store_true')
                          # With respect to the map file being gene names mapping, this
                          # script can typically be used one of two ways:
                          # 1. To map an unmapped file
                          # 2. To unmap a previously mapped file
                          # With regards to names that weren't mapped -- meaning their
                          # mapped names are either "unmapped-none" or "unmapped-many":
                          # 1: You may want to remove any unmapped names -- this option
                          # allows this
                          # 2. If the file has any unmapped names, there's nothing you can
                          # do, because they won't be unique -- so you have to hope there
                          # weren't any
                          parser.add_argument("-u", "--drop_unmapped_names", action='store_true')

                          args = parser.parse_args()

                          return args


                      def read_name_map(args):
                          name_map = {}

                          with open(args.map_file, 'r') as f:
                              for line in f:
                                  fields = line.rstrip().split()
                                  if args.switch_mapped_order:
                                      orig_name = fields[0]
                                      mapped_name = fields[1]
                                  else:
                                      orig_name = fields[1]
                                      mapped_name = fields[0]
                                  name_map[orig_name] = mapped_name

                          return name_map


                      def main():
                          args = parse_args()

                          df = pd.read_table(args.input_file, index_col=0)
                          print(df)
                          name_map = read_name_map(args)
                          print(name_map)
                          if args.names_are_cols:
                              df.rename(columns=name_map, inplace=True)
                              if args.drop_unmapped_names:
                                  #unmapped_cols = [col for col in df.columns if col.startswith("unmapped-")]
                                  df.drop(df.filter(like="unmapped-", axis="columns").columns, axis="columns", inplace=True)
                          else:
                              df.rename(index=name_map, inplace=True)
                              if args.drop_unmapped_names:
                                  #unmapped_rows = [row for row in df.index if row.startswith("unmapped-")]
                                  df.drop(df.filter(like="unmapped-", axis="index").index, axis="index", inplace=True)
                          print(df)
                          df.to_csv(path_or_buf=args.output_file, sep='\t')


                      if __name__ == "__main__":
                          main()
                    filename: map_names.py
              - class: ExpressionEngineRequirement
                id: '#cwl-js-engine'
                requirements:
                  - class: DockerRequirement
                    dockerPull: rabix/js-engine
            successCodes: []
            'sbg:createdOn': 1522285864
            'sbg:publisher': sbg
            stdin: ''
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1522285864
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:modifiedOn': 1522286794
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Modified name.
                'sbg:modifiedOn': 1522286850
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Changed container.
                'sbg:modifiedOn': 1522288616
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified map_names.py to add drop_unmapped_names option; added
                  drop_unmapped_names input.
                'sbg:modifiedOn': 1524714160
                'sbg:revision': 4
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
                'sbg:modifiedOn': 1524716022
                'sbg:revision': 5
          'sbg:y': 361
          id: '#Map_Names'
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/mapper-workflow/2.png
      'sbg:createdOn': 1524843132
      'sbg:canvas_y': 0
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1524843132
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:modifiedOn': 1524843462
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
          'sbg:modifiedOn': 1526497729
          'sbg:revision': 2
    'sbg:y': 75.99999999999999
    id: '#Mapper_Workflow'
  - inputs:
      - source:
          - '#taxonid'
        id: '#Mapper_Workflow_1.taxon'
      - id: '#Mapper_Workflow_1.source_hint'
      - id: '#Mapper_Workflow_1.output_filename'
        default: signatures_mapped.tsv
      - source:
          - '#signatures_file'
        id: '#Mapper_Workflow_1.input_file'
      - source:
          - '#dont_map_signatures'
        id: '#Mapper_Workflow_1.dont_do_mapping'
    outputs:
      - id: '#Mapper_Workflow_1.output_file_1'
      - id: '#Mapper_Workflow_1.output_file'
    'sbg:x': 433.00000000000006
    run:
      hints: []
      inputs:
        - label: taxon
          'sbg:x': 81
          'sbg:y': 326
          'sbg:includeInPorts': true
          id: '#taxon'
          required: false
          type:
            - 'null'
            - string
        - label: source_hint
          'sbg:x': 86
          'sbg:y': 464
          'sbg:includeInPorts': true
          id: '#source_hint'
          required: false
          type:
            - 'null'
            - string
        - label: output_filename
          'sbg:x': 87
          'sbg:y': 596
          'sbg:includeInPorts': true
          id: '#output_filename'
          required: true
          type:
            - string
        - label: input_file
          'sbg:x': 80
          'sbg:y': 62
          id: '#input_file'
          required: true
          type:
            - File
        - label: dont_do_mapping
          'sbg:x': 83
          'sbg:y': 199
          'sbg:includeInPorts': true
          id: '#dont_do_mapping'
          required: false
          type:
            - 'null'
            - boolean
      'sbg:modifiedOn': 1526497729
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:canvas_zoom': 0.95
      x: 433.00000000000006
      'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Mapper Workflow
      'sbg:id': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      cwlVersion: 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      'sbg:sbgMaintained': false
      outputs:
        - label: map_file
          'sbg:x': 1145.2631578947369
          'sbg:y': 170.52628366570724
          source:
            - '#KN_Mapper.output_file'
          'sbg:includeInPorts': true
          id: '#output_file_1'
          type:
            - 'null'
            - File
        - label: output_file
          'sbg:x': 1148.9473684210527
          'sbg:y': 360.105269582648
          source:
            - '#Map_Names.output_file'
          'sbg:includeInPorts': true
          id: '#output_file'
          required: false
          type:
            - 'null'
            - File
      'sbg:modifiedBy': mepstein
      'sbg:revision': 2
      'sbg:latestRevision': 2
      description: ''
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:canvas_x': 0
      class: Workflow
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'y': 353.99999999999994
      'sbg:contributors':
        - mepstein
      $namespaces:
        sbg: 'https://sevenbridges.com'
      requirements: []
      steps:
        - inputs:
            - source:
                - '#taxon'
              id: '#KN_Mapper.taxon'
            - source:
                - '#source_hint'
              id: '#KN_Mapper.source_hint'
            - id: '#KN_Mapper.redis_port'
            - id: '#KN_Mapper.redis_pass'
            - id: '#KN_Mapper.redis_host'
            - id: '#KN_Mapper.output_name'
            - source:
                - '#input_file'
              id: '#KN_Mapper.input_file'
            - source:
                - '#dont_do_mapping'
              id: '#KN_Mapper.dont_do_mapping'
            - id: '#KN_Mapper.dont_cut_first_line'
          outputs:
            - id: '#KN_Mapper.output_file'
          'sbg:x': 495
          run:
            hints:
              - value: 1
                class: 'sbg:CPURequirement'
              - value: 1000
                class: 'sbg:MemRequirement'
              - class: DockerRequirement
                dockerImageId: ''
                dockerPull: 'knoweng/kn_mapper:latest'
            inputs:
              - label: Species Taxon ID
                description: The species taxon id
                inputBinding:
                  prefix: '-t'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:includeInPorts': true
                id: '#taxon'
                required: false
                type:
                  - 'null'
                  - string
              - label: Source Hint
                description: The source hint
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:includeInPorts': true
                id: '#source_hint'
                required: false
                type:
                  - 'null'
                  - string
              - label: Redis Port
                description: The redis port
                inputBinding:
                  prefix: '-p'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#redis_port'
                type:
                  - 'null'
                  - string
              - label: Redis Password
                description: The redis password
                inputBinding:
                  prefix: '-P'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#redis_pass'
                type:
                  - 'null'
                  - string
              - label: Redis Host
                description: The redis host
                inputBinding:
                  prefix: '-h'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#redis_host'
                type:
                  - 'null'
                  - string
              - label: Output Filename
                description: The output file name
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#output_name'
                type:
                  - 'null'
                  - string
              - label: Input File
                description: The input file
                inputBinding:
                  prefix: '-i'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#input_file'
                required: true
                type:
                  - File
              - label: Dont Do Mapping Flag
                inputBinding:
                  prefix: '-n'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  If present, the names won't be mapped, instead a dummy map
                  (with the two columns identical) will be created
                'sbg:includeInPorts': true
                'sbg:stageInput': null
                id: '#dont_do_mapping'
                required: false
                type:
                  - 'null'
                  - boolean
              - label: Dont Cut First Line Flag
                description: >-
                  If the input file is a list of gene names rather than a
                  genomic spreadsheet, you might want to use this (i.e., the
                  first line won't be column headers)
                inputBinding:
                  prefix: '-F'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:stageInput': null
                id: '#dont_cut_first_line'
                type:
                  - 'null'
                  - boolean
            'sbg:modifiedOn': 1524842883
            'sbg:contributors':
              - mepstein
            cwlVersion: 'sbg:draft-2'
            x: 495
            'sbg:revisionNotes': Added dont_do_mapping input/behavior.
            arguments: []
            'sbg:validationErrors': []
            'sbg:createdBy': mepstein
            label: KN Mapper
            description: Map the genes in a spreadsheet/file.
            stdout: ''
            temporaryFailCodes: []
            'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
            baseCommand:
              - sh
              - kn_mapper.sh
            id: mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            'sbg:job':
              inputs:
                redis_port: redis_port-string-value
                output_name: output_name-string-value
                redis_host: redis_host-string-value
                input_file:
                  class: File
                  secondaryFiles: []
                  size: 0
                  path: /path/to/input_file.ext
                taxon: taxon-string-value
                redis_pass: redis_pass-string-value
                source_hint: source_hint-string-value
                dont_cut_first_line: true
                dont_do_mapping: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:sbgMaintained': false
            outputs:
              - label: The Output File
                description: The output file (the gene name map)
                id: '#output_file'
                outputBinding:
                  glob: names.node_map.txt
                type:
                  - 'null'
                  - File
            'sbg:modifiedBy': mepstein
            'sbg:revision': 3
            'sbg:latestRevision': 3
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            class: CommandLineTool
            'sbg:image_url': null
            'y': 171
            'sbg:appVersion':
              - 'sbg:draft-2'
            $namespaces:
              sbg: 'https://sevenbridges.com'
            requirements:
              - class: CreateFileRequirement
                fileDef:
                  - fileContent: |-
                      # Defaults
                      OUTNAME=names.node_map.txt
                      # This is actually how many initial lines to cut
                      #CUTFIRSTLINE=
                      CUTFIRSTLINE=1
                      DONT_DO_MAPPING=
                      HOST=
                      PORT=
                      PASS=
                      SOURCEHINT=
                      TAXON=

                      # Process options
                      #while getopts :fFh:i:o:p:P:s:t: option
                      while getopts :f:Fh:i:no:p:P:s:t: option
                      do
                          case "$option" in
                          f)
                              #CUTFIRSTLINE=1
                              CUTFIRSTLINE=$OPTARG
                              ;;
                          F)
                              CUTFIRSTLINE=
                              ;;
                          h)
                              HOST=$OPTARG
                              ;;
                          i)
                              INFILE=$OPTARG
                              ;;
                          n)
                              DONT_DO_MAPPING=1
                              ;;
                          o)
                              OUTNAME=$OPTARG
                              ;;
                          p)
                              PORT=$OPTARG
                              ;;
                          P)
                              PASS=$OPTARG
                              ;;
                          s)
                              SOURCEHINT=$OPTARG
                              ;;
                          t)
                              TAXON=$OPTARG
                              ;;
                          *)
                              echo "An invalid option was received."
                              #echo "The recognized options are: -h, -i, -o, -p, -P, -s, -t"
                              echo "The recognized options are: -f -h, -i, -o, -p, -P, -s, -t"
                              #echo "The recognized flags are: -f -F -n"
                              echo "The recognized flags are: -F -n"
                              echo "The required options are: -i"
                              echo ""
                              ;;
                              esac
                      done

                      # Check the required options
                      if [ -z "$INFILE" ]
                      then
                          echo "The input file is not specified; use the -i option."
                          exit
                      fi

                      TMPFILE=names.$$.txt

                      if [ -z "$CUTFIRSTLINE" ]
                      then
                          CMD="cat $INFILE | cut -f 1 > $TMPFILE"
                      else
                          CMD="tail -n +$(($CUTFIRSTLINE+1)) $INFILE | cut -f 1 > $TMPFILE"
                      fi
                      echo $CMD
                      eval $CMD

                      if [ -n "$DONT_DO_MAPPING" ]
                      then
                          paste $TMPFILE $TMPFILE > $OUTNAME
                          exit
                      fi

                      OPTS=
                      if [ -n "$HOST" ]
                      then
                          OPTS="$OPTS --redis_host $HOST"
                      fi
                      if [ -n "$PORT" ]
                      then
                          OPTS="$OPTS --redis_port $PORT"
                      fi
                      if [ -n "$PASS" ]
                      then
                          OPTS="$OPTS --redis_pass $PASS"
                      fi
                      if [ -n "$SOURCEHINT" ]
                      then
                          OPTS="$OPTS --source_hint $SOURCEHINT"
                      fi
                      if [ -n "$TAXON" ]
                      then
                          OPTS="$OPTS --taxon $TAXON"
                      fi
                      if [ -n "$OUTNAME" ]
                      then
                          OPTS="$OPTS --outfile $OUTNAME"
                      fi
                      CMD="python3 /home/src/kn_mapper.py $TMPFILE$OPTS"
                      echo $CMD
                      eval $CMD
                    filename: kn_mapper.sh
            successCodes: []
            'sbg:createdOn': 1524681212
            'sbg:publisher': sbg
            stdin: ''
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1524681212
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:modifiedOn': 1524681994
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Fixed typo in tail command in kn_mapper.sh.
                'sbg:modifiedOn': 1524687186
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added dont_do_mapping input/behavior.
                'sbg:modifiedOn': 1524842883
                'sbg:revision': 3
          'sbg:y': 171
          id: '#KN_Mapper'
        - inputs:
            - id: '#Map_Names.switch_mapped_order'
              default: true
            - source:
                - '#output_filename'
              id: '#Map_Names.output_filename'
            - id: '#Map_Names.names_are_columns'
            - source:
                - '#KN_Mapper.output_file'
              id: '#Map_Names.map_file'
            - source:
                - '#input_file'
              id: '#Map_Names.input_file'
            - id: '#Map_Names.drop_unmapped_names'
              default: true
          outputs:
            - id: '#Map_Names.output_file'
          'sbg:x': 782
          run:
            hints:
              - value: 1
                class: 'sbg:CPURequirement'
              - value: 1000
                class: 'sbg:MemRequirement'
              - class: DockerRequirement
                dockerImageId: ''
                dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
            inputs:
              - label: Switch Mapped Order
                description: >-
                  If present, the order in the map file is original name/mapped
                  name
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:stageInput': null
                id: '#switch_mapped_order'
                type:
                  - 'null'
                  - boolean
              - label: Output Filename
                description: Output Filename
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:includeInPorts': true
                id: '#output_filename'
                required: true
                type:
                  - string
              - label: Names are Columns
                description: >-
                  If present, the names to be mapped in the input file are
                  columns, not rows
                inputBinding:
                  prefix: '-c'
                  'sbg:cmdInclude': true
                  separate: true
                'sbg:stageInput': null
                id: '#names_are_columns'
                type:
                  - 'null'
                  - boolean
              - label: Map File
                description: >-
                  Map files with orginal/mapped names in first two columns
                  (default is mapped in first, original in second)
                inputBinding:
                  prefix: '-m'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#map_file'
                required: true
                type:
                  - File
              - label: Input File
                description: Input file to be mapped
                inputBinding:
                  prefix: '-i'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#input_file'
                required: true
                type:
                  - File
              - label: Drop Unmapped Names Flag
                description: 'If present, any names that are unmapped will be dropped'
                inputBinding:
                  prefix: '-u'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#drop_unmapped_names'
                type:
                  - 'null'
                  - boolean
            'sbg:modifiedOn': 1524716022
            'sbg:contributors':
              - mepstein
            cwlVersion: 'sbg:draft-2'
            x: 782
            'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
            arguments: []
            'sbg:validationErrors': []
            'sbg:createdBy': mepstein
            label: Map Names
            description: Map the names in the input file based on the map file.
            stdout: ''
            temporaryFailCodes: []
            'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
            'sbg:cmdPreview': >-
              python3 map_names.py -i /path/to/input_file.ext -m
              /path/to/map_file.ext -o output_filename-string-value
            baseCommand:
              - python3
              - map_names.py
            id: mepstein/knoweng-signature-analysis-dev/map-names/5
            'sbg:job':
              inputs:
                input_file:
                  class: File
                  secondaryFiles: []
                  size: 0
                  path: /path/to/input_file.ext
                drop_unmapped_names: true
                map_file:
                  class: File
                  secondaryFiles: []
                  size: 0
                  path: /path/to/map_file.ext
                switch_mapped_order: true
                output_filename: output_filename-string-value
                names_are_columns: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:sbgMaintained': false
            outputs:
              - label: Output File
                description: Output File
                id: '#output_file'
                outputBinding:
                  glob:
                    class: Expression
                    engine: '#cwl-js-engine'
                    script: $job.inputs.output_filename
                type:
                  - 'null'
                  - File
            'sbg:modifiedBy': mepstein
            'sbg:revision': 5
            'sbg:latestRevision': 5
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            class: CommandLineTool
            'sbg:image_url': null
            'y': 361
            'sbg:appVersion':
              - 'sbg:draft-2'
            $namespaces:
              sbg: 'https://sevenbridges.com'
            requirements:
              - class: CreateFileRequirement
                fileDef:
                  - fileContent: |-
                      #!/usr/bin/env python3


                      import argparse
                      import sys
                      import pandas as pd


                      def parse_args():
                          parser = argparse.ArgumentParser()

                          parser.add_argument("-i", "--input_file", required=True)
                          parser.add_argument("-m", "--map_file", required=True)
                          parser.add_argument("-o", "--output_file", required=True)
                          # default for map_file is mapped_name\torig_name
                          # use -s/--switch_mapped_order for orig_name\tmapped_name
                          parser.add_argument("-s", "--switch_mapped_order", action='store_true')
                          # default is names to be mapped are rows
                          # use -c/--names_are_cols if they are columns
                          parser.add_argument("-c", "--names_are_cols", action='store_true')
                          # With respect to the map file being gene names mapping, this
                          # script can typically be used one of two ways:
                          # 1. To map an unmapped file
                          # 2. To unmap a previously mapped file
                          # With regards to names that weren't mapped -- meaning their
                          # mapped names are either "unmapped-none" or "unmapped-many":
                          # 1: You may want to remove any unmapped names -- this option
                          # allows this
                          # 2. If the file has any unmapped names, there's nothing you can
                          # do, because they won't be unique -- so you have to hope there
                          # weren't any
                          parser.add_argument("-u", "--drop_unmapped_names", action='store_true')

                          args = parser.parse_args()

                          return args


                      def read_name_map(args):
                          name_map = {}

                          with open(args.map_file, 'r') as f:
                              for line in f:
                                  fields = line.rstrip().split()
                                  if args.switch_mapped_order:
                                      orig_name = fields[0]
                                      mapped_name = fields[1]
                                  else:
                                      orig_name = fields[1]
                                      mapped_name = fields[0]
                                  name_map[orig_name] = mapped_name

                          return name_map


                      def main():
                          args = parse_args()

                          df = pd.read_table(args.input_file, index_col=0)
                          print(df)
                          name_map = read_name_map(args)
                          print(name_map)
                          if args.names_are_cols:
                              df.rename(columns=name_map, inplace=True)
                              if args.drop_unmapped_names:
                                  #unmapped_cols = [col for col in df.columns if col.startswith("unmapped-")]
                                  df.drop(df.filter(like="unmapped-", axis="columns").columns, axis="columns", inplace=True)
                          else:
                              df.rename(index=name_map, inplace=True)
                              if args.drop_unmapped_names:
                                  #unmapped_rows = [row for row in df.index if row.startswith("unmapped-")]
                                  df.drop(df.filter(like="unmapped-", axis="index").index, axis="index", inplace=True)
                          print(df)
                          df.to_csv(path_or_buf=args.output_file, sep='\t')


                      if __name__ == "__main__":
                          main()
                    filename: map_names.py
              - class: ExpressionEngineRequirement
                id: '#cwl-js-engine'
                requirements:
                  - class: DockerRequirement
                    dockerPull: rabix/js-engine
            successCodes: []
            'sbg:createdOn': 1522285864
            'sbg:publisher': sbg
            stdin: ''
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1522285864
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:modifiedOn': 1522286794
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Modified name.
                'sbg:modifiedOn': 1522286850
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Changed container.
                'sbg:modifiedOn': 1522288616
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified map_names.py to add drop_unmapped_names option; added
                  drop_unmapped_names input.
                'sbg:modifiedOn': 1524714160
                'sbg:revision': 4
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
                'sbg:modifiedOn': 1524716022
                'sbg:revision': 5
          'sbg:y': 361
          id: '#Map_Names'
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/mapper-workflow/2.png
      'sbg:createdOn': 1524843132
      'sbg:canvas_y': 0
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1524843132
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:modifiedOn': 1524843462
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
          'sbg:modifiedOn': 1526497729
          'sbg:revision': 2
    'sbg:y': 353.99999999999994
    id: '#Mapper_Workflow_1'
  - inputs:
      - id: '#Signature_Analysis.use_network'
        default: false
      - source:
          - '#Data_Cleaning_Preprocessing.clean_genomic_file'
        id: '#Signature_Analysis.spreadsheet_file'
      - source:
          - '#similarity_measure'
        id: '#Signature_Analysis.similarity_measure'
      - source:
          - '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
        id: '#Signature_Analysis.signature_file'
      - id: '#Signature_Analysis.processing_method'
      - id: '#Signature_Analysis.parallelism'
      - id: '#Signature_Analysis.num_bootstraps'
        default: 0
      - id: '#Signature_Analysis.network_influence_percent'
      - id: '#Signature_Analysis.network_file'
      - id: '#Signature_Analysis.bootstrap_sample_percent'
    outputs:
      - id: '#Signature_Analysis.similarity_matrix_binary'
      - id: '#Signature_Analysis.similarity_matrix'
      - id: '#Signature_Analysis.run_params_yml'
      - id: '#Signature_Analysis.readme'
      - id: '#Signature_Analysis.clean_signatures_file'
      - id: '#Signature_Analysis.clean_samples_file'
    'sbg:x': 940.9999999999999
    run:
      hints:
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
        - class: DockerRequirement
          dockerImageId: ''
          dockerPull: 'knowengdev/signature_analysis_pipeline:05_10_2018'
      inputs:
        - label: Use Network Flag
          description: Whether to use the network
          'sbg:stageInput': null
          id: '#use_network'
          type:
            - 'null'
            - boolean
        - label: Spreadsheet File
          id: '#spreadsheet_file'
          description: The input spreadsheet file
          required: false
          type:
            - 'null'
            - File
        - label: Similarity Measure
          description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
          'sbg:includeInPorts': true
          id: '#similarity_measure'
          required: false
          type:
            - 'null'
            - symbols:
                - cosine
                - pearson
                - spearman
              name: similarity_measure
              type: enum
        - label: Signature File
          id: '#signature_file'
          description: The input signature file
          required: false
          type:
            - 'null'
            - File
        - 'sbg:toolDefaultValue': serial
          label: The processing method
          description: 'The processing method (e.g., serial or parallel, default: serial)'
          'sbg:stageInput': null
          id: '#processing_method'
          type:
            - 'null'
            - symbols:
                - serial
                - parallel
              name: processing_method
              type: enum
        - 'sbg:toolDefaultValue': '4'
          label: parallelism
          description: 'The parallelism (if the processing method is parallel; default: 4)'
          'sbg:stageInput': null
          id: '#parallelism'
          type:
            - 'null'
            - int
        - 'sbg:toolDefaultValue': '0'
          label: Number of Bootstraps
          description: 'The number of bootstraps (default: 0)'
          'sbg:stageInput': null
          id: '#num_bootstraps'
          type:
            - 'null'
            - int
        - 'sbg:toolDefaultValue': '50'
          label: Amount of Network Influence
          description: >-
            The amount of network influence (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          'sbg:stageInput': null
          id: '#network_influence_percent'
          type:
            - 'null'
            - int
        - label: Knowledge Network File
          id: '#network_file'
          description: The knowledge network file
          required: false
          type:
            - 'null'
            - File
        - 'sbg:toolDefaultValue': '80'
          label: Bootstrap Sample Percent
          description: 'The bootstrap sample percent (default: 80%)'
          'sbg:stageInput': null
          id: '#bootstrap_sample_percent'
          type:
            - 'null'
            - int
      'sbg:modifiedOn': 1526542156
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 940.9999999999999
      'sbg:revisionNotes': Changed how wget.py called on command line.
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Signature Analysis
      description: >-
        Calls the KnowEnG Signature Analysis pipeline.


        Note: In the current implementation of Signature Analysis, the only mode
        available is non-network, non-bootstrapping.  That means that the tool
        behaves as if the input parameters use_network is false and
        num_bootstraps is 0, and the input file network_file and the input
        parameters network_influence_percent, bootstrap_sample_percent,
        processing_method, and parallelism are ignored.  (These inputs are still
        present; this behavior is set in the javascript that generates
        run_sa.cmd.)


        In summary, the only inputs that are used are the input files
        spreadsheet_file and signature_file and the input parameter
        similarity_measure.
      stdout: ''
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis/13
      'sbg:cmdPreview': >-
        sh run_sa.cmd && cp -pr result*.tsv similarity_matrix.tsv && cp -pr
        Gene_to_TF_Association*.tsv similarity_matrix.binary.tsv && python3
        wget.py
        https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SA.md
        README-SA.md
      baseCommand:
        - sh
        - run_sa.cmd
        - '&&'
        - cp
        - '-pr'
        - result*.tsv
        - similarity_matrix.tsv
        - '&&'
        - cp
        - '-pr'
        - Gene_to_TF_Association*.tsv
        - similarity_matrix.binary.tsv
        - '&&'
        - python3
        - wget.py
        - >-
          https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SA.md
        - README-SA.md
      id: mepstein/knoweng-signature-analysis-dev/signature-analysis/13
      'sbg:job':
        inputs:
          signature_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/signature_file.ext
          similarity_measure: spearman
          parallelism: 4
          network_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/network_file.ext
          network_influence_percent: 50
          bootstrap_sample_percent: 80
          processing_method: serial
          num_bootstraps: 0
          spreadsheet_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/spreadsheet_file.ext
          use_network: false
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      outputs:
        - label: Similarity Matrix Binary
          description: The signature similarity matrix (binary; one 1 per row/gene/feature)
          id: '#similarity_matrix_binary'
          outputBinding:
            glob: similarity_matrix.binary.tsv
          type:
            - 'null'
            - File
        - label: Similarity Matrix
          description: The signature similarity results
          id: '#similarity_matrix'
          outputBinding:
            glob: similarity_matrix.tsv
          type:
            - 'null'
            - File
        - label: SA Parameters File
          description: The Signature Analysis parameters
          id: '#run_params_yml'
          outputBinding:
            glob: run_params.yml
          type:
            - 'null'
            - File
        - label: The README file
          description: The README file that describes the output files
          id: '#readme'
          outputBinding:
            glob: README-SA.md
          type:
            - 'null'
            - File
        - label: Clean Signatures File
          description: The clean signatures file
          id: '#clean_signatures_file'
          outputBinding:
            glob: clean_signatures_matrix.tsv
          type:
            - 'null'
            - File
        - label: Clean Samples File
          description: The clean samples file
          id: '#clean_samples_file'
          outputBinding:
            glob: clean_samples_matrix.tsv
          type:
            - 'null'
            - File
      'sbg:modifiedBy': mepstein
      'sbg:revision': 13
      'sbg:latestRevision': 13
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      class: CommandLineTool
      'sbg:image_url': null
      'y': 427
      'sbg:contributors':
        - mepstein
      $namespaces:
        sbg: 'https://sevenbridges.com'
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >+


                  //similarity_measure

                  //spreadsheet_file

                  //signature_file

                  //use_network

                  //network_file

                  //network_influence_percent

                  //num_bootstraps

                  //bootstrap_sample_percent

                  //processing_method

                  //parallelism

                  //Can these be the same?

                  //results_directory

                  //tmp_directory



                  var str = "";


                  // similarity_measure: cosine, pearson, or spearman

                  str += "similarity_measure: " + $job.inputs.similarity_measure
                  + "\n";


                  str += "spreadsheet_name_full_path: " +
                  $job.inputs.spreadsheet_file.path + "\n";

                  str += "signature_name_full_path: " +
                  $job.inputs.signature_file.path + "\n";


                  str += "results_directory: ./\n";

                  str += "tmp_directory: ./tmp/\n";


                  var method = "similarity";


                  var use_network = $job.inputs.use_network;

                  use_network = false;


                  if (use_network) {

                  //if ($job.inputs.use_network) {

                  //if ($job.inputs.use_network == "true") {

                  //if ($job.inputs.network_file) {
                      method = "net_" + method;
                      str += "gg_network_name_full_path: " + $job.inputs.network_file.path + "\n";
                      str += "rwr_convergence_tolerence: 0.0001\n";
                      str += "rwr_max_iterations: 100\n";
                      //str += "rwr_restart_probability: 0.5\n";
                      if ($job.inputs.network_influence_percent &&
                          $job.inputs.network_influence_percent >= 0 && $job.inputs.network_influence_percent <= 100) {
                          //restart_prob = 1 - ($job.inputs.network_influence_percent/100);
                          restart_prob = $job.inputs.network_influence_percent/100;
                          str += "rwr_restart_probability: " + restart_prob + "\n";
                      }
                      else {
                          str += "rwr_restart_probability: 0.5\n";
                      }
                  }


                  var num_bootstraps = $job.inputs.num_bootstraps;

                  num_bootstraps = 0;


                  //if ($job.inputs.num_bootstraps &&

                  //    $job.inputs.num_bootstraps > 1) {

                  if (num_bootstraps &&
                      num_bootstraps > 1) {
                      method = "cc_" + method;
                      str += "number_of_bootstraps: " + $job.inputs.num_bootstraps + "\n";
                      //str += "cols_sampling_fraction: 0.8\n";
                      if ($job.inputs.bootstrap_sample_percent &&
                          $job.inputs.bootstrap_sample_percent >= 0 && $job.inputs.bootstrap_sample_percent <= 100) {
                          //str += "cols_sampling_fraction: " + $job.inputs.bootstrap_sample_percent/100 + "\n";
                          str += "rows_sampling_fraction: " + $job.inputs.bootstrap_sample_percent/100 + "\n";
                      }
                      else {
                          //str += "cols_sampling_fraction: 0.8\n";
                          str += "rows_sampling_fraction: 0.8\n";
                      }
                      //str += "rows_sampling_fraction: 1.0\n";

                      // processing_method: serial or parallel
                      if ($job.inputs.processing_method && $job.inputs.processing_method != "serial") {
                          str += "processing_method: " + $job.inputs.processing_method + "\n";
                          if ($job.inputs.processing_method == "parallel") {
                              if ($job.inputs.parallelism) {
                                  str += "parallelism: " + $job.inputs.parallelism + "\n";
                              }
                              else {
                                  str += "parallelism: 4\n";

                              }
                          }
                          //str += "cluster_shared_volumn: none\n";
                      }
                      else {
                          str += "processing_method: serial\n";
                      }
                  }


                  str += "method: " + method + "\n";


                  var str2 = "cp -pr " + $job.inputs.spreadsheet_file.path + "
                  clean_samples_matrix.tsv && cp -pr " +
                  $job.inputs.signature_file.path + "
                  clean_signatures_matrix.tsv";


                  var str3 = "echo \"" + str + "\" > run_params.yml && " + str2
                  + " && python3 /home/src/gene_signature.py -run_directory ./
                  -run_file run_params.yml";


                  str3;

              filename: run_sa.cmd
            - fileContent: |-
                #!/usr/bin/env python3


                import argparse
                import sys
                import numpy as np
                import pandas as pd


                def parse_args():
                    parser = argparse.ArgumentParser()

                    parser.add_argument("-i", "--input_file", required=True)
                    parser.add_argument("-o", "--output_file", required=True)
                    # default is per_row
                    parser.add_argument("-c", "--per_col", action='store_true')

                    args = parser.parse_args()

                    return args


                def one_per_row(df, args):
                    binary_df = pd.DataFrame(0, index=df.index, columns=df.columns)

                    for ix, row in df.iterrows():
                        idxmax = row.idxmax(axis='columns')
                        #if np.isnan(idxmax):
                        if isinstance(idxmax, float) and np.isnan(idxmax):
                            #idxmax = df.columns[0]
                            idxmax = df.columns[-1]
                        binary_df[idxmax][ix] = 1

                    binary_df.to_csv(path_or_buf=args.output_file, sep='\t')

                    return binary_df


                def one_per_col(df, args):
                    binary_df = pd.DataFrame(0, index=df.index, columns=df.columns)

                    for col in df.columns:
                        idxmax = df[col].idxmax()
                        #if np.isnan(idxmax):
                        if isinstance(idxmax, float) and np.isnan(idxmax):
                            #idxmax = 0
                            idxmax = -1
                        binary_df[col][idxmax] = 1

                    binary_df.to_csv(path_or_buf=args.output_file, sep='\t')

                    return binary_df


                def main():
                    args = parse_args()

                    df = pd.read_table(args.input_file, index_col=0)

                    if args.per_col:
                        binary_df = one_per_col(df, args)
                    else:
                        binary_df = one_per_row(df, args)

                    print(binary_df)


                if __name__ == "__main__":
                    main()
              filename: mbm.py
            - fileContent: >-
                #!/usr/bin/env python3



                import sys

                import urllib.request



                GP_README_URL =
                'https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GP.md'

                GSC_README_URL =
                'https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md'

                SC_README_URL =
                'https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SC.md'

                SSV_README_URL =
                'https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SSV.md'



                if len(sys.argv) != 3:
                    print("Usage: %s URL output_file" % (__file__))
                    sys.exit(1)

                url = sys.argv[1]

                output_file = sys.argv[2]



                filename, headers = urllib.request.urlretrieve(url,
                filename=output_file)
              filename: wget.py
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      successCodes: []
      'sbg:createdOn': 1520542501
      'sbg:publisher': sbg
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1520542501
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:modifiedOn': 1520544005
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed glob value on results file.
          'sbg:modifiedOn': 1520544423
          'sbg:revision': 2
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified the default behavior (with regard to certain inputs).
          'sbg:modifiedOn': 1520577053
          'sbg:revision': 3
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Modified run_sa.cmd javascript to run SA in only one mode
            (non-network, non-bootstrapping); added similarity map binary matrix
            output.
          'sbg:modifiedOn': 1521661999
          'sbg:revision': 4
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified mbm.py to handle empty spreadsheets.
          'sbg:modifiedOn': 1522291013
          'sbg:revision': 5
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated version of SAP container.
          'sbg:modifiedOn': 1524106105
          'sbg:revision': 6
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated a few things (docker container, output for binary similarity
            matrix, ...).
          'sbg:modifiedOn': 1526407664
          'sbg:revision': 7
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added outputs for clean samples and signatures files.
          'sbg:modifiedOn': 1526482172
          'sbg:revision': 8
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified documentation to include new similar measure (pearson).
          'sbg:modifiedOn': 1526484932
          'sbg:revision': 9
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed js syntax error (missing +).
          'sbg:modifiedOn': 1526486122
          'sbg:revision': 10
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added call to wget.py.
          'sbg:modifiedOn': 1526540717
          'sbg:revision': 11
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added readme output file.
          'sbg:modifiedOn': 1526540795
          'sbg:revision': 12
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Changed how wget.py called on command line.
          'sbg:modifiedOn': 1526542156
          'sbg:revision': 13
    'sbg:y': 427
    id: '#Signature_Analysis'
  - inputs:
      - source:
          - '#Mapper_Workflow_1.output_file_1'
        id: '#Signature_Analysis_Renamer.gene_map2_in'
      - source:
          - '#Mapper_Workflow.output_file_1'
        id: '#Signature_Analysis_Renamer.gene_map1_in'
    outputs:
      - id: '#Signature_Analysis_Renamer.gene_map_file_out'
    'sbg:x': 867.0588235294119
    run:
      hints:
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
        - class: DockerRequirement
          dockerImageId: ''
          dockerPull: ubuntu
      inputs:
        - label: Gene Map File 2 Input
          id: '#gene_map2_in'
          description: Gene Map File 2 Input
          required: false
          type:
            - 'null'
            - File
        - label: Gene Map File 1 Input
          id: '#gene_map1_in'
          description: Gene Map File 1 Input
          required: false
          type:
            - 'null'
            - File
      'sbg:modifiedOn': 1526570997
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 867.0588235294119
      'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Signature Analysis Renamer
      description: ''
      stdout: ''
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
      'sbg:cmdPreview': sh renamer.sh
      baseCommand:
        - sh
        - renamer.sh
      id: mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
      'sbg:job':
        inputs:
          gene_map2_in:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/gene_map2_in.ext
          gene_map1_in:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/gene_map1_in.ext
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      outputs:
        - label: Gene Map File
          description: The gene map file
          id: '#gene_map_file_out'
          outputBinding:
            glob: gene_map.txt
          type:
            - 'null'
            - File
      'sbg:modifiedBy': mepstein
      'sbg:revision': 3
      'sbg:latestRevision': 3
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      class: CommandLineTool
      'sbg:image_url': null
      'y': 71.76470588235296
      'sbg:contributors':
        - mepstein
      $namespaces:
        sbg: 'https://sevenbridges.com'
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent: >-
                #!/usr/bin/bash


                INPUT=$1

                OUTPUT=$2


                # As seen on:

                #
                https://unix.stackexchange.com/questions/30173/how-to-remove-duplicate-lines-inside-a-text-file

                <$INPUT nl -b a -s : |          # number the lines

                sort -t : -k 2 -u |             # sort and uniquify ignoring the
                line numbers

                sort -t : -k 1n |               # sort according to the line
                numbers

                cut -d : -f 2- >$OUTPUT         # remove the line numbers


                # Using awk:

                # <input awk '!seen[$0]++'
              filename: rem_dups.sh
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: |
                  var str = "";

                  var files = "";

                  if ($job.inputs.gene_map1_in) {
                      files += " " + $job.inputs.gene_map1_in.path;
                  }
                  if ($job.inputs.gene_map2_in) {
                      files += " " + $job.inputs.gene_map2_in.path;
                  }

                  if (files) {
                      //str += "cat " + files + " > tmp1 && ./rem_dups.sh tmp1 gene_map.txt";
                      str += "echo 'user_supplied_gene_name\\tstatus' > tmp1 && cat " + files + " >> tmp1 && sh rem_dups.sh tmp1 gene_map.txt";
                  }
                  else {
                      str += "touch gene_map.txt";
                  }

                  str;
              filename: renamer.sh
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      successCodes: []
      'sbg:createdOn': 1526539333
      'sbg:publisher': sbg
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1526539333
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:modifiedOn': 1526540443
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Changed how shell script called in renamer.sh.
          'sbg:modifiedOn': 1526542055
          'sbg:revision': 2
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
          'sbg:modifiedOn': 1526570997
          'sbg:revision': 3
    'sbg:y': 71.76470588235296
    id: '#Signature_Analysis_Renamer'
'sbg:toolAuthor': KnowEnG
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:toolkit': KnowEnG_CGC
'sbg:publisher': sbg
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522163173
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522163902
    'sbg:revisionNotes': Initial version.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522170822
    'sbg:revisionNotes': Modified documentation on inputs.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522181628
    'sbg:revisionNotes': Added initial description.
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522287949
    'sbg:revisionNotes': Added Map Names app (temporary workaround for mapping problem with DCP).
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522288661
    'sbg:revisionNotes': Updated Map Names version.
  - 'sbg:revision': 6
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522291062
    'sbg:revisionNotes': Updated version of Signature Analysis tool.
  - 'sbg:revision': 7
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1523641455
    'sbg:revisionNotes': Updated description.
  - 'sbg:revision': 8
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524112989
    'sbg:revisionNotes': Updated versions of DC/P and SA.
  - 'sbg:revision': 9
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524113397
    'sbg:revisionNotes': Removed Map Names tool (no longer needed).
  - 'sbg:revision': 10
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524851857
    'sbg:revisionNotes': Added mapping (optional) of samples and signatures files.
  - 'sbg:revision': 11
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1525369832
    'sbg:revisionNotes': Modified names/descriptions on some of the inputs.
  - 'sbg:revision': 12
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1525372690
    'sbg:revisionNotes': 'Updated the description (mostly, added the Demo Data section).'
  - 'sbg:revision': 13
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1525372894
    'sbg:revisionNotes': Fixed formatting of pre-block in description.
  - 'sbg:revision': 14
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526408576
    'sbg:revisionNotes': Updated SA version; updated description.
  - 'sbg:revision': 15
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526484019
    'sbg:revisionNotes': 'Various updates (added output files, modified description, ...).'
  - 'sbg:revision': 16
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526485063
    'sbg:revisionNotes': Added new version of SA; added new similarity measure (pearson).
  - 'sbg:revision': 17
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526486173
    'sbg:revisionNotes': Updated version of SA.
  - 'sbg:revision': 18
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526541640
    'sbg:revisionNotes': >-
      Variety of changes (added Renamer, added Gene Map File output, updated SA,
      added README output, ...).
  - 'sbg:revision': 19
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526542197
    'sbg:revisionNotes': Updated Renamer and SA.
  - 'sbg:revision': 20
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526571030
    'sbg:revisionNotes': Updated renamer.
  - 'sbg:revision': 21
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1527180011
    'sbg:revisionNotes': Modified description (revised section on demo data files).
  - 'sbg:revision': 22
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1527180205
    'sbg:revisionNotes': Fixed a typo in a markdown link in the description.
  - 'sbg:revision': 23
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1527219481
    'sbg:revisionNotes': Added reference to description.
  - 'sbg:revision': 24
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1528984040
    'sbg:revisionNotes': Added "Analysis" category.
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-dev/signature-analysis-workflow/24/raw/
'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis-workflow/24
'sbg:revision': 24
'sbg:modifiedOn': 1528984040
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1522163173
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 24
'sbg:content_hash': null
