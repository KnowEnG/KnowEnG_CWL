'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529392936
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529392994
    'sbg:revisionNotes': Saving imported workflow.
'sbg:projectName': KnowEnG_Signature_Analysis_Public
'sbg:publisher': KnowEnG
inputs:
  - type:
      - 'null'
      - string
    label: Species Taxon ID
    'sbg:x': 63
    'sbg:y': 237
    description: >-
      The species taxon ID (e.g., 9606 for human).See
      https://knoweng.org/kn-data-references/ for possible values (KN Contents
      by Species).
    id: '#taxonid'
    'sbg:includeInPorts': true
  - type:
      - File
    label: Samples File
    'sbg:x': 55
    'sbg:y': 50
    description: The samples file
    id: '#samples_file'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - boolean
    label: Dont Map Samples Flag
    'sbg:x': 149
    'sbg:y': 133
    description: 'If set, the names will not be mapped'
    id: '#dont_map_samples'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - File
    label: Signatures File
    'sbg:x': 66
    'sbg:y': 368
    description: The signatures file
    id: '#signatures_file'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - boolean
    label: Dont Map Signatures Flag
    'sbg:x': 158
    'sbg:y': 456
    description: 'If set, the names will not be mapped'
    id: '#dont_map_signatures'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - type: enum
        name: similarity_measure
        symbols:
          - cosine
          - pearson
          - spearman
    label: Similarity Measure
    'sbg:x': 75
    'sbg:y': 558
    description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
    id: '#similarity_measure'
    'sbg:includeInPorts': true
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-public/signature-analysis-workflow/1.png
'sbg:toolAuthor': KnowEnG
'sbg:revisionNotes': Saving imported workflow.
outputs:
  - type:
      - 'null'
      - File
    label: Clean Samples
    'sbg:x': 1187.254997702206
    source:
      - '#Signature_Analysis.clean_samples_file'
    'sbg:y': 204.5098338407629
    description: The clean samples file
    id: '#clean_samples_file'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Clean Signatures
    'sbg:x': 1272.0262235753678
    source:
      - '#Signature_Analysis.clean_signatures_file'
    'sbg:y': 309.67317468979786
    description: The clean signatures file
    id: '#clean_signatures_file'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Similarity Matrix File
    'sbg:x': 1182.5684311810664
    source:
      - '#Signature_Analysis.similarity_matrix'
    'sbg:y': 396.4510210822611
    description: The signature similarity results
    id: '#similarity_matrix'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Similarity Matrix Binary
    'sbg:x': 1278.8509593290441
    source:
      - '#Signature_Analysis.similarity_matrix_binary'
    'sbg:y': 500.3956155215994
    description: The signature similarity matrix (binary; one 1 per row/gene/feature)
    id: '#similarity_matrix_binary'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: SA run_params_yml
    'sbg:x': 1275.8431468290444
    source:
      - '#Signature_Analysis.run_params_yml'
    'sbg:y': 677.8823673023899
    description: The configuration parameters specified for the SA run
    id: '#run_params_yml'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: README
    'sbg:x': 1186.1437988281252
    source:
      - '#Signature_Analysis.readme'
    'sbg:y': 578.627498851103
    description: The README file that describes the output files
    id: '#readme'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Gene Map File
    'sbg:x': 1185.8823529411768
    source:
      - '#Signature_Analysis_Renamer.gene_map_file_out'
    'sbg:y': 57.64705882352942
    description: The gene map file
    id: '#gene_map_file_out'
    'sbg:includeInPorts': true
    required: false
'sbg:canvas_y': 22
class: Workflow
hints: []
requirements: []
steps:
  - 'sbg:x': 741
    'sbg:y': 224
    run:
      'sbg:id': mepstein/knoweng-signature-analysis-dev/data-cleaning-copy/2
      arguments: []
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1522093713
      'sbg:job':
        inputs:
          geneset_characterization_impute: remove
          gene_prioritization_corr_measure: pearson
          pipeline_type: geneset_characterization_pipeline
          genomic_spreadsheet_file:
            class: File
            size: 0
            path: /path/to/file.tsv
            secondaryFiles: []
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1522093713
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/19
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1522098998
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/20
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1524112841
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
          'sbg:revision': 2
      inputs:
        - label: Species Taxon ID
          type:
            - 'null'
            - string
          'sbg:toolDefaultValue': '9606'
          doc: taxon id of species related to genomic spreadsheet
          default: '9606'
          description: 'The species taxon ID (e.g., 9606 for human)'
          id: '#taxonid'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - string
          label: ID Source Hint
          'sbg:toolDefaultValue': ''''''
          doc: >-
            suggestion for ID source database used to resolve ambiguities in
            mapping
          default: \'\'
          description: The source hint for the redis queries (can be '')
          id: '#source_hint'
        - type:
            - 'null'
            - int
          label: RedisDB Port
          'sbg:toolDefaultValue': 6379
          doc: port for Redis db
          default: 6379
          description: The redis DB port
          id: '#redis_port'
        - type:
            - 'null'
            - string
          label: RedisDB Password
          'sbg:toolDefaultValue': KnowEnG
          doc: password for Redis db
          default: KnowEnG
          description: The redis DB password
          id: '#redis_pass'
        - type:
            - 'null'
            - string
          label: RedisDB Host
          'sbg:toolDefaultValue': knowredis.knoweng.org
          doc: url of Redis db
          default: knowredis.knoweng.org
          description: The redis DB host name
          id: '#redis_host'
        - type:
            - string
          id: '#pipeline_type'
          description: >-
            The name of the pipeline that will be run (i.e., data cleaning is
            pipeline-specific)
          doc: >-
            keywork name of pipeline from following list
            ['gene_prioritization_pipeline', 'samples_clustering_pipeline',
            'geneset_characterization_pipeline']
          label: Name of Pipeline
        - type:
            - 'null'
            - File
          label: Phenotypic Spreadsheet File (optional)
          'sbg:toolDefaultValue':
            class: File
            location: /bin/sh
          doc: 'the phenotypic spreadsheet input for the pipeline [may be optional]'
          default:
            class: File
            location: /bin/sh
          description: The phenotypic spreadsheet file (optional)
          id: '#phenotypic_spreadsheet_file'
          required: false
        - type:
            - File
          label: Genomic Spreadsheet File
          doc: the genomic spreadsheet input for the pipeline
          description: The genomic spreadsheet file
          id: '#genomic_spreadsheet_file'
          required: true
        - type:
            - 'null'
            - type: enum
              name: geneset_characterization_impute
              symbols:
                - remove
                - average
                - reject
          label: GSC Imputation Strategy
          id: '#geneset_characterization_impute'
          description: >-
            How to handle missing values in the input data (e.g., remove rows,
            fill in with row average, reject)
        - type:
            - 'null'
            - type: enum
              name: gene_prioritization_corr_measure
              symbols:
                - pearson
                - t_test
          label: GP Correlation Measure
          doc: >-
            if pipeline_type=='gene_prioritization_pipeline', then must be one
            of either ['t_test', 'pearson']
          default: missing
          'sbg:stageInput': null
          description: 'The correlation measure to be used for GP (e.g., t_test or pearson)'
          id: '#gene_prioritization_corr_measure'
      'sbg:cmdPreview': sh run_dc.cmd
      'sbg:revision': 2
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'sbg:modifiedBy': mepstein
      successCodes: []
      'sbg:appVersion':
        - 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/data-cleaning-copy/2
      'sbg:latestRevision': 2
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
      outputs:
        - type:
            - 'null'
            - File
          label: Gene Unmapped File
          doc: two columns for original gene ids and unmapped reason code
          description: The genes that were not mapped
          outputBinding:
            glob: '*_UNMAPPED.tsv'
          id: '#gene_unmap_file'
        - type:
            - 'null'
            - File
          label: Gene Map File
          doc: two columns for internal gene ids and original gene ids
          description: The gene map file
          outputBinding:
            glob: '*_MAP.tsv'
          id: '#gene_map_file'
        - type:
            - 'null'
            - File
          id: '#gene_map_exceptions_file'
          description: The gene map exceptions file
          outputBinding:
            glob: '*_User_To_Ensembl.tsv'
          label: Gene Map Exceptions File
        - type:
            - 'null'
            - File
          id: '#cmd_log_file'
          description: The log of the data cleaning command
          outputBinding:
            glob: run_dc.cmd
          label: Command Log File
        - type:
            - 'null'
            - File
          label: Cleaning Parameters File
          doc: data cleaning parameters in yaml format
          description: The configuration parameters specified for the data cleaning run
          outputBinding:
            glob: run_cleanup.yml
          id: '#cleaning_parameters_yml'
        - type:
            - 'null'
            - File
          label: Cleaning Log File
          doc: information on souce of errors for cleaning pipeline
          description: The log of the data cleaning run
          outputBinding:
            glob: log_*_pipeline.yml
          id: '#cleaning_log_file'
        - type:
            - 'null'
            - File
          label: Clean Phenotypic Spreadsheet
          doc: phenotype file prepared for pipeline
          description: The clean phenotypic spreadsheet
          outputBinding:
            glob:
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
              class: Expression
          id: '#clean_phenotypic_file'
        - type:
            - 'null'
            - File
          label: Clean Genomic Spreadsheet
          doc: matrix with gene names mapped and data cleaned
          description: The clean genomic spreadsheet
          outputBinding:
            glob:
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
              class: Expression
          id: '#clean_genomic_file'
      label: Data Cleaning/Preprocessing
      stdin: ''
      baseCommand:
        - sh
        - run_dc.cmd
      hints:
        - class: DockerRequirement
          dockerPull: 'knowengdev/data_cleanup_pipeline:04_11_2018'
        - coresMin: 1
          class: ResourceRequirement
          ramMin: 5000
          outdirMin: 512000
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
      requirements:
        - id: '#cwl-js-engine'
          class: ExpressionEngineRequirement
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: InlineJavascriptRequirement
        - class: ShellCommandRequirement
        - fileDef:
            - fileContent:
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
                class: Expression
              filename: run_dc.cmd
          class: CreateFileRequirement
      temporaryFailCodes: []
      'sbg:modifiedOn': 1524112841
      x: 741
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 224
      description: >-
        Clean/preprocess input data (genomic and optionally phenotypic) for use
        with other tools/pipelines.
      stdout: ''
      'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/21
      doc: checks the inputs of a pipeline for potential sources of errors
      'sbg:createdBy': mepstein
      class: CommandLineTool
      'sbg:sbgMaintained': false
    inputs:
      - id: '#Data_Cleaning_Preprocessing.taxonid'
        source:
          - '#taxonid'
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
      - id: '#Data_Cleaning_Preprocessing.phenotypic_spreadsheet_file'
        source:
          - '#Mapper_Workflow_1.output_file'
      - id: '#Data_Cleaning_Preprocessing.genomic_spreadsheet_file'
        source:
          - '#Mapper_Workflow.output_file'
      - id: '#Data_Cleaning_Preprocessing.geneset_characterization_impute'
      - id: '#Data_Cleaning_Preprocessing.gene_prioritization_corr_measure'
    id: '#Data_Cleaning_Preprocessing'
    outputs:
      - id: '#Data_Cleaning_Preprocessing.gene_unmap_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_exceptions_file'
      - id: '#Data_Cleaning_Preprocessing.cmd_log_file'
      - id: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
      - id: '#Data_Cleaning_Preprocessing.cleaning_log_file'
      - id: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Data_Cleaning_Preprocessing.clean_genomic_file'
  - 'sbg:x': 431
    'sbg:y': 75.99999999999999
    run:
      'sbg:id': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1524843132
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1524843462
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1526497729
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
          'sbg:revision': 2
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1524843132
      description: ''
      inputs:
        - type:
            - 'null'
            - string
          label: taxon
          'sbg:x': 81
          'sbg:y': 326
          id: '#taxon'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - string
          label: source_hint
          'sbg:x': 86
          'sbg:y': 464
          id: '#source_hint'
          required: false
          'sbg:includeInPorts': true
        - type:
            - string
          label: output_filename
          'sbg:x': 87
          'sbg:y': 596
          id: '#output_filename'
          required: true
          'sbg:includeInPorts': true
        - type:
            - File
          label: input_file
          'sbg:x': 80
          'sbg:y': 62
          id: '#input_file'
          required: true
        - type:
            - 'null'
            - boolean
          label: dont_do_mapping
          'sbg:x': 83
          'sbg:y': 199
          id: '#dont_do_mapping'
          required: false
          'sbg:includeInPorts': true
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:revision': 2
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      'sbg:latestRevision': 2
      'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
      outputs:
        - type:
            - 'null'
            - File
          label: map_file
          'sbg:x': 1145.2631578947369
          'sbg:y': 170.52628366570724
          source:
            - '#KN_Mapper.output_file'
          id: '#output_file_1'
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - File
          label: output_file
          'sbg:x': 1148.9473684210527
          'sbg:y': 360.105269582648
          source:
            - '#Map_Names.output_file'
          id: '#output_file'
          required: false
          'sbg:includeInPorts': true
      'sbg:canvas_y': 0
      class: Workflow
      hints: []
      requirements: []
      steps:
        - 'sbg:x': 495
          'sbg:y': 171
          id: '#KN_Mapper'
          inputs:
            - id: '#KN_Mapper.taxon'
              source:
                - '#taxon'
            - id: '#KN_Mapper.source_hint'
              source:
                - '#source_hint'
            - id: '#KN_Mapper.redis_port'
            - id: '#KN_Mapper.redis_pass'
            - id: '#KN_Mapper.redis_host'
            - id: '#KN_Mapper.output_name'
            - id: '#KN_Mapper.input_file'
              source:
                - '#input_file'
            - id: '#KN_Mapper.dont_do_mapping'
              source:
                - '#dont_do_mapping'
            - id: '#KN_Mapper.dont_cut_first_line'
          run:
            'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            arguments: []
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:contributors':
              - mepstein
            'sbg:createdOn': 1524681212
            'sbg:job':
              inputs:
                redis_host: redis_host-string-value
                source_hint: source_hint-string-value
                output_name: output_name-string-value
                redis_pass: redis_pass-string-value
                taxon: taxon-string-value
                redis_port: redis_port-string-value
                dont_do_mapping: true
                input_file:
                  class: File
                  size: 0
                  path: /path/to/input_file.ext
                  secondaryFiles: []
                dont_cut_first_line: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:revisionsInfo':
              - 'sbg:modifiedOn': 1524681212
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:revision': 0
              - 'sbg:modifiedOn': 1524681994
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:revision': 1
              - 'sbg:modifiedOn': 1524687186
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Fixed typo in tail command in kn_mapper.sh.
                'sbg:revision': 2
              - 'sbg:modifiedOn': 1524842883
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added dont_do_mapping input/behavior.
                'sbg:revision': 3
            inputs:
              - type:
                  - 'null'
                  - string
                label: Species Taxon ID
                description: The species taxon id
                id: '#taxon'
                inputBinding:
                  separate: true
                  prefix: '-t'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: false
              - type:
                  - 'null'
                  - string
                label: Source Hint
                description: The source hint
                id: '#source_hint'
                inputBinding:
                  separate: true
                  prefix: '-s'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: false
              - type:
                  - 'null'
                  - string
                id: '#redis_port'
                inputBinding:
                  separate: true
                  prefix: '-p'
                  'sbg:cmdInclude': true
                description: The redis port
                label: Redis Port
              - type:
                  - 'null'
                  - string
                id: '#redis_pass'
                inputBinding:
                  separate: true
                  prefix: '-P'
                  'sbg:cmdInclude': true
                description: The redis password
                label: Redis Password
              - type:
                  - 'null'
                  - string
                id: '#redis_host'
                inputBinding:
                  separate: true
                  prefix: '-h'
                  'sbg:cmdInclude': true
                description: The redis host
                label: Redis Host
              - type:
                  - 'null'
                  - string
                id: '#output_name'
                inputBinding:
                  separate: true
                  prefix: '-o'
                  'sbg:cmdInclude': true
                description: The output file name
                label: Output Filename
              - type:
                  - File
                label: Input File
                description: The input file
                id: '#input_file'
                inputBinding:
                  separate: true
                  prefix: '-i'
                  'sbg:cmdInclude': true
                required: true
              - type:
                  - 'null'
                  - boolean
                label: Dont Do Mapping Flag
                'sbg:stageInput': null
                description: >-
                  If present, the names won't be mapped, instead a dummy map
                  (with the two columns identical) will be created
                id: '#dont_do_mapping'
                inputBinding:
                  separate: true
                  prefix: '-n'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: false
              - type:
                  - 'null'
                  - boolean
                label: Dont Cut First Line Flag
                'sbg:stageInput': null
                description: >-
                  If the input file is a list of gene names rather than a
                  genomic spreadsheet, you might want to use this (i.e., the
                  first line won't be column headers)
                id: '#dont_cut_first_line'
                inputBinding:
                  separate: true
                  prefix: '-F'
                  'sbg:cmdInclude': true
            'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:revision': 3
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            'sbg:appVersion':
              - 'sbg:draft-2'
            id: mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            'sbg:latestRevision': 3
            'sbg:revisionNotes': Added dont_do_mapping input/behavior.
            outputs:
              - type:
                  - 'null'
                  - File
                id: '#output_file'
                description: The output file (the gene name map)
                outputBinding:
                  glob: names.node_map.txt
                label: The Output File
            label: KN Mapper
            stdin: ''
            baseCommand:
              - sh
              - kn_mapper.sh
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerImageId: ''
                class: DockerRequirement
                dockerPull: 'knoweng/kn_mapper:latest'
            requirements:
              - fileDef:
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
                class: CreateFileRequirement
            temporaryFailCodes: []
            'sbg:modifiedOn': 1524842883
            x: 495
            'sbg:publisher': sbg
            cwlVersion: 'sbg:draft-2'
            'sbg:image_url': null
            'sbg:validationErrors': []
            'y': 171
            description: Map the genes in a spreadsheet/file.
            stdout: ''
            successCodes: []
            'sbg:createdBy': mepstein
            class: CommandLineTool
            'sbg:sbgMaintained': false
          outputs:
            - id: '#KN_Mapper.output_file'
        - 'sbg:x': 782
          'sbg:y': 361
          id: '#Map_Names'
          inputs:
            - id: '#Map_Names.switch_mapped_order'
              default: true
            - id: '#Map_Names.output_filename'
              source:
                - '#output_filename'
            - id: '#Map_Names.names_are_columns'
            - id: '#Map_Names.map_file'
              source:
                - '#KN_Mapper.output_file'
            - id: '#Map_Names.input_file'
              source:
                - '#input_file'
            - id: '#Map_Names.drop_unmapped_names'
              default: true
          run:
            'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
            arguments: []
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:contributors':
              - mepstein
            'sbg:createdOn': 1522285864
            'sbg:job':
              inputs:
                output_filename: output_filename-string-value
                input_file:
                  class: File
                  size: 0
                  path: /path/to/input_file.ext
                  secondaryFiles: []
                map_file:
                  class: File
                  size: 0
                  path: /path/to/map_file.ext
                  secondaryFiles: []
                drop_unmapped_names: true
                names_are_columns: true
                switch_mapped_order: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:revisionsInfo':
              - 'sbg:modifiedOn': 1522285864
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:revision': 0
              - 'sbg:modifiedOn': 1522286794
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:revision': 1
              - 'sbg:modifiedOn': 1522286850
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Modified name.
                'sbg:revision': 2
              - 'sbg:modifiedOn': 1522288616
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Changed container.
                'sbg:revision': 3
              - 'sbg:modifiedOn': 1524714160
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified map_names.py to add drop_unmapped_names option; added
                  drop_unmapped_names input.
                'sbg:revision': 4
              - 'sbg:modifiedOn': 1524716022
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
                'sbg:revision': 5
            inputs:
              - type:
                  - 'null'
                  - boolean
                label: Switch Mapped Order
                'sbg:stageInput': null
                description: >-
                  If present, the order in the map file is original name/mapped
                  name
                id: '#switch_mapped_order'
                inputBinding:
                  separate: true
                  prefix: '-s'
                  'sbg:cmdInclude': true
              - type:
                  - string
                label: Output Filename
                description: Output Filename
                id: '#output_filename'
                inputBinding:
                  separate: true
                  prefix: '-o'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: true
              - type:
                  - 'null'
                  - boolean
                label: Names are Columns
                'sbg:stageInput': null
                description: >-
                  If present, the names to be mapped in the input file are
                  columns, not rows
                id: '#names_are_columns'
                inputBinding:
                  separate: true
                  prefix: '-c'
                  'sbg:cmdInclude': true
              - type:
                  - File
                label: Map File
                description: >-
                  Map files with orginal/mapped names in first two columns
                  (default is mapped in first, original in second)
                id: '#map_file'
                inputBinding:
                  separate: true
                  prefix: '-m'
                  'sbg:cmdInclude': true
                required: true
              - type:
                  - File
                label: Input File
                description: Input file to be mapped
                id: '#input_file'
                inputBinding:
                  separate: true
                  prefix: '-i'
                  'sbg:cmdInclude': true
                required: true
              - type:
                  - 'null'
                  - boolean
                id: '#drop_unmapped_names'
                inputBinding:
                  separate: true
                  prefix: '-u'
                  'sbg:cmdInclude': true
                description: 'If present, any names that are unmapped will be dropped'
                label: Drop Unmapped Names Flag
            'sbg:cmdPreview': >-
              python3 map_names.py -i /path/to/input_file.ext -m
              /path/to/map_file.ext -o output_filename-string-value
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:revision': 5
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            'sbg:appVersion':
              - 'sbg:draft-2'
            id: mepstein/knoweng-signature-analysis-dev/map-names/5
            'sbg:latestRevision': 5
            'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
            outputs:
              - type:
                  - 'null'
                  - File
                id: '#output_file'
                description: Output File
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    script: $job.inputs.output_filename
                    class: Expression
                label: Output File
            label: Map Names
            stdin: ''
            baseCommand:
              - python3
              - map_names.py
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerImageId: ''
                class: DockerRequirement
                dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
            requirements:
              - fileDef:
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
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                class: ExpressionEngineRequirement
                requirements:
                  - class: DockerRequirement
                    dockerPull: rabix/js-engine
            temporaryFailCodes: []
            'sbg:modifiedOn': 1524716022
            x: 782
            'sbg:publisher': sbg
            cwlVersion: 'sbg:draft-2'
            'sbg:image_url': null
            'sbg:validationErrors': []
            'y': 361
            description: Map the names in the input file based on the map file.
            stdout: ''
            successCodes: []
            'sbg:createdBy': mepstein
            class: CommandLineTool
            'sbg:sbgMaintained': false
          outputs:
            - id: '#Map_Names.output_file'
      'sbg:modifiedOn': 1526497729
      x: 431
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/mapper-workflow/2.png
      'sbg:validationErrors': []
      'y': 75.99999999999999
      'sbg:canvas_x': 0
      'sbg:canvas_zoom': 0.95
      label: Mapper Workflow
      'sbg:sbgMaintained': false
      'sbg:createdBy': mepstein
    inputs:
      - id: '#Mapper_Workflow.taxon'
        source:
          - '#taxonid'
      - id: '#Mapper_Workflow.source_hint'
      - id: '#Mapper_Workflow.output_filename'
        default: samples_mapped.tsv
      - id: '#Mapper_Workflow.input_file'
        source:
          - '#samples_file'
      - id: '#Mapper_Workflow.dont_do_mapping'
        source:
          - '#dont_map_samples'
    id: '#Mapper_Workflow'
    outputs:
      - id: '#Mapper_Workflow.output_file_1'
      - id: '#Mapper_Workflow.output_file'
  - 'sbg:x': 433.00000000000006
    'sbg:y': 353.99999999999994
    run:
      'sbg:id': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1524843132
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1524843462
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1526497729
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
          'sbg:revision': 2
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1524843132
      description: ''
      inputs:
        - type:
            - 'null'
            - string
          label: taxon
          'sbg:x': 81
          'sbg:y': 326
          id: '#taxon'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - string
          label: source_hint
          'sbg:x': 86
          'sbg:y': 464
          id: '#source_hint'
          required: false
          'sbg:includeInPorts': true
        - type:
            - string
          label: output_filename
          'sbg:x': 87
          'sbg:y': 596
          id: '#output_filename'
          required: true
          'sbg:includeInPorts': true
        - type:
            - File
          label: input_file
          'sbg:x': 80
          'sbg:y': 62
          id: '#input_file'
          required: true
        - type:
            - 'null'
            - boolean
          label: dont_do_mapping
          'sbg:x': 83
          'sbg:y': 199
          id: '#dont_do_mapping'
          required: false
          'sbg:includeInPorts': true
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:revision': 2
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
      'sbg:latestRevision': 2
      'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
      outputs:
        - type:
            - 'null'
            - File
          label: map_file
          'sbg:x': 1145.2631578947369
          'sbg:y': 170.52628366570724
          source:
            - '#KN_Mapper.output_file'
          id: '#output_file_1'
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - File
          label: output_file
          'sbg:x': 1148.9473684210527
          'sbg:y': 360.105269582648
          source:
            - '#Map_Names.output_file'
          id: '#output_file'
          required: false
          'sbg:includeInPorts': true
      'sbg:canvas_y': 0
      class: Workflow
      hints: []
      requirements: []
      steps:
        - 'sbg:x': 495
          'sbg:y': 171
          id: '#KN_Mapper'
          inputs:
            - id: '#KN_Mapper.taxon'
              source:
                - '#taxon'
            - id: '#KN_Mapper.source_hint'
              source:
                - '#source_hint'
            - id: '#KN_Mapper.redis_port'
            - id: '#KN_Mapper.redis_pass'
            - id: '#KN_Mapper.redis_host'
            - id: '#KN_Mapper.output_name'
            - id: '#KN_Mapper.input_file'
              source:
                - '#input_file'
            - id: '#KN_Mapper.dont_do_mapping'
              source:
                - '#dont_do_mapping'
            - id: '#KN_Mapper.dont_cut_first_line'
          run:
            'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            arguments: []
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:contributors':
              - mepstein
            'sbg:createdOn': 1524681212
            'sbg:job':
              inputs:
                redis_host: redis_host-string-value
                source_hint: source_hint-string-value
                output_name: output_name-string-value
                redis_pass: redis_pass-string-value
                taxon: taxon-string-value
                redis_port: redis_port-string-value
                dont_do_mapping: true
                input_file:
                  class: File
                  size: 0
                  path: /path/to/input_file.ext
                  secondaryFiles: []
                dont_cut_first_line: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:revisionsInfo':
              - 'sbg:modifiedOn': 1524681212
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:revision': 0
              - 'sbg:modifiedOn': 1524681994
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:revision': 1
              - 'sbg:modifiedOn': 1524687186
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Fixed typo in tail command in kn_mapper.sh.
                'sbg:revision': 2
              - 'sbg:modifiedOn': 1524842883
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added dont_do_mapping input/behavior.
                'sbg:revision': 3
            inputs:
              - type:
                  - 'null'
                  - string
                label: Species Taxon ID
                description: The species taxon id
                id: '#taxon'
                inputBinding:
                  separate: true
                  prefix: '-t'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: false
              - type:
                  - 'null'
                  - string
                label: Source Hint
                description: The source hint
                id: '#source_hint'
                inputBinding:
                  separate: true
                  prefix: '-s'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: false
              - type:
                  - 'null'
                  - string
                id: '#redis_port'
                inputBinding:
                  separate: true
                  prefix: '-p'
                  'sbg:cmdInclude': true
                description: The redis port
                label: Redis Port
              - type:
                  - 'null'
                  - string
                id: '#redis_pass'
                inputBinding:
                  separate: true
                  prefix: '-P'
                  'sbg:cmdInclude': true
                description: The redis password
                label: Redis Password
              - type:
                  - 'null'
                  - string
                id: '#redis_host'
                inputBinding:
                  separate: true
                  prefix: '-h'
                  'sbg:cmdInclude': true
                description: The redis host
                label: Redis Host
              - type:
                  - 'null'
                  - string
                id: '#output_name'
                inputBinding:
                  separate: true
                  prefix: '-o'
                  'sbg:cmdInclude': true
                description: The output file name
                label: Output Filename
              - type:
                  - File
                label: Input File
                description: The input file
                id: '#input_file'
                inputBinding:
                  separate: true
                  prefix: '-i'
                  'sbg:cmdInclude': true
                required: true
              - type:
                  - 'null'
                  - boolean
                label: Dont Do Mapping Flag
                'sbg:stageInput': null
                description: >-
                  If present, the names won't be mapped, instead a dummy map
                  (with the two columns identical) will be created
                id: '#dont_do_mapping'
                inputBinding:
                  separate: true
                  prefix: '-n'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: false
              - type:
                  - 'null'
                  - boolean
                label: Dont Cut First Line Flag
                'sbg:stageInput': null
                description: >-
                  If the input file is a list of gene names rather than a
                  genomic spreadsheet, you might want to use this (i.e., the
                  first line won't be column headers)
                id: '#dont_cut_first_line'
                inputBinding:
                  separate: true
                  prefix: '-F'
                  'sbg:cmdInclude': true
            'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:revision': 3
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            'sbg:appVersion':
              - 'sbg:draft-2'
            id: mepstein/knoweng-signature-analysis-dev/kn-mapper/3
            'sbg:latestRevision': 3
            'sbg:revisionNotes': Added dont_do_mapping input/behavior.
            outputs:
              - type:
                  - 'null'
                  - File
                id: '#output_file'
                description: The output file (the gene name map)
                outputBinding:
                  glob: names.node_map.txt
                label: The Output File
            label: KN Mapper
            stdin: ''
            baseCommand:
              - sh
              - kn_mapper.sh
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerImageId: ''
                class: DockerRequirement
                dockerPull: 'knoweng/kn_mapper:latest'
            requirements:
              - fileDef:
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
                class: CreateFileRequirement
            temporaryFailCodes: []
            'sbg:modifiedOn': 1524842883
            x: 495
            'sbg:publisher': sbg
            cwlVersion: 'sbg:draft-2'
            'sbg:image_url': null
            'sbg:validationErrors': []
            'y': 171
            description: Map the genes in a spreadsheet/file.
            stdout: ''
            successCodes: []
            'sbg:createdBy': mepstein
            class: CommandLineTool
            'sbg:sbgMaintained': false
          outputs:
            - id: '#KN_Mapper.output_file'
        - 'sbg:x': 782
          'sbg:y': 361
          id: '#Map_Names'
          inputs:
            - id: '#Map_Names.switch_mapped_order'
              default: true
            - id: '#Map_Names.output_filename'
              source:
                - '#output_filename'
            - id: '#Map_Names.names_are_columns'
            - id: '#Map_Names.map_file'
              source:
                - '#KN_Mapper.output_file'
            - id: '#Map_Names.input_file'
              source:
                - '#input_file'
            - id: '#Map_Names.drop_unmapped_names'
              default: true
          run:
            'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
            arguments: []
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:contributors':
              - mepstein
            'sbg:createdOn': 1522285864
            'sbg:job':
              inputs:
                output_filename: output_filename-string-value
                input_file:
                  class: File
                  size: 0
                  path: /path/to/input_file.ext
                  secondaryFiles: []
                map_file:
                  class: File
                  size: 0
                  path: /path/to/map_file.ext
                  secondaryFiles: []
                drop_unmapped_names: true
                names_are_columns: true
                switch_mapped_order: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:revisionsInfo':
              - 'sbg:modifiedOn': 1522285864
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:revision': 0
              - 'sbg:modifiedOn': 1522286794
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Initial version.
                'sbg:revision': 1
              - 'sbg:modifiedOn': 1522286850
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Modified name.
                'sbg:revision': 2
              - 'sbg:modifiedOn': 1522288616
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Changed container.
                'sbg:revision': 3
              - 'sbg:modifiedOn': 1524714160
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified map_names.py to add drop_unmapped_names option; added
                  drop_unmapped_names input.
                'sbg:revision': 4
              - 'sbg:modifiedOn': 1524716022
                'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
                'sbg:revision': 5
            inputs:
              - type:
                  - 'null'
                  - boolean
                label: Switch Mapped Order
                'sbg:stageInput': null
                description: >-
                  If present, the order in the map file is original name/mapped
                  name
                id: '#switch_mapped_order'
                inputBinding:
                  separate: true
                  prefix: '-s'
                  'sbg:cmdInclude': true
              - type:
                  - string
                label: Output Filename
                description: Output Filename
                id: '#output_filename'
                inputBinding:
                  separate: true
                  prefix: '-o'
                  'sbg:cmdInclude': true
                'sbg:includeInPorts': true
                required: true
              - type:
                  - 'null'
                  - boolean
                label: Names are Columns
                'sbg:stageInput': null
                description: >-
                  If present, the names to be mapped in the input file are
                  columns, not rows
                id: '#names_are_columns'
                inputBinding:
                  separate: true
                  prefix: '-c'
                  'sbg:cmdInclude': true
              - type:
                  - File
                label: Map File
                description: >-
                  Map files with orginal/mapped names in first two columns
                  (default is mapped in first, original in second)
                id: '#map_file'
                inputBinding:
                  separate: true
                  prefix: '-m'
                  'sbg:cmdInclude': true
                required: true
              - type:
                  - File
                label: Input File
                description: Input file to be mapped
                id: '#input_file'
                inputBinding:
                  separate: true
                  prefix: '-i'
                  'sbg:cmdInclude': true
                required: true
              - type:
                  - 'null'
                  - boolean
                id: '#drop_unmapped_names'
                inputBinding:
                  separate: true
                  prefix: '-u'
                  'sbg:cmdInclude': true
                description: 'If present, any names that are unmapped will be dropped'
                label: Drop Unmapped Names Flag
            'sbg:cmdPreview': >-
              python3 map_names.py -i /path/to/input_file.ext -m
              /path/to/map_file.ext -o output_filename-string-value
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:revision': 5
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            'sbg:appVersion':
              - 'sbg:draft-2'
            id: mepstein/knoweng-signature-analysis-dev/map-names/5
            'sbg:latestRevision': 5
            'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
            outputs:
              - type:
                  - 'null'
                  - File
                id: '#output_file'
                description: Output File
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    script: $job.inputs.output_filename
                    class: Expression
                label: Output File
            label: Map Names
            stdin: ''
            baseCommand:
              - python3
              - map_names.py
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerImageId: ''
                class: DockerRequirement
                dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
            requirements:
              - fileDef:
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
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                class: ExpressionEngineRequirement
                requirements:
                  - class: DockerRequirement
                    dockerPull: rabix/js-engine
            temporaryFailCodes: []
            'sbg:modifiedOn': 1524716022
            x: 782
            'sbg:publisher': sbg
            cwlVersion: 'sbg:draft-2'
            'sbg:image_url': null
            'sbg:validationErrors': []
            'y': 361
            description: Map the names in the input file based on the map file.
            stdout: ''
            successCodes: []
            'sbg:createdBy': mepstein
            class: CommandLineTool
            'sbg:sbgMaintained': false
          outputs:
            - id: '#Map_Names.output_file'
      'sbg:modifiedOn': 1526497729
      x: 433.00000000000006
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/mapper-workflow/2.png
      'sbg:validationErrors': []
      'y': 353.99999999999994
      'sbg:canvas_x': 0
      'sbg:canvas_zoom': 0.95
      label: Mapper Workflow
      'sbg:sbgMaintained': false
      'sbg:createdBy': mepstein
    inputs:
      - id: '#Mapper_Workflow_1.taxon'
        source:
          - '#taxonid'
      - id: '#Mapper_Workflow_1.source_hint'
      - id: '#Mapper_Workflow_1.output_filename'
        default: signatures_mapped.tsv
      - id: '#Mapper_Workflow_1.input_file'
        source:
          - '#signatures_file'
      - id: '#Mapper_Workflow_1.dont_do_mapping'
        source:
          - '#dont_map_signatures'
    id: '#Mapper_Workflow_1'
    outputs:
      - id: '#Mapper_Workflow_1.output_file_1'
      - id: '#Mapper_Workflow_1.output_file'
  - 'sbg:x': 940.9999999999999
    'sbg:y': 427
    run:
      'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis/13
      arguments: []
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1520542501
      'sbg:job':
        inputs:
          bootstrap_sample_percent: 80
          parallelism: 4
          network_file:
            class: File
            size: 0
            path: /path/to/network_file.ext
            secondaryFiles: []
          network_influence_percent: 50
          spreadsheet_file:
            class: File
            size: 0
            path: /path/to/spreadsheet_file.ext
            secondaryFiles: []
          signature_file:
            class: File
            size: 0
            path: /path/to/signature_file.ext
            secondaryFiles: []
          num_bootstraps: 0
          use_network: false
          processing_method: serial
          similarity_measure: spearman
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1520542501
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1520544005
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1520544423
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed glob value on results file.
          'sbg:revision': 2
        - 'sbg:modifiedOn': 1520577053
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified the default behavior (with regard to certain inputs).
          'sbg:revision': 3
        - 'sbg:modifiedOn': 1521661999
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Modified run_sa.cmd javascript to run SA in only one mode
            (non-network, non-bootstrapping); added similarity map binary matrix
            output.
          'sbg:revision': 4
        - 'sbg:modifiedOn': 1522291013
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified mbm.py to handle empty spreadsheets.
          'sbg:revision': 5
        - 'sbg:modifiedOn': 1524106105
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated version of SAP container.
          'sbg:revision': 6
        - 'sbg:modifiedOn': 1526407664
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated a few things (docker container, output for binary similarity
            matrix, ...).
          'sbg:revision': 7
        - 'sbg:modifiedOn': 1526482172
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added outputs for clean samples and signatures files.
          'sbg:revision': 8
        - 'sbg:modifiedOn': 1526484932
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified documentation to include new similar measure (pearson).
          'sbg:revision': 9
        - 'sbg:modifiedOn': 1526486122
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed js syntax error (missing +).
          'sbg:revision': 10
        - 'sbg:modifiedOn': 1526540717
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added call to wget.py.
          'sbg:revision': 11
        - 'sbg:modifiedOn': 1526540795
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added readme output file.
          'sbg:revision': 12
        - 'sbg:modifiedOn': 1526542156
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Changed how wget.py called on command line.
          'sbg:revision': 13
      inputs:
        - type:
            - 'null'
            - boolean
          id: '#use_network'
          description: Whether to use the network
          'sbg:stageInput': null
          label: Use Network Flag
        - type:
            - 'null'
            - File
          label: Spreadsheet File
          description: The input spreadsheet file
          id: '#spreadsheet_file'
          required: false
        - type:
            - 'null'
            - type: enum
              name: similarity_measure
              symbols:
                - cosine
                - pearson
                - spearman
          label: Similarity Measure
          description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
          id: '#similarity_measure'
          'sbg:includeInPorts': true
          required: false
        - type:
            - 'null'
            - File
          label: Signature File
          description: The input signature file
          id: '#signature_file'
          required: false
        - type:
            - 'null'
            - type: enum
              name: processing_method
              symbols:
                - serial
                - parallel
          label: The processing method
          'sbg:toolDefaultValue': serial
          'sbg:stageInput': null
          description: 'The processing method (e.g., serial or parallel, default: serial)'
          id: '#processing_method'
        - type:
            - 'null'
            - int
          label: parallelism
          'sbg:toolDefaultValue': '4'
          'sbg:stageInput': null
          description: 'The parallelism (if the processing method is parallel; default: 4)'
          id: '#parallelism'
        - type:
            - 'null'
            - int
          label: Number of Bootstraps
          'sbg:toolDefaultValue': '0'
          'sbg:stageInput': null
          description: 'The number of bootstraps (default: 0)'
          id: '#num_bootstraps'
        - type:
            - 'null'
            - int
          label: Amount of Network Influence
          'sbg:toolDefaultValue': '50'
          'sbg:stageInput': null
          description: >-
            The amount of network influence (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          id: '#network_influence_percent'
        - type:
            - 'null'
            - File
          label: Knowledge Network File
          description: The knowledge network file
          id: '#network_file'
          required: false
        - type:
            - 'null'
            - int
          label: Bootstrap Sample Percent
          'sbg:toolDefaultValue': '80'
          'sbg:stageInput': null
          description: 'The bootstrap sample percent (default: 80%)'
          id: '#bootstrap_sample_percent'
      'sbg:cmdPreview': >-
        sh run_sa.cmd && cp -pr result*.tsv similarity_matrix.tsv && cp -pr
        Gene_to_TF_Association*.tsv similarity_matrix.binary.tsv && python3
        wget.py
        https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SA.md
        README-SA.md
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:revision': 13
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/signature-analysis/13
      'sbg:latestRevision': 13
      'sbg:revisionNotes': Changed how wget.py called on command line.
      outputs:
        - type:
            - 'null'
            - File
          id: '#similarity_matrix_binary'
          description: The signature similarity matrix (binary; one 1 per row/gene/feature)
          outputBinding:
            glob: similarity_matrix.binary.tsv
          label: Similarity Matrix Binary
        - type:
            - 'null'
            - File
          id: '#similarity_matrix'
          description: The signature similarity results
          outputBinding:
            glob: similarity_matrix.tsv
          label: Similarity Matrix
        - type:
            - 'null'
            - File
          id: '#run_params_yml'
          description: The Signature Analysis parameters
          outputBinding:
            glob: run_params.yml
          label: SA Parameters File
        - type:
            - 'null'
            - File
          id: '#readme'
          description: The README file that describes the output files
          outputBinding:
            glob: README-SA.md
          label: The README file
        - type:
            - 'null'
            - File
          id: '#clean_signatures_file'
          description: The clean signatures file
          outputBinding:
            glob: clean_signatures_matrix.tsv
          label: Clean Signatures File
        - type:
            - 'null'
            - File
          id: '#clean_samples_file'
          description: The clean samples file
          outputBinding:
            glob: clean_samples_matrix.tsv
          label: Clean Samples File
      label: Signature Analysis
      stdin: ''
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
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - dockerImageId: ''
          class: DockerRequirement
          dockerPull: 'knowengdev/signature_analysis_pipeline:05_10_2018'
      requirements:
        - fileDef:
            - fileContent:
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

                class: Expression
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
          class: CreateFileRequirement
        - id: '#cwl-js-engine'
          class: ExpressionEngineRequirement
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      temporaryFailCodes: []
      'sbg:modifiedOn': 1526542156
      x: 940.9999999999999
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 427
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
      successCodes: []
      'sbg:createdBy': mepstein
      class: CommandLineTool
      'sbg:sbgMaintained': false
    inputs:
      - id: '#Signature_Analysis.use_network'
        default: false
      - id: '#Signature_Analysis.spreadsheet_file'
        source:
          - '#Data_Cleaning_Preprocessing.clean_genomic_file'
      - id: '#Signature_Analysis.similarity_measure'
        source:
          - '#similarity_measure'
      - id: '#Signature_Analysis.signature_file'
        source:
          - '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Signature_Analysis.processing_method'
      - id: '#Signature_Analysis.parallelism'
      - id: '#Signature_Analysis.num_bootstraps'
        default: 0
      - id: '#Signature_Analysis.network_influence_percent'
      - id: '#Signature_Analysis.network_file'
      - id: '#Signature_Analysis.bootstrap_sample_percent'
    id: '#Signature_Analysis'
    outputs:
      - id: '#Signature_Analysis.similarity_matrix_binary'
      - id: '#Signature_Analysis.similarity_matrix'
      - id: '#Signature_Analysis.run_params_yml'
      - id: '#Signature_Analysis.readme'
      - id: '#Signature_Analysis.clean_signatures_file'
      - id: '#Signature_Analysis.clean_samples_file'
  - 'sbg:x': 867.0588235294119
    'sbg:y': 71.76470588235296
    run:
      'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
      arguments: []
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1526539333
      'sbg:job':
        inputs:
          gene_map1_in:
            class: File
            size: 0
            path: /path/to/gene_map1_in.ext
            secondaryFiles: []
          gene_map2_in:
            class: File
            size: 0
            path: /path/to/gene_map2_in.ext
            secondaryFiles: []
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1526539333
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1526540443
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1526542055
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Changed how shell script called in renamer.sh.
          'sbg:revision': 2
        - 'sbg:modifiedOn': 1526570997
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
          'sbg:revision': 3
      inputs:
        - label: Gene Map File 2 Input
          type:
            - 'null'
            - File
          description: Gene Map File 2 Input
          id: '#gene_map2_in'
          required: false
        - label: Gene Map File 1 Input
          type:
            - 'null'
            - File
          description: Gene Map File 1 Input
          id: '#gene_map1_in'
          required: false
      'sbg:cmdPreview': sh renamer.sh
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:revision': 3
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      id: mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
      'sbg:latestRevision': 3
      'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
      outputs:
        - type:
            - 'null'
            - File
          id: '#gene_map_file_out'
          description: The gene map file
          outputBinding:
            glob: gene_map.txt
          label: Gene Map File
      label: Signature Analysis Renamer
      stdin: ''
      baseCommand:
        - sh
        - renamer.sh
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - dockerImageId: ''
          class: DockerRequirement
          dockerPull: ubuntu
      requirements:
        - fileDef:
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
                class: Expression
              filename: renamer.sh
          class: CreateFileRequirement
        - id: '#cwl-js-engine'
          class: ExpressionEngineRequirement
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      temporaryFailCodes: []
      'sbg:modifiedOn': 1526570997
      x: 867.0588235294119
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 71.76470588235296
      description: ''
      stdout: ''
      successCodes: []
      'sbg:createdBy': mepstein
      class: CommandLineTool
      'sbg:sbgMaintained': false
    inputs:
      - id: '#Signature_Analysis_Renamer.gene_map2_in'
        source:
          - '#Mapper_Workflow_1.output_file_1'
      - id: '#Signature_Analysis_Renamer.gene_map1_in'
        source:
          - '#Mapper_Workflow.output_file_1'
    id: '#Signature_Analysis_Renamer'
    outputs:
      - id: '#Signature_Analysis_Renamer.gene_map_file_out'
'sbg:toolkitVersion': v1.0
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
cwlVersion: 'sbg:draft-2'
'sbg:canvas_x': 14
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:categories':
  - Analysis
'sbg:canvas_zoom': 0.8499999999999999
label: Signature Analysis Workflow
'sbg:toolkit': KnowEnG_CGC
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-public/signature-analysis-workflow/1/raw/
'sbg:id': mepstein/knoweng-signature-analysis-public/signature-analysis-workflow/1
'sbg:revision': 1
'sbg:modifiedOn': 1529392994
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529392936
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-public
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 1
'sbg:content_hash': null
