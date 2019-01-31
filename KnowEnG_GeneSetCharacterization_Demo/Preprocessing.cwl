hints:
  - class: DockerRequirement
    dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
  - outdirMin: 512000
    class: ResourceRequirement
    coresMin: 1
    ramMin: 5000
  - value: 1
    class: 'sbg:CPURequirement'
  - value: 1000
    class: 'sbg:MemRequirement'
outputs:
  - label: Cleaning Log File
    description: The log of the data cleaning run
    type:
      - 'null'
      - File
    id: '#cleaning_log_file'
    doc: information on souce of errors for cleaning pipeline
    outputBinding:
      glob: log_*_pipeline.yml
  - label: Clean Genomic Spreadsheet
    description: The clean genomic spreadsheet
    type:
      - 'null'
      - File
    id: '#clean_genomic_file'
    doc: matrix with gene names mapped and data cleaned
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

          basename($job.inputs.genomic_spreadsheet_file.name) + "_ETL.tsv";
  - label: Clean Phenotypic Spreadsheet
    description: The clean phenotypic spreadsheet
    type:
      - 'null'
      - File
    id: '#clean_phenotypic_file'
    doc: phenotype file prepared for pipeline
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
  - label: Gene Map File
    description: The gene map file
    type:
      - 'null'
      - File
    id: '#gene_map_file'
    doc: two columns for internal gene ids and original gene ids
    outputBinding:
      glob: '*_MAP.tsv'
  - label: Gene Unmapped File
    description: The genes that were not mapped
    type:
      - 'null'
      - File
    id: '#gene_unmap_file'
    doc: two columns for original gene ids and unmapped reason code
    outputBinding:
      glob: '*_UNMAPPED.tsv'
  - label: Cleaning Parameters File
    description: The configuration parameters specified for the data cleaning run
    type:
      - 'null'
      - File
    id: '#cleaning_parameters_yml'
    doc: data cleaning parameters in yaml format
    outputBinding:
      glob: run_cleanup.yml
  - label: Command Log File
    description: The log of the data cleaning command
    id: '#cmd_log_file'
    outputBinding:
      glob: run_dc.cmd
    type:
      - 'null'
      - File
inputs:
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
  - label: Genomic Spreadsheet File
    description: The genomic spreadsheet file
    id: '#genomic_spreadsheet_file'
    doc: the genomic spreadsheet input for the pipeline
    type:
      - File
  - 'sbg:toolDefaultValue': '9606'
    label: Species Taxon ID
    description: 'The species taxon ID (e.g., 9606 for human)'
    type:
      - 'null'
      - string
    id: '#taxonid'
    doc: taxon id of species related to genomic spreadsheet
    default: '9606'
  - 'sbg:toolDefaultValue':
      class: File
      location: /bin/sh
    label: Phenotypic Spreadsheet File (optional)
    description: The phenotypic spreadsheet file (optional)
    type:
      - 'null'
      - File
    id: '#phenotypic_spreadsheet_file'
    doc: 'the phenotypic spreadsheet input for the pipeline [may be optional]'
    default:
      class: File
      location: /bin/sh
  - 'sbg:toolDefaultValue': missing
    label: GP Correlation Measure
    description: 'The correlation measure to be used for GP (e.g., t_test or pearson)'
    type:
      - 'null'
      - string
    id: '#gene_prioritization_corr_measure'
    doc: >-
      if pipeline_type=='gene_prioritization_pipeline', then must be one of
      either ['t_test', 'pearson']
    default: missing
  - 'sbg:toolDefaultValue': knowredis.knoweng.org
    label: RedisDB Host
    description: The redis DB host name
    type:
      - 'null'
      - string
    id: '#redis_host'
    doc: url of Redis db
    default: knowredis.knoweng.org
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
  - 'sbg:toolDefaultValue': ''''''
    label: ID Source Hint
    description: The source hint for the redis queries (can be '')
    type:
      - 'null'
      - string
    id: '#source_hint'
    doc: suggestion for ID source database used to resolve ambiguities in mapping
    default: \'\'
'sbg:publisher': sbg
'sbg:cmdPreview': sh run_dc.cmd
description: >-
  Clean/preprocess input data (genomic and optionally phenotypic) for use with
  other tools/pipelines.
'sbg:projectName': KnowEnG_GeneSetCharacterization_Demo
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
                str += "phenotype_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
            }

            if ($job.inputs.pipeline_type == "gene_prioritization_pipeline") {
                str += "correlation_measure: " + $job.inputs.gene_prioritization_corr_measure + "\n";
            }


            //str2 = "echo \"" + str + "\" > run_cleanup.yml"

            //str2 = "echo \"" + str + "\" > run_cleanup.yml && touch
            log_X_pipeline.yml && touch GX_ETL.tsv && touch PX_ETL.tsv && touch
            X_MAP.tsv && touch X_UNMAPPED.tsv"

            str2 = "echo \"" + str + "\" > run_cleanup.yml && date && python3
            /home/src/data_cleanup.py -run_directory ./ -run_file
            run_cleanup.yml && date"


            str2;
        filename: run_dc.cmd
class: CommandLineTool
'sbg:image_url': null
successCodes: []
label: Data Cleaning/Preprocessing
stdout: ''
temporaryFailCodes: []
doc: checks the inputs of a pipeline for potential sources of errors
arguments: []
cwlVersion: 'sbg:draft-2'
baseCommand:
  - sh
  - run_dc.cmd
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': viktorian_miok
    'sbg:modifiedOn': 1512038144
    'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
'sbg:job':
  inputs: {}
  allocatedResources:
    cpu: 1
    mem: 1000
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0/raw/
'sbg:id': mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
'sbg:revision': 0
'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
'sbg:modifiedOn': 1512038144
'sbg:modifiedBy': viktorian_miok
'sbg:createdOn': 1512038144
'sbg:createdBy': viktorian_miok
'sbg:project': mepstein/knoweng-genesetcharacterization
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - viktorian_miok
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
'sbg:update': mepstein/genesetcharacterization/data-cleaning-copy/21
'sbg:updateRevisionNotes': Updated version of DCP container.
'sbg:updateModifiedBy': mepstein
