hints: []
inputs:
  - label: input_files
    'sbg:x': 68.73912904573523
    'sbg:y': 212.13042995204094
    'sbg:fileTypes': TXT
    id: '#input_files'
    type:
      - items: File
        name: input_files
        type: array
  - label: num_bootstraps
    'sbg:x': 416.52169199837255
    'sbg:y': 314.0869106011498
    'sbg:includeInPorts': true
    id: '#num_bootstraps'
    type:
      - 'null'
      - int
  - label: correlation_measure
    'sbg:x': 414.7825868098184
    'sbg:y': 434.78260789521454
    'sbg:includeInPorts': true
    id: '#correlation_method'
    type:
      - 'null'
      - string
  - label: edge_type_1
    'sbg:x': 126.08697192475077
    'sbg:y': 565.2071522929358
    'sbg:includeInPorts': true
    id: '#edge_type_1'
    type:
      - string
  - label: phenotype_column_str
    'sbg:x': 69.73912666695784
    'sbg:y': 72.82608644182602
    'sbg:includeInPorts': true
    id: '#phenotype_column_str'
    type:
      - string
  - label: phenotype_value_str
    'sbg:x': 64.34781995026972
    'sbg:y': -41.73912905024221
    'sbg:includeInPorts': true
    id: '#phenotype_value_str'
    type:
      - 'null'
      - string
'sbg:canvas_zoom': 1.1500000000000001
description: >-
  This workflow takes a set of gene expression files from the TCGA, a phenotype
  of interest, and a type of subnetwork from the KnowEnG Knowledge Network.  The
  workflow runs the network-guided ProGENI to produce a ranked list of genes for
  the phenotype
'sbg:projectName': KnowEnG_GenePrioritization_Dev
requirements: []
class: Workflow
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-geneprioritization-dev/gpworkflow/0.png
label: ProGENI For TCGA Workflow
'sbg:canvas_x': 99
steps:
  - inputs:
      - source:
          - '#KN_Spreadsheet_Preprocessor_1.output_matrix'
        id: '#ProGENI.spreadsheet_file'
      - source:
          - '#num_bootstraps'
        id: '#ProGENI.num_bootstraps'
      - source:
          - '#Knowledge_Network_Fetcher___draft_2.output_file'
        id: '#ProGENI.network_file'
      - source:
          - '#KN_Spreadsheet_Preprocessor.output_matrix'
        id: '#ProGENI.drug_response_file'
      - source:
          - '#correlation_method'
        id: '#ProGENI.correlation_method'
    outputs:
      - id: '#ProGENI.output_name'
    'sbg:x': 791.3043097404094
    run:
      'sbg:modifiedBy': charles_blatti
      inputs:
        - label: Spreadsheet File
          'sbg:stageInput': link
          id: '#spreadsheet_file'
          required: false
          type:
            - 'null'
            - File
        - label: Number of bootstraps
          'sbg:includeInPorts': true
          'sbg:stageInput': null
          id: '#num_bootstraps'
          required: false
          type:
            - 'null'
            - int
        - label: Network File
          'sbg:stageInput': link
          id: '#network_file'
          required: false
          type:
            - 'null'
            - File
        - label: Drug Response File
          'sbg:stageInput': link
          id: '#drug_response_file'
          required: false
          type:
            - 'null'
            - File
        - label: Correlation Method
          'sbg:includeInPorts': true
          id: '#correlation_method'
          required: false
          type:
            - 'null'
            - string
      'sbg:modifiedOn': 1484244101
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 791.3043097404094
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent: |-
                NETWORK_FILE=$1
                SPREADSHEET_FILE=$2
                DRUG_RESPONSE_FILE=$3
                CORRELATION_METHOD=$4
                NUM_BOOTSTRAPS=$5
                YMLNAME=$6
                echo "
                method: bootstrap_net_correlation
                correlation_method: $CORRELATION_METHOD
                gg_network_name_full_path: $NETWORK_FILE
                spreadsheet_name_full_path: $SPREADSHEET_FILE
                drug_response_full_path: $DRUG_RESPONSE_FILE
                results_directory: ./
                number_of_bootstraps: $NUM_BOOTSTRAPS
                rows_sampling_fraction: 1.0       
                cols_sampling_fraction: 0.9       
                rwr_max_iterations: 100
                rwr_convergence_tolerence: 1.0e-2
                rwr_restart_probability: 0.5       
                top_beta_of_sort: 100
                drop_method: drop_NA
                out_filename: bootstrap_net_correlation
                " > $YMLNAME
              filename: gp_ymler.sh
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments:
        - separate: true
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.network_file.name
        - separate: true
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.spreadsheet_file.name
        - separate: true
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.drug_response_file.name
        - separate: true
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.correlation_method
        - separate: true
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.num_bootstraps
        - separate: true
          valueFrom: run_params.yml
        - separate: true
          valueFrom: '&&'
        - separate: true
          valueFrom: python3
        - separate: true
          valueFrom: /home/src/gene_prioritization.py
        - prefix: '-run_directory'
          valueFrom: ./
          separate: true
        - prefix: '-run_file'
          valueFrom: run_params.yml
          separate: true
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: ProGENI
      temporaryFailCodes: []
      'sbg:revisionNotes': change desc
      'sbg:cmdPreview': >-
        sh gp_ymler.sh        correlation_method-string-value  10 
        run_params.yml  &&  python3  /home/src/gene_prioritization.py
        -run_directory ./ -run_file run_params.yml
      baseCommand:
        - sh
        - gp_ymler.sh
      id: mepstein/geneprioritization/gene-prioritization/2
      'sbg:job':
        inputs:
          drug_response_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/drug_response_file.ext
          spreadsheet_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/spreadsheet_file.ext
          num_bootstraps: 10
          network_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/network_file.ext
          correlation_method: correlation_method-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        Network-guided gene prioritization method implementation by KnowEnG that
        ranks gene measurements by their correlation to observed phenotypes.
      outputs:
        - id: '#output_name'
          outputBinding:
            glob: '*bootstrap_net_correlation*'
          type:
            - 'null'
            - items: File
              type: array
      'sbg:revision': 2
      'sbg:latestRevision': 2
      'sbg:sbgMaintained': false
      'sbg:project': mepstein/geneprioritization
      class: CommandLineTool
      'sbg:image_url': null
      'y': 371.31792443072413
      'sbg:contributors':
        - mepstein
        - charles_blatti
      'sbg:id': mepstein/geneprioritization/gene-prioritization/2
      successCodes: []
      'sbg:createdOn': 1484243338
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of charles_blatti/geneprioritizationdemo/gene-prioritization/2
          'sbg:modifiedOn': 1484243338
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added description
          'sbg:modifiedOn': 1484243648
          'sbg:revision': 1
        - 'sbg:modifiedBy': charles_blatti
          'sbg:revisionNotes': change desc
          'sbg:modifiedOn': 1484244101
          'sbg:revision': 2
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'knowengdev/gene_prioritization_pipeline:01_05_2017'
          dockerImageId: ''
    'sbg:y': 371.31792443072413
    id: '#ProGENI'
  - inputs:
      - id: '#Knowledge_Network_Fetcher___draft_2.taxon'
        default: '9606'
      - id: '#Knowledge_Network_Fetcher___draft_2.output_name'
        default: subnetwork.edge
      - id: '#Knowledge_Network_Fetcher___draft_2.network_type'
        default: Gene
      - source:
          - '#edge_type_1'
        id: '#Knowledge_Network_Fetcher___draft_2.edge_type'
      - id: '#Knowledge_Network_Fetcher___draft_2.bucket'
        default: KNsample
      - id: '#Knowledge_Network_Fetcher___draft_2.aws_secret_access_key'
        default: z1QYuHnp3IT9ajUrMXQo3ON0f4t4Uq58IjE0yLnJ
      - id: '#Knowledge_Network_Fetcher___draft_2.aws_access_key_id'
        default: AKIAIVLADKCGCVGHNLIA
    outputs:
      - id: '#Knowledge_Network_Fetcher___draft_2.output_file'
    'sbg:x': 450.4347338180694
    run:
      'sbg:modifiedBy': elehnert
      inputs:
        - label: Subnetwork Species ID
          id: '#taxon'
          default: '9606'
          description: the taxonomic id for the species of interest
          type:
            - string
        - label: Output Filename
          id: '#output_name'
          default: KN.4col.edge
          description: the output file name to save the contents of the key to
          type:
            - 'null'
            - string
        - label: Subnetwork Class
          id: '#network_type'
          default: Gene
          description: the type of subnetwork
          type:
            - 'null'
            - string
        - label: Subnetwork Edge Type
          description: the edge type keyword for the subnetwork of interest
          default: PPI_physical_association
          'sbg:includeInPorts': true
          id: '#edge_type'
          required: true
          type:
            - string
        - label: AWS S3 Bucket Name
          id: '#bucket'
          default: KNsample
          description: the aws s3 bucket
          type:
            - 'null'
            - string
        - label: AWS Secret Access Key
          id: '#aws_secret_access_key'
          description: the aws secrety access key
          type:
            - string
        - label: AWS Access Key ID
          id: '#aws_access_key_id'
          description: the aws access key id
          type:
            - string
      'sbg:modifiedOn': 1490213586
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 450.4347338180694
      requirements:
        - class: InlineJavascriptRequirement
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments:
        - prefix: '--access_key'
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.aws_access_key_id
          separate: true
        - prefix: '--secret_key'
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.aws_secret_access_key
          separate: true
        - valueFrom: get
        - valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: >-
              's3://' + $job.inputs.bucket + '/' + $job.inputs.network_type +
              '/' + $job.inputs.taxon + '/' + $job.inputs.edge_type + '/' +
              $job.inputs.taxon + '.' + $job.inputs.edge_type + '.edge'
        - valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.output_name
      'sbg:validationErrors': []
      'sbg:createdBy': elehnert
      label: Knowledge Network Fetcher - draft 2
      'sbg:revision': 3
      temporaryFailCodes: []
      'sbg:id': mepstein/geneprioritization/knowledge-network-fetcher/3
      'sbg:cmdPreview': >-
        s3cmd --access_key  --secret_key  get
        s3://undefined/undefined/undefined/undefined/undefined.undefined.edge
      'sbg:image_url': null
      id: mepstein/geneprioritization/knowledge-network-fetcher/3
      successCodes: []
      description: >-
        Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS
        S3 storage
      outputs:
        - label: Subnetwork Edge File
          id: '#output_file'
          description: 4 column format for subnetwork for single edge type and species
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: $job.inputs.output_name
          type:
            - File
      baseCommand:
        - s3cmd
      'sbg:latestRevision': 3
      'sbg:sbgMaintained': false
      'sbg:projectName': GenePrioritization
      class: CommandLineTool
      'sbg:project': mepstein/geneprioritization
      'y': 595.4720959799876
      'sbg:contributors':
        - elehnert
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:toolAuthor': KnowEnG
      'sbg:createdOn': 1490213114
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': elehnert
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1490213114
          'sbg:revision': 0
        - 'sbg:modifiedBy': elehnert
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1490213129
          'sbg:revision': 1
        - 'sbg:modifiedBy': elehnert
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1490213152
          'sbg:revision': 2
        - 'sbg:modifiedBy': elehnert
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1490213586
          'sbg:revision': 3
      hints:
        - class: DockerRequirement
          dockerPull: 'cblatti3/aws:0.1'
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'cblatti3/aws:0.1'
    'sbg:y': 595.4720959799876
    id: '#Knowledge_Network_Fetcher___draft_2'
  - inputs:
      - id: '#KN_Spreadsheet_Preprocessor.taxon'
        default: '9606'
      - id: '#KN_Spreadsheet_Preprocessor.spreadsheet_format'
        default: samples_x_phenotypes
      - id: '#KN_Spreadsheet_Preprocessor.output_name'
        default: clean_pheno_data
      - source:
          - '#Expression_Spreadsheet_Builder.metadata'
        id: '#KN_Spreadsheet_Preprocessor.input_file'
    outputs:
      - id: '#KN_Spreadsheet_Preprocessor.params_yml'
      - id: '#KN_Spreadsheet_Preprocessor.output_matrix'
    'sbg:x': 573.0434368292196
    run:
      'sbg:modifiedBy': mepstein
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          label: Species Taxon ID
          description: the taxonomic id for the species of interest
          id: '#taxon'
          type:
            - 'null'
            - string
        - label: Spreadsheet Format Type
          description: >-
            the keyword for different types of preprocessing, i.e
            genes_x_samples, genes_x_samples_check, or samples_x_phenotypes
          id: '#spreadsheet_format'
          type:
            - 'null'
            - string
        - label: Output Filename Prefix
          description: the output file name of the processes data frame
          id: '#output_name'
          type:
            - 'null'
            - string
        - label: Original Spreadsheet
          description: spreadsheet with row and column names
          'sbg:stageInput': link
          id: '#input_file'
          required: false
          type:
            - 'null'
            - File
      'sbg:modifiedOn': 1490991595
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 573.0434368292196
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent: |-
                INFILE=$1
                TAXON=$2
                SPTYPE=$3
                OUTNAME=$4
                YMLNAME=$5
                echo "
                spreadsheet_file_full_path: $INFILE
                taxon: '$TAXON'
                spreadsheet_format: $SPTYPE
                output_file_dataframe: $OUTNAME.df
                output_file_gene_map: $OUTNAME.genes.name_map
                output_file_metadata: $OUTNAME.metadata
                results_directory: ./
                input_delimiter: \",\"
                output_delimiter: \"\t\"
                redis_host: knowredis.knowhub.org
                redis_port: 6380
                redis_pass: KnowEnG
                gene_map_two_columns: False
                check_data: numeric_drop
                gene_map_first_column_orig: True
                output_orig_names: True
                source_hint: ''
                " > $YMLNAME
              filename: sp_ymler.sh
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments:
        - separate: true
          position: 1
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.input_file.name
        - separate: true
          position: 2
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.taxon
        - separate: true
          position: 3
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.spreadsheet_format
        - separate: true
          position: 5
          valueFrom: run_params.yml
        - separate: true
          position: 6
          valueFrom: '&& python3 /home/src/preprocess/spreadsheet_preprocess.py'
        - prefix: '-run_directory'
          separate: true
          position: 7
          valueFrom: ./
        - prefix: '-run_file'
          separate: true
          position: 8
          valueFrom: run_params.yml
        - separate: true
          position: 4
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.output_name
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: KN Spreadsheet Preprocessor
      'sbg:revision': 9
      temporaryFailCodes: []
      'sbg:revisionNotes': 'Fixed redis host name:port (knowredis.knowhub.org:6380).'
      'sbg:cmdPreview': >-
        sh sp_ymler.sh    taxon-string-value  spreadsheet_format-string-value 
        output_name-string-value  run_params.yml  && python3
        /home/src/preprocess/spreadsheet_preprocess.py -run_directory ./
        -run_file run_params.yml
      'sbg:image_url': null
      id: mepstein/geneprioritization/sp-pp-interface/9
      successCodes: []
      description: >-
        Transforms user spreadsheet in preparation for KN analytics by removing
        noise, mapping gene names, and extracting metadata statistics
      outputs:
        - label: Configuration Parameter File
          description: contains the values used in analysis
          id: '#params_yml'
          outputBinding:
            glob: run_params.yml
          type:
            - 'null'
            - File
        - label: Spreadsheet File
          description: Spreadsheet with columns and row headers
          id: '#output_matrix'
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: $job.inputs.output_name + '.df'
          type:
            - 'null'
            - File
      baseCommand:
        - sh
        - sp_ymler.sh
      'sbg:latestRevision': 9
      'sbg:sbgMaintained': false
      'sbg:projectName': GenePrioritization
      class: CommandLineTool
      'sbg:project': mepstein/geneprioritization
      'y': 72.18749711525916
      'sbg:contributors':
        - charles_blatti
        - mepstein
      'sbg:id': mepstein/geneprioritization/sp-pp-interface/9
      'sbg:job':
        inputs:
          input_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/input_file.ext
          output_name: output_name-string-value
          spreadsheet_format: spreadsheet_format-string-value
          taxon: taxon-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:toolAuthor': KnowEnG
      'sbg:createdOn': 1484243324
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of charles_blatti/geneprioritizationdemo/sp-pp-interface/7
          'sbg:modifiedOn': 1484243324
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified app name
          'sbg:modifiedOn': 1484243709
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1484243889
          'sbg:revision': 2
        - 'sbg:modifiedBy': charles_blatti
          'sbg:revisionNotes': change desc
          'sbg:modifiedOn': 1484244183
          'sbg:revision': 3
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added input_delimiter to ymler
          'sbg:modifiedOn': 1484255231
          'sbg:revision': 4
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified redis host
          'sbg:modifiedOn': 1484256105
          'sbg:revision': 5
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated docker tag (from 20170111 to 20170216).
          'sbg:modifiedOn': 1489182258
          'sbg:revision': 6
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated redis host/port info (knowredis.knowhub.org/6379).
          'sbg:modifiedOn': 1490818241
          'sbg:revision': 7
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated to use faster redis library/server.
          'sbg:modifiedOn': 1490989894
          'sbg:revision': 8
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Fixed redis host name:port (knowredis.knowhub.org:6380).'
          'sbg:modifiedOn': 1490991595
          'sbg:revision': 9
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'mepsteindr/spreadsheet_preprocess:20170331'
          dockerImageId: ''
    'sbg:y': 72.18749711525916
    id: '#KN_Spreadsheet_Preprocessor'
  - inputs:
      - id: '#KN_Spreadsheet_Preprocessor_1.taxon'
        default: '9606'
      - id: '#KN_Spreadsheet_Preprocessor_1.spreadsheet_format'
        default: genes_x_samples_check
      - id: '#KN_Spreadsheet_Preprocessor_1.output_name'
        default: clean_genomic_data
      - source:
          - '#Expression_Spreadsheet_Builder.gene'
        id: '#KN_Spreadsheet_Preprocessor_1.input_file'
    outputs:
      - id: '#KN_Spreadsheet_Preprocessor_1.params_yml'
      - id: '#KN_Spreadsheet_Preprocessor_1.output_matrix'
    'sbg:x': 572.1738068953804
    run:
      'sbg:modifiedBy': mepstein
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          label: Species Taxon ID
          description: the taxonomic id for the species of interest
          id: '#taxon'
          type:
            - 'null'
            - string
        - label: Spreadsheet Format Type
          description: >-
            the keyword for different types of preprocessing, i.e
            genes_x_samples, genes_x_samples_check, or samples_x_phenotypes
          id: '#spreadsheet_format'
          type:
            - 'null'
            - string
        - label: Output Filename Prefix
          description: the output file name of the processes data frame
          id: '#output_name'
          type:
            - 'null'
            - string
        - label: Original Spreadsheet
          description: spreadsheet with row and column names
          'sbg:stageInput': link
          id: '#input_file'
          required: false
          type:
            - 'null'
            - File
      'sbg:modifiedOn': 1490991595
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 572.1738068953804
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent: |-
                INFILE=$1
                TAXON=$2
                SPTYPE=$3
                OUTNAME=$4
                YMLNAME=$5
                echo "
                spreadsheet_file_full_path: $INFILE
                taxon: '$TAXON'
                spreadsheet_format: $SPTYPE
                output_file_dataframe: $OUTNAME.df
                output_file_gene_map: $OUTNAME.genes.name_map
                output_file_metadata: $OUTNAME.metadata
                results_directory: ./
                input_delimiter: \",\"
                output_delimiter: \"\t\"
                redis_host: knowredis.knowhub.org
                redis_port: 6380
                redis_pass: KnowEnG
                gene_map_two_columns: False
                check_data: numeric_drop
                gene_map_first_column_orig: True
                output_orig_names: True
                source_hint: ''
                " > $YMLNAME
              filename: sp_ymler.sh
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments:
        - separate: true
          position: 1
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.input_file.name
        - separate: true
          position: 2
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.taxon
        - separate: true
          position: 3
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.spreadsheet_format
        - separate: true
          position: 5
          valueFrom: run_params.yml
        - separate: true
          position: 6
          valueFrom: '&& python3 /home/src/preprocess/spreadsheet_preprocess.py'
        - prefix: '-run_directory'
          separate: true
          position: 7
          valueFrom: ./
        - prefix: '-run_file'
          separate: true
          position: 8
          valueFrom: run_params.yml
        - separate: true
          position: 4
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: $job.inputs.output_name
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: KN Spreadsheet Preprocessor
      'sbg:revision': 9
      temporaryFailCodes: []
      'sbg:revisionNotes': 'Fixed redis host name:port (knowredis.knowhub.org:6380).'
      'sbg:cmdPreview': >-
        sh sp_ymler.sh    taxon-string-value  spreadsheet_format-string-value 
        output_name-string-value  run_params.yml  && python3
        /home/src/preprocess/spreadsheet_preprocess.py -run_directory ./
        -run_file run_params.yml
      'sbg:image_url': null
      id: mepstein/geneprioritization/sp-pp-interface/9
      successCodes: []
      description: >-
        Transforms user spreadsheet in preparation for KN analytics by removing
        noise, mapping gene names, and extracting metadata statistics
      outputs:
        - label: Configuration Parameter File
          description: contains the values used in analysis
          id: '#params_yml'
          outputBinding:
            glob: run_params.yml
          type:
            - 'null'
            - File
        - label: Spreadsheet File
          description: Spreadsheet with columns and row headers
          id: '#output_matrix'
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: $job.inputs.output_name + '.df'
          type:
            - 'null'
            - File
      baseCommand:
        - sh
        - sp_ymler.sh
      'sbg:latestRevision': 9
      'sbg:sbgMaintained': false
      'sbg:projectName': GenePrioritization
      class: CommandLineTool
      'sbg:project': mepstein/geneprioritization
      'y': 200.88313890540078
      'sbg:contributors':
        - charles_blatti
        - mepstein
      'sbg:id': mepstein/geneprioritization/sp-pp-interface/9
      'sbg:job':
        inputs:
          input_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/input_file.ext
          output_name: output_name-string-value
          spreadsheet_format: spreadsheet_format-string-value
          taxon: taxon-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:toolAuthor': KnowEnG
      'sbg:createdOn': 1484243324
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of charles_blatti/geneprioritizationdemo/sp-pp-interface/7
          'sbg:modifiedOn': 1484243324
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified app name
          'sbg:modifiedOn': 1484243709
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1484243889
          'sbg:revision': 2
        - 'sbg:modifiedBy': charles_blatti
          'sbg:revisionNotes': change desc
          'sbg:modifiedOn': 1484244183
          'sbg:revision': 3
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added input_delimiter to ymler
          'sbg:modifiedOn': 1484255231
          'sbg:revision': 4
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified redis host
          'sbg:modifiedOn': 1484256105
          'sbg:revision': 5
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated docker tag (from 20170111 to 20170216).
          'sbg:modifiedOn': 1489182258
          'sbg:revision': 6
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated redis host/port info (knowredis.knowhub.org/6379).
          'sbg:modifiedOn': 1490818241
          'sbg:revision': 7
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated to use faster redis library/server.
          'sbg:modifiedOn': 1490989894
          'sbg:revision': 8
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Fixed redis host name:port (knowredis.knowhub.org:6380).'
          'sbg:modifiedOn': 1490991595
          'sbg:revision': 9
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'mepsteindr/spreadsheet_preprocess:20170331'
          dockerImageId: ''
    'sbg:y': 200.88313890540078
    id: '#KN_Spreadsheet_Preprocessor_1'
  - inputs:
      - source:
          - '#input_files'
        id: '#Expression_Spreadsheet_Builder.input_files'
      - id: '#Expression_Spreadsheet_Builder.output_filename'
        default: munger_out
      - source:
          - '#phenotype_column_str'
        id: '#Expression_Spreadsheet_Builder.phenotype_column_str'
      - source:
          - '#phenotype_value_str'
        id: '#Expression_Spreadsheet_Builder.phenotype_value_str'
    outputs:
      - id: '#Expression_Spreadsheet_Builder.gene'
      - id: '#Expression_Spreadsheet_Builder.case'
      - id: '#Expression_Spreadsheet_Builder.metadata'
      - id: '#Expression_Spreadsheet_Builder.index'
    'sbg:x': 322.6086928975153
    run:
      'sbg:modifiedBy': mepstein
      inputs:
        - label: Input Files
          id: '#input_files'
          description: Input array of TCGA Level 3 gene expression quantification files
          'sbg:fileTypes': TXT
          'sbg:stageInput': link
          'sbg:altPrefix': '--files'
          type:
            - items: File
              name: input_files
              type: array
        - 'sbg:toolDefaultValue': <disease_type>
          label: Output Filename
          id: '#output_filename'
          description: Used-defined name for the output files (added as a prefix)
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            position: 3
            prefix: '-o'
            valueFrom:
              class: Expression
              engine: '#cwl-js-engine'
              script: >-
                // take what the user gives and pop any extensions to prevent
                silly names like 'file.csv.csv'

                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
          'sbg:altPrefix': '--output_filename'
          type:
            - string
        - 'sbg:toolDefaultValue': sample_type
          label: Selected Phenotype
          description: >-
            String to select a particular phenotype: 'case_id',
            'age_at_diagnosis', 'vital_status', 'days_to_death', 'gender',
            'sample_type', 'primary_site', 'race', 'ethnicity', 'platform',
            'investigation', 'case_uuid', 'sample_uuid', 'aliquot_uuid',
            'disease_type', 'experimental_strategy', 'data_subtype'
          'sbg:includeInPorts': true
          id: '#phenotype_column_str'
          type:
            - string
        - 'sbg:toolDefaultValue': Primary Tumor
          label: Class label
          description: Class label of interest for t_test
          'sbg:includeInPorts': true
          id: '#phenotype_value_str'
          type:
            - 'null'
            - string
      'sbg:modifiedOn': 1493062594
      'sbg:contributors':
        - charles_blatti
        - mepstein
      cwlVersion: 'sbg:draft-2'
      'sbg:revisionNotes': Added check for val length
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent: >-
                """

                usage: munger.py [-h] [-f FILES [FILES ...]] [-r INDEX_FILE]
                [-c] [-o OUTPUT_FILENAME]


                optional arguments:
                  -h, --help            show this help message and exit
                  -f FILES [FILES ...], --files FILES [FILES ...]
                                        TCGA Gene Expression TXT files
                  -c, --csv
                  -r FILE_INDEX         A file with input files, one each line. Merged with -f files.
                  -o OUTPUT_FILENAME, --output_filename OUTPUT_FILENAME
                """


                import pandas as pd

                import argparse

                import sys

                import re


                # To read TXT files:

                # df = pd.read_table(filename)

                # To read MAF files:

                # df = pd.read_table(filename, skiprows=1) # to skip the version
                row


                def strip_pipe(string):
                    if string == 'SLC35E2|9906':
                        return string
                    pos = string.find('|')
                    if pos != -1:
                        if string.startswith("?|"):
                            string = string[pos+1:]
                        else:
                            string = string[:pos]
                    return string


                def get_dataframe_list(args, data_fields=('gene', 'RPKM')):

                    # GET A LIST OF DATAFRAMES
                    dfs, files = [], args['files'] or []
                    if args['file_index']:
                        with open(args['file_index']) as fp:
                            files.extend(fp.readlines())
                    files = sorted(filter(None, set([f.strip() for f in files])))
                    for f in files:
                        # Get only specific columns with usecols
                        df = pd.read_table(f, usecols=data_fields)
                        df[df.columns[0]] = df[df.columns[0]].apply(strip_pipe)
                        dfs.append(df)
                    return dfs, files # a list of dataframes

                def get_metadata_tag(filename):
                    """ Gets a filename (without extension) from a provided path """
                    m = re.search('TCGA-\w+-\w+-\w+-\w+-\w+-\w+',filename)
                    if m:
                        return m.group(0)
                    return filename

                def merge_texts(args):
                    # get the list of dataframes
                    dfs, filenames = get_dataframe_list(args)
                    # files_list = filenames
                    # get the filenames to later append the column name with the TCGA barcode
                    # filenames = args['files'] # need to get the INDEX
                    # rename the columns of the first df
                    print dfs
                    df = dfs[0].rename(columns={'RPKM': get_metadata_tag(filenames[0])})
                    # enumerate over the list, merge, and rename columns
                    for i, frame in enumerate(dfs[1:], 2):
                        df = df.merge(frame, on='gene').rename(columns={'RPKM':get_metadata_tag(filenames[i-1])})
                    return df

                def get_csv(args, df, filename='GEX_dataframe.csv',
                header_opt=False, index_opt=False):
                    # if csv is true and an output filename is given, rename
                    # there is a default filename, so it should pass if --csv is True
                    if args['csv'] and args['output_filename']:
                        return df.to_csv(path_or_buf=filename, header=header_opt, index=index_opt)

                def get_transpose(df):
                    df_transpose = df.transpose()
                    df_transpose = df_transpose.rename(index = {'gene':'case'})
                    return df_transpose

                def main(args):
                    df = merge_texts(args)
                    get_csv(args, df, filename=str(args['output_filename']) + '_by_gene.csv', header_opt=True)
                    if args['transpose']:
                        get_csv(args, get_transpose(df), filename=str(args['output_filename']) + '_by_case.csv', header_opt=False, index_opt=True)
                    return df

                if __name__ == "__main__":
                    parser = argparse.ArgumentParser()
                    parser.add_argument("-f", "--files", help="TCGA Gene Expression TXT files", nargs="+")
                    parser.add_argument("-c", "--csv", action="store_true", default=False)
                    parser.add_argument("-t", "--transpose", action="store_true", default=False)
                    parser.add_argument("-o", "--output_filename", type=str, default="GEX_dataframe")
                    parser.add_argument("-r", "--file_index", type=str, default=None)

                    args = parser.parse_args()
                    args = vars(args)
                    if not args['files'] and not args['file_index']:
                        parser.print_help()
                        sys.exit(0)

                    df = main(args)
              filename: munger.py
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: |-
                  {
                    var pstr = $job.inputs.phenotype_column_str;
                    var pvstr = $job.inputs.phenotype_value_str;
                    var keys = ['aliquot_id'].concat(pstr.split(',,'));
                    var records = [];
                    for (var k=0; k<keys.length; k++) {
                      r = []
                      for (var i=0; i<$job.inputs.input_files.length; i++) {
                        var meta = $job.inputs.input_files[i].metadata;
                        var val = (meta[keys[k]] || '')
                        if (k > 0 && (typeof val === 'string' || val instanceof String) && val.length > 0) {
                            //val = val.replace("Primary Tumor", 1);
                            //val = val.replace("Solid Tissue Normal", 0);
                            if (val == pvstr) {
                              val = 1;
                            }
                            else {
                              val = 0;
                            }
                        }
                        r.push(val);
                      }
                      records.push(r.join(','));
                    }
                    var return_str = '';
                    for (var k=0; k<keys.length; k++) {
                      return_str += keys[k] + "," + records[k] + "\n";
                    }
                    return return_str;
                  }
                   
              filename:
                class: Expression
                engine: '#cwl-js-engine'
                script: >-
                  // Metadata CSV

                  $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_metadata.csv'

                  // take processed output_filename and add appropriate suffix
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >-
                  $job.inputs.input_files.map(function(f){return
                  f.path.split('/').pop()}).join('\n');

                  // create an index file by taking the filename for each input
                  file in the input array

                  // an adding each in a new line (\n)
              filename:
                class: Expression
                engine: '#cwl-js-engine'
                script: >-
                  // Index File

                  $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_file.txt'

                  // take processed output_filename and add appropriate suffix
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments:
        - prefix: ''
          separate: false
          position: 1
          valueFrom: '-c'
        - separate: false
          position: 2
          valueFrom: '-t'
        - prefix: '-r'
          valueFrom:
            class: Expression
            engine: '#cwl-js-engine'
            script: >-
              $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_file.txt'
          separate: true
      'sbg:toolkitVersion': '1.0'
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Expression Spreadsheet Builder
      stdout: ''
      temporaryFailCodes: []
      'sbg:id': mepstein/geneprioritization/geneexprmunger/8
      'sbg:cmdPreview': python munger.py -r tcga_file.txt -c -t -o tcga
      'sbg:image_url': null
      id: >-
        https://cgc-api.sbgenomics.com/v2/apps/mepstein/geneprioritization/geneexprmunger/8/raw/
      'sbg:revision': 8
      description: >-
        Expression Spreadsheet Builder is a tool built for processing Level 3
        RNA-seq gene expression data from The Cancer Genome Atlas. It will
        produce two tables of gene expression data (per gene, or per case) as
        well as a metadata table. It is capable of processing any number of
        files as it will automatically create an index for the list of files you
        specify, and then use that index in the command line.


        This code was modified from a version produced by Gaurav Kaushik with
        contributions from Boysha Tijanic for the Seven Bridges + NIH BD2K
        Hackathon, which took place April 1st to 3rd, 2016.
      outputs:
        - label: Gene Matrix
          id: '#gene'
          description: Genes by Cases (row by cols)
          'sbg:fileTypes': CSV
          outputBinding:
            glob: '*_gene.csv'
            'sbg:metadata':
              num_input_files: $job.inputs.input_files.length
            'sbg:inheritMetadataFrom': '#input_files'
          type:
            - 'null'
            - File
        - label: Case Matrix
          id: '#case'
          description: Transpose of Gene (rows are Cases)
          'sbg:fileTypes': CSV
          outputBinding:
            glob: '*_case.csv'
            'sbg:metadata':
              num_input_files:
                class: Expression
                engine: '#cwl-js-engine'
                script: $job.inputs.input_files.length
            'sbg:inheritMetadataFrom': '#input_files'
          type:
            - 'null'
            - File
        - label: Metadata Matrix
          id: '#metadata'
          description: Metadata values for the input files
          'sbg:fileTypes': CSV
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: >-
                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_metadata.csv'
            'sbg:metadata':
              num_input_files:
                class: Expression
                engine: '#cwl-js-engine'
                script: $job.inputs.input_files.length
          type:
            - 'null'
            - File
        - label: Index File
          id: '#index'
          description: A file containing a list of the files used in this execution
          'sbg:fileTypes': TXT
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: >-
                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_file.txt'
            'sbg:metadata':
              num_input_files:
                class: Expression
                engine: '#cwl-js-engine'
                script: $job.inputs.input_files.length
            'sbg:inheritMetadataFrom': '#input_files'
          type:
            - 'null'
            - File
      baseCommand:
        - python
        - munger.py
      'sbg:latestRevision': 8
      'sbg:sbgMaintained': false
      'sbg:projectName': GenePrioritization
      class: CommandLineTool
      'sbg:project': mepstein/geneprioritization
      'sbg:createdOn': 1484243332
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:categories':
        - DataScience
        - TCGA
      successCodes: []
      'sbg:job':
        inputs:
          input_files:
            - class: File
              secondaryFiles: []
              size: 0
              path: /path/to/input_files-1.txt
              metadata:
                race: BLACK OR AFRICAN AMERICAN
                age_at_diagnosis: '61'
                case_id: TCGA-CM-4746
            - class: File
              secondaryFiles: []
              size: 0
              path: /path/to/input_files-2.txt
              metadata:
                ethnicity: BLACK
                age_at_diagnosis: '41'
                case_id: TCGA-CM-1415
            - secondaryFiles: []
              size: 0
              path: /path/to/input_files-3.txt
              metadata:
                age_at_diagnosis: '89'
                case_id: TCGA-AHSOAD
          phenotype_value_str: phenotype_value_str-string-value
          output_filename: tcga.csv
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:toolAuthor': Gaurav Kaushik & Boysha Tijanic/Seven Bridges
      'sbg:license': MIT License
      'sbg:toolkit': DataScience
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of charles_blatti/geneprioritizationdemo/geneexprmunger/7
          'sbg:modifiedOn': 1484243332
          'sbg:revision': 0
        - 'sbg:modifiedBy': charles_blatti
          'sbg:revisionNotes': change name
          'sbg:modifiedOn': 1484243771
          'sbg:revision': 1
        - 'sbg:modifiedBy': charles_blatti
          'sbg:revisionNotes': change desc
          'sbg:modifiedOn': 1484243846
          'sbg:revision': 2
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Removed gene limiter (20)
          'sbg:modifiedOn': 1484247162
          'sbg:revision': 3
        - 'sbg:modifiedBy': charles_blatti
          'sbg:revisionNotes': |-
            hack for duplicate genes
                if string == 'SLC35E2|9906':
                    return string
          'sbg:modifiedOn': 1484253742
          'sbg:revision': 4
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Adding check that val is a string in javascript code.
          'sbg:modifiedOn': 1490993673
          'sbg:revision': 5
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added phenotype_value_str
          'sbg:modifiedOn': 1493060796
          'sbg:revision': 6
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Don't change aliquot_id value
          'sbg:modifiedOn': 1493061589
          'sbg:revision': 7
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added check for val length
          'sbg:modifiedOn': 1493062594
          'sbg:revision': 8
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: rfranklin/pythondev
          dockerImageId: ''
    'sbg:y': 146.97009057015035
    id: '#Expression_Spreadsheet_Builder'
'sbg:toolAuthor': KnowEnG
'sbg:revisionNotes': Copy of mepstein/geneprioritization/gpworkflow/13
cwlVersion: 'sbg:draft-2'
'sbg:canvas_y': 146
outputs:
  - label: genomic_data
    'sbg:x': 1005.5217538673162
    'sbg:y': 220.99998862171003
    source:
      - '#KN_Spreadsheet_Preprocessor_1.output_matrix'
    'sbg:includeInPorts': true
    id: '#output_matrix'
    required: false
    type:
      - 'null'
      - File
  - label: pheno_data
    'sbg:x': 1003.5651472682997
    'sbg:y': 95.6086837366535
    source:
      - '#KN_Spreadsheet_Preprocessor.output_matrix'
    'sbg:includeInPorts': true
    id: '#output_matrix_1'
    required: false
    type:
      - 'null'
      - File
  - label: gene_ranking
    'sbg:x': 1007.9563561720778
    'sbg:y': 370.69561526185004
    source:
      - '#ProGENI.output_name'
    'sbg:includeInPorts': true
    id: '#output_name'
    required: false
    type:
      - 'null'
      - items: File
        type: array
  - label: kn_subnetwork
    'sbg:x': 1012.1303158464433
    'sbg:y': 557.3912953735523
    source:
      - '#Knowledge_Network_Fetcher___draft_2.output_file'
    'sbg:includeInPorts': true
    id: '#output_file'
    required: true
    type:
      - File
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1513885119
    'sbg:revisionNotes': Copy of mepstein/geneprioritization/gpworkflow/13
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-dev/gpworkflow/0/raw/
'sbg:id': mepstein/knoweng-geneprioritization-dev/gpworkflow/0
'sbg:revision': 0
'sbg:modifiedOn': 1513885119
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1513885119
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:publisher': sbg
'sbg:content_hash': null
'sbg:copyOf': mepstein/geneprioritization/gpworkflow/13
