hints:
  - value: 1
    class: 'sbg:CPURequirement'
  - value: 1000
    class: 'sbg:MemRequirement'
  - class: DockerRequirement
    dockerImageId: ''
    dockerPull: 'mepsteindr/spreadsheet_preprocess:20180614'
inputs:
  - label: The Original Spreadsheet
    description: The original spreadsheet with row and column names
    inputBinding:
      prefix: '-i'
      'sbg:cmdInclude': true
      separate: true
    'sbg:stageInput': link
    id: '#input_file'
    type:
      - 'null'
      - File
  - 'sbg:toolDefaultValue': '9606'
    label: Species Taxon ID
    description: the taxonomic id for the species of interest
    inputBinding:
      prefix: '-t'
      'sbg:cmdInclude': true
      separate: true
    id: '#taxon'
    type:
      - string
  - label: Spreadsheet Format Type
    description: >-
      The keyword for different types of preprocessing (e.g., genes_x_samples,
      genes_x_samples_check, or samples_x_phenotypes)
    inputBinding:
      prefix: '-s'
      'sbg:cmdInclude': true
      separate: true
    id: '#spreadsheet_format'
    type:
      - string
  - label: Output Filename Prefix
    description: the output file name of the processes data frame
    inputBinding:
      prefix: '-o'
      'sbg:cmdInclude': true
      separate: true
    id: '#output_name'
    type:
      - 'null'
      - string
  - 'sbg:toolDefaultValue': '10'
    label: Max Traits in a Category
    description: >-
      The maximum number of traits allowable for a trait to be considered
      "categorical"
    inputBinding:
      prefix: '-c'
      'sbg:cmdInclude': true
      separate: true
    id: '#category_max_traits'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': 'False'
    label: Map Names Flag
    description: 'The map names flag (default: False)'
    inputBinding:
      prefix: '-m'
      'sbg:cmdInclude': true
      separate: true
    id: '#map_names'
    type:
      - 'null'
      - boolean
  - 'sbg:toolDefaultValue': 'False'
    label: Normalize Flag
    description: >-
      Whether to normalize the spreadsheet (default: False) (currently the only
      normalization available is z-score)
    inputBinding:
      prefix: '-n'
      'sbg:cmdInclude': true
      separate: true
    id: '#normalize'
    type:
      - 'null'
      - boolean
  - 'sbg:toolDefaultValue': '0.0'
    label: Filter Minimum Percentage
    description: >-
      If present, rows with a lower percentage of values below the filter
      threshold will be dropped; this is a float between 0.0 and 1.0; default:
      0.0 (no filtering).
    inputBinding:
      prefix: '-f'
      'sbg:cmdInclude': true
      separate: true
    'sbg:stageInput': null
    id: '#filter_min_percentage'
    type:
      - 'null'
      - float
  - 'sbg:toolDefaultValue': '1.0'
    label: Filter Threshold
    description: 'The filter threshold (see filter minimum percentage); default: 1.0'
    inputBinding:
      prefix: '-F'
      'sbg:cmdInclude': true
      separate: true
    id: '#filter_threshold'
    type:
      - 'null'
      - float
stdout: ''
cwlVersion: 'sbg:draft-2'
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
          output_file_dataframe: $OUTNAME.tsv
          output_file_gene_map: $OUTNAME.genes.name_map
          output_file_metadata: $OUTNAME.metadata
          output_file_row_names: $OUTNAME.row.names
          output_file_column_names: $OUTNAME.column.names
          results_directory: ./
          input_delimiter: \"\t\"
          output_delimiter: \"\t\"
          redis_host: knowredis.knoweng.org
          redis_port: 6379
          redis_pass: KnowEnG
          gene_map_two_columns: False
          check_data: numeric_drop
          gene_map_first_column_orig: True
          output_orig_names: True
          source_hint: ''
          " > $YMLNAME
        filename: sp_ymler.old.sh
      - fileContent: |-
          # Defaults
          CATEGORY_MAX_TRAITS=10
          USE_ORIG_NAMES=True
          NORMALIZE=False
          FILTER_MIN_PERCENTAGE=0.0
          FILTER_THRESHOLD=1.0

          # Process options
          while getopts :c:f:F:i:mno:s:t:y: option
          do
              case "$option" in
              c)
                  CATEGORY_MAX_TRAITS=$OPTARG
                  ;;
              f)
                  FILTER_MIN_PERCENTAGE=$OPTARG
                  ;;
              F)
                  FILTER_THRESHOLD=$OPTARG
                  ;;
              i)
                  INFILE=$OPTARG
                  ;;
              m)
                  USE_ORIG_NAMES=False
                  ;;
              n)
                  NORMALIZE=True
                  ;;
              o)
                  OUTNAME=$OPTARG
                  ;;
              s)
                  SPTYPE=$OPTARG
                  ;;
              t)
                  TAXON=$OPTARG
                  ;;
              y)
                  YMLNAME=$OPTARG
                  ;;
              *)
                  echo "An invalid option was received."
                  echo "The recognized options are: -c, -f, -F, -i, -o, -s, -t, -y"
                  echo "The recognized flags are: -m -n"
                  echo "The required options are: -i, -o, -s, -t, -y"
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
          if [ -z "$OUTNAME" ]
          then
              echo "The output file name is not specified; use the -o option."
              exit
          fi
          if [ -z "$SPTYPE" ]
          then
              echo "The spreadsheet format is not specified; use the -s option."
              exit
          fi
          if [ -z "$TAXON" ]
          then
              echo "The taxon is not specified; use the -t option."
              exit
          fi
          if [ -z "$YMLNAME" ]
          then
              echo "The yml file name is not specified; use the -y option."
              exit
          fi

          # Output
          echo "
          spreadsheet_file_full_path: $INFILE
          taxon: '$TAXON'
          spreadsheet_format: $SPTYPE
          output_file_dataframe: $OUTNAME.tsv
          output_file_gene_map: $OUTNAME.genes.name_map
          output_file_metadata: $OUTNAME.metadata
          output_file_row_names: $OUTNAME.row.names
          output_file_column_names: $OUTNAME.column.names
          results_directory: ./
          input_delimiter: \"\t\"
          output_delimiter: \"\t\"
          redis_host: knowredis.knoweng.org
          redis_port: 6379
          redis_pass: KnowEnG
          gene_map_two_columns: False
          check_data: numeric_drop
          gene_map_first_column_orig: True
          output_orig_names: True
          source_hint: ''
          categorical_max_trait_values: $CATEGORY_MAX_TRAITS
          use_orig_names: $USE_ORIG_NAMES
          normalize: $NORMALIZE
          filter_min_percentage: $FILTER_MIN_PERCENTAGE
          filter_threshold: $FILTER_THRESHOLD
          " > $YMLNAME
        filename: sp_ymler.sh
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments:
  - separate: true
    position: 0
    prefix: '-y'
    valueFrom: run_params.yml
  - separate: true
    position: 6
    valueFrom: '&& python3 /home/src/preprocess/spreadsheet_preprocess.py'
  - separate: true
    position: 7
    prefix: '-run_directory'
    valueFrom: ./
  - separate: true
    position: 8
    prefix: '-run_file'
    valueFrom: run_params.yml
label: KN Spreadsheet Preprocessor-V2
temporaryFailCodes: []
'sbg:revisionNotes': Copy of mepstein/geneprioritization/sp-pp-interface-v2/12
baseCommand:
  - sh
  - sp_ymler.sh
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    map_names: true
    output_name: output_name-string-value
    filter_min_percentage: 3.512089799507774
    filter_threshold: 1.5190595614190268
    taxon: taxon-string-value
    category_max_traits: 1
    spreadsheet_format: spreadsheet_format-string-value
    input_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/input_file.ext
    normalize: true
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Spreadsheet File
    description: Spreadsheet with columns and row headers
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: $job.inputs.output_name + '.tsv'
    id: '#output_matrix'
    type:
      - 'null'
      - File
  - label: Configuration Parameter File
    description: contains the values used in analysis
    outputBinding:
      glob: run_params.yml
    id: '#params_yml'
    type:
      - 'null'
      - File
  - label: Binary Phenotypic Data
    description: Binary Phenotypic Data
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: ' $job.inputs.output_name + ''.binary.tsv'''
    id: '#binary_output_matrix'
    type:
      - 'null'
      - File
  - label: Numeric Phenotypic Data
    description: Numeric Phenotypic Data
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: ' $job.inputs.output_name + ''.numeric.tsv'''
    id: '#numeric_output_matrix'
    type:
      - 'null'
      - File
  - label: Metadata
    description: Metadata
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: ' $job.inputs.output_name + ''.metadata'''
    id: '#metadata'
    type:
      - 'null'
      - File
'sbg:cmdPreview': >-
  sh sp_ymler.sh -t taxon-string-value -s spreadsheet_format-string-value -y
  run_params.yml  && python3 /home/src/preprocess/spreadsheet_preprocess.py
  -run_directory ./ -run_file run_params.yml
description: >-
  Transforms user spreadsheet in preparation for KN analytics by removing noise,
  mapping gene names, and extracting metadata statistics
'sbg:projectName': KnowEnG_SpreadsheetBuilder_Dev
class: CommandLineTool
'sbg:image_url': null
successCodes: []
'sbg:toolAuthor': KnowEnG
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529391421
    'sbg:revisionNotes': Copy of mepstein/geneprioritization/sp-pp-interface-v2/12
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-spreadsheetbuilder-dev/sp-pp-interface-v2/0/raw/
'sbg:id': mepstein/knoweng-spreadsheetbuilder-dev/sp-pp-interface-v2/0
'sbg:revision': 0
'sbg:modifiedOn': 1529391421
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529391421
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-spreadsheetbuilder-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/geneprioritization/sp-pp-interface-v2/12
