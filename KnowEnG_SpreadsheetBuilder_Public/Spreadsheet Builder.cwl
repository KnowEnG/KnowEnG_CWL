'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529393324
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529393356
    'sbg:revisionNotes': Imported SB workflow.
'sbg:projectName': KnowEnG_SpreadsheetBuilder_Public
'sbg:publisher': KnowEnG
inputs:
  - type:
      - type: array
        name: input_files
        items: File
    label: Input Files
    'sbg:x': 37.17857360839845
    'sbg:y': 134.25000871930808
    description: >-
      The input files from which to build the genomic and phenotypic
      spreadsheets
    id: '#input_files'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - string
    label: Data Input Separator
    'sbg:x': 146.25002179827015
    'sbg:y': 330.0000000000001
    description: >-
      The separator used in the input data files (generally ',' or '\t' [TAB];
      default: '\t')
    id: '#data_separator'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - string
    label: Metadata Sample ID Key
    'sbg:x': 38.21426391601564
    'sbg:y': 256.42857142857156
    description: >-
      The metadata key to use for the Sample ID (acutally, this can be a
      comma-separated list of keys to try; the first one that is found in the
      metadata will be used; the default is "aliquot_id,sample_id"; if the key
      is not found in the metadata, an error will be thrown)
    id: '#expected_header_key'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - string
    label: Data Column Info
    'sbg:x': 145.07143293108265
    'sbg:y': 504.78581019810287
    description: >-
      The name or the index of the column to find the data in the input data
      files (indexes start at 1); the default behavior is that the last column
      will be used.
    id: '#data_column_info'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Category Max Values
    'sbg:x': 32.321450369698674
    'sbg:y': 13.035730634416858
    description: >-
      The maximum number of distinct values allowable for a phenotype to be
      considered "categorical" (default: 10)
    id: '#category_max_traits'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - string
    label: Gene Column Info
    'sbg:x': 41.10714503696988
    'sbg:y': 414.785853794643
    description: >-
      The name or the index of the column to find the gene in the input data
      files (indexes start at 1); the default behavior is that if there is a
      column labeled "gene", that will be used; else the first column will be
      used.
    id: '#gene_column_info'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - boolean
    label: Map Names Flag
    'sbg:x': 41.785670689174125
    'sbg:y': 612.8571864536833
    description: >-
      Whether to map the (row) names in the generated genomic spreadsheet
      (default: False)
    id: '#map_names'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - boolean
    label: Normalize Flag
    'sbg:x': 142.49997820172996
    'sbg:y': 686.0713413783485
    description: >-
      Whether to normalize the generated genomic spreadsheet (default: False)
      (currently the only normalization available is z-score)
    id: '#normalize'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - float
    label: Filter Threshold
    'sbg:x': 144.28575788225453
    'sbg:y': 848.5714285714289
    description: The filter threshold (see Filter Minimum Percentage).
    id: '#filter_threshold'
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - float
    label: Filter Minimum Percentage
    'sbg:x': 42.85716465541296
    'sbg:y': 787.1428571428575
    description: >-
      If present, rows with a lower percentage of values below the filter
      threshold will be dropped; this is a float between 0.0 and 1.0; default:
      0.0 (no filtering).
    id: '#filter_min_percentage'
    'sbg:includeInPorts': true
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder/1.png
'sbg:toolAuthor': KnowEnG
'sbg:revisionNotes': Imported SB workflow.
outputs:
  - type:
      - 'null'
      - File
    label: Phenotypic run_params_yml
    'sbg:x': 1128
    source:
      - '#KN_Spreadsheet_Preprocessor_V2.params_yml'
    'sbg:y': 37
    description: >-
      The configuration parameters specified for the spreadsheet preprocessor
      run
    id: '#params_yml'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Phenotypic Spreadsheet File
    'sbg:x': 1243
    source:
      - '#KN_Spreadsheet_Preprocessor_V2.output_matrix'
    'sbg:y': 124
    description: The phenotypic spreadsheet file
    id: '#output_matrix'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Numeric Phenotypic Spreadsheet File
    'sbg:x': 1127
    source:
      - '#KN_Spreadsheet_Preprocessor_V2.numeric_output_matrix'
    'sbg:y': 215
    description: The numeric columns of the phenotypic spreadsheet
    id: '#numeric_output_matrix'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Binary Phenotypic Spreadsheet File
    'sbg:x': 1248
    source:
      - '#KN_Spreadsheet_Preprocessor_V2.binary_output_matrix'
    'sbg:y': 327
    description: The binary columns of the phenotypic spreadsheet
    id: '#binary_output_matrix'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Phenotypic Metadata
    'sbg:x': 1133
    source:
      - '#KN_Spreadsheet_Preprocessor_V2.metadata'
    'sbg:y': 395
    description: The metadata for the phenotypic data
    id: '#metadata'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Genomic run_params_yml
    'sbg:x': 1138.8235294117649
    source:
      - '#KN_Spreadsheet_Preprocessor_V2_1.params_yml'
    'sbg:y': 541.1764705882354
    description: >-
      The configuration parameters specified for the spreadsheet preprocessor
      run
    id: '#params_yml_1'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Genomic Spreadsheet File
    'sbg:x': 1275.2942612591912
    source:
      - '#KN_Spreadsheet_Preprocessor_V2_1.output_matrix'
    'sbg:y': 629.4117647058824
    description: The genomic spreadsheet file
    id: '#output_matrix_1'
    'sbg:includeInPorts': true
    required: false
  - type:
      - 'null'
      - File
    label: Genomic Metadata
    'sbg:x': 1144.7058823529414
    source:
      - '#KN_Spreadsheet_Preprocessor_V2_1.metadata'
    'sbg:y': 708.2353659237133
    description: The metadata for the genomic data
    id: '#metadata_1'
    'sbg:includeInPorts': true
    required: false
'sbg:canvas_y': 34
class: Workflow
hints: []
requirements: []
steps:
  - 'sbg:x': 420.75000762939464
    'sbg:y': 289.2499923706055
    run:
      'sbg:id': mepstein/geneprioritization/geneexprmunger-v2/18
      arguments:
        - separate: false
          position: 0
          valueFrom: '-t'
        - separate: true
          prefix: '-r'
          valueFrom:
            engine: '#cwl-js-engine'
            class: Expression
            script: >-
              $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_file.txt'
        - separate: false
          position: 5
          valueFrom: '&&'
        - separate: false
          position: 6
          valueFrom: cp
        - separate: false
          position: 7
          valueFrom: '-p'
        - separate: false
          position: 8
          valueFrom:
            engine: '#cwl-js-engine'
            class: Expression
            script: >-
              // Metadata CSV

              //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_metadata.csv';

              extension = 'tsv';

              if ($job.inputs.separator && $job.inputs.separator == ',') {
                  extension = '.csv';
              }

              $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_by_gene.' + extension;

              // take processed output_filename and add appropriate suffix
        - separate: false
          position: 9
          valueFrom:
            engine: '#cwl-js-engine'
            class: Expression
            script: >-
              // Metadata CSV

              //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_metadata.csv';

              extension = 'tsv';

              if ($job.inputs.separator && $job.inputs.separator == ',') {
                  extension = '.csv';
              }

              'genomic.' + extension;
        - separate: true
          position: 0
          prefix: '-m'
          valueFrom:
            engine: '#cwl-js-engine'
            class: Expression
            script: >-
              // Metadata CSV

              //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_metadata.csv';

              extension = 'tsv';

              if ($job.inputs.separator && $job.inputs.separator == ',') {
                  extension = '.csv';
              }

              $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
              '_metadata.' + extension;

              // take processed output_filename and add appropriate suffix
      'sbg:projectName': GenePrioritization
      'sbg:contributors':
        - mepstein
      'sbg:toolAuthor': ''
      'sbg:job':
        inputs:
          separator: separator-string-value
          output_filename: output.csv
          input_files:
            - metadata:
                race: BLACK OR AFRICAN AMERICAN
                age_at_diagnosis: '61'
                case_id: TCGA-CM-4746
              class: File
              size: 0
              secondaryFiles: []
              path: /path/to/input_files-1.txt
            - metadata:
                ethnicity: BLACK
                case_id: TCGA-CM-1415
                age_at_diagnosis: '41'
              class: File
              size: 0
              secondaryFiles: []
              path: /path/to/input_files-2.txt
            - metadata:
                case_id: TCGA-AHSOAD
                age_at_diagnosis: '89'
              size: 0
              secondaryFiles: []
              path: /path/to/input_files-3.txt
          expected_header_key: expected_header_key-string-value
          gene_column_info: gene_column_info-string-value
          data_separator: data_separator-string-value
          data_column_info: data_column_info-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1517515526
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/geneprioritization/geneexprmunger/8
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1517515876
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated to build complete metadata file.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1517517339
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added .sort() to output of metadata.
          'sbg:revision': 2
        - 'sbg:modifiedOn': 1517591446
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added creation of *metadata_T.csv file.
          'sbg:revision': 3
        - 'sbg:modifiedOn': 1517612583
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added expected_header_key input.
          'sbg:revision': 4
        - 'sbg:modifiedOn': 1518044439
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added -T option for tab-separated output.
          'sbg:revision': 5
        - 'sbg:modifiedOn': 1518052898
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 6
        - 'sbg:modifiedOn': 1518055214
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added renaming of genomic output file.
          'sbg:revision': 7
        - 'sbg:modifiedOn': 1518055436
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added genomic spreadsheet output file.
          'sbg:revision': 8
        - 'sbg:modifiedOn': 1519016381
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Added separator input parameter (and modified generation of metadata
            files).
          'sbg:revision': 9
        - 'sbg:modifiedOn': 1519199390
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated munger.py, file names of created files, command line
            arguments, and a few other things.
          'sbg:revision': 10
        - 'sbg:modifiedOn': 1519243797
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Updated munger.py, inputs, outputs, arguments.'
          'sbg:revision': 11
        - 'sbg:modifiedOn': 1519252148
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed name of file for output case.
          'sbg:revision': 12
        - 'sbg:modifiedOn': 1519761510
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Updated container, metadata js, munger.py, inputs.'
          'sbg:revision': 13
        - 'sbg:modifiedOn': 1519795221
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Added filename to metadata generations scripts, and munger.py.'
          'sbg:revision': 14
        - 'sbg:modifiedOn': 1519845042
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Added data_separator input, updated munger.py.'
          'sbg:revision': 15
        - 'sbg:modifiedOn': 1519847517
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added alternative prefix for some inputs.
          'sbg:revision': 16
        - 'sbg:modifiedOn': 1519848494
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated description on expected_header_key input.
          'sbg:revision': 17
        - 'sbg:modifiedOn': 1519848907
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated description in some inputs.
          'sbg:revision': 18
      stdout: ''
      'sbg:cmdPreview': >-
        python munger.py -o output -t -r output_file.txt -m output_metadata.tsv
        && cp -p output_by_gene.tsv genomic.tsv
      'y': 289.2499923706055
      'sbg:revision': 18
      'sbg:image_url': null
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      id: mepstein/geneprioritization/geneexprmunger-v2/18
      'sbg:latestRevision': 18
      'sbg:revisionNotes': Updated description in some inputs.
      outputs:
        - label: Metadata Matrix (Transposed)
          'sbg:fileTypes': CSV
          description: 'Metadata for the input files (transposed, phenotypes X samples)'
          outputBinding:
            'sbg:metadata':
              num_input_files:
                engine: '#cwl-js-engine'
                class: Expression
                script: $job.inputs.input_files.length
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: >-
                //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_metadata_T.csv';

                extension = 'tsv';

                if ($job.inputs.separator && $job.inputs.separator == ',') {
                    extension = '.csv';
                }

                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_metadata_T.' + extension;
          id: '#metadata_t'
          type:
            - 'null'
            - File
        - label: Metadata Matrix
          'sbg:fileTypes': CSV
          description: Metadata values for the input files (samples X phenotypes)
          outputBinding:
            'sbg:metadata':
              num_input_files:
                engine: '#cwl-js-engine'
                class: Expression
                script: $job.inputs.input_files.length
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: >-
                //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_metadata.csv';

                extension = 'tsv';

                if ($job.inputs.separator && $job.inputs.separator == ',') {
                    extension = '.csv';
                }

                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_metadata.' + extension;
          id: '#metadata'
          type:
            - 'null'
            - File
        - label: Index File
          'sbg:fileTypes': TXT
          description: A file containing a list of the files used in this execution
          outputBinding:
            'sbg:inheritMetadataFrom': '#input_files'
            'sbg:metadata':
              num_input_files:
                engine: '#cwl-js-engine'
                class: Expression
                script: $job.inputs.input_files.length
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: >-
                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_file.txt'
          id: '#index'
          type:
            - 'null'
            - File
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: |-
                extension = 'tsv';
                if ($job.inputs.separator && $job.inputs.separator == ',') {
                    extension = '.csv';
                }
                'genomic.' + extension;
          label: Genomic Spreadsheet File
          id: '#genomic_spreadsheet_file'
          description: The genomic spreadsheet file
        - label: Gene Matrix
          'sbg:fileTypes': CSV
          description: Genes by Cases (genes X samples)
          outputBinding:
            'sbg:inheritMetadataFrom': '#input_files'
            'sbg:metadata':
              num_input_files: $job.inputs.input_files.length
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: >-
                extension = 'tsv';

                if ($job.inputs.separator && $job.inputs.separator == ',') {
                    extension = '.csv';
                }

                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_by_gene.' + extension;
          id: '#gene'
          type:
            - 'null'
            - File
        - label: Case Matrix
          'sbg:fileTypes': CSV
          description: Transpose of Gene (samples X genes)
          outputBinding:
            'sbg:inheritMetadataFrom': '#input_files'
            'sbg:metadata':
              num_input_files:
                engine: '#cwl-js-engine'
                class: Expression
                script: $job.inputs.input_files.length
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: >-
                extension = 'tsv';

                if ($job.inputs.separator && $job.inputs.separator == ',') {
                    extension = '.csv';
                }

                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                '_by_sample.' + extension;
          id: '#case'
          type:
            - 'null'
            - File
      'sbg:createdOn': 1517515526
      label: Expression Spreadsheet Builder-V2
      stdin: ''
      baseCommand:
        - python
        - munger.py
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - dockerImageId: ''
          class: DockerRequirement
          dockerPull: continuumio/anaconda3
      requirements:
        - fileDef:
            - fileContent: >-
                #!/usr/bin/env python3


                """

                usage: munger.py [-h] [-f FILES [FILES ...]] [-r INDEX_FILE]
                [-c] [-o OUTPUT_FILENAME]


                optional arguments:
                  -h, --help            show this help message and exit
                  -f FILES [FILES ...], --files FILES [FILES ...]
                                        TCGA Gene Expression TXT files
                  -r FILE_INDEX         A file with input files, one each line. Merged with -f files.
                  -o OUTPUT_FILENAME, --output_filename OUTPUT_FILENAME
                """


                import argparse

                import sys

                import re

                import pandas as pd


                DEFAULT_OUTPUT_FILENAME = 'GEX_dataframe'


                #DEFAULT_METADATA_KEY = 'sample_id'

                DEFAULT_METADATA_KEY = 'aliquot_id'


                #DEFAULT_METADATA_SEPARATOR = ','

                DEFAULT_METADATA_SEPARATOR = '\t'


                DEFAULT_DATA_SEPARATOR = '\t'


                # To read TXT files:

                # df = pd.read_table(filename)

                # To read MAF files:

                # df = pd.read_table(filename, skiprows=1) # to skip the version
                row


                def is_integer(string):
                    try:
                        int(string)
                        return True
                    except ValueError:
                        return False

                def is_number(string):
                    try:
                        float(string)
                        return True
                    except ValueError:
                        return False

                # Some gene names are "ENSG#######.##";

                # returns the name with any trailing ".##" removed.

                def strip_dot(string):
                    if not string.startswith('ENSG'):
                        return string
                    pos = string.find('.')
                    if pos != -1:
                        string = string[:pos]
                    return string

                # Some gene names are "...|...";

                # returns the name with the portion before the '|',

                # unless that's a '?', in which case returns the portion after
                the '|'.

                def strip_pipe(string):
                    # An exception, where the '|' needs to be preserved
                    if string == 'SLC35E2|9906':
                        return string
                    pos = string.find('|')
                    if pos != -1:
                        if string.startswith('?|'):
                            string = string[pos+1:]
                        else:
                            string = string[:pos]
                    return string

                def get_gene_column(args, filename, first_row, num_cols,
                has_headers):
                    if args['gene_column_info'] is not None:
                        if is_integer(args['gene_column_info']):
                            args['gene_column_index'] = int(args['gene_column_info'])
                        else:
                            args['gene_column_name'] = args['gene_column_info']
                    if args['gene_column_name'] is not None:
                        if not has_headers:
                            raise RuntimeError("Can't specify -n/--gene_column_name (%s) when data file (%s) doesn't have headers" % (args['gene_column_name'], filename))
                        if args['gene_column_name'] not in first_row:
                            raise RuntimeError("-n/--gene_column_name (%s) not found in data file (%s, %s)" % (args['gene_column_name'], filename, first_row))
                        return args['gene_column_name']
                    elif args['gene_column_index'] is not None:
                        if args['gene_column_index'] > num_cols:
                            raise RuntimeError("-i/--gene_column_index (%s) greater than number of columns in data file (%s, %d)" % (args['gene_column_index'], filename, num_cols))
                        if has_headers:
                            return first_row[args['gene_column_index']-1]
                        else:
                            return args['gene_column_index']-1
                    # Defaults
                    else:
                        if has_headers:
                            if 'gene' in first_row:
                                return 'gene'
                            else:
                                return first_row[0]
                        else:
                            return 0

                def get_data_column(args, filename, first_row, num_cols,
                has_headers):
                    if args['data_column_info'] is not None:
                        if is_integer(args['data_column_info']):
                            args['data_column_index'] = int(args['data_column_info'])
                        else:
                            args['data_column_name'] = args['data_column_info']
                    if args['data_column_name'] is not None:
                        if not has_headers:
                            raise RuntimeError("Can't specify -N/--data_column_name (%s) when data file (%s) doesn't have headers" % (args['data_column_name'], filename))
                        if args['data_column_name'] not in first_row:
                            raise RuntimeError("-N/--data_column_name (%s) not found in data file (%s, %s)" % (args['data_column_name'], filename, first_row))
                        return args['data_column_name']
                    elif args['data_column_index'] is not None:
                        if args['data_column_index'] > num_cols:
                            raise RuntimeError("-I/--data_column_index (%s) greater than number of columns in data file (%s, %d)" % (args['data_column_index'], filename, num_cols))
                        if has_headers:
                            return first_row[args['data_column_index']-1]
                        else:
                            return args['data_column_index']-1
                    # Defaults
                    else:
                        if has_headers:
                            return first_row[num_cols-1]
                        else:
                            return num_cols-1

                def get_dataframe_list(args, meta_df):
                    # Get a list of dataframes
                    dfs, files = [], args['files'] or []
                    if args['file_index'] is not None:
                        with open(args['file_index']) as fp:
                            files.extend(fp.readlines())
                    files = sorted(filter(None, set([f.strip() for f in files])))

                    if meta_df is not None and len(files) != len(meta_df):
                        raise RuntimeError("length of files list and length of metadata file do not match (%d, %d)" % (len(files), len(meta_df)))

                    # Try to do something with separator, inferring, allowing other options,
                    # detecting problems parsing and generating clean error message
                    for f in files:
                        print("\nProcessing file %s" % (f))
                        #first_row = list(pd.read_table(f, nrows=1).columns)
                        first_row = list(pd.read_table(f, nrows=1, sep=args['data_separator']).columns)
                        num_cols = len(first_row)
                        if num_cols <= 1:
                            raise RuntimeError("problem parsing data file, fewer than two columns found (%d, '%s')" % (num_cols, args['data_separator']))
                        has_headers = not is_number(first_row[-1])
                        usecols = [get_gene_column(args, f, first_row, num_cols, has_headers),
                                   get_data_column(args, f, first_row, num_cols, has_headers)]
                        params = {}
                        if not has_headers:
                            params['header'] = None
                            params['names'] = ["gene", "data"]
                        # Some of these files may be .gz files, but they're handled automatically
                        #df = pd.read_table(f, usecols=usecols, **params)
                        df = pd.read_table(f, usecols=usecols, sep=args['data_separator'], **params)
                        df[df.columns[0]] = df[df.columns[0]].apply(strip_pipe).apply(strip_dot)
                        dfs.append(df)

                    return dfs, files

                def get_metadata_tag(filename, i, meta_df, args):
                    # If there's no metadata, get the tag from the filename
                    if meta_df is None:
                        m = re.search('TCGA-\w+-\w+-\w+-\w+-\w+-\w+', filename)
                        if m:
                            return m.group(0)
                        return filename
                    # Otherwise, look for the tag in the metadata
                    if 'filename' not in meta_df.columns:
                        raise RuntimeError("metadata does not contain 'filename' column")
                    row = meta_df[meta_df.filename == filename]
                    if row.empty:
                        raise RuntimeError("metadata does not contain data for file '%s'" % (filename))
                    if len(row) != 1:
                        raise RuntimeError("metadata contains multiple rows of data for file '%s'" % (filename))
                    index = row.index[0]
                    if args['metadata_key'] is not None and args['metadata_key'] in meta_df.columns:
                        return row[args['metadata_key']][index]
                    if args['metadata_key_first_column'] is not None and args['metadata_key_first_column']:
                        return row[meta_df.columns[0]][index]
                    # Have this be the default?
                    # Then args['metadata_key_first_column'] may be superfluous
                    # And it conflicts with having a default for args['metadata_key']
                    return row[meta_df.columns[0]][index]

                def merge_texts(args, meta_df):
                    # Get the list of dataframes
                    dfs, filenames = get_dataframe_list(args, meta_df)
                    print(dfs)
                    # Keep track of the metadata tags seen
                    # (they have to be unique; duplicates will be skipped)
                    metadata_tags = []
                    metadata_tag = get_metadata_tag(filenames[0], 0, meta_df, args)
                    print("\nFound file metadata (%d, %s, %s)" % (0, filenames[0], metadata_tag))
                    metadata_tags.append(metadata_tag)
                    # Rename the columns of the first df
                    df = dfs[0].rename(columns={dfs[0].columns[1]: metadata_tag})
                    # Enumerate over the list, merge, and rename columns
                    for i, frame in enumerate(dfs[1:], 2):
                        metadata_tag = get_metadata_tag(filenames[i-1], i-1, meta_df, args)
                        print("\nFound file metadata (%d, %s, %s)" % (i-1, filenames[i-1], metadata_tag))
                        # Make sure the metadata_tag is unique; don't include duplicates
                        if metadata_tag in metadata_tags:
                            continue
                        metadata_tags.append(metadata_tag)
                        df = df.merge(frame, on=df.columns[0]).rename(columns={dfs[i-1].columns[1]: metadata_tag})
                    return df

                def get_transpose(df):
                    df_transpose = df.transpose()
                    df_transpose = df_transpose.rename(index={'gene': 'sample'})
                    return df_transpose

                def get_metadata(args):
                    if args['metadata_file'] is None:
                        return None
                    #meta_df = pd.read_table(args['metadata_file'], sep=',')
                    #meta_df = pd.read_table(args['metadata_file'], sep='\t')
                    meta_df = pd.read_table(args['metadata_file'], sep=args['metadata_separator'])
                    return meta_df

                def parse_args():
                    parser = argparse.ArgumentParser()
                    parser.add_argument("-f", "--files", help="TCGA Gene Expression TXT files", nargs="+")
                    parser.add_argument("-r", "--file_index", type=str)
                    parser.add_argument("-o", "--output_filename", type=str, default=DEFAULT_OUTPUT_FILENAME)
                    parser.add_argument("-t", "--transpose", action="store_true")
                    parser.add_argument("-c", "--comma_separated_output", action="store_true")
                    parser.add_argument("-m", "--metadata_file", type=str)
                    #parser.add_argument("-M", "--metadata_key", type=str, default=DEFAULT_METADATA_KEY)
                    metadata_key_group = parser.add_mutually_exclusive_group()
                    #metadata_key_group.add_argument("-M", "--metadata_key", type=str, default=DEFAULT_METADATA_KEY)
                    metadata_key_group.add_argument("-M", "--metadata_key", type=str)
                    metadata_key_group.add_argument("-k", "--metadata_key_first_column", action="store_true")
                    parser.add_argument("-s", "--metadata_separator", type=str, default=DEFAULT_METADATA_SEPARATOR)
                    parser.add_argument("-S", "--data_separator", type=str, default=DEFAULT_DATA_SEPARATOR)
                    gene_column_group = parser.add_mutually_exclusive_group()
                    gene_column_group.add_argument("-i", "--gene_column_index", type=int)
                    gene_column_group.add_argument("-n", "--gene_column_name", type=str)
                    gene_column_group.add_argument("-g", "--gene_column_info", type=str)
                    data_column_group = parser.add_mutually_exclusive_group()
                    data_column_group.add_argument("-I", "--data_column_index", type=int)
                    data_column_group.add_argument("-N", "--data_column_name", type=str)
                    data_column_group.add_argument("-d", "--data_column_info", type=str)

                    args = parser.parse_args()
                    args = vars(args)
                    if not args['files'] and not args['file_index']:
                        parser.print_help()
                        sys.exit(0)

                    if args['gene_column_index'] is not None and args['gene_column_index'] <= 0:
                        raise RuntimeError("-i/--gene_column_index (%s) must be greater than 0" % (args['gene_column_index']))
                    if args['data_column_index'] is not None and args['data_column_index'] <= 0:
                        raise RuntimeError("-I/--data_column_index (%s) must be greater than 0" % (args['data_column_index']))

                    if args['comma_separated_output']:
                        args['output_separator'] = ","
                        args['output_extension'] = "csv"
                    # If it's not comma-separated, it's tab-separated
                    else:
                        args['output_separator'] = "\t"
                        args['output_extension'] = "tsv"

                    return args

                def main():
                    args = parse_args()
                    meta_df = get_metadata(args)
                    print(meta_df)
                    df = merge_texts(args, meta_df)

                    # This is genes X samples
                    df.to_csv(path_or_buf=args['output_filename'] + '_by_gene.' + args['output_extension'], sep=args['output_separator'], header=True, index=False)
                    # This is samples X genes
                    if args['transpose']:
                        get_transpose(df).to_csv(path_or_buf=args['output_filename'] + '_by_sample.' + args['output_extension'], sep=args['output_separator'], header=False, index=True)

                    return df

                if __name__ == "__main__":
                    the_df = main()
              filename: munger.py
            - fileContent:
                engine: '#cwl-js-engine'
                class: Expression
                script: |
                  {
                    //var expected_header_key = "aliquot_id";
                    var expected_header_key = "aliquot_id,sample_id";
                    if ($job.inputs.expected_header_key) {
                      expected_header_key = $job.inputs.expected_header_key;
                    }

                    //var separator = ",";
                    var separator = "\t";
                    if ($job.inputs.separator) {
                      separator = $job.inputs.separator;
                    }

                    // keys are metadata keys, values are arrays of values per files
                    var metadata = {};
                    metadata["filename"] = Array.apply(null, Array($job.inputs.input_files.length)).map(function () {return '';});
                    for (var i=0; i<$job.inputs.input_files.length; i++) {
                      var file = $job.inputs.input_files[i];
                      var filename = file.name;
                      metadata["filename"][i] = filename;
                      var meta = file.metadata;
                      var keys = Object.keys(meta).sort();
                      for (var j=0; j<keys.length; j++) {
                        var key = keys[j];
                        // If metadata[key] doesn't exist, initialize it to an array of empty strings
                        if (!(key in metadata)) {
                          metadata[key] = Array.apply(null, Array($job.inputs.input_files.length)).map(function () {return '';});
                        }
                        metadata[key][i] = meta[key];
                      }
                    }

                    // Find the expected header key
                    var eh_key_found = false;
                    var eh_keys = expected_header_key.split(/, */);
                    for (var i=0; i<eh_keys.length; i++) {
                      var eh_key = eh_keys[i];
                      if (eh_key in metadata) {
                        eh_key_found = true;
                        break;
                      }
                    }
                    if (eh_key_found) {
                      expected_header_key = eh_key;
                    }
                    else {
                      throw "expected header key not found in metadata (" + expected_header_key + ")"
                    }

                    // Build the return string
                    var return_str = '';
                    //if (metadata[expected_header_key]) {
                    if (expected_header_key in metadata) {
                      return_str += expected_header_key + separator + metadata[expected_header_key].join(separator) + "\n";
                    }
                    var keys = Object.keys(metadata).sort();
                    for (var i=0; i<keys.length; i++) {
                      var key = keys[i];
                      if (key == expected_header_key) {
                        continue;
                      }
                      return_str += key + separator + metadata[key].join(separator) + "\n";
                    }

                    return return_str;
                  }
              filename:
                engine: '#cwl-js-engine'
                class: Expression
                script: >-
                  // Metadata CSV

                  //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_metadata_T.csv';

                  extension = 'tsv';

                  if ($job.inputs.separator && $job.inputs.separator == ',') {
                      extension = '.csv';
                  }

                  $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_metadata_T.' + extension;

                  // take processed output_filename and add appropriate suffix
            - fileContent:
                engine: '#cwl-js-engine'
                class: Expression
                script: >-
                  $job.inputs.input_files.map(function(f){return
                  f.path.split('/').pop()}).join('\n');

                  // create an index file by taking the filename for each input
                  file in the input array

                  // an adding each in a new line (\n)
              filename:
                engine: '#cwl-js-engine'
                class: Expression
                script: >-
                  // Index File

                  $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_file.txt'

                  // take processed output_filename and add appropriate suffix
            - fileContent:
                engine: '#cwl-js-engine'
                class: Expression
                script: |
                  {
                    //var expected_header_key = "aliquot_id";
                    var expected_header_key = "aliquot_id,sample_id";
                    if ($job.inputs.expected_header_key) {
                      expected_header_key = $job.inputs.expected_header_key;
                    }

                    //var separator = ",";
                    var separator = "\t";
                    if ($job.inputs.separator) {
                      separator = $job.inputs.separator;
                    }

                    // keys are metadata keys, values are arrays of values per files
                    var metadata = {};
                    metadata["filename"] = Array.apply(null, Array($job.inputs.input_files.length)).map(function () {return '';});
                    for (var i=0; i<$job.inputs.input_files.length; i++) {
                      var file = $job.inputs.input_files[i];
                      var filename = file.name;
                      metadata["filename"][i] = filename;
                      var meta = file.metadata;
                      var keys = Object.keys(meta).sort();
                      for (var j=0; j<keys.length; j++) {
                        var key = keys[j];
                        // If metadata[key] doesn't exist, initialize it to an array of empty strings
                        if (!(key in metadata)) {
                          metadata[key] = Array.apply(null, Array($job.inputs.input_files.length)).map(function () {return '';});
                        }
                        metadata[key][i] = meta[key];
                      }
                    }

                    // Find the expected header key
                    var eh_key_found = false;
                    var eh_keys = expected_header_key.split(/, */);
                    for (var i=0; i<eh_keys.length; i++) {
                      var eh_key = eh_keys[i];
                      if (eh_key in metadata) {
                        eh_key_found = true;
                        break;
                      }
                    }
                    if (eh_key_found) {
                      expected_header_key = eh_key;
                    }
                    else {
                      throw "expected header key not found in metadata (" + expected_header_key + ")"
                    }

                    // Build the return string
                    var return_str = '';
                    var keys = Object.keys(metadata).sort();

                    // Header line
                    var line = '';
                    //if (metadata[expected_header_key]) {
                    if (expected_header_key in metadata) {
                      line += expected_header_key;
                    }
                    for (var i=0; i<keys.length; i++) {
                      var key = keys[i];
                      if (key == expected_header_key) {
                        continue;
                      }
                      //line += separator + key;
                      if (i > 0 || expected_header_key in metadata) {
                        line += separator;
                      }
                      line += key;
                    }
                    line += "\n";
                    return_str += line;

                    for (var i=0; i<$job.inputs.input_files.length; i++) {
                      line = '';
                      //if (metadata[expected_header_key]) {
                      if (expected_header_key in metadata) {
                        line += metadata[expected_header_key][i];
                      }
                      for (var j=0; j<keys.length; j++) {
                        var key = keys[j];
                        if (key == expected_header_key) {
                          continue;
                        }
                        //line += separator + metadata[key][i];
                        if (j > 0 || expected_header_key in metadata) {
                          line += separator;
                        }
                        line += metadata[key][i];
                      }
                      line += "\n";
                      return_str += line;
                    }

                    return return_str;
                  }
              filename:
                engine: '#cwl-js-engine'
                class: Expression
                script: >-
                  // Metadata CSV

                  //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_metadata.csv';

                  extension = 'tsv';

                  if ($job.inputs.separator && $job.inputs.separator == ',') {
                      extension = '.csv';
                  }

                  $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                  '_metadata.' + extension;

                  // take processed output_filename and add appropriate suffix
          class: CreateFileRequirement
        - id: '#cwl-js-engine'
          class: ExpressionEngineRequirement
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      temporaryFailCodes: []
      'sbg:modifiedOn': 1519848907
      x: 420.75000762939464
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:project': mepstein/geneprioritization
      'sbg:validationErrors': []
      'sbg:sbgMaintained': false
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
      'sbg:license': ''
      successCodes: []
      'sbg:categories':
        - TCGA
        - CCLE
        - spreadsheet
      'sbg:createdBy': mepstein
      inputs:
        - 'sbg:altPrefix': '--metadata_separator'
          type:
            - 'null'
            - string
          'sbg:toolDefaultValue': '\t [TAB]'
          description: >-
            The separator to use in the metadata output files (default: '\t'
            [TAB])
          id: '#separator'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            position: 0
            prefix: '-s'
          label: Metadata Output Separator
        - type:
            - string
          label: Output Filename
          'sbg:altPrefix': '--output_filename'
          description: >-
            Prefix to use on the various output files (e.g., the gene expression
            data and the metadata)
          id: '#output_filename'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            position: 0
            valueFrom:
              engine: '#cwl-js-engine'
              class: Expression
              script: >-
                // take what the user gives and pop any extensions to prevent
                silly names like 'file.csv.csv'

                $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
            prefix: '-o'
        - type:
            - type: array
              items: File
          label: Input Files
          'sbg:altPrefix': '--files'
          'sbg:stageInput': link
          description: Input array of TCGA Level 3 gene expression quantification files
          id: '#input_files'
          required: true
        - type:
            - 'null'
            - string
          label: Gene Column Info
          'sbg:altPrefix': '--gene_column_info'
          description: >-
            The name or the index of the column to find the gene in the input
            data files (indexes start at 1); the default behavior is that if
            there is a column labeled "gene", that will be used; else the first
            column will be used.
          id: '#gene_column_info'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-g'
          'sbg:includeInPorts': true
          required: false
        - label: Metadata Sample ID Key
          type:
            - 'null'
            - string
          'sbg:toolDefaultValue': 'aliquot_id,sample_id'
          description: >-
            The metadata key to use for the Sample ID (acutally, this can be a
            comma-separated list of keys to try; the first one that is found in
            the metadata will be used; the default is "aliquot_id,sample_id"; if
            the key is not found in the metadata, an error will be thrown)
          id: '#expected_header_key'
          required: false
          'sbg:includeInPorts': true
        - 'sbg:altPrefix': '--data_separator'
          label: Data Input Separator
          'sbg:toolDefaultValue': '\t [TAB]'
          description: >-
            The separator used in the input data files (generally ',' or '\t'
            [TAB]; default: '\t')
          id: '#data_separator'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-S'
          'sbg:includeInPorts': true
          type:
            - 'null'
            - string
          required: false
        - type:
            - 'null'
            - string
          label: Data Column Info
          'sbg:altPrefix': '--data_column_info'
          description: >-
            The name or the index of the column to find the data in the input
            data files (indexes start at 1); the default behavior is that the
            last column will be used.
          id: '#data_column_info'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-d'
          'sbg:includeInPorts': true
          required: false
      class: CommandLineTool
      'sbg:toolkit': ''
      'sbg:toolkitVersion': ''
    inputs:
      - id: '#Expression_Spreadsheet_Builder_V2.separator'
      - id: '#Expression_Spreadsheet_Builder_V2.output_filename'
        default: output
      - id: '#Expression_Spreadsheet_Builder_V2.input_files'
        source:
          - '#input_files'
      - id: '#Expression_Spreadsheet_Builder_V2.gene_column_info'
        source:
          - '#gene_column_info'
      - id: '#Expression_Spreadsheet_Builder_V2.expected_header_key'
        source:
          - '#expected_header_key'
      - id: '#Expression_Spreadsheet_Builder_V2.data_separator'
        source:
          - '#data_separator'
      - id: '#Expression_Spreadsheet_Builder_V2.data_column_info'
        source:
          - '#data_column_info'
    id: '#Expression_Spreadsheet_Builder_V2'
    outputs:
      - id: '#Expression_Spreadsheet_Builder_V2.metadata_t'
      - id: '#Expression_Spreadsheet_Builder_V2.metadata'
      - id: '#Expression_Spreadsheet_Builder_V2.index'
      - id: '#Expression_Spreadsheet_Builder_V2.genomic_spreadsheet_file'
      - id: '#Expression_Spreadsheet_Builder_V2.gene'
      - id: '#Expression_Spreadsheet_Builder_V2.case'
  - 'sbg:x': 703
    'sbg:y': 85.00000000000003
    run:
      'sbg:id': mepstein/geneprioritization/sp-pp-interface-v2/12
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
      'sbg:projectName': GenePrioritization
      'sbg:contributors':
        - mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:job':
        inputs:
          map_names: true
          spreadsheet_format: spreadsheet_format-string-value
          normalize: true
          filter_min_percentage: 3.512089799507774
          taxon: taxon-string-value
          filter_threshold: 1.5190595614190268
          output_name: output_name-string-value
          category_max_traits: 1
          input_file:
            secondaryFiles: []
            class: File
            size: 0
            path: /path/to/input_file.ext
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1518037552
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/geneprioritization/sp-pp-interface/9
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1518038403
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated to new version of SS_PP container; creates binary and
            numeric phenotypic spreadsheet outputs.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1518039882
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added metadata output file.
          'sbg:revision': 2
        - 'sbg:modifiedOn': 1518052855
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified documentation on inputs.
          'sbg:revision': 3
        - 'sbg:modifiedOn': 1519283540
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Changed input_delimiter to \t/TAB (remove altogether so it's
            inferred?).
          'sbg:revision': 4
        - 'sbg:modifiedOn': 1520367644
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Updated call to KN SS PP -- arguments, container version.'
          'sbg:revision': 5
        - 'sbg:modifiedOn': 1520367819
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added -M option (no mapping).
          'sbg:revision': 6
        - 'sbg:modifiedOn': 1524447774
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated container version; added dont_map and normalize
            inputs/parameters.
          'sbg:revision': 7
        - 'sbg:modifiedOn': 1524499769
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 8
        - 'sbg:modifiedOn': 1524596605
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Modified inputs and defaults a bit (e.g., dont_map_names is now
            map_names, with default being False, i.e., no mapping).
          'sbg:revision': 9
        - 'sbg:modifiedOn': 1528576122
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Added filter_min_percentage and filter_threshold inputs; new
            container version.
          'sbg:revision': 10
        - 'sbg:modifiedOn': 1528579024
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Changed docs on filter_min_percentage to say it was a float between
            0.0 and 1.0.
          'sbg:revision': 11
        - 'sbg:modifiedOn': 1529009273
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated container tag (20180614).
          'sbg:revision': 12
      inputs:
        - type:
            - string
          label: Species Taxon ID
          'sbg:toolDefaultValue': '9606'
          description: the taxonomic id for the species of interest
          id: '#taxon'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-t'
        - type:
            - string
          id: '#spreadsheet_format'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-s'
          label: Spreadsheet Format Type
          description: >-
            The keyword for different types of preprocessing (e.g.,
            genes_x_samples, genes_x_samples_check, or samples_x_phenotypes)
        - type:
            - 'null'
            - string
          id: '#output_name'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-o'
          label: Output Filename Prefix
          description: the output file name of the processes data frame
        - type:
            - 'null'
            - boolean
          label: Normalize Flag
          'sbg:toolDefaultValue': 'False'
          description: >-
            Whether to normalize the spreadsheet (default: False) (currently the
            only normalization available is z-score)
          id: '#normalize'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-n'
        - type:
            - 'null'
            - boolean
          label: Map Names Flag
          'sbg:toolDefaultValue': 'False'
          description: 'The map names flag (default: False)'
          id: '#map_names'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-m'
        - type:
            - 'null'
            - File
          label: The Original Spreadsheet
          'sbg:stageInput': link
          description: The original spreadsheet with row and column names
          id: '#input_file'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-i'
          required: false
        - type:
            - 'null'
            - float
          label: Filter Threshold
          'sbg:toolDefaultValue': '1.0'
          description: 'The filter threshold (see filter minimum percentage); default: 1.0'
          id: '#filter_threshold'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-F'
        - type:
            - 'null'
            - float
          label: Filter Minimum Percentage
          'sbg:toolDefaultValue': '0.0'
          'sbg:stageInput': null
          description: >-
            If present, rows with a lower percentage of values below the filter
            threshold will be dropped; this is a float between 0.0 and 1.0;
            default: 0.0 (no filtering).
          id: '#filter_min_percentage'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-f'
        - type:
            - 'null'
            - int
          label: Max Traits in a Category
          'sbg:toolDefaultValue': '10'
          description: >-
            The maximum number of traits allowable for a trait to be considered
            "categorical"
          id: '#category_max_traits'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-c'
          required: false
          'sbg:includeInPorts': true
      'sbg:cmdPreview': >-
        sh sp_ymler.sh -t taxon-string-value -s spreadsheet_format-string-value
        -y run_params.yml  && python3
        /home/src/preprocess/spreadsheet_preprocess.py -run_directory ./
        -run_file run_params.yml
      'y': 85.00000000000003
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:revision': 12
      'sbg:project': mepstein/geneprioritization
      'sbg:modifiedBy': mepstein
      'sbg:toolAuthor': KnowEnG
      id: mepstein/geneprioritization/sp-pp-interface-v2/12
      'sbg:latestRevision': 12
      'sbg:revisionNotes': Updated container tag (20180614).
      outputs:
        - type:
            - 'null'
            - File
          outputBinding:
            glob: run_params.yml
          label: Configuration Parameter File
          id: '#params_yml'
          description: contains the values used in analysis
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: $job.inputs.output_name + '.tsv'
          label: Spreadsheet File
          id: '#output_matrix'
          description: Spreadsheet with columns and row headers
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: ' $job.inputs.output_name + ''.numeric.tsv'''
          label: Numeric Phenotypic Data
          id: '#numeric_output_matrix'
          description: Numeric Phenotypic Data
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: ' $job.inputs.output_name + ''.metadata'''
          label: Metadata
          id: '#metadata'
          description: Metadata
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: ' $job.inputs.output_name + ''.binary.tsv'''
          label: Binary Phenotypic Data
          id: '#binary_output_matrix'
          description: Binary Phenotypic Data
      'sbg:createdOn': 1518037552
      label: KN Spreadsheet Preprocessor-V2
      stdin: ''
      baseCommand:
        - sh
        - sp_ymler.sh
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - dockerImageId: ''
          class: DockerRequirement
          dockerPull: 'mepsteindr/spreadsheet_preprocess:20180614'
      requirements:
        - fileDef:
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
          class: CreateFileRequirement
        - id: '#cwl-js-engine'
          class: ExpressionEngineRequirement
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      temporaryFailCodes: []
      'sbg:modifiedOn': 1529009273
      x: 703
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': null
      'sbg:validationErrors': []
      'sbg:sbgMaintained': false
      description: >-
        Transforms user spreadsheet in preparation for KN analytics by removing
        noise, mapping gene names, and extracting metadata statistics
      stdout: ''
      successCodes: []
      'sbg:createdBy': mepstein
      class: CommandLineTool
    inputs:
      - id: '#KN_Spreadsheet_Preprocessor_V2.taxon'
        default: '9606'
      - id: '#KN_Spreadsheet_Preprocessor_V2.spreadsheet_format'
        default: samples_x_phenotypes
      - id: '#KN_Spreadsheet_Preprocessor_V2.output_name'
        default: phenotypic
      - id: '#KN_Spreadsheet_Preprocessor_V2.normalize'
        default: false
      - id: '#KN_Spreadsheet_Preprocessor_V2.map_names'
      - id: '#KN_Spreadsheet_Preprocessor_V2.input_file'
        source:
          - '#Expression_Spreadsheet_Builder_V2.metadata'
      - id: '#KN_Spreadsheet_Preprocessor_V2.filter_threshold'
      - id: '#KN_Spreadsheet_Preprocessor_V2.filter_min_percentage'
      - id: '#KN_Spreadsheet_Preprocessor_V2.category_max_traits'
        source:
          - '#category_max_traits'
    id: '#KN_Spreadsheet_Preprocessor_V2'
    outputs:
      - id: '#KN_Spreadsheet_Preprocessor_V2.params_yml'
      - id: '#KN_Spreadsheet_Preprocessor_V2.output_matrix'
      - id: '#KN_Spreadsheet_Preprocessor_V2.numeric_output_matrix'
      - id: '#KN_Spreadsheet_Preprocessor_V2.metadata'
      - id: '#KN_Spreadsheet_Preprocessor_V2.binary_output_matrix'
  - 'sbg:x': 707.3531341552736
    'sbg:y': 451.91181182861345
    run:
      'sbg:id': mepstein/geneprioritization/sp-pp-interface-v2/12
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
      'sbg:projectName': GenePrioritization
      'sbg:contributors':
        - mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:job':
        inputs:
          map_names: true
          spreadsheet_format: spreadsheet_format-string-value
          normalize: true
          filter_min_percentage: 3.512089799507774
          taxon: taxon-string-value
          filter_threshold: 1.5190595614190268
          output_name: output_name-string-value
          category_max_traits: 1
          input_file:
            secondaryFiles: []
            class: File
            size: 0
            path: /path/to/input_file.ext
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1518037552
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/geneprioritization/sp-pp-interface/9
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1518038403
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated to new version of SS_PP container; creates binary and
            numeric phenotypic spreadsheet outputs.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1518039882
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added metadata output file.
          'sbg:revision': 2
        - 'sbg:modifiedOn': 1518052855
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Modified documentation on inputs.
          'sbg:revision': 3
        - 'sbg:modifiedOn': 1519283540
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Changed input_delimiter to \t/TAB (remove altogether so it's
            inferred?).
          'sbg:revision': 4
        - 'sbg:modifiedOn': 1520367644
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Updated call to KN SS PP -- arguments, container version.'
          'sbg:revision': 5
        - 'sbg:modifiedOn': 1520367819
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added -M option (no mapping).
          'sbg:revision': 6
        - 'sbg:modifiedOn': 1524447774
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Updated container version; added dont_map and normalize
            inputs/parameters.
          'sbg:revision': 7
        - 'sbg:modifiedOn': 1524499769
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 8
        - 'sbg:modifiedOn': 1524596605
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Modified inputs and defaults a bit (e.g., dont_map_names is now
            map_names, with default being False, i.e., no mapping).
          'sbg:revision': 9
        - 'sbg:modifiedOn': 1528576122
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Added filter_min_percentage and filter_threshold inputs; new
            container version.
          'sbg:revision': 10
        - 'sbg:modifiedOn': 1528579024
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Changed docs on filter_min_percentage to say it was a float between
            0.0 and 1.0.
          'sbg:revision': 11
        - 'sbg:modifiedOn': 1529009273
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated container tag (20180614).
          'sbg:revision': 12
      inputs:
        - type:
            - string
          label: Species Taxon ID
          'sbg:toolDefaultValue': '9606'
          description: the taxonomic id for the species of interest
          id: '#taxon'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-t'
        - type:
            - string
          id: '#spreadsheet_format'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-s'
          label: Spreadsheet Format Type
          description: >-
            The keyword for different types of preprocessing (e.g.,
            genes_x_samples, genes_x_samples_check, or samples_x_phenotypes)
        - type:
            - 'null'
            - string
          id: '#output_name'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-o'
          label: Output Filename Prefix
          description: the output file name of the processes data frame
        - type:
            - 'null'
            - boolean
          label: Normalize Flag
          'sbg:toolDefaultValue': 'False'
          description: >-
            Whether to normalize the spreadsheet (default: False) (currently the
            only normalization available is z-score)
          id: '#normalize'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-n'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - boolean
          label: Map Names Flag
          'sbg:toolDefaultValue': 'False'
          description: 'The map names flag (default: False)'
          id: '#map_names'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-m'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - File
          label: The Original Spreadsheet
          'sbg:stageInput': link
          description: The original spreadsheet with row and column names
          id: '#input_file'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-i'
          required: false
        - type:
            - 'null'
            - float
          label: Filter Threshold
          'sbg:toolDefaultValue': '1.0'
          description: 'The filter threshold (see filter minimum percentage); default: 1.0'
          id: '#filter_threshold'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-F'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - float
          label: Filter Minimum Percentage
          'sbg:toolDefaultValue': '0.0'
          'sbg:stageInput': null
          description: >-
            If present, rows with a lower percentage of values below the filter
            threshold will be dropped; this is a float between 0.0 and 1.0;
            default: 0.0 (no filtering).
          id: '#filter_min_percentage'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-f'
          required: false
          'sbg:includeInPorts': true
        - type:
            - 'null'
            - int
          label: Max Traits in a Category
          'sbg:toolDefaultValue': '10'
          description: >-
            The maximum number of traits allowable for a trait to be considered
            "categorical"
          id: '#category_max_traits'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-c'
      'sbg:cmdPreview': >-
        sh sp_ymler.sh -t taxon-string-value -s spreadsheet_format-string-value
        -y run_params.yml  && python3
        /home/src/preprocess/spreadsheet_preprocess.py -run_directory ./
        -run_file run_params.yml
      'y': 451.91181182861345
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:revision': 12
      'sbg:project': mepstein/geneprioritization
      'sbg:modifiedBy': mepstein
      'sbg:toolAuthor': KnowEnG
      id: mepstein/geneprioritization/sp-pp-interface-v2/12
      'sbg:latestRevision': 12
      'sbg:revisionNotes': Updated container tag (20180614).
      outputs:
        - type:
            - 'null'
            - File
          outputBinding:
            glob: run_params.yml
          label: Configuration Parameter File
          id: '#params_yml'
          description: contains the values used in analysis
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: $job.inputs.output_name + '.tsv'
          label: Spreadsheet File
          id: '#output_matrix'
          description: Spreadsheet with columns and row headers
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: ' $job.inputs.output_name + ''.numeric.tsv'''
          label: Numeric Phenotypic Data
          id: '#numeric_output_matrix'
          description: Numeric Phenotypic Data
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: ' $job.inputs.output_name + ''.metadata'''
          label: Metadata
          id: '#metadata'
          description: Metadata
        - type:
            - 'null'
            - File
          outputBinding:
            glob:
              engine: '#cwl-js-engine'
              class: Expression
              script: ' $job.inputs.output_name + ''.binary.tsv'''
          label: Binary Phenotypic Data
          id: '#binary_output_matrix'
          description: Binary Phenotypic Data
      'sbg:createdOn': 1518037552
      label: KN Spreadsheet Preprocessor-V2
      stdin: ''
      baseCommand:
        - sh
        - sp_ymler.sh
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - dockerImageId: ''
          class: DockerRequirement
          dockerPull: 'mepsteindr/spreadsheet_preprocess:20180614'
      requirements:
        - fileDef:
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
          class: CreateFileRequirement
        - id: '#cwl-js-engine'
          class: ExpressionEngineRequirement
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      temporaryFailCodes: []
      'sbg:modifiedOn': 1529009273
      x: 707.3531341552736
      'sbg:publisher': sbg
      cwlVersion: 'sbg:draft-2'
      'sbg:image_url': null
      'sbg:validationErrors': []
      'sbg:sbgMaintained': false
      description: >-
        Transforms user spreadsheet in preparation for KN analytics by removing
        noise, mapping gene names, and extracting metadata statistics
      stdout: ''
      successCodes: []
      'sbg:createdBy': mepstein
      class: CommandLineTool
    inputs:
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.taxon'
        default: '9606'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.spreadsheet_format'
        default: genes_x_samples
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.output_name'
        default: genomic
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.normalize'
        default: false
        source:
          - '#normalize'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.map_names'
        source:
          - '#map_names'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.input_file'
        source:
          - '#Expression_Spreadsheet_Builder_V2.genomic_spreadsheet_file'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.filter_threshold'
        source:
          - '#filter_threshold'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.filter_min_percentage'
        source:
          - '#filter_min_percentage'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.category_max_traits'
    id: '#KN_Spreadsheet_Preprocessor_V2_1'
    outputs:
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.params_yml'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.output_matrix'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.numeric_output_matrix'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.metadata'
      - id: '#KN_Spreadsheet_Preprocessor_V2_1.binary_output_matrix'
'sbg:toolkitVersion': v1.0
description: "This [KnowEnG](https://knoweng.org/) workflow processes CGC input files with genomic data and generates genomic and phenotypic spreadsheets for use in genomic analyses.\n\nThe spreadsheets it produces are suitable for use in other KnowEnG knowledge-guided genomic analysis workflows.  One such example is the the [KnowEnG Gene Prioritization workflow](https://cgc.sbgenomics.com/public/apps#mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/), which could be used to find genomic features in CGC files that relate across samples to a phenotype annotated in the CGC file metadata.\n\nThe primary value of this workflow is that it is able to extract genomic features from many separate input files and merge them into a single spreadsheet for further analysis.  The workflow was originally designed to work with with Level 3 RNA-Seq gene expression data from The Cancer Genome Atlas (TCGA), but it has been adapted to make it more flexible and able to generalize to other datasets.\n\nGiven files with identical formats for multiple samples, having genomic feature labels in one column and genomic feature values in another, this Spreadsheet Builder workflow reformats the data and outputs a genomic spreadsheet that will be genomic features X samples.\n\nIn the example of the legacy TCGA data input files, there were four columns with the following headers:\n```\ngene\traw_counts\tmedian_length_normalized\tRPKM\n```\nWith such input files, the genomic feature labels can be extracted from the first column and the genomic feature values from any of the other three, such as the fourth column, the RPKM, using the parameters of the workflow.\n\nThis workflow uses the metadata associated with CGC files to produce phenotypic spreadsheet(s) that will be samples X phenotypes.  The sample labels that match between the genomic and phenotypic spreadsheets are extracted from the file metadata using a parameter of the workflow.\n\nIn addition to a phenotypic spreadsheet that contains all metadata, two additional phenotypic spreadsheets may be generated.  The first is a binary phenotypic data spreadsheet containing all the binary phenotypes present as well one binary indicator column for each category of the categorical phenotypes.  The second possible additional phenotypic data spreadsheet will contain all phenotypes which have only numerical values.  These separate phenotypic spreadsheets are helpful for providing inputs to analyses that are designed to work on certain specific data types.\n\n### Required inputs\n\nThis workflow has one required file input:\n\n1. Input Files (ID: *input_files*, type: a list of input files).  These are files that capture the same type of genomic data for multiple samples.  All files should be in the same format and have the same metadata associated with them.\n\nThere are no required input parameters.\n\n\n### Optional inputs\n\nThis workflow has nine optional input parameters:\n\n1. Metadata Sample ID Key (ID: *expected_header_key*, type: str, default: \"aliquot_id,sample_id\").  The metadata key to use to find the sample name/ID for a given input data file among its CGC metadata.  This can actually be a comma-separated list of valid keys, and the first one that is found in the metadata will be used.  The default value is \"aliquot_id,sample_id\", meaning that \"aliquot_id\" will be used if present, otherwise \"sample_id\".  If none of the keys are found in the metadata, an error will be thrown.\n\nThese labels will be the row names in the phenotypic files generated (which are samples X phenotypes) and the column headers in the genomic file generated (which is genes X samples).\n\n2. Data Input Separator (ID: *data_separator*, type: str, default: '\\t' [TAB]).  The separator that is used in the input data files (generally '\\t' [TAB] or ',').\n\n3. Gene Column Info (ID: *gene_column_info*, type: str, default: see description).  The name or the index of the column in the input data files that contains the genomic feature labels (indexes start at 1).  The default behavior is that if there is a column named \"gene\", that will be used; else the first column will be used.\n\n4. Data Column Info (ID: *data_column_info*, type: str, default: see description).  The name or the index of the column in the input data files that contains the genomic feature values (indexes start at 1).  The default behavior is that the last column will be used.\n\n5. Category Max Values (ID: *category_max_traits*, type: int, default: 10).  The maximum number of distinct values a phenotype can have in order for it to be considered \"categorical\".\n\n6) Map Names Flag (ID: *map_names*, type: boolean; default: False).  Whether to map the (row) names in the generated genomic spreadsheet.\n\n7) Normalize Flag (ID: *normalize*, type: boolean, default: False).  Whether to normalize the generated genomic spreadsheet (currently the only normalization available is z-score).\n\n8) Filter Minimum Percentage (ID: *filter_min_percentage*, type: float, default: 0.0/no filtering).  If present, rows with a lower percentage of values below the filter threshold will be dropped.  This should be a float between 0.0 and 1.0 (inclusive).\n\n9) Filter Threshold (ID: *filter_threshold*, type: float, default: 1.0).  The filter threshold (see Filter Minimum Percentage).\n\n\n### Outputs\n\nThis workflow generates up to eight output files (two of them may not be present, as described below).  These are outlined below.  The structure and order specified here may not match what's listed on the completed task page.\n\n#### Results\n\n* Genomic Spreadsheet File (file name: `genomic.tsv`).\n\n* Phenotypic Spreadsheet File (file name: `phenotypic.tsv`).\n\n* Numeric Phenotypic Spreadsheet File (file name: `phenotypic.numeric.tsv`).  If there are no columns with numeric (continuous) values in the phenotypic data, this file will not be present.\n\n* Binary Phenotypic Spreadsheet File (file name: `phenotypic.binary.tsv`).  If there are no columns with binary values in the phenotypic data, this file will not be present.\n\n#### Metadata and run info\n\n* Phenotypic Metadata File (file name: `phenotypic.metadata`).\n\n* Phenotypic Run Params yml (file name: `run_params.yml`).\n\n* Genomic Metadata File (file name: `genomic.metadata`).\n\n* Genomic Run Params yml (file name: `run_params.yml`).\n\n\n### Additional Resources\n\n[Quickstart Guide](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf) for this workflow\n\n[KnowEnG Analytics Platform](https://knoweng.org/analyze/) for knowledge-guided analysis\n\n[YouTube Tutorial](https://youtu.be/Vp76-Oz-Yuc) for this workflow in KnowEnG Platform\n\n[Additional Pipelines](https://knoweng.org/pipelines/) supported by KnowEnG\n\n\n### Acknowledgements\n\nThe KnowEnG BD2K center is supported by grant U54GM114838 awarded by NIGMS through funds provided by the trans-NIH Big Data to Knowledge (BD2K) initiative.\n\nThe Expression Spreadsheet Builder tool in this workflow was adapted from [a tool](https://github.com/sbg/nci-workshop/tree/master/GeneExpressionWF/GeneExpressionMunger) originally developed by Gaurav Kaushik and Boysha Tijanic of Seven Bridges for the Seven Bridges + NIH BD2K Hackathon, which took place April 1st to 3rd, 2016.\n\nQuestions or comments can be sent to knoweng-support@illinois.edu."
cwlVersion: 'sbg:draft-2'
'sbg:canvas_x': 56
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:categories':
  - Converters
'sbg:canvas_zoom': 0.6999999999999997
label: Spreadsheet Builder
'sbg:toolkit': KnowEnG_CGC
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder/1/raw/
'sbg:id': mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder/1
'sbg:revision': 1
'sbg:modifiedOn': 1529393356
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529393324
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-spreadsheetbuilder-public
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 1
'sbg:content_hash': null
