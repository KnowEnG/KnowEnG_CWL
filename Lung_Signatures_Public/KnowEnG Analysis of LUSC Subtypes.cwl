'sbg:toolkitVersion': v1.0
'sbg:publisher': KnowEnG
steps:
  - 'sbg:x': 316.11111111111114
    inputs:
      - id: '#Spreadsheet_Builder.normalize'
        default: false
        source:
          - '#normalize'
      - id: '#Spreadsheet_Builder.map_names'
        default: true
      - id: '#Spreadsheet_Builder.input_files'
        source:
          - '#input_files'
      - id: '#Spreadsheet_Builder.gene_column_info'
      - id: '#Spreadsheet_Builder.filter_threshold'
        source:
          - '#filter_threshold'
      - id: '#Spreadsheet_Builder.filter_min_percentage'
        source:
          - '#filter_min_percentage'
      - id: '#Spreadsheet_Builder.expected_header_key'
        source:
          - '#expected_header_key'
      - id: '#Spreadsheet_Builder.data_separator'
      - id: '#Spreadsheet_Builder.data_column_info'
      - id: '#Spreadsheet_Builder.category_max_traits'
        default: 24
    'sbg:y': 165.67835489908856
    run:
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:projectName': Lung_Signatures
      'sbg:publisher': KnowEnG
      'sbg:canvas_zoom': 0.6999999999999997
      'sbg:validationErrors': []
      'sbg:contributors':
        - mepstein
      'sbg:id': mepstein/lung/spreadsheet-builder/0
      inputs:
        - type:
            - 'null'
            - boolean
          required: false
          'sbg:y': 686.0713413783485
          id: '#normalize'
          description: >-
            Whether to normalize the generated genomic spreadsheet (default:
            False) (currently the only normalization available is z-score)
          'sbg:x': 142.49997820172996
          'sbg:includeInPorts': true
          label: Normalize Flag
        - type:
            - 'null'
            - boolean
          'sbg:y': 612.8571864536833
          id: '#map_names'
          description: >-
            Whether to map the (row) names in the generated genomic spreadsheet
            (default: False)
          'sbg:x': 41.785670689174125
          'sbg:includeInPorts': false
          label: Map Names Flag
        - type:
            - items: File
              type: array
              name: input_files
          required: true
          'sbg:y': 134.25000871930808
          id: '#input_files'
          description: >-
            The input files from which to build the genomic and phenotypic
            spreadsheets
          'sbg:x': 37.17857360839845
          'sbg:includeInPorts': true
          label: Input Files
        - type:
            - 'null'
            - string
          'sbg:y': 414.785853794643
          id: '#gene_column_info'
          description: >-
            The name or the index of the column to find the gene in the input
            data files (indexes start at 1); the default behavior is that if
            there is a column labeled "gene", that will be used; else the first
            column will be used.
          'sbg:x': 41.10714503696988
          'sbg:includeInPorts': false
          label: Gene Column Info
        - type:
            - 'null'
            - float
          required: false
          'sbg:y': 848.5714285714289
          id: '#filter_threshold'
          description: The filter threshold (see Filter Minimum Percentage).
          'sbg:x': 144.28575788225453
          'sbg:includeInPorts': true
          label: Filter Threshold
        - type:
            - 'null'
            - float
          required: false
          'sbg:y': 787.1428571428575
          id: '#filter_min_percentage'
          description: >-
            If present, rows with a lower percentage of values below the filter
            threshold will be dropped; this is a float between 0.0 and 1.0;
            default: 0.0 (no filtering).
          'sbg:x': 42.85716465541296
          'sbg:includeInPorts': true
          label: Filter Minimum Percentage
        - type:
            - 'null'
            - string
          required: false
          'sbg:y': 256.42857142857156
          id: '#expected_header_key'
          description: >-
            The metadata key to use for the Sample ID (acutally, this can be a
            comma-separated list of keys to try; the first one that is found in
            the metadata will be used; the default is "aliquot_id,sample_id"; if
            the key is not found in the metadata, an error will be thrown)
          'sbg:x': 38.21426391601564
          'sbg:includeInPorts': true
          label: Metadata Sample ID Key
        - type:
            - 'null'
            - string
          'sbg:y': 330.0000000000001
          id: '#data_separator'
          description: >-
            The separator used in the input data files (generally ',' or '\t'
            [TAB]; default: '\t')
          'sbg:x': 146.25002179827015
          'sbg:includeInPorts': false
          label: Data Input Separator
        - type:
            - 'null'
            - string
          'sbg:y': 504.78581019810287
          id: '#data_column_info'
          description: >-
            The name or the index of the column to find the data in the input
            data files (indexes start at 1); the default behavior is that the
            last column will be used.
          'sbg:x': 145.07143293108265
          'sbg:includeInPorts': false
          label: Data Column Info
        - type:
            - 'null'
            - int
          required: false
          'sbg:y': 13.035730634416858
          id: '#category_max_traits'
          description: >-
            The maximum number of distinct values allowable for a phenotype to
            be considered "categorical" (default: 10)
          'sbg:x': 32.321450369698674
          'sbg:includeInPorts': false
          label: Category Max Values
      'sbg:toolkitVersion': v1.0
      'sbg:revisionNotes': Copy of mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder/1
      'sbg:modifiedOn': 1530641566
      description: "This [KnowEnG](https://knoweng.org/) workflow processes CGC input files with genomic data and generates genomic and phenotypic spreadsheets for use in genomic analyses.\n\nThe spreadsheets it produces are suitable for use in other KnowEnG knowledge-guided genomic analysis workflows.  One such example is the the [KnowEnG Gene Prioritization workflow](https://cgc.sbgenomics.com/public/apps#mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/), which could be used to find genomic features in CGC files that relate across samples to a phenotype annotated in the CGC file metadata.\n\nThe primary value of this workflow is that it is able to extract genomic features from many separate input files and merge them into a single spreadsheet for further analysis.  The workflow was originally designed to work with with Level 3 RNA-Seq gene expression data from The Cancer Genome Atlas (TCGA), but it has been adapted to make it more flexible and able to generalize to other datasets.\n\nGiven files with identical formats for multiple samples, having genomic feature labels in one column and genomic feature values in another, this Spreadsheet Builder workflow reformats the data and outputs a genomic spreadsheet that will be genomic features X samples.\n\nIn the example of the legacy TCGA data input files, there were four columns with the following headers:\n```\ngene\traw_counts\tmedian_length_normalized\tRPKM\n```\nWith such input files, the genomic feature labels can be extracted from the first column and the genomic feature values from any of the other three, such as the fourth column, the RPKM, using the parameters of the workflow.\n\nThis workflow uses the metadata associated with CGC files to produce phenotypic spreadsheet(s) that will be samples X phenotypes.  The sample labels that match between the genomic and phenotypic spreadsheets are extracted from the file metadata using a parameter of the workflow.\n\nIn addition to a phenotypic spreadsheet that contains all metadata, two additional phenotypic spreadsheets may be generated.  The first is a binary phenotypic data spreadsheet containing all the binary phenotypes present as well one binary indicator column for each category of the categorical phenotypes.  The second possible additional phenotypic data spreadsheet will contain all phenotypes which have only numerical values.  These separate phenotypic spreadsheets are helpful for providing inputs to analyses that are designed to work on certain specific data types.\n\n### Required inputs\n\nThis workflow has one required file input:\n\n1. Input Files (ID: *input_files*, type: a list of input files).  These are files that capture the same type of genomic data for multiple samples.  All files should be in the same format and have the same metadata associated with them.\n\nThere are no required input parameters.\n\n\n### Optional inputs\n\nThis workflow has nine optional input parameters:\n\n1. Metadata Sample ID Key (ID: *expected_header_key*, type: str, default: \"aliquot_id,sample_id\").  The metadata key to use to find the sample name/ID for a given input data file among its CGC metadata.  This can actually be a comma-separated list of valid keys, and the first one that is found in the metadata will be used.  The default value is \"aliquot_id,sample_id\", meaning that \"aliquot_id\" will be used if present, otherwise \"sample_id\".  If none of the keys are found in the metadata, an error will be thrown.\n\nThese labels will be the row names in the phenotypic files generated (which are samples X phenotypes) and the column headers in the genomic file generated (which is genes X samples).\n\n2. Data Input Separator (ID: *data_separator*, type: str, default: '\\t' [TAB]).  The separator that is used in the input data files (generally '\\t' [TAB] or ',').\n\n3. Gene Column Info (ID: *gene_column_info*, type: str, default: see description).  The name or the index of the column in the input data files that contains the genomic feature labels (indexes start at 1).  The default behavior is that if there is a column named \"gene\", that will be used; else the first column will be used.\n\n4. Data Column Info (ID: *data_column_info*, type: str, default: see description).  The name or the index of the column in the input data files that contains the genomic feature values (indexes start at 1).  The default behavior is that the last column will be used.\n\n5. Category Max Values (ID: *category_max_traits*, type: int, default: 10).  The maximum number of distinct values a phenotype can have in order for it to be considered \"categorical\".\n\n6) Map Names Flag (ID: *map_names*, type: boolean; default: False).  Whether to map the (row) names in the generated genomic spreadsheet.\n\n7) Normalize Flag (ID: *normalize*, type: boolean, default: False).  Whether to normalize the generated genomic spreadsheet (currently the only normalization available is z-score).\n\n8) Filter Minimum Percentage (ID: *filter_min_percentage*, type: float, default: 0.0/no filtering).  If present, rows with a lower percentage of values below the filter threshold will be dropped.  This should be a float between 0.0 and 1.0 (inclusive).\n\n9) Filter Threshold (ID: *filter_threshold*, type: float, default: 1.0).  The filter threshold (see Filter Minimum Percentage).\n\n\n### Outputs\n\nThis workflow generates up to eight output files (two of them may not be present, as described below).  These are outlined below.  The structure and order specified here may not match what's listed on the completed task page.\n\n#### Results\n\n* Genomic Spreadsheet File (file name: `genomic.tsv`).\n\n* Phenotypic Spreadsheet File (file name: `phenotypic.tsv`).\n\n* Numeric Phenotypic Spreadsheet File (file name: `phenotypic.numeric.tsv`).  If there are no columns with numeric (continuous) values in the phenotypic data, this file will not be present.\n\n* Binary Phenotypic Spreadsheet File (file name: `phenotypic.binary.tsv`).  If there are no columns with binary values in the phenotypic data, this file will not be present.\n\n#### Metadata and run info\n\n* Phenotypic Metadata File (file name: `phenotypic.metadata`).\n\n* Phenotypic Run Params yml (file name: `run_params.yml`).\n\n* Genomic Metadata File (file name: `genomic.metadata`).\n\n* Genomic Run Params yml (file name: `run_params.yml`).\n\n\n### Additional Resources\n\n[Quickstart Guide](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf) for this workflow\n\n[KnowEnG Analytics Platform](https://knoweng.org/analyze/) for knowledge-guided analysis\n\n[YouTube Tutorial](https://youtu.be/Vp76-Oz-Yuc) for this workflow in KnowEnG Platform\n\n[Additional Pipelines](https://knoweng.org/pipelines/) supported by KnowEnG\n\n\n### Acknowledgements\n\nThe KnowEnG BD2K center is supported by grant U54GM114838 awarded by NIGMS through funds provided by the trans-NIH Big Data to Knowledge (BD2K) initiative.\n\nThe Expression Spreadsheet Builder tool in this workflow was adapted from [a tool](https://github.com/sbg/nci-workshop/tree/master/GeneExpressionWF/GeneExpressionMunger) originally developed by Gaurav Kaushik and Boysha Tijanic of Seven Bridges for the Seven Bridges + NIH BD2K Hackathon, which took place April 1st to 3rd, 2016.\n\nQuestions or comments can be sent to knoweng-support@illinois.edu."
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/lung/spreadsheet-builder/0.png
      outputs:
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 541.1764705882354
          id: '#params_yml_1'
          description: >-
            The configuration parameters specified for the spreadsheet
            preprocessor run
          'sbg:x': 1138.8235294117649
          'sbg:includeInPorts': true
          label: Genomic run_params_yml
          source:
            - '#KN_Spreadsheet_Preprocessor_V2_1.params_yml'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 37
          id: '#params_yml'
          description: >-
            The configuration parameters specified for the spreadsheet
            preprocessor run
          'sbg:x': 1128
          'sbg:includeInPorts': true
          label: Phenotypic run_params_yml
          source:
            - '#KN_Spreadsheet_Preprocessor_V2.params_yml'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 629.4117647058824
          id: '#output_matrix_1'
          description: The genomic spreadsheet file
          'sbg:x': 1275.2942612591912
          'sbg:includeInPorts': true
          label: Genomic Spreadsheet File
          source:
            - '#KN_Spreadsheet_Preprocessor_V2_1.output_matrix'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 124
          id: '#output_matrix'
          description: The phenotypic spreadsheet file
          'sbg:x': 1243
          'sbg:includeInPorts': true
          label: Phenotypic Spreadsheet File
          source:
            - '#KN_Spreadsheet_Preprocessor_V2.output_matrix'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 215
          id: '#numeric_output_matrix'
          description: The numeric columns of the phenotypic spreadsheet
          'sbg:x': 1127
          'sbg:includeInPorts': true
          label: Numeric Phenotypic Spreadsheet File
          source:
            - '#KN_Spreadsheet_Preprocessor_V2.numeric_output_matrix'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 708.2353659237133
          id: '#metadata_1'
          description: The metadata for the genomic data
          'sbg:x': 1144.7058823529414
          'sbg:includeInPorts': true
          label: Genomic Metadata
          source:
            - '#KN_Spreadsheet_Preprocessor_V2_1.metadata'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 395
          id: '#metadata'
          description: The metadata for the phenotypic data
          'sbg:x': 1133
          'sbg:includeInPorts': true
          label: Phenotypic Metadata
          source:
            - '#KN_Spreadsheet_Preprocessor_V2.metadata'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 327
          id: '#binary_output_matrix'
          description: The binary columns of the phenotypic spreadsheet
          'sbg:x': 1248
          'sbg:includeInPorts': true
          label: Binary Phenotypic Spreadsheet File
          source:
            - '#KN_Spreadsheet_Preprocessor_V2.binary_output_matrix'
      requirements: []
      'sbg:modifiedBy': mepstein
      label: Spreadsheet Builder
      'sbg:revision': 0
      'sbg:canvas_x': 56
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder/1
          'sbg:modifiedOn': 1530641566
          'sbg:revision': 0
      'sbg:createdOn': 1530641566
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:sbgMaintained': false
      'y': 165.67835489908856
      id: mepstein/lung/spreadsheet-builder/0
      x: 316.11111111111114
      'sbg:categories':
        - Converters
      'sbg:project': mepstein/lung
      'sbg:license': >-
        Copyright (c) 2017, University of Illinois Board of Trustees; All rights
        reserved.
      'sbg:toolkit': KnowEnG_CGC
      steps:
        - 'sbg:x': 420.75000762939464
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
          'sbg:y': 289.2499923706055
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            class: CommandLineTool
            'sbg:projectName': GenePrioritization
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            baseCommand:
              - python
              - munger.py
            'sbg:id': mepstein/geneprioritization/geneexprmunger-v2/18
            inputs:
              - 'sbg:toolDefaultValue': '\t [TAB]'
                type:
                  - 'null'
                  - string
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  position: 0
                  separate: true
                description: >-
                  The separator to use in the metadata output files (default:
                  '\t' [TAB])
                id: '#separator'
                'sbg:altPrefix': '--metadata_separator'
                label: Metadata Output Separator
              - type:
                  - string
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  position: 0
                  separate: true
                  valueFrom:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      // take what the user gives and pop any extensions to
                      prevent silly names like 'file.csv.csv'

                      $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                description: >-
                  Prefix to use on the various output files (e.g., the gene
                  expression data and the metadata)
                id: '#output_filename'
                'sbg:altPrefix': '--output_filename'
                label: Output Filename
              - type:
                  - items: File
                    type: array
                'sbg:stageInput': link
                required: true
                description: >-
                  Input array of TCGA Level 3 gene expression quantification
                  files
                id: '#input_files'
                'sbg:altPrefix': '--files'
                label: Input Files
              - type:
                  - 'null'
                  - string
                required: false
                inputBinding:
                  prefix: '-g'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  The name or the index of the column to find the gene in the
                  input data files (indexes start at 1); the default behavior is
                  that if there is a column labeled "gene", that will be used;
                  else the first column will be used.
                id: '#gene_column_info'
                'sbg:includeInPorts': true
                'sbg:altPrefix': '--gene_column_info'
                label: Gene Column Info
              - 'sbg:toolDefaultValue': 'aliquot_id,sample_id'
                type:
                  - 'null'
                  - string
                required: false
                description: >-
                  The metadata key to use for the Sample ID (acutally, this can
                  be a comma-separated list of keys to try; the first one that
                  is found in the metadata will be used; the default is
                  "aliquot_id,sample_id"; if the key is not found in the
                  metadata, an error will be thrown)
                id: '#expected_header_key'
                'sbg:includeInPorts': true
                label: Metadata Sample ID Key
              - 'sbg:toolDefaultValue': '\t [TAB]'
                type:
                  - 'null'
                  - string
                required: false
                inputBinding:
                  prefix: '-S'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#data_separator'
                description: >-
                  The separator used in the input data files (generally ',' or
                  '\t' [TAB]; default: '\t')
                'sbg:includeInPorts': true
                'sbg:altPrefix': '--data_separator'
                label: Data Input Separator
              - type:
                  - 'null'
                  - string
                required: false
                inputBinding:
                  prefix: '-d'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  The name or the index of the column to find the data in the
                  input data files (indexes start at 1); the default behavior is
                  that the last column will be used.
                id: '#data_column_info'
                'sbg:includeInPorts': true
                'sbg:altPrefix': '--data_column_info'
                label: Data Column Info
            'sbg:toolkitVersion': ''
            'sbg:publisher': sbg
            x: 420.75000762939464
            'sbg:revisionNotes': Updated description in some inputs.
            stdout: ''
            'sbg:modifiedOn': 1519848907
            description: >-
              Expression Spreadsheet Builder is a tool built for processing
              Level 3 RNA-seq gene expression data from The Cancer Genome Atlas.
              It will produce two tables of gene expression data (per gene, or
              per case) as well as a metadata table. It is capable of processing
              any number of files as it will automatically create an index for
              the list of files you specify, and then use that index in the
              command line.


              This code was modified from a version produced by Gaurav Kaushik
              with contributions from Boysha Tijanic for the Seven Bridges + NIH
              BD2K Hackathon, which took place April 1st to 3rd, 2016.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                id: '#metadata_t'
                description: >-
                  Metadata for the input files (transposed, phenotypes X
                  samples)
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                      '') + '_metadata_T.csv';

                      extension = 'tsv';

                      if ($job.inputs.separator && $job.inputs.separator == ',')
                      {
                          extension = '.csv';
                      }

                      $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                      + '_metadata_T.' + extension;
                  'sbg:metadata':
                    num_input_files:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: $job.inputs.input_files.length
                'sbg:fileTypes': CSV
                label: Metadata Matrix (Transposed)
              - type:
                  - 'null'
                  - File
                id: '#metadata'
                description: Metadata values for the input files (samples X phenotypes)
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                      '') + '_metadata.csv';

                      extension = 'tsv';

                      if ($job.inputs.separator && $job.inputs.separator == ',')
                      {
                          extension = '.csv';
                      }

                      $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                      + '_metadata.' + extension;
                  'sbg:metadata':
                    num_input_files:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: $job.inputs.input_files.length
                'sbg:fileTypes': CSV
                label: Metadata Matrix
              - type:
                  - 'null'
                  - File
                id: '#index'
                description: A file containing a list of the files used in this execution
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                      + '_file.txt'
                  'sbg:inheritMetadataFrom': '#input_files'
                  'sbg:metadata':
                    num_input_files:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: $job.inputs.input_files.length
                'sbg:fileTypes': TXT
                label: Index File
              - description: The genomic spreadsheet file
                type:
                  - 'null'
                  - File
                id: '#genomic_spreadsheet_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      extension = 'tsv';

                      if ($job.inputs.separator && $job.inputs.separator == ',')
                      {
                          extension = '.csv';
                      }

                      'genomic.' + extension;
                label: Genomic Spreadsheet File
              - type:
                  - 'null'
                  - File
                id: '#gene'
                description: Genes by Cases (genes X samples)
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      extension = 'tsv';

                      if ($job.inputs.separator && $job.inputs.separator == ',')
                      {
                          extension = '.csv';
                      }

                      $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                      + '_by_gene.' + extension;
                  'sbg:inheritMetadataFrom': '#input_files'
                  'sbg:metadata':
                    num_input_files: $job.inputs.input_files.length
                'sbg:fileTypes': CSV
                label: Gene Matrix
              - type:
                  - 'null'
                  - File
                id: '#case'
                description: Transpose of Gene (samples X genes)
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: >-
                      extension = 'tsv';

                      if ($job.inputs.separator && $job.inputs.separator == ',')
                      {
                          extension = '.csv';
                      }

                      $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                      + '_by_sample.' + extension;
                  'sbg:inheritMetadataFrom': '#input_files'
                  'sbg:metadata':
                    num_input_files:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: $job.inputs.input_files.length
                'sbg:fileTypes': CSV
                label: Case Matrix
            requirements:
              - fileDef:
                  - fileContent: >-
                      #!/usr/bin/env python3


                      """

                      usage: munger.py [-h] [-f FILES [FILES ...]] [-r
                      INDEX_FILE] [-c] [-o OUTPUT_FILENAME]


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

                      # df = pd.read_table(filename, skiprows=1) # to skip the
                      version row


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

                      # unless that's a '?', in which case returns the portion
                      after the '|'.

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

                        //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                        '') + '_metadata_T.csv';

                        extension = 'tsv';

                        if ($job.inputs.separator && $job.inputs.separator ==
                        ',') {
                            extension = '.csv';
                        }

                        $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                        '') + '_metadata_T.' + extension;

                        // take processed output_filename and add appropriate
                        suffix
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >-
                        $job.inputs.input_files.map(function(f){return
                        f.path.split('/').pop()}).join('\n');

                        // create an index file by taking the filename for each
                        input file in the input array

                        // an adding each in a new line (\n)
                    filename:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >-
                        // Index File

                        $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                        '') + '_file.txt'

                        // take processed output_filename and add appropriate
                        suffix
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

                        //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                        '') + '_metadata.csv';

                        extension = 'tsv';

                        if ($job.inputs.separator && $job.inputs.separator ==
                        ',') {
                            extension = '.csv';
                        }

                        $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g,
                        '') + '_metadata.' + extension;

                        // take processed output_filename and add appropriate
                        suffix
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            'sbg:modifiedBy': mepstein
            label: Expression Spreadsheet Builder-V2
            'sbg:revision': 18
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Copy of mepstein/geneprioritization/geneexprmunger/8
                'sbg:modifiedOn': 1517515526
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Updated to build complete metadata file.
                'sbg:modifiedOn': 1517515876
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added .sort() to output of metadata.
                'sbg:modifiedOn': 1517517339
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added creation of *metadata_T.csv file.
                'sbg:modifiedOn': 1517591446
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added expected_header_key input.
                'sbg:modifiedOn': 1517612583
                'sbg:revision': 4
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added -T option for tab-separated output.
                'sbg:modifiedOn': 1518044439
                'sbg:revision': 5
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1518052898
                'sbg:revision': 6
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added renaming of genomic output file.
                'sbg:modifiedOn': 1518055214
                'sbg:revision': 7
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added genomic spreadsheet output file.
                'sbg:modifiedOn': 1518055436
                'sbg:revision': 8
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Added separator input parameter (and modified generation of
                  metadata files).
                'sbg:modifiedOn': 1519016381
                'sbg:revision': 9
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Updated munger.py, file names of created files, command line
                  arguments, and a few other things.
                'sbg:modifiedOn': 1519199390
                'sbg:revision': 10
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Updated munger.py, inputs, outputs, arguments.'
                'sbg:modifiedOn': 1519243797
                'sbg:revision': 11
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Fixed name of file for output case.
                'sbg:modifiedOn': 1519252148
                'sbg:revision': 12
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Updated container, metadata js, munger.py, inputs.'
                'sbg:modifiedOn': 1519761510
                'sbg:revision': 13
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Added filename to metadata generations scripts, and munger.py.'
                'sbg:modifiedOn': 1519795221
                'sbg:revision': 14
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Added data_separator input, updated munger.py.'
                'sbg:modifiedOn': 1519845042
                'sbg:revision': 15
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added alternative prefix for some inputs.
                'sbg:modifiedOn': 1519847517
                'sbg:revision': 16
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Updated description on expected_header_key input.
                'sbg:modifiedOn': 1519848494
                'sbg:revision': 17
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Updated description in some inputs.
                'sbg:modifiedOn': 1519848907
                'sbg:revision': 18
            'sbg:createdOn': 1517515526
            'sbg:license': ''
            'sbg:sbgMaintained': false
            'y': 289.2499923706055
            id: mepstein/geneprioritization/geneexprmunger-v2/18
            cwlVersion: 'sbg:draft-2'
            'sbg:categories':
              - TCGA
              - CCLE
              - spreadsheet
            'sbg:project': mepstein/geneprioritization
            'sbg:createdBy': mepstein
            'sbg:toolkit': ''
            'sbg:cmdPreview': >-
              python munger.py -o output -t -r output_file.txt -m
              output_metadata.tsv && cp -p output_by_gene.tsv genomic.tsv
            stdin: ''
            arguments:
              - position: 0
                separate: false
                valueFrom: '-t'
              - prefix: '-r'
                valueFrom:
                  engine: '#cwl-js-engine'
                  class: Expression
                  script: >-
                    $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                    '_file.txt'
                separate: true
              - position: 5
                separate: false
                valueFrom: '&&'
              - position: 6
                separate: false
                valueFrom: cp
              - position: 7
                separate: false
                valueFrom: '-p'
              - position: 8
                separate: false
                valueFrom:
                  engine: '#cwl-js-engine'
                  class: Expression
                  script: >-
                    // Metadata CSV

                    //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                    + '_metadata.csv';

                    extension = 'tsv';

                    if ($job.inputs.separator && $job.inputs.separator == ',') {
                        extension = '.csv';
                    }

                    $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                    '_by_gene.' + extension;

                    // take processed output_filename and add appropriate suffix
              - position: 9
                separate: false
                valueFrom:
                  engine: '#cwl-js-engine'
                  class: Expression
                  script: >-
                    // Metadata CSV

                    //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                    + '_metadata.csv';

                    extension = 'tsv';

                    if ($job.inputs.separator && $job.inputs.separator == ',') {
                        extension = '.csv';
                    }

                    'genomic.' + extension;
              - prefix: '-m'
                position: 0
                separate: true
                valueFrom:
                  engine: '#cwl-js-engine'
                  class: Expression
                  script: >-
                    // Metadata CSV

                    //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
                    + '_metadata.csv';

                    extension = 'tsv';

                    if ($job.inputs.separator && $job.inputs.separator == ',') {
                        extension = '.csv';
                    }

                    $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
                    '_metadata.' + extension;

                    // take processed output_filename and add appropriate suffix
            'sbg:latestRevision': 18
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: continuumio/anaconda3
                dockerImageId: ''
                class: DockerRequirement
            'sbg:toolAuthor': ''
            successCodes: []
            'sbg:job':
              inputs:
                input_files:
                  - path: /path/to/input_files-1.txt
                    metadata:
                      case_id: TCGA-CM-4746
                      age_at_diagnosis: '61'
                      race: BLACK OR AFRICAN AMERICAN
                    class: File
                    size: 0
                    secondaryFiles: []
                  - path: /path/to/input_files-2.txt
                    metadata:
                      ethnicity: BLACK
                      age_at_diagnosis: '41'
                      case_id: TCGA-CM-1415
                    class: File
                    size: 0
                    secondaryFiles: []
                  - metadata:
                      case_id: TCGA-AHSOAD
                      age_at_diagnosis: '89'
                    size: 0
                    path: /path/to/input_files-3.txt
                    secondaryFiles: []
                expected_header_key: expected_header_key-string-value
                gene_column_info: gene_column_info-string-value
                data_column_info: data_column_info-string-value
                output_filename: output.csv
                separator: separator-string-value
                data_separator: data_separator-string-value
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Expression_Spreadsheet_Builder_V2'
          outputs:
            - id: '#Expression_Spreadsheet_Builder_V2.metadata_t'
            - id: '#Expression_Spreadsheet_Builder_V2.metadata'
            - id: '#Expression_Spreadsheet_Builder_V2.index'
            - id: '#Expression_Spreadsheet_Builder_V2.genomic_spreadsheet_file'
            - id: '#Expression_Spreadsheet_Builder_V2.gene'
            - id: '#Expression_Spreadsheet_Builder_V2.case'
        - 'sbg:x': 703
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
          'sbg:y': 85.00000000000003
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': GenePrioritization
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            'sbg:project': mepstein/geneprioritization
            'sbg:id': mepstein/geneprioritization/sp-pp-interface-v2/12
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - string
                inputBinding:
                  prefix: '-t'
                  'sbg:cmdInclude': true
                  separate: true
                description: the taxonomic id for the species of interest
                id: '#taxon'
                label: Species Taxon ID
              - id: '#spreadsheet_format'
                type:
                  - string
                description: >-
                  The keyword for different types of preprocessing (e.g.,
                  genes_x_samples, genes_x_samples_check, or
                  samples_x_phenotypes)
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  separate: true
                label: Spreadsheet Format Type
              - id: '#output_name'
                type:
                  - 'null'
                  - string
                description: the output file name of the processes data frame
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  separate: true
                label: Output Filename Prefix
              - 'sbg:toolDefaultValue': 'False'
                type:
                  - 'null'
                  - boolean
                inputBinding:
                  prefix: '-n'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  Whether to normalize the spreadsheet (default: False)
                  (currently the only normalization available is z-score)
                id: '#normalize'
                label: Normalize Flag
              - 'sbg:toolDefaultValue': 'False'
                type:
                  - 'null'
                  - boolean
                inputBinding:
                  prefix: '-m'
                  'sbg:cmdInclude': true
                  separate: true
                description: 'The map names flag (default: False)'
                id: '#map_names'
                label: Map Names Flag
              - type:
                  - 'null'
                  - File
                'sbg:stageInput': link
                required: false
                inputBinding:
                  prefix: '-i'
                  'sbg:cmdInclude': true
                  separate: true
                description: The original spreadsheet with row and column names
                id: '#input_file'
                label: The Original Spreadsheet
              - 'sbg:toolDefaultValue': '1.0'
                type:
                  - 'null'
                  - float
                inputBinding:
                  prefix: '-F'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  The filter threshold (see filter minimum percentage); default:
                  1.0
                id: '#filter_threshold'
                label: Filter Threshold
              - 'sbg:toolDefaultValue': '0.0'
                type:
                  - 'null'
                  - float
                'sbg:stageInput': null
                inputBinding:
                  prefix: '-f'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  If present, rows with a lower percentage of values below the
                  filter threshold will be dropped; this is a float between 0.0
                  and 1.0; default: 0.0 (no filtering).
                id: '#filter_min_percentage'
                label: Filter Minimum Percentage
              - 'sbg:toolDefaultValue': '10'
                type:
                  - 'null'
                  - int
                required: false
                inputBinding:
                  prefix: '-c'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  The maximum number of traits allowable for a trait to be
                  considered "categorical"
                id: '#category_max_traits'
                'sbg:includeInPorts': true
                label: Max Traits in a Category
            'sbg:publisher': sbg
            x: 703
            'sbg:revisionNotes': Updated container tag (20180614).
            arguments:
              - prefix: '-y'
                position: 0
                separate: true
                valueFrom: run_params.yml
              - position: 6
                separate: true
                valueFrom: '&& python3 /home/src/preprocess/spreadsheet_preprocess.py'
              - prefix: '-run_directory'
                position: 7
                separate: true
                valueFrom: ./
              - prefix: '-run_file'
                position: 8
                separate: true
                valueFrom: run_params.yml
            'sbg:modifiedOn': 1529009273
            description: >-
              Transforms user spreadsheet in preparation for KN analytics by
              removing noise, mapping gene names, and extracting metadata
              statistics
            'sbg:image_url': null
            outputs:
              - description: contains the values used in analysis
                type:
                  - 'null'
                  - File
                id: '#params_yml'
                outputBinding:
                  glob: run_params.yml
                label: Configuration Parameter File
              - description: Spreadsheet with columns and row headers
                type:
                  - 'null'
                  - File
                id: '#output_matrix'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: $job.inputs.output_name + '.tsv'
                label: Spreadsheet File
              - description: Numeric Phenotypic Data
                type:
                  - 'null'
                  - File
                id: '#numeric_output_matrix'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: ' $job.inputs.output_name + ''.numeric.tsv'''
                label: Numeric Phenotypic Data
              - description: Metadata
                type:
                  - 'null'
                  - File
                id: '#metadata'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: ' $job.inputs.output_name + ''.metadata'''
                label: Metadata
              - description: Binary Phenotypic Data
                type:
                  - 'null'
                  - File
                id: '#binary_output_matrix'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: ' $job.inputs.output_name + ''.binary.tsv'''
                label: Binary Phenotypic Data
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
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: KN Spreadsheet Preprocessor-V2
            'sbg:revision': 12
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Copy of mepstein/geneprioritization/sp-pp-interface/9
                'sbg:modifiedOn': 1518037552
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Updated to new version of SS_PP container; creates binary and
                  numeric phenotypic spreadsheet outputs.
                'sbg:modifiedOn': 1518038403
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added metadata output file.
                'sbg:modifiedOn': 1518039882
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Modified documentation on inputs.
                'sbg:modifiedOn': 1518052855
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Changed input_delimiter to \t/TAB (remove altogether so it's
                  inferred?).
                'sbg:modifiedOn': 1519283540
                'sbg:revision': 4
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Updated call to KN SS PP -- arguments, container version.'
                'sbg:modifiedOn': 1520367644
                'sbg:revision': 5
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added -M option (no mapping).
                'sbg:modifiedOn': 1520367819
                'sbg:revision': 6
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Updated container version; added dont_map and normalize
                  inputs/parameters.
                'sbg:modifiedOn': 1524447774
                'sbg:revision': 7
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1524499769
                'sbg:revision': 8
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified inputs and defaults a bit (e.g., dont_map_names is
                  now map_names, with default being False, i.e., no mapping).
                'sbg:modifiedOn': 1524596605
                'sbg:revision': 9
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Added filter_min_percentage and filter_threshold inputs; new
                  container version.
                'sbg:modifiedOn': 1528576122
                'sbg:revision': 10
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Changed docs on filter_min_percentage to say it was a float
                  between 0.0 and 1.0.
                'sbg:modifiedOn': 1528579024
                'sbg:revision': 11
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Updated container tag (20180614).
                'sbg:modifiedOn': 1529009273
                'sbg:revision': 12
            id: mepstein/geneprioritization/sp-pp-interface-v2/12
            'sbg:createdOn': 1518037552
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 85.00000000000003
            'sbg:cmdPreview': >-
              sh sp_ymler.sh -t taxon-string-value -s
              spreadsheet_format-string-value -y run_params.yml  && python3
              /home/src/preprocess/spreadsheet_preprocess.py -run_directory ./
              -run_file run_params.yml
            cwlVersion: 'sbg:draft-2'
            baseCommand:
              - sh
              - sp_ymler.sh
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 12
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: 'mepsteindr/spreadsheet_preprocess:20180614'
                dockerImageId: ''
                class: DockerRequirement
            'sbg:toolAuthor': KnowEnG
            successCodes: []
            'sbg:job':
              inputs:
                filter_min_percentage: 3.512089799507774
                normalize: true
                taxon: taxon-string-value
                map_names: true
                output_name: output_name-string-value
                spreadsheet_format: spreadsheet_format-string-value
                category_max_traits: 1
                input_file:
                  path: /path/to/input_file.ext
                  class: File
                  size: 0
                  secondaryFiles: []
                filter_threshold: 1.5190595614190268
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#KN_Spreadsheet_Preprocessor_V2'
          outputs:
            - id: '#KN_Spreadsheet_Preprocessor_V2.params_yml'
            - id: '#KN_Spreadsheet_Preprocessor_V2.output_matrix'
            - id: '#KN_Spreadsheet_Preprocessor_V2.numeric_output_matrix'
            - id: '#KN_Spreadsheet_Preprocessor_V2.metadata'
            - id: '#KN_Spreadsheet_Preprocessor_V2.binary_output_matrix'
        - 'sbg:x': 707.3531341552736
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
          'sbg:y': 451.91181182861345
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': GenePrioritization
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            'sbg:project': mepstein/geneprioritization
            'sbg:id': mepstein/geneprioritization/sp-pp-interface-v2/12
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - string
                inputBinding:
                  prefix: '-t'
                  'sbg:cmdInclude': true
                  separate: true
                description: the taxonomic id for the species of interest
                id: '#taxon'
                label: Species Taxon ID
              - id: '#spreadsheet_format'
                type:
                  - string
                description: >-
                  The keyword for different types of preprocessing (e.g.,
                  genes_x_samples, genes_x_samples_check, or
                  samples_x_phenotypes)
                inputBinding:
                  prefix: '-s'
                  'sbg:cmdInclude': true
                  separate: true
                label: Spreadsheet Format Type
              - id: '#output_name'
                type:
                  - 'null'
                  - string
                description: the output file name of the processes data frame
                inputBinding:
                  prefix: '-o'
                  'sbg:cmdInclude': true
                  separate: true
                label: Output Filename Prefix
              - 'sbg:toolDefaultValue': 'False'
                type:
                  - 'null'
                  - boolean
                required: false
                inputBinding:
                  prefix: '-n'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  Whether to normalize the spreadsheet (default: False)
                  (currently the only normalization available is z-score)
                id: '#normalize'
                'sbg:includeInPorts': true
                label: Normalize Flag
              - 'sbg:toolDefaultValue': 'False'
                type:
                  - 'null'
                  - boolean
                required: false
                inputBinding:
                  prefix: '-m'
                  'sbg:cmdInclude': true
                  separate: true
                description: 'The map names flag (default: False)'
                id: '#map_names'
                'sbg:includeInPorts': true
                label: Map Names Flag
              - type:
                  - 'null'
                  - File
                'sbg:stageInput': link
                required: false
                inputBinding:
                  prefix: '-i'
                  'sbg:cmdInclude': true
                  separate: true
                description: The original spreadsheet with row and column names
                id: '#input_file'
                label: The Original Spreadsheet
              - 'sbg:toolDefaultValue': '1.0'
                type:
                  - 'null'
                  - float
                required: false
                inputBinding:
                  prefix: '-F'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  The filter threshold (see filter minimum percentage); default:
                  1.0
                id: '#filter_threshold'
                'sbg:includeInPorts': true
                label: Filter Threshold
              - 'sbg:toolDefaultValue': '0.0'
                type:
                  - 'null'
                  - float
                'sbg:stageInput': null
                required: false
                inputBinding:
                  prefix: '-f'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  If present, rows with a lower percentage of values below the
                  filter threshold will be dropped; this is a float between 0.0
                  and 1.0; default: 0.0 (no filtering).
                id: '#filter_min_percentage'
                'sbg:includeInPorts': true
                label: Filter Minimum Percentage
              - 'sbg:toolDefaultValue': '10'
                type:
                  - 'null'
                  - int
                inputBinding:
                  prefix: '-c'
                  'sbg:cmdInclude': true
                  separate: true
                description: >-
                  The maximum number of traits allowable for a trait to be
                  considered "categorical"
                id: '#category_max_traits'
                label: Max Traits in a Category
            'sbg:publisher': sbg
            x: 707.3531341552736
            'sbg:revisionNotes': Updated container tag (20180614).
            arguments:
              - prefix: '-y'
                position: 0
                separate: true
                valueFrom: run_params.yml
              - position: 6
                separate: true
                valueFrom: '&& python3 /home/src/preprocess/spreadsheet_preprocess.py'
              - prefix: '-run_directory'
                position: 7
                separate: true
                valueFrom: ./
              - prefix: '-run_file'
                position: 8
                separate: true
                valueFrom: run_params.yml
            'sbg:modifiedOn': 1529009273
            description: >-
              Transforms user spreadsheet in preparation for KN analytics by
              removing noise, mapping gene names, and extracting metadata
              statistics
            'sbg:image_url': null
            outputs:
              - description: contains the values used in analysis
                type:
                  - 'null'
                  - File
                id: '#params_yml'
                outputBinding:
                  glob: run_params.yml
                label: Configuration Parameter File
              - description: Spreadsheet with columns and row headers
                type:
                  - 'null'
                  - File
                id: '#output_matrix'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: $job.inputs.output_name + '.tsv'
                label: Spreadsheet File
              - description: Numeric Phenotypic Data
                type:
                  - 'null'
                  - File
                id: '#numeric_output_matrix'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: ' $job.inputs.output_name + ''.numeric.tsv'''
                label: Numeric Phenotypic Data
              - description: Metadata
                type:
                  - 'null'
                  - File
                id: '#metadata'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: ' $job.inputs.output_name + ''.metadata'''
                label: Metadata
              - description: Binary Phenotypic Data
                type:
                  - 'null'
                  - File
                id: '#binary_output_matrix'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: ' $job.inputs.output_name + ''.binary.tsv'''
                label: Binary Phenotypic Data
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
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: KN Spreadsheet Preprocessor-V2
            'sbg:revision': 12
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Copy of mepstein/geneprioritization/sp-pp-interface/9
                'sbg:modifiedOn': 1518037552
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Updated to new version of SS_PP container; creates binary and
                  numeric phenotypic spreadsheet outputs.
                'sbg:modifiedOn': 1518038403
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added metadata output file.
                'sbg:modifiedOn': 1518039882
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Modified documentation on inputs.
                'sbg:modifiedOn': 1518052855
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Changed input_delimiter to \t/TAB (remove altogether so it's
                  inferred?).
                'sbg:modifiedOn': 1519283540
                'sbg:revision': 4
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': 'Updated call to KN SS PP -- arguments, container version.'
                'sbg:modifiedOn': 1520367644
                'sbg:revision': 5
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added -M option (no mapping).
                'sbg:modifiedOn': 1520367819
                'sbg:revision': 6
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Updated container version; added dont_map and normalize
                  inputs/parameters.
                'sbg:modifiedOn': 1524447774
                'sbg:revision': 7
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1524499769
                'sbg:revision': 8
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified inputs and defaults a bit (e.g., dont_map_names is
                  now map_names, with default being False, i.e., no mapping).
                'sbg:modifiedOn': 1524596605
                'sbg:revision': 9
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Added filter_min_percentage and filter_threshold inputs; new
                  container version.
                'sbg:modifiedOn': 1528576122
                'sbg:revision': 10
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Changed docs on filter_min_percentage to say it was a float
                  between 0.0 and 1.0.
                'sbg:modifiedOn': 1528579024
                'sbg:revision': 11
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Updated container tag (20180614).
                'sbg:modifiedOn': 1529009273
                'sbg:revision': 12
            id: mepstein/geneprioritization/sp-pp-interface-v2/12
            'sbg:createdOn': 1518037552
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 451.91181182861345
            'sbg:cmdPreview': >-
              sh sp_ymler.sh -t taxon-string-value -s
              spreadsheet_format-string-value -y run_params.yml  && python3
              /home/src/preprocess/spreadsheet_preprocess.py -run_directory ./
              -run_file run_params.yml
            cwlVersion: 'sbg:draft-2'
            baseCommand:
              - sh
              - sp_ymler.sh
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 12
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: 'mepsteindr/spreadsheet_preprocess:20180614'
                dockerImageId: ''
                class: DockerRequirement
            'sbg:toolAuthor': KnowEnG
            successCodes: []
            'sbg:job':
              inputs:
                filter_min_percentage: 3.512089799507774
                normalize: true
                taxon: taxon-string-value
                map_names: true
                output_name: output_name-string-value
                spreadsheet_format: spreadsheet_format-string-value
                category_max_traits: 1
                input_file:
                  path: /path/to/input_file.ext
                  class: File
                  size: 0
                  secondaryFiles: []
                filter_threshold: 1.5190595614190268
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#KN_Spreadsheet_Preprocessor_V2_1'
          outputs:
            - id: '#KN_Spreadsheet_Preprocessor_V2_1.params_yml'
            - id: '#KN_Spreadsheet_Preprocessor_V2_1.output_matrix'
            - id: '#KN_Spreadsheet_Preprocessor_V2_1.numeric_output_matrix'
            - id: '#KN_Spreadsheet_Preprocessor_V2_1.metadata'
            - id: '#KN_Spreadsheet_Preprocessor_V2_1.binary_output_matrix'
      'sbg:createdBy': mepstein
      cwlVersion: 'sbg:draft-2'
      'sbg:latestRevision': 0
      hints: []
      'sbg:toolAuthor': KnowEnG
      'sbg:canvas_y': 34
      'sbg:copyOf': mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder/1
      class: Workflow
    id: '#Spreadsheet_Builder'
    outputs:
      - id: '#Spreadsheet_Builder.params_yml_1'
      - id: '#Spreadsheet_Builder.params_yml'
      - id: '#Spreadsheet_Builder.output_matrix_1'
      - id: '#Spreadsheet_Builder.output_matrix'
      - id: '#Spreadsheet_Builder.numeric_output_matrix'
      - id: '#Spreadsheet_Builder.metadata_1'
      - id: '#Spreadsheet_Builder.metadata'
      - id: '#Spreadsheet_Builder.binary_output_matrix'
  - 'sbg:x': 532.6966050091912
    inputs:
      - id: '#Signature_Analysis_Workflow.taxonid'
        default: '9606'
      - id: '#Signature_Analysis_Workflow.similarity_measure'
        source:
          - '#similarity_measure'
      - id: '#Signature_Analysis_Workflow.signatures_file'
        source:
          - '#signatures_file'
      - id: '#Signature_Analysis_Workflow.samples_file'
        source:
          - '#Spreadsheet_Builder.output_matrix_1'
      - id: '#Signature_Analysis_Workflow.dont_map_signatures'
      - id: '#Signature_Analysis_Workflow.dont_map_samples'
    'sbg:y': 285.5820599724265
    run:
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:projectName': Lung_Signatures
      'sbg:publisher': KnowEnG
      'sbg:canvas_zoom': 0.8499999999999999
      'sbg:validationErrors': []
      'sbg:contributors':
        - mepstein
      'sbg:id': mepstein/lung/signature-analysis-workflow/0
      inputs:
        - type:
            - 'null'
            - string
          required: false
          'sbg:y': 237
          id: '#taxonid'
          description: >-
            The species taxon ID (e.g., 9606 for human).See
            https://knoweng.org/kn-data-references/ for possible values (KN
            Contents by Species).
          'sbg:x': 63
          'sbg:includeInPorts': false
          label: Species Taxon ID
        - type:
            - 'null'
            - type: enum
              name: similarity_measure
              symbols:
                - cosine
                - pearson
                - spearman
          required: false
          'sbg:y': 558
          id: '#similarity_measure'
          description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
          'sbg:x': 75
          'sbg:includeInPorts': true
          label: Similarity Measure
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 368
          id: '#signatures_file'
          description: The signatures file
          'sbg:x': 66
          'sbg:includeInPorts': true
          label: Signatures File
        - type:
            - File
          required: true
          'sbg:y': 50
          id: '#samples_file'
          description: The samples file
          'sbg:x': 55
          'sbg:includeInPorts': true
          label: Samples File
        - type:
            - 'null'
            - boolean
          'sbg:y': 456
          id: '#dont_map_signatures'
          description: 'If set, the names will not be mapped'
          'sbg:x': 158
          'sbg:includeInPorts': false
          label: Dont Map Signatures Flag
        - type:
            - 'null'
            - boolean
          'sbg:y': 133
          id: '#dont_map_samples'
          description: 'If set, the names will not be mapped'
          'sbg:x': 149
          'sbg:includeInPorts': false
          label: Dont Map Samples Flag
      'sbg:toolkitVersion': v1.0
      'sbg:revisionNotes': >-
        Copy of
        mepstein/knoweng-signature-analysis-public/signature-analysis-workflow/1
      'sbg:modifiedOn': 1530641561
      description: >-
        This [KnowEnG](https://knoweng.org/) workflow matches genomic profiles
        from a user-supplied query spreadsheet to a library of genomic
        signatures determined in previous studies.  The query genomic profiles
        will come from different biological samples under investigation and will
        often be measurement of gene expression.  The library of signatures must
        be provided by the user and should contain similarly derived measurement
        for specific conditions or treatments.  In this Signature Analysis
        Pipeline, we find the list of common genomic features between the query
        and library and then rank the library signatures in order of the
        selected Similarity Measure for each query.


        ### Required inputs


        This workflow has two required file inputs:


        1. Samples File (ID: *samples_file*, type: file), a spreadsheet
        containing the query signatures.  Rows are gene labels, columns are
        sample labels, and entries can be genomic measurements such as gene
        expression levels (e.g., z-scores).


        2. Signatures File (ID: *signatures_file*, type: file), a spreadsheet
        containing the library signatures.  Rows are gene labels, columns are
        signature labels, and entries are genomic measurements analogous to the
        ones in the samples file.


        There is one required input parameters.


        1. Similarity Measure (ID: *similarity_measure*, type: enum ["cosine",
        "pearson", "spearman"]).  The similarity measure to use in the signature
        analysis.



        ### Optional inputs


        There are three optional input parameters.


        1. Species Taxon ID (ID: *taxonid*; type: string, default: "9606").  The
        ID of the species to be used in the analysis, e.g., "9606" for human. 
        Possible values are listed in parentheses in the first column of the
        [KnowEnG Supported
        Species](https://knoweng.org/kn-data-references/#kn_contents_by_species)
        table ("KN Contents by Species").  This value is only needed if gene
        name mapping is going to be done on either the samples or signatures
        files.


        2. Dont Map Samples Flag (ID: *dont_map_samples*, type: boolean,
        default: False).  If set, do not perform gene mapping on the samples
        file.  (The default is False, i.e., mapping will be done.)


        3. Dont Map Signatures Flag (ID: *dont_map_signatures*, type: boolean,
        default: False).  If set, do not perform gene mapping on the signatures
        file.  (The default is False, i.e., mapping will be done.)



        ### Outputs


        This workflow generates up to seven output files.  These are outlined
        below.  The structure and order specified here may not match what's
        listed on the completed task page.  The README output file goes into
        more detail on the purpose and the contents of the various output
        files.  That file can also be found
        [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-SA.md).


        #### Results


        * Similarity Matrix File (file name: `similarity_matrix.tsv`).


        * Similarity Matrix Binary File (file name:
        `similarity_matrix.binary.tsv`).  This file is similar to the Similarity
        Matrix File, with each row (sample) containing a 1 in the column for the
        signature with the highest similarity score, 0's in all the other
        columns.


        * README (file name: `README-SA.md`).  This file describes the various
        output files.


        #### Mapping


        * Clean Samples File (file name: `clean_samples_matrix.tsv`).


        * Clean Signatures File (file name: `clean_signatures_matrix.tsv`).


        * Gene Mapping File (file name: `gene_map.txt`).  (This file will only
        be produced if mapping was done on at least one of the input files.)


        #### Metadata and run info


        * Signature Analysis Run Params yml (file name: `run_params.yml`).



        ### Additional Resources


        [Quickstart
        Guide](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf)
        for this workflow


        [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
        knowledge-guided analysis


        [YouTube Tutorial](https://youtu.be/Vp76-Oz-Yuc) for this workflow in
        KnowEnG Platform


        [Additional Pipelines](https://knoweng.org/pipelines/) supported by
        KnowEnG



        ### Acknowledgements


        The KnowEnG BD2K center is supported by grant U54GM114838 awarded by
        NIGMS through funds provided by the trans-NIH Big Data to Knowledge
        (BD2K) initiative.


        Questions or comments can be sent to knoweng-support@illinois.edu.



        ### References


        Liu, Rui, et al. "The prognostic role of a gene signature from
        tumorigenic breast-cancer cells." New England Journal of Medicine 356.3
        (2007): 217-226.



        ### Demo Data


        Demo samples and signatures files are provided for this workflow.  Below
        is a description of these files and how they were obtained.  These files
        can also be found
        [here](https://github.com/KnowEnG/quickstart-demos/blob/master/demo_files/).


        #### Demo samples file: name: `demo_SA.samples.txt`


        This file is a set of sample expression values from the TCGA GRCh38 data
        set.  It was created from data in the CGC, using the following steps:


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
        `*.FPKM-UQ.txt`, and `*.FPKM.txt`.  Copy these files to a project. 
        (Things will be easier if you tag the files when you copy them.)


        2. Looking at these files in the project, remove those that match the
        first two of these patterns, leaving only those of the form `*.FPKM.txt`
        (551 files).


        3. Run the [Spreadsheet
        Builder](https://cgc.sbgenomics.com/u/mepstein/geneprioritization/apps/#mepstein/geneprioritization/spreadsheet-builder/25)
        (SB) with these files as the input files.  (Leave all of the parameters
        blank, i.e., use the default settings.  In particular this means that a
        z-score normalization will have been done on the output that is
        generated.)


        The *Genomic Spreadsheet File* output file of this run is basically this
        demo samples file, but a couple of additional steps were necessary to
        reduce the file size to allow it to be stored on github:


        1. Round the values, using a line of code (using the python pandas
        library) like the following: `df.to_csv(output_file , sep="\t",
        float_format="%g")`.


        2. Compress the file using `bzip2`.


        #### Demo signatures file: name: `demo_SA.signatures.txt`


        This file was taken from this publication (original name
        `predictor.centroids.csv`):


        Wilkerson, M.D. et al. (2010) Lung squamous cell carcinoma mRNA
        expression subtypes are reproducible, clinically important and
        correspond to normal cell types.


        Available at
        [http://cancer.unc.edu/nhayes/publications/scc/](http://cancer.unc.edu/nhayes/publications/scc/).


        (For convenience, the [github
        repo](https://github.com/KnowEnG/quickstart-demos/blob/master/demo_files/)
        containing these files includes a version named
        `demo_SA.signatures.mapped.txt`, in which the gene names have already
        been mapped.)
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/lung/signature-analysis-workflow/0.png
      outputs:
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 500.3956155215994
          id: '#similarity_matrix_binary'
          description: The signature similarity matrix (binary; one 1 per row/gene/feature)
          'sbg:x': 1278.8509593290441
          'sbg:includeInPorts': true
          label: Similarity Matrix Binary
          source:
            - '#Signature_Analysis.similarity_matrix_binary'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 396.4510210822611
          id: '#similarity_matrix'
          description: The signature similarity results
          'sbg:x': 1182.5684311810664
          'sbg:includeInPorts': true
          label: Similarity Matrix File
          source:
            - '#Signature_Analysis.similarity_matrix'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 677.8823673023899
          id: '#run_params_yml'
          description: The configuration parameters specified for the SA run
          'sbg:x': 1275.8431468290444
          'sbg:includeInPorts': true
          label: SA run_params_yml
          source:
            - '#Signature_Analysis.run_params_yml'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 578.627498851103
          id: '#readme'
          description: The README file that describes the output files
          'sbg:x': 1186.1437988281252
          'sbg:includeInPorts': true
          label: README
          source:
            - '#Signature_Analysis.readme'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 57.64705882352942
          id: '#gene_map_file_out'
          description: The gene map file
          'sbg:x': 1185.8823529411768
          'sbg:includeInPorts': true
          label: Gene Map File
          source:
            - '#Signature_Analysis_Renamer.gene_map_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 309.67317468979786
          id: '#clean_signatures_file'
          description: The clean signatures file
          'sbg:x': 1272.0262235753678
          'sbg:includeInPorts': true
          label: Clean Signatures
          source:
            - '#Signature_Analysis.clean_signatures_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 204.5098338407629
          id: '#clean_samples_file'
          description: The clean samples file
          'sbg:x': 1187.254997702206
          'sbg:includeInPorts': true
          label: Clean Samples
          source:
            - '#Signature_Analysis.clean_samples_file'
      requirements: []
      'sbg:modifiedBy': mepstein
      label: Signature Analysis Workflow
      'sbg:revision': 0
      'sbg:canvas_x': 14
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-signature-analysis-public/signature-analysis-workflow/1
          'sbg:modifiedOn': 1530641561
          'sbg:revision': 0
      'sbg:createdOn': 1530641561
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:sbgMaintained': false
      'y': 285.5820599724265
      id: mepstein/lung/signature-analysis-workflow/0
      x: 532.6966050091912
      'sbg:categories':
        - Analysis
      'sbg:project': mepstein/lung
      'sbg:license': >-
        Copyright (c) 2017, University of Illinois Board of Trustees; All rights
        reserved.
      'sbg:toolkit': KnowEnG_CGC
      steps:
        - 'sbg:x': 741
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
          'sbg:y': 224
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:id': mepstein/knoweng-signature-analysis-dev/data-cleaning-copy/2
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: taxon id of species related to genomic spreadsheet
                description: 'The species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Species Taxon ID
              - 'sbg:toolDefaultValue': ''''''
                type:
                  - 'null'
                  - string
                doc: >-
                  suggestion for ID source database used to resolve ambiguities
                  in mapping
                description: The source hint for the redis queries (can be '')
                default: \'\'
                id: '#source_hint'
                label: ID Source Hint
              - 'sbg:toolDefaultValue': 6379
                type:
                  - 'null'
                  - int
                doc: port for Redis db
                description: The redis DB port
                default: 6379
                id: '#redis_port'
                label: RedisDB Port
              - 'sbg:toolDefaultValue': KnowEnG
                type:
                  - 'null'
                  - string
                doc: password for Redis db
                description: The redis DB password
                default: KnowEnG
                id: '#redis_pass'
                label: RedisDB Password
              - 'sbg:toolDefaultValue': knowredis.knoweng.org
                type:
                  - 'null'
                  - string
                doc: url of Redis db
                description: The redis DB host name
                default: knowredis.knoweng.org
                id: '#redis_host'
                label: RedisDB Host
              - id: '#pipeline_type'
                type:
                  - string
                description: >-
                  The name of the pipeline that will be run (i.e., data cleaning
                  is pipeline-specific)
                label: Name of Pipeline
                doc: >-
                  keywork name of pipeline from following list
                  ['gene_prioritization_pipeline',
                  'samples_clustering_pipeline',
                  'geneset_characterization_pipeline']
              - 'sbg:toolDefaultValue':
                  location: /bin/sh
                  class: File
                type:
                  - 'null'
                  - File
                required: false
                doc: >-
                  the phenotypic spreadsheet input for the pipeline [may be
                  optional]
                description: The phenotypic spreadsheet file (optional)
                default:
                  location: /bin/sh
                  class: File
                id: '#phenotypic_spreadsheet_file'
                label: Phenotypic Spreadsheet File (optional)
              - type:
                  - File
                required: true
                doc: the genomic spreadsheet input for the pipeline
                description: The genomic spreadsheet file
                id: '#genomic_spreadsheet_file'
                label: Genomic Spreadsheet File
              - description: >-
                  How to handle missing values in the input data (e.g., remove
                  rows, fill in with row average, reject)
                type:
                  - 'null'
                  - type: enum
                    name: geneset_characterization_impute
                    symbols:
                      - remove
                      - average
                      - reject
                id: '#geneset_characterization_impute'
                label: GSC Imputation Strategy
              - type:
                  - 'null'
                  - type: enum
                    name: gene_prioritization_corr_measure
                    symbols:
                      - pearson
                      - t_test
                'sbg:stageInput': null
                doc: >-
                  if pipeline_type=='gene_prioritization_pipeline', then must be
                  one of either ['t_test', 'pearson']
                description: >-
                  The correlation measure to be used for GP (e.g., t_test or
                  pearson)
                default: missing
                id: '#gene_prioritization_corr_measure'
                label: GP Correlation Measure
            'sbg:publisher': sbg
            x: 741
            'sbg:cmdPreview': sh run_dc.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
            arguments: []
            'sbg:modifiedOn': 1524112841
            description: >-
              Clean/preprocess input data (genomic and optionally phenotypic)
              for use with other tools/pipelines.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: two columns for original gene ids and unmapped reason code
                description: The genes that were not mapped
                id: '#gene_unmap_file'
                outputBinding:
                  glob: '*_UNMAPPED.tsv'
                label: Gene Unmapped File
              - type:
                  - 'null'
                  - File
                doc: two columns for internal gene ids and original gene ids
                description: The gene map file
                id: '#gene_map_file'
                outputBinding:
                  glob: '*_MAP.tsv'
                label: Gene Map File
              - id: '#gene_map_exceptions_file'
                type:
                  - 'null'
                  - File
                description: The gene map exceptions file
                outputBinding:
                  glob: '*_User_To_Ensembl.tsv'
                label: Gene Map Exceptions File
              - id: '#cmd_log_file'
                type:
                  - 'null'
                  - File
                description: The log of the data cleaning command
                outputBinding:
                  glob: run_dc.cmd
                label: Command Log File
              - type:
                  - 'null'
                  - File
                doc: data cleaning parameters in yaml format
                description: >-
                  The configuration parameters specified for the data cleaning
                  run
                id: '#cleaning_parameters_yml'
                outputBinding:
                  glob: run_cleanup.yml
                label: Cleaning Parameters File
              - type:
                  - 'null'
                  - File
                doc: information on souce of errors for cleaning pipeline
                description: The log of the data cleaning run
                id: '#cleaning_log_file'
                outputBinding:
                  glob: log_*_pipeline.yml
                label: Cleaning Log File
              - type:
                  - 'null'
                  - File
                doc: phenotype file prepared for pipeline
                description: The clean phenotypic spreadsheet
                id: '#clean_phenotypic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Phenotypic Spreadsheet
              - type:
                  - 'null'
                  - File
                doc: matrix with gene names mapped and data cleaned
                description: The clean genomic spreadsheet
                id: '#clean_genomic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Genomic Spreadsheet
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        str = ""


                        str += "pipeline_type: " + $job.inputs.pipeline_type +
                        "\n";

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

                        //str2 = "echo \"" + str + "\" > run_cleanup.yml &&
                        touch log_X_pipeline.yml && touch GX_ETL.tsv && touch
                        PX_ETL.tsv && touch X_MAP.tsv && touch X_UNMAPPED.tsv"

                        str2 = "echo \"" + str + "\" > run_cleanup.yml && date
                        && python3 /home/src/data_cleanup.py -run_directory ./
                        -run_file run_cleanup.yml && date"


                        str2;
                    filename: run_dc.cmd
                class: CreateFileRequirement
            class: CommandLineTool
            label: Data Cleaning/Preprocessing
            'sbg:revision': 2
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
            'sbg:createdOn': 1522093713
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 224
            id: mepstein/knoweng-signature-analysis-dev/data-cleaning-copy/2
            cwlVersion: 'sbg:draft-2'
            doc: checks the inputs of a pipeline for potential sources of errors
            baseCommand:
              - sh
              - run_dc.cmd
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 2
            hints:
              - dockerPull: 'knowengdev/data_cleanup_pipeline:04_11_2018'
                class: DockerRequirement
              - ramMin: 5000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/21
            'sbg:job':
              inputs:
                geneset_characterization_impute: remove
                gene_prioritization_corr_measure: pearson
                genomic_spreadsheet_file:
                  size: 0
                  class: File
                  path: /path/to/file.tsv
                  secondaryFiles: []
                pipeline_type: geneset_characterization_pipeline
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
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
          'sbg:y': 75.99999999999999
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:canvas_zoom': 0.95
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            'sbg:id': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
            inputs:
              - type:
                  - 'null'
                  - string
                required: false
                'sbg:y': 326
                id: '#taxon'
                'sbg:x': 81
                'sbg:includeInPorts': true
                label: taxon
              - type:
                  - 'null'
                  - string
                required: false
                'sbg:y': 464
                id: '#source_hint'
                'sbg:x': 86
                'sbg:includeInPorts': true
                label: source_hint
              - type:
                  - string
                required: true
                'sbg:y': 596
                id: '#output_filename'
                'sbg:x': 87
                'sbg:includeInPorts': true
                label: output_filename
              - type:
                  - File
                required: true
                'sbg:y': 62
                id: '#input_file'
                'sbg:x': 80
                label: input_file
              - type:
                  - 'null'
                  - boolean
                required: false
                'sbg:y': 199
                id: '#dont_do_mapping'
                'sbg:x': 83
                'sbg:includeInPorts': true
                label: dont_do_mapping
            'sbg:publisher': sbg
            'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
            'sbg:modifiedOn': 1526497729
            description: ''
            'sbg:image_url': >-
              https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/mapper-workflow/2.png
            outputs:
              - type:
                  - 'null'
                  - File
                'sbg:y': 170.52628366570724
                id: '#output_file_1'
                'sbg:x': 1145.2631578947369
                'sbg:includeInPorts': true
                label: map_file
                source:
                  - '#KN_Mapper.output_file'
              - type:
                  - 'null'
                  - File
                required: false
                'sbg:y': 360.105269582648
                id: '#output_file'
                'sbg:x': 1148.9473684210527
                'sbg:includeInPorts': true
                label: output_file
                source:
                  - '#Map_Names.output_file'
            requirements: []
            label: Mapper Workflow
            'sbg:revision': 2
            'sbg:canvas_x': 0
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
            'sbg:createdOn': 1524843132
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 75.99999999999999
            id: mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
            x: 431
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            'sbg:createdBy': mepstein
            cwlVersion: 'sbg:draft-2'
            'sbg:latestRevision': 2
            hints: []
            'sbg:canvas_y': 0
            steps:
              - 'sbg:x': 495
                'sbg:y': 171
                run:
                  'sbg:appVersion':
                    - 'sbg:draft-2'
                  'sbg:projectName': KnowEnG_Signature_Analysis_Dev
                  'sbg:validationErrors': []
                  'sbg:contributors':
                    - mepstein
                  baseCommand:
                    - sh
                    - kn_mapper.sh
                  'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
                  inputs:
                    - type:
                        - 'null'
                        - string
                      required: false
                      inputBinding:
                        prefix: '-t'
                        'sbg:cmdInclude': true
                        separate: true
                      description: The species taxon id
                      id: '#taxon'
                      'sbg:includeInPorts': true
                      label: Species Taxon ID
                    - type:
                        - 'null'
                        - string
                      required: false
                      inputBinding:
                        prefix: '-s'
                        'sbg:cmdInclude': true
                        separate: true
                      description: The source hint
                      id: '#source_hint'
                      'sbg:includeInPorts': true
                      label: Source Hint
                    - id: '#redis_port'
                      type:
                        - 'null'
                        - string
                      description: The redis port
                      inputBinding:
                        prefix: '-p'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Redis Port
                    - id: '#redis_pass'
                      type:
                        - 'null'
                        - string
                      description: The redis password
                      inputBinding:
                        prefix: '-P'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Redis Password
                    - id: '#redis_host'
                      type:
                        - 'null'
                        - string
                      description: The redis host
                      inputBinding:
                        prefix: '-h'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Redis Host
                    - id: '#output_name'
                      type:
                        - 'null'
                        - string
                      description: The output file name
                      inputBinding:
                        prefix: '-o'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Output Filename
                    - type:
                        - File
                      required: true
                      inputBinding:
                        prefix: '-i'
                        'sbg:cmdInclude': true
                        separate: true
                      description: The input file
                      id: '#input_file'
                      label: Input File
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      required: false
                      inputBinding:
                        prefix: '-n'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If present, the names won't be mapped, instead a dummy
                        map (with the two columns identical) will be created
                      id: '#dont_do_mapping'
                      'sbg:includeInPorts': true
                      label: Dont Do Mapping Flag
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      inputBinding:
                        prefix: '-F'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If the input file is a list of gene names rather than a
                        genomic spreadsheet, you might want to use this (i.e.,
                        the first line won't be column headers)
                      id: '#dont_cut_first_line'
                      label: Dont Cut First Line Flag
                  'sbg:publisher': sbg
                  x: 495
                  'sbg:revisionNotes': Added dont_do_mapping input/behavior.
                  arguments: []
                  'sbg:modifiedOn': 1524842883
                  description: Map the genes in a spreadsheet/file.
                  'sbg:image_url': null
                  outputs:
                    - id: '#output_file'
                      type:
                        - 'null'
                        - File
                      description: The output file (the gene name map)
                      outputBinding:
                        glob: names.node_map.txt
                      label: The Output File
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
                  class: CommandLineTool
                  label: KN Mapper
                  'sbg:revision': 3
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
                  id: mepstein/knoweng-signature-analysis-dev/kn-mapper/3
                  'sbg:createdOn': 1524681212
                  $namespaces:
                    sbg: 'https://sevenbridges.com'
                  'sbg:sbgMaintained': false
                  'y': 171
                  'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
                  cwlVersion: 'sbg:draft-2'
                  'sbg:project': mepstein/knoweng-signature-analysis-dev
                  'sbg:modifiedBy': mepstein
                  stdout: ''
                  'sbg:createdBy': mepstein
                  stdin: ''
                  'sbg:latestRevision': 3
                  hints:
                    - class: 'sbg:CPURequirement'
                      value: 1
                    - class: 'sbg:MemRequirement'
                      value: 1000
                    - dockerPull: 'knoweng/kn_mapper:latest'
                      dockerImageId: ''
                      class: DockerRequirement
                  successCodes: []
                  'sbg:job':
                    inputs:
                      dont_cut_first_line: true
                      taxon: taxon-string-value
                      output_name: output_name-string-value
                      redis_host: redis_host-string-value
                      dont_do_mapping: true
                      source_hint: source_hint-string-value
                      redis_port: redis_port-string-value
                      input_file:
                        size: 0
                        class: File
                        path: /path/to/input_file.ext
                        secondaryFiles: []
                      redis_pass: redis_pass-string-value
                    allocatedResources:
                      cpu: 1
                      mem: 1000
                  temporaryFailCodes: []
                id: '#KN_Mapper'
                outputs:
                  - id: '#KN_Mapper.output_file'
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
              - 'sbg:x': 782
                'sbg:y': 361
                run:
                  'sbg:appVersion':
                    - 'sbg:draft-2'
                  'sbg:projectName': KnowEnG_Signature_Analysis_Dev
                  'sbg:validationErrors': []
                  'sbg:contributors':
                    - mepstein
                  baseCommand:
                    - python3
                    - map_names.py
                  'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
                  inputs:
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      inputBinding:
                        prefix: '-s'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If present, the order in the map file is original
                        name/mapped name
                      id: '#switch_mapped_order'
                      label: Switch Mapped Order
                    - type:
                        - string
                      required: true
                      inputBinding:
                        prefix: '-o'
                        'sbg:cmdInclude': true
                        separate: true
                      description: Output Filename
                      id: '#output_filename'
                      'sbg:includeInPorts': true
                      label: Output Filename
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      inputBinding:
                        prefix: '-c'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If present, the names to be mapped in the input file are
                        columns, not rows
                      id: '#names_are_columns'
                      label: Names are Columns
                    - type:
                        - File
                      required: true
                      inputBinding:
                        prefix: '-m'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        Map files with orginal/mapped names in first two columns
                        (default is mapped in first, original in second)
                      id: '#map_file'
                      label: Map File
                    - type:
                        - File
                      required: true
                      inputBinding:
                        prefix: '-i'
                        'sbg:cmdInclude': true
                        separate: true
                      description: Input file to be mapped
                      id: '#input_file'
                      label: Input File
                    - id: '#drop_unmapped_names'
                      type:
                        - 'null'
                        - boolean
                      description: 'If present, any names that are unmapped will be dropped'
                      inputBinding:
                        prefix: '-u'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Drop Unmapped Names Flag
                  'sbg:publisher': sbg
                  x: 782
                  'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
                  arguments: []
                  'sbg:modifiedOn': 1524716022
                  description: Map the names in the input file based on the map file.
                  'sbg:image_url': null
                  outputs:
                    - id: '#output_file'
                      type:
                        - 'null'
                        - File
                      description: Output File
                      outputBinding:
                        glob:
                          engine: '#cwl-js-engine'
                          class: Expression
                          script: $job.inputs.output_filename
                      label: Output File
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
                      requirements:
                        - dockerPull: rabix/js-engine
                          class: DockerRequirement
                      class: ExpressionEngineRequirement
                  class: CommandLineTool
                  label: Map Names
                  'sbg:revision': 5
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
                        Modified map_names.py to add drop_unmapped_names option;
                        added drop_unmapped_names input.
                      'sbg:modifiedOn': 1524714160
                      'sbg:revision': 4
                    - 'sbg:modifiedBy': mepstein
                      'sbg:revisionNotes': >-
                        Changed docker container, to get newer version of
                        pandas.
                      'sbg:modifiedOn': 1524716022
                      'sbg:revision': 5
                  id: mepstein/knoweng-signature-analysis-dev/map-names/5
                  'sbg:createdOn': 1522285864
                  $namespaces:
                    sbg: 'https://sevenbridges.com'
                  'sbg:sbgMaintained': false
                  'y': 361
                  'sbg:cmdPreview': >-
                    python3 map_names.py -i /path/to/input_file.ext -m
                    /path/to/map_file.ext -o output_filename-string-value
                  cwlVersion: 'sbg:draft-2'
                  'sbg:project': mepstein/knoweng-signature-analysis-dev
                  'sbg:modifiedBy': mepstein
                  stdout: ''
                  'sbg:createdBy': mepstein
                  stdin: ''
                  'sbg:latestRevision': 5
                  hints:
                    - class: 'sbg:CPURequirement'
                      value: 1
                    - class: 'sbg:MemRequirement'
                      value: 1000
                    - dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
                      dockerImageId: ''
                      class: DockerRequirement
                  successCodes: []
                  'sbg:job':
                    inputs:
                      output_filename: output_filename-string-value
                      switch_mapped_order: true
                      map_file:
                        size: 0
                        class: File
                        path: /path/to/map_file.ext
                        secondaryFiles: []
                      drop_unmapped_names: true
                      names_are_columns: true
                      input_file:
                        size: 0
                        class: File
                        path: /path/to/input_file.ext
                        secondaryFiles: []
                    allocatedResources:
                      cpu: 1
                      mem: 1000
                  temporaryFailCodes: []
                id: '#Map_Names'
                outputs:
                  - id: '#Map_Names.output_file'
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
            class: Workflow
          id: '#Mapper_Workflow'
          outputs:
            - id: '#Mapper_Workflow.output_file_1'
            - id: '#Mapper_Workflow.output_file'
        - 'sbg:x': 433.00000000000006
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
          'sbg:y': 353.99999999999994
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:canvas_zoom': 0.95
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            'sbg:id': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
            inputs:
              - type:
                  - 'null'
                  - string
                required: false
                'sbg:y': 326
                id: '#taxon'
                'sbg:x': 81
                'sbg:includeInPorts': true
                label: taxon
              - type:
                  - 'null'
                  - string
                required: false
                'sbg:y': 464
                id: '#source_hint'
                'sbg:x': 86
                'sbg:includeInPorts': true
                label: source_hint
              - type:
                  - string
                required: true
                'sbg:y': 596
                id: '#output_filename'
                'sbg:x': 87
                'sbg:includeInPorts': true
                label: output_filename
              - type:
                  - File
                required: true
                'sbg:y': 62
                id: '#input_file'
                'sbg:x': 80
                label: input_file
              - type:
                  - 'null'
                  - boolean
                required: false
                'sbg:y': 199
                id: '#dont_do_mapping'
                'sbg:x': 83
                'sbg:includeInPorts': true
                label: dont_do_mapping
            'sbg:publisher': sbg
            'sbg:revisionNotes': 'Added output (map_file, from KN Mapper).'
            'sbg:modifiedOn': 1526497729
            description: ''
            'sbg:image_url': >-
              https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-dev/mapper-workflow/2.png
            outputs:
              - type:
                  - 'null'
                  - File
                'sbg:y': 170.52628366570724
                id: '#output_file_1'
                'sbg:x': 1145.2631578947369
                'sbg:includeInPorts': true
                label: map_file
                source:
                  - '#KN_Mapper.output_file'
              - type:
                  - 'null'
                  - File
                required: false
                'sbg:y': 360.105269582648
                id: '#output_file'
                'sbg:x': 1148.9473684210527
                'sbg:includeInPorts': true
                label: output_file
                source:
                  - '#Map_Names.output_file'
            requirements: []
            label: Mapper Workflow
            'sbg:revision': 2
            'sbg:canvas_x': 0
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
            'sbg:createdOn': 1524843132
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 353.99999999999994
            id: mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
            x: 433.00000000000006
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            'sbg:createdBy': mepstein
            cwlVersion: 'sbg:draft-2'
            'sbg:latestRevision': 2
            hints: []
            'sbg:canvas_y': 0
            steps:
              - 'sbg:x': 495
                'sbg:y': 171
                run:
                  'sbg:appVersion':
                    - 'sbg:draft-2'
                  'sbg:projectName': KnowEnG_Signature_Analysis_Dev
                  'sbg:validationErrors': []
                  'sbg:contributors':
                    - mepstein
                  baseCommand:
                    - sh
                    - kn_mapper.sh
                  'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
                  inputs:
                    - type:
                        - 'null'
                        - string
                      required: false
                      inputBinding:
                        prefix: '-t'
                        'sbg:cmdInclude': true
                        separate: true
                      description: The species taxon id
                      id: '#taxon'
                      'sbg:includeInPorts': true
                      label: Species Taxon ID
                    - type:
                        - 'null'
                        - string
                      required: false
                      inputBinding:
                        prefix: '-s'
                        'sbg:cmdInclude': true
                        separate: true
                      description: The source hint
                      id: '#source_hint'
                      'sbg:includeInPorts': true
                      label: Source Hint
                    - id: '#redis_port'
                      type:
                        - 'null'
                        - string
                      description: The redis port
                      inputBinding:
                        prefix: '-p'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Redis Port
                    - id: '#redis_pass'
                      type:
                        - 'null'
                        - string
                      description: The redis password
                      inputBinding:
                        prefix: '-P'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Redis Password
                    - id: '#redis_host'
                      type:
                        - 'null'
                        - string
                      description: The redis host
                      inputBinding:
                        prefix: '-h'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Redis Host
                    - id: '#output_name'
                      type:
                        - 'null'
                        - string
                      description: The output file name
                      inputBinding:
                        prefix: '-o'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Output Filename
                    - type:
                        - File
                      required: true
                      inputBinding:
                        prefix: '-i'
                        'sbg:cmdInclude': true
                        separate: true
                      description: The input file
                      id: '#input_file'
                      label: Input File
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      required: false
                      inputBinding:
                        prefix: '-n'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If present, the names won't be mapped, instead a dummy
                        map (with the two columns identical) will be created
                      id: '#dont_do_mapping'
                      'sbg:includeInPorts': true
                      label: Dont Do Mapping Flag
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      inputBinding:
                        prefix: '-F'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If the input file is a list of gene names rather than a
                        genomic spreadsheet, you might want to use this (i.e.,
                        the first line won't be column headers)
                      id: '#dont_cut_first_line'
                      label: Dont Cut First Line Flag
                  'sbg:publisher': sbg
                  x: 495
                  'sbg:revisionNotes': Added dont_do_mapping input/behavior.
                  arguments: []
                  'sbg:modifiedOn': 1524842883
                  description: Map the genes in a spreadsheet/file.
                  'sbg:image_url': null
                  outputs:
                    - id: '#output_file'
                      type:
                        - 'null'
                        - File
                      description: The output file (the gene name map)
                      outputBinding:
                        glob: names.node_map.txt
                      label: The Output File
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
                  class: CommandLineTool
                  label: KN Mapper
                  'sbg:revision': 3
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
                  id: mepstein/knoweng-signature-analysis-dev/kn-mapper/3
                  'sbg:createdOn': 1524681212
                  $namespaces:
                    sbg: 'https://sevenbridges.com'
                  'sbg:sbgMaintained': false
                  'y': 171
                  'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
                  cwlVersion: 'sbg:draft-2'
                  'sbg:project': mepstein/knoweng-signature-analysis-dev
                  'sbg:modifiedBy': mepstein
                  stdout: ''
                  'sbg:createdBy': mepstein
                  stdin: ''
                  'sbg:latestRevision': 3
                  hints:
                    - class: 'sbg:CPURequirement'
                      value: 1
                    - class: 'sbg:MemRequirement'
                      value: 1000
                    - dockerPull: 'knoweng/kn_mapper:latest'
                      dockerImageId: ''
                      class: DockerRequirement
                  successCodes: []
                  'sbg:job':
                    inputs:
                      dont_cut_first_line: true
                      taxon: taxon-string-value
                      output_name: output_name-string-value
                      redis_host: redis_host-string-value
                      dont_do_mapping: true
                      source_hint: source_hint-string-value
                      redis_port: redis_port-string-value
                      input_file:
                        size: 0
                        class: File
                        path: /path/to/input_file.ext
                        secondaryFiles: []
                      redis_pass: redis_pass-string-value
                    allocatedResources:
                      cpu: 1
                      mem: 1000
                  temporaryFailCodes: []
                id: '#KN_Mapper'
                outputs:
                  - id: '#KN_Mapper.output_file'
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
              - 'sbg:x': 782
                'sbg:y': 361
                run:
                  'sbg:appVersion':
                    - 'sbg:draft-2'
                  'sbg:projectName': KnowEnG_Signature_Analysis_Dev
                  'sbg:validationErrors': []
                  'sbg:contributors':
                    - mepstein
                  baseCommand:
                    - python3
                    - map_names.py
                  'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
                  inputs:
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      inputBinding:
                        prefix: '-s'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If present, the order in the map file is original
                        name/mapped name
                      id: '#switch_mapped_order'
                      label: Switch Mapped Order
                    - type:
                        - string
                      required: true
                      inputBinding:
                        prefix: '-o'
                        'sbg:cmdInclude': true
                        separate: true
                      description: Output Filename
                      id: '#output_filename'
                      'sbg:includeInPorts': true
                      label: Output Filename
                    - type:
                        - 'null'
                        - boolean
                      'sbg:stageInput': null
                      inputBinding:
                        prefix: '-c'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        If present, the names to be mapped in the input file are
                        columns, not rows
                      id: '#names_are_columns'
                      label: Names are Columns
                    - type:
                        - File
                      required: true
                      inputBinding:
                        prefix: '-m'
                        'sbg:cmdInclude': true
                        separate: true
                      description: >-
                        Map files with orginal/mapped names in first two columns
                        (default is mapped in first, original in second)
                      id: '#map_file'
                      label: Map File
                    - type:
                        - File
                      required: true
                      inputBinding:
                        prefix: '-i'
                        'sbg:cmdInclude': true
                        separate: true
                      description: Input file to be mapped
                      id: '#input_file'
                      label: Input File
                    - id: '#drop_unmapped_names'
                      type:
                        - 'null'
                        - boolean
                      description: 'If present, any names that are unmapped will be dropped'
                      inputBinding:
                        prefix: '-u'
                        'sbg:cmdInclude': true
                        separate: true
                      label: Drop Unmapped Names Flag
                  'sbg:publisher': sbg
                  x: 782
                  'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
                  arguments: []
                  'sbg:modifiedOn': 1524716022
                  description: Map the names in the input file based on the map file.
                  'sbg:image_url': null
                  outputs:
                    - id: '#output_file'
                      type:
                        - 'null'
                        - File
                      description: Output File
                      outputBinding:
                        glob:
                          engine: '#cwl-js-engine'
                          class: Expression
                          script: $job.inputs.output_filename
                      label: Output File
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
                      requirements:
                        - dockerPull: rabix/js-engine
                          class: DockerRequirement
                      class: ExpressionEngineRequirement
                  class: CommandLineTool
                  label: Map Names
                  'sbg:revision': 5
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
                        Modified map_names.py to add drop_unmapped_names option;
                        added drop_unmapped_names input.
                      'sbg:modifiedOn': 1524714160
                      'sbg:revision': 4
                    - 'sbg:modifiedBy': mepstein
                      'sbg:revisionNotes': >-
                        Changed docker container, to get newer version of
                        pandas.
                      'sbg:modifiedOn': 1524716022
                      'sbg:revision': 5
                  id: mepstein/knoweng-signature-analysis-dev/map-names/5
                  'sbg:createdOn': 1522285864
                  $namespaces:
                    sbg: 'https://sevenbridges.com'
                  'sbg:sbgMaintained': false
                  'y': 361
                  'sbg:cmdPreview': >-
                    python3 map_names.py -i /path/to/input_file.ext -m
                    /path/to/map_file.ext -o output_filename-string-value
                  cwlVersion: 'sbg:draft-2'
                  'sbg:project': mepstein/knoweng-signature-analysis-dev
                  'sbg:modifiedBy': mepstein
                  stdout: ''
                  'sbg:createdBy': mepstein
                  stdin: ''
                  'sbg:latestRevision': 5
                  hints:
                    - class: 'sbg:CPURequirement'
                      value: 1
                    - class: 'sbg:MemRequirement'
                      value: 1000
                    - dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
                      dockerImageId: ''
                      class: DockerRequirement
                  successCodes: []
                  'sbg:job':
                    inputs:
                      output_filename: output_filename-string-value
                      switch_mapped_order: true
                      map_file:
                        size: 0
                        class: File
                        path: /path/to/map_file.ext
                        secondaryFiles: []
                      drop_unmapped_names: true
                      names_are_columns: true
                      input_file:
                        size: 0
                        class: File
                        path: /path/to/input_file.ext
                        secondaryFiles: []
                    allocatedResources:
                      cpu: 1
                      mem: 1000
                  temporaryFailCodes: []
                id: '#Map_Names'
                outputs:
                  - id: '#Map_Names.output_file'
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
            class: Workflow
          id: '#Mapper_Workflow_1'
          outputs:
            - id: '#Mapper_Workflow_1.output_file_1'
            - id: '#Mapper_Workflow_1.output_file'
        - 'sbg:x': 940.9999999999999
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
          'sbg:y': 427
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
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
            'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis/13
            inputs:
              - id: '#use_network'
                type:
                  - 'null'
                  - boolean
                'sbg:stageInput': null
                description: Whether to use the network
                label: Use Network Flag
              - id: '#spreadsheet_file'
                type:
                  - 'null'
                  - File
                description: The input spreadsheet file
                required: false
                label: Spreadsheet File
              - type:
                  - 'null'
                  - type: enum
                    name: similarity_measure
                    symbols:
                      - cosine
                      - pearson
                      - spearman
                required: false
                description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
                id: '#similarity_measure'
                'sbg:includeInPorts': true
                label: Similarity Measure
              - id: '#signature_file'
                type:
                  - 'null'
                  - File
                description: The input signature file
                required: false
                label: Signature File
              - 'sbg:toolDefaultValue': serial
                type:
                  - 'null'
                  - type: enum
                    name: processing_method
                    symbols:
                      - serial
                      - parallel
                'sbg:stageInput': null
                id: '#processing_method'
                description: >-
                  The processing method (e.g., serial or parallel, default:
                  serial)
                label: The processing method
              - 'sbg:toolDefaultValue': '4'
                type:
                  - 'null'
                  - int
                'sbg:stageInput': null
                id: '#parallelism'
                description: >-
                  The parallelism (if the processing method is parallel;
                  default: 4)
                label: parallelism
              - 'sbg:toolDefaultValue': '0'
                type:
                  - 'null'
                  - int
                'sbg:stageInput': null
                id: '#num_bootstraps'
                description: 'The number of bootstraps (default: 0)'
                label: Number of Bootstraps
              - 'sbg:toolDefaultValue': '50'
                type:
                  - 'null'
                  - int
                'sbg:stageInput': null
                id: '#network_influence_percent'
                description: >-
                  The amount of network influence (as a percent; default 50%); a
                  greater value means greater contribution from the network
                  interactions
                label: Amount of Network Influence
              - id: '#network_file'
                type:
                  - 'null'
                  - File
                description: The knowledge network file
                required: false
                label: Knowledge Network File
              - 'sbg:toolDefaultValue': '80'
                type:
                  - 'null'
                  - int
                'sbg:stageInput': null
                id: '#bootstrap_sample_percent'
                description: 'The bootstrap sample percent (default: 80%)'
                label: Bootstrap Sample Percent
            'sbg:publisher': sbg
            x: 940.9999999999999
            'sbg:revisionNotes': Changed how wget.py called on command line.
            arguments: []
            'sbg:modifiedOn': 1526542156
            description: >-
              Calls the KnowEnG Signature Analysis pipeline.


              Note: In the current implementation of Signature Analysis, the
              only mode available is non-network, non-bootstrapping.  That means
              that the tool behaves as if the input parameters use_network is
              false and num_bootstraps is 0, and the input file network_file and
              the input parameters network_influence_percent,
              bootstrap_sample_percent, processing_method, and parallelism are
              ignored.  (These inputs are still present; this behavior is set in
              the javascript that generates run_sa.cmd.)


              In summary, the only inputs that are used are the input files
              spreadsheet_file and signature_file and the input parameter
              similarity_measure.
            'sbg:image_url': null
            outputs:
              - id: '#similarity_matrix_binary'
                type:
                  - 'null'
                  - File
                description: >-
                  The signature similarity matrix (binary; one 1 per
                  row/gene/feature)
                outputBinding:
                  glob: similarity_matrix.binary.tsv
                label: Similarity Matrix Binary
              - id: '#similarity_matrix'
                type:
                  - 'null'
                  - File
                description: The signature similarity results
                outputBinding:
                  glob: similarity_matrix.tsv
                label: Similarity Matrix
              - id: '#run_params_yml'
                type:
                  - 'null'
                  - File
                description: The Signature Analysis parameters
                outputBinding:
                  glob: run_params.yml
                label: SA Parameters File
              - id: '#readme'
                type:
                  - 'null'
                  - File
                description: The README file that describes the output files
                outputBinding:
                  glob: README-SA.md
                label: The README file
              - id: '#clean_signatures_file'
                type:
                  - 'null'
                  - File
                description: The clean signatures file
                outputBinding:
                  glob: clean_signatures_matrix.tsv
                label: Clean Signatures File
              - id: '#clean_samples_file'
                type:
                  - 'null'
                  - File
                description: The clean samples file
                outputBinding:
                  glob: clean_samples_matrix.tsv
                label: Clean Samples File
            requirements:
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
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

                        str += "similarity_measure: " +
                        $job.inputs.similarity_measure + "\n";


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


                        var str2 = "cp -pr " + $job.inputs.spreadsheet_file.path
                        + " clean_samples_matrix.tsv && cp -pr " +
                        $job.inputs.signature_file.path + "
                        clean_signatures_matrix.tsv";


                        var str3 = "echo \"" + str + "\" > run_params.yml && " +
                        str2 + " && python3 /home/src/gene_signature.py
                        -run_directory ./ -run_file run_params.yml";


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
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Signature Analysis
            'sbg:revision': 13
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
                  (non-network, non-bootstrapping); added similarity map binary
                  matrix output.
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
                  Updated a few things (docker container, output for binary
                  similarity matrix, ...).
                'sbg:modifiedOn': 1526407664
                'sbg:revision': 7
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Added outputs for clean samples and signatures files.
                'sbg:modifiedOn': 1526482172
                'sbg:revision': 8
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Modified documentation to include new similar measure
                  (pearson).
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
            id: mepstein/knoweng-signature-analysis-dev/signature-analysis/13
            'sbg:createdOn': 1520542501
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 427
            'sbg:cmdPreview': >-
              sh run_sa.cmd && cp -pr result*.tsv similarity_matrix.tsv && cp
              -pr Gene_to_TF_Association*.tsv similarity_matrix.binary.tsv &&
              python3 wget.py
              https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SA.md
              README-SA.md
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 13
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: 'knowengdev/signature_analysis_pipeline:05_10_2018'
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:job':
              inputs:
                similarity_measure: spearman
                use_network: false
                processing_method: serial
                network_influence_percent: 50
                num_bootstraps: 0
                parallelism: 4
                spreadsheet_file:
                  size: 0
                  class: File
                  path: /path/to/spreadsheet_file.ext
                  secondaryFiles: []
                network_file:
                  size: 0
                  class: File
                  path: /path/to/network_file.ext
                  secondaryFiles: []
                signature_file:
                  size: 0
                  class: File
                  path: /path/to/signature_file.ext
                  secondaryFiles: []
                bootstrap_sample_percent: 80
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Signature_Analysis'
          outputs:
            - id: '#Signature_Analysis.similarity_matrix_binary'
            - id: '#Signature_Analysis.similarity_matrix'
            - id: '#Signature_Analysis.run_params_yml'
            - id: '#Signature_Analysis.readme'
            - id: '#Signature_Analysis.clean_signatures_file'
            - id: '#Signature_Analysis.clean_samples_file'
        - 'sbg:x': 867.0588235294119
          inputs:
            - id: '#Signature_Analysis_Renamer.gene_map2_in'
              source:
                - '#Mapper_Workflow_1.output_file_1'
            - id: '#Signature_Analysis_Renamer.gene_map1_in'
              source:
                - '#Mapper_Workflow.output_file_1'
          'sbg:y': 71.76470588235296
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_Signature_Analysis_Dev
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            baseCommand:
              - sh
              - renamer.sh
            'sbg:id': >-
              mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
            inputs:
              - id: '#gene_map2_in'
                type:
                  - 'null'
                  - File
                description: Gene Map File 2 Input
                required: false
                label: Gene Map File 2 Input
              - id: '#gene_map1_in'
                type:
                  - 'null'
                  - File
                description: Gene Map File 1 Input
                required: false
                label: Gene Map File 1 Input
            'sbg:publisher': sbg
            x: 867.0588235294119
            'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
            arguments: []
            'sbg:modifiedOn': 1526570997
            description: ''
            'sbg:image_url': null
            outputs:
              - id: '#gene_map_file_out'
                type:
                  - 'null'
                  - File
                description: The gene map file
                outputBinding:
                  glob: gene_map.txt
                label: Gene Map File
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

                      sort -t : -k 2 -u |             # sort and uniquify
                      ignoring the line numbers

                      sort -t : -k 1n |               # sort according to the
                      line numbers

                      cut -d : -f 2- >$OUTPUT         # remove the line numbers


                      # Using awk:

                      # <input awk '!seen[$0]++'
                    filename: rem_dups.sh
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
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
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Signature Analysis Renamer
            'sbg:revision': 3
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
            id: >-
              mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
            'sbg:createdOn': 1526539333
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'y': 71.76470588235296
            'sbg:cmdPreview': sh renamer.sh
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-signature-analysis-dev
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 3
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: ubuntu
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:job':
              inputs:
                gene_map1_in:
                  size: 0
                  class: File
                  path: /path/to/gene_map1_in.ext
                  secondaryFiles: []
                gene_map2_in:
                  size: 0
                  class: File
                  path: /path/to/gene_map2_in.ext
                  secondaryFiles: []
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Signature_Analysis_Renamer'
          outputs:
            - id: '#Signature_Analysis_Renamer.gene_map_file_out'
      'sbg:createdBy': mepstein
      cwlVersion: 'sbg:draft-2'
      'sbg:latestRevision': 0
      hints: []
      'sbg:toolAuthor': KnowEnG
      'sbg:canvas_y': 22
      'sbg:copyOf': mepstein/knoweng-signature-analysis-public/signature-analysis-workflow/1
      class: Workflow
    id: '#Signature_Analysis_Workflow'
    outputs:
      - id: '#Signature_Analysis_Workflow.similarity_matrix_binary'
      - id: '#Signature_Analysis_Workflow.similarity_matrix'
      - id: '#Signature_Analysis_Workflow.run_params_yml'
      - id: '#Signature_Analysis_Workflow.readme'
      - id: '#Signature_Analysis_Workflow.gene_map_file_out'
      - id: '#Signature_Analysis_Workflow.clean_signatures_file'
      - id: '#Signature_Analysis_Workflow.clean_samples_file'
  - 'sbg:x': 704.378231272978
    inputs:
      - id: '#Gene_Prioritization_Workflow.taxonid'
        default: '9606'
      - id: '#Gene_Prioritization_Workflow.phenotypic_spreadsheet_file'
        source:
          - '#Signature_Analysis_Workflow.similarity_matrix_binary'
      - id: '#Gene_Prioritization_Workflow.number_of_top_genes'
        source:
          - '#number_of_top_genes'
      - id: '#Gene_Prioritization_Workflow.num_bootstraps'
      - id: '#Gene_Prioritization_Workflow.network_influence_percent'
      - id: '#Gene_Prioritization_Workflow.knowledge_network_edge_type'
      - id: '#Gene_Prioritization_Workflow.genomic_spreadsheet_file'
        source:
          - '#Spreadsheet_Builder.output_matrix_1'
      - id: '#Gene_Prioritization_Workflow.correlation_measure_in'
        default: t_test
      - id: '#Gene_Prioritization_Workflow.bootstrap_sample_percent'
    'sbg:y': 455.8885641659008
    run:
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:projectName': Lung_Signatures
      'sbg:canvas_zoom': 0.7499999999999998
      'sbg:validationErrors': []
      'sbg:toolkit': KnowEnG_CGC
      'sbg:id': mepstein/lung/gene-prioritization-workflow/0
      inputs:
        - type:
            - string
          required: true
          'sbg:y': 69.00000000000003
          id: '#taxonid'
          description: >-
            The species taxon ID (e.g., 9606 for human).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
            possible values (KN Contents by Species).
          'sbg:x': 80.00000000000003
          'sbg:includeInPorts': false
          label: Species Taxon ID
        - type:
            - File
          required: true
          'sbg:y': 277.94116210937506
          id: '#phenotypic_spreadsheet_file'
          description: The phenotypic spreadsheet file
          'sbg:x': 85.23531087239586
          'sbg:includeInPorts': true
          label: Phenotypic Spreadsheet File
        - type:
            - 'null'
            - int
          required: false
          'sbg:y': 729.0196126302085
          id: '#number_of_top_genes'
          description: The number of top genes to find (default 100).
          'sbg:x': 225.25488281250006
          'sbg:includeInPorts': true
          label: Number of Top Genes
        - type:
            - 'null'
            - int
          required: false
          'sbg:y': 804.0180664062502
          id: '#num_bootstraps'
          description: >-
            The number of bootstraps to use (0 means no bootstrapping; default
            0).
          'sbg:x': 87.96982828776045
          'sbg:includeInPorts': false
          label: Number of Bootstraps
        - type:
            - 'null'
            - int
          required: false
          'sbg:y': 634.1569010416669
          id: '#network_influence_percent'
          description: >-
            The amount of network influence (as a percent, i.e., an integer
            between 0 and 100, inclusive; default 50%); a greater value means
            greater contribution from the network interactions.  This value is
            only used if the knowledge network is used in the analysis.
          'sbg:x': 91.37254842122398
          'sbg:includeInPorts': false
          label: Amount of Network Influence
        - type:
            - 'null'
            - string
          required: false
          'sbg:y': 458.6666666666668
          id: '#knowledge_network_edge_type'
          description: >-
            The knowledge network edge type (e.g., STRING_experimental).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type]
            for possible values (KN Contents by Gene-Gene Edge Type).  Leave
            this blank to not use the knowledge network in the analysis.
          'sbg:x': 96.00000000000001
          'sbg:includeInPorts': false
          label: Knowledge Network Edge Type
        - type:
            - File
          required: true
          'sbg:y': 149.68627929687503
          id: '#genomic_spreadsheet_file'
          description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
          'sbg:x': 218.82352701822924
          'sbg:includeInPorts': true
          label: Genomic Spreadsheet File
        - type:
            - type: enum
              name: correlation_measure_in
              symbols:
                - pearson
                - t_test
          required: true
          'sbg:y': 548.0000000000001
          id: '#correlation_measure_in'
          description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
          'sbg:x': 216.00000000000006
          'sbg:includeInPorts': false
          label: Correlation Measure
        - type:
            - 'null'
            - int
          required: false
          'sbg:y': 894.0512695312502
          id: '#bootstrap_sample_percent'
          description: >-
            The bootstrap sample percent (an integer between 0 and 100,
            inclusive; default 80%).
          'sbg:x': 228.92311604817715
          'sbg:includeInPorts': false
          label: Bootstrap Sample Percent
      'sbg:toolkitVersion': v1.0
      'sbg:publisher': KnowEnG
      'sbg:revisionNotes': >-
        Copy of
        mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/4
      'sbg:modifiedOn': 1530641542
      description: >-
        This [KnowEnG](https://knoweng.org/) Gene Prioritization workflow
        identifies genes whose genomic measurements are most strongly associated
        with a collection of observed phenotypes.


        In this pipeline, the user submits a spreadsheet of gene-level
        transcriptomic (or other omics) profiles of a collection of biological
        samples.  Each sample is also annotated with a numeric phenotype (e.g.,
        drug response) or binary phenotype (e.g., metastatic status).  This
        pipeline scores each gene by the correlation between its “omic” value
        (e.g., expression) and the phenotype, and reports the top
        phenotype-related genes.  Gene prioritization can be done in a Knowledge
        Network-guided mode (using
        [ProGENI](https://www.ncbi.nlm.nih.gov/pubmed/28800781)), and with
        optional use of bootstrapping to achieve robust prioritization.


        A network-guided analysis can offer various benefits over a standard
        one, since it evaluates the associations while considering the activity
        levels of the gene’s network neighbors. As a result, it can identify
        genes that both directly and indirectly (through their neighbors) affect
        the phenotype.



        ### Required inputs


        This workflow has two required input files:


        1. Genomic Spreadsheet File (ID: *genomic_spreadsheet_file*).  This
        currently must be a TSV file (a spreadsheet with tab-separated values). 
        The first row (header) should contain the identifiers for the biological
        samples that provide the data for the corresponding columns.  The first
        column of the spreadsheet should be the gene identifiers corresponding
        to each row.  Each entry in the spreadsheet table should be a numeric
        value (positive or negative) indicating the genomic measurement of the
        corresponding row gene in the corresponding column sample.  There should
        be no NA values/empty cells.


        A sample input file,
        [demo_GP.genomic.txt](https://cgc.sbgenomics.com/public/files/5a7474014f0cfede55af6472/),
        as described in the [quickstart guide for this
        workflow](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf),
        is available.


        Example of Genomic Spreadsheet File Format:


        | &nbsp; |Sample1 | Sample2 | Sample3 |

        | --- | --- | --- | --- | --- |

        |**Gene1**| -0.2 | 1.5 | 4.1 |

        |**Gene2**| 0.9 | -3.0 | -0.6 |

        |**Gene3**| -1.1 | 0.2 | -3.1 |

        |**Gene4**| -0.8 | 0.1 | -0.2 |

        |**Gene5**| 1.7 | 0.6 | -1.0 |

        |...| ... | ... | ... |


        2. Phenotypic Spreadsheet File (ID: *phenotypic_spreadsheet_file*). 
        This currently must be a TSV file (a spreadsheet with tab-separated
        values).  The first row (header) of the spreadsheet should be the
        phenotypes corresponding to each column.  The first column should
        contain the identifiers for the biological samples that have had their
        phenotypes measured in the corresponding rows.  The phenotypic
        spreadsheet file cells must either contain numeric (positive or
        negative) values or NAs.  For Correlation Measure = `t_test`, the
        numeric values must be either “0” or “1”.  For Correlation Measure =
        `pearson`, continuous numeric values are preferred.


        A sample input file,
        [demo_GP.phenotypic.txt](https://cgc.sbgenomics.com/public/files/5a7474014f0cfede55af6473/),
        as described in the [quickstart guide for this
        workflow](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf),
        is available.


        Example of Phenotypic Spreadsheet File Format (for Correlation Measure =
        `t_test`):


        | &nbsp; | Pheno1 | Pheno2 | Pheno3 |

        | --- | --- | --- | --- | --- |

        |**Sample1**| 0 | 1 | 1 |

        |**Sample2**| 0 | 0 | 0 |

        |**Sample3**| 1 | 0 | 1 |

        |**Sample**| 0 | 1 | 0 |

        |**Sample**| 1 | 0 | 0 |

        |...| ... | ... | ... |


        There are three required input parameters:


        1. Species Taxon ID (ID: *taxonid*; type: string).  The ID of the
        species to be used in the analysis, e.g., "9606" for human.  Possible
        values are listed in parentheses in the first column of the [KnowEnG
        Supported
        Species](https://knoweng.org/kn-data-references/#kn_contents_by_species)
        table ("KN Contents by Species").


        2. Number of Top Genes (ID: *number_of_top_genes*; type: int).  This is
        the number of top ranking genes that will be returned by the method.


        3. Correlation Measure (ID: *correlation_measure_in*; type
        enum/string).  This is the correlation measure that will be used in the
        gene prioritization.  The values currently available are `pearson` (for
        continuous values) and `t_test` (for binary data).


        ### Optional inputs


        There are four optional input parameters.


        If you use the Knowledge Network, these two parameters should be
        specified:


        1. Knowledge Network Edge Type (ID: *knowlege_network_edge_type*; type:
        string).  The edge type for the knowledge network (i.e., interaction
        network), e.g., "STRING_experimental".  Possible values are listed in
        parentheses in the first column of the [KnowEnG Interaction
        Networks](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type)
        table (KN Contents by Gene-Gene Edge Type"")(use one of the values in
        parentheses).  If no value is specified, no knowledge network will be
        used in the analysis.


        2. Amount of Network Influence (ID: *network_influence_percent*; type:
        int).  The amount of network influence.  This should be an integer
        between 0 and 100 (inclusive).  If no value is specified (or the value
        is outside that range), 50% will be used.  A greater value means greater
        contribution from the network interactions.  (This value is only
        relevant if the knowledge network is used.)


        If you use bootstrapping, these two parameters should be specified:


        1. Number of Bootstraps (ID: *num_bootstraps*; type: int).  The number
        of bootstraps to use.  If no value is specified, no bootstrapping will
        be done.


        2. Bootstrap Sample Percent (ID: *bootstrap_sample_percent*; type:
        int).  The percent of columns that will be sampled on each bootstrap. 
        This should be an integer between 0 and 100 (inclusive).  If no value is
        specified (or the value is outside that range), 80% will be used.  (This
        value is only relevant if bootstrapping is done.)


        ### Outputs


        This workflow generates eight output files.  These are outlined below. 
        The structure and order specified here may not match what's listed on
        the completed task page.  The README output file goes into more detail
        on the purpose and the contents of the various output files.  That file
        can also be found
        [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-GP.md).


        #### Results


        * Ranked Genes File (file name: `genes_ranked_per_phenotype.txt`).


        * Top Genes File (file name: `top_genes_per_phenotype_matrix.txt`).


        * README (file name: `README-GP.md`).  This file describes the various
        output files.


        #### Mapping


        * Gene Map File (file name: `gene_map.txt`).


        * Clean Genomic File (file name: `clean_genomic_matrix.txt`).


        * Clean Phenotypic File (file name: `clean_phenotypic_matrix.txt`).


        #### Metadata and run info


        * Interaction Network Metadata File (file name:
        `interaction_network.metadata`).  This file will only be present if a
        knowledge network was used in the analysis.


        * GP Run Params yml (file name: `run_params.yml`).


        ### Additional Resources


        [Quickstart
        Guide](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf)
        for this workflow


        [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
        knowledge-guided analysis


        [YouTube Tutorial](https://youtu.be/Vp76-Oz-Yuc) for this workflow in
        KnowEnG Platform


        [Additional Pipelines](https://knoweng.org/pipelines/) supported by
        KnowEnG


        ### Acknowledgements


        The KnowEnG BD2K center is supported by grant U54GM114838 awarded by
        NIGMS through funds provided by the trans-NIH Big Data to Knowledge
        (BD2K) initiative.


        Questions or comments can be sent to knoweng-support@illinois.edu.


        ### References


        Emad A, Cairns J, Kalari KR, Wang L, Sinha S. Knowledge-guided gene
        prioritization reveals new insights into the mechanisms of
        chemoresistance. Genome Biol. 2017;18(1):153.


        Rees MG, Seashore-ludlow B, Cheah JH, et al. Correlating chemical
        sensitivity and basal gene expression reveals mechanism of action. Nat
        Chem Biol. 2016;12(2):109-16.
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/lung/gene-prioritization-workflow/0.png
      outputs:
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 556.0000000000001
          id: '#top_genes_file'
          description: The top genes file
          'sbg:x': 1485.3333333333337
          'sbg:includeInPorts': true
          label: Top Genes File
          source:
            - '#ProGENI.top_genes_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 662.6666666666669
          id: '#run_params_yml'
          description: The configuration parameters specified for the GP run
          'sbg:x': 1312.0000000000005
          'sbg:includeInPorts': true
          label: GP Run Params yml
          source:
            - '#ProGENI.run_params_yml'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 742.6666666666669
          id: '#readme'
          description: README-GP.md
          'sbg:x': 1488.0000000000005
          'sbg:includeInPorts': true
          label: README
          source:
            - '#ProGENI.readme'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 364.0000000000001
          id: '#interaction_network_metadata_file_out'
          description: The interaction network metadata file
          'sbg:x': 1488.0000000000005
          'sbg:includeInPorts': true
          label: Interaction Network Metadata File
          source:
            - '#Gene_Prioritization_Renamer.interaction_network_metadata_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 476.00000000000017
          id: '#genes_ranked_file'
          description: The genes ranked file
          'sbg:x': 1308.0000000000005
          'sbg:includeInPorts': true
          label: Ranked Genes File
          source:
            - '#ProGENI.genes_ranked_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 256.00000000000006
          id: '#gene_map_file_out'
          description: The gene map file
          'sbg:x': 1313.3333333333337
          'sbg:includeInPorts': true
          label: Gene Map File
          source:
            - '#Gene_Prioritization_Renamer.gene_map_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 164.00000000000006
          id: '#clean_phenotypic_file_out'
          description: The clean phenotypic spreadsheet file
          'sbg:x': 1488.0000000000005
          'sbg:includeInPorts': true
          label: Clean Phenotypic File
          source:
            - '#Gene_Prioritization_Renamer.clean_phenotypic_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 65.33333333333334
          id: '#clean_genomic_file_out'
          description: The clean genomic spreadsheet file
          'sbg:x': 1320.0000000000005
          'sbg:includeInPorts': true
          label: Clean Genomic File
          source:
            - '#Gene_Prioritization_Renamer.clean_genomic_file_out'
      x: 704.378231272978
      'sbg:modifiedBy': mepstein
      label: Gene Prioritization Workflow
      'sbg:revision': 0
      'sbg:canvas_x': 14
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/4
          'sbg:modifiedOn': 1530641542
          'sbg:revision': 0
      'sbg:createdOn': 1530641542
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:sbgMaintained': false
      'y': 455.8885641659008
      id: mepstein/lung/gene-prioritization-workflow/0
      requirements: []
      'sbg:categories':
        - Analysis
        - Prioritization
      'sbg:project': mepstein/lung
      'sbg:license': >-
        Copyright (c) 2017, University of Illinois Board of Trustees; All rights
        reserved.
      'sbg:contributors':
        - mepstein
      steps:
        - 'sbg:x': 687.777750651042
          'sbg:y': 138.3333129882813
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GenePrioritization_Dev
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            baseCommand:
              - sh
              - run_dc.cmd
            'sbg:id': mepstein/knoweng-geneprioritization-demo/data-cleaning-copy/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: taxon id of species related to genomic spreadsheet
                description: 'The species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Species Taxon ID
              - 'sbg:toolDefaultValue': ''''''
                type:
                  - 'null'
                  - string
                doc: >-
                  suggestion for ID source database used to resolve ambiguities
                  in mapping
                description: The source hint for the redis queries (can be '')
                default: \'\'
                id: '#source_hint'
                label: ID Source Hint
              - 'sbg:toolDefaultValue': 6379
                type:
                  - 'null'
                  - int
                doc: port for Redis db
                description: The redis DB port
                default: 6379
                id: '#redis_port'
                label: RedisDB Port
              - 'sbg:toolDefaultValue': KnowEnG
                type:
                  - 'null'
                  - string
                doc: password for Redis db
                description: The redis DB password
                default: KnowEnG
                id: '#redis_pass'
                label: RedisDB Password
              - 'sbg:toolDefaultValue': knowredis.knoweng.org
                type:
                  - 'null'
                  - string
                doc: url of Redis db
                description: The redis DB host name
                default: knowredis.knoweng.org
                id: '#redis_host'
                label: RedisDB Host
              - description: >-
                  The name of the pipeline that will be run (i.e., data cleaning
                  is pipeline-specific)
                type:
                  - string
                id: '#pipeline_type'
                label: Name of Pipeline
                doc: >-
                  keywork name of pipeline from following list
                  ['gene_prioritization_pipeline',
                  'samples_clustering_pipeline',
                  'geneset_characterization_pipeline']
              - 'sbg:toolDefaultValue':
                  location: /bin/sh
                  class: File
                type:
                  - 'null'
                  - File
                required: false
                doc: >-
                  the phenotypic spreadsheet input for the pipeline [may be
                  optional]
                description: The phenotypic spreadsheet file (optional)
                default:
                  location: /bin/sh
                  class: File
                id: '#phenotypic_spreadsheet_file'
                label: Phenotypic Spreadsheet File (optional)
              - type:
                  - File
                required: true
                doc: the genomic spreadsheet input for the pipeline
                description: The genomic spreadsheet file
                id: '#genomic_spreadsheet_file'
                label: Genomic Spreadsheet File
              - 'sbg:toolDefaultValue': missing
                type:
                  - 'null'
                  - string
                required: false
                doc: >-
                  if pipeline_type=='gene_prioritization_pipeline', then must be
                  one of either ['t_test', 'pearson']
                description: >-
                  The correlation measure to be used for GP (e.g., t_test or
                  pearson)
                default: missing
                id: '#gene_prioritization_corr_measure'
                'sbg:includeInPorts': true
                label: GP Correlation Measure
            'sbg:publisher': sbg
            x: 687.777750651042
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
            arguments: []
            'sbg:modifiedOn': 1513886524
            description: >-
              Clean/preprocess input data (genomic and optionally phenotypic)
              for use with other tools/pipelines.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: two columns for original gene ids and unmapped reason code
                description: The genes that were not mapped
                id: '#gene_unmap_file'
                outputBinding:
                  glob: '*_UNMAPPED.tsv'
                label: Gene Unmapped File
              - type:
                  - 'null'
                  - File
                doc: two columns for internal gene ids and original gene ids
                description: The gene map file
                id: '#gene_map_file'
                outputBinding:
                  glob: '*_MAP.tsv'
                label: Gene Map File
              - id: '#cmd_log_file'
                type:
                  - 'null'
                  - File
                description: The log of the data cleaning command
                outputBinding:
                  glob: run_dc.cmd
                label: Command Log File
              - type:
                  - 'null'
                  - File
                doc: data cleaning parameters in yaml format
                description: >-
                  The configuration parameters specified for the data cleaning
                  run
                id: '#cleaning_parameters_yml'
                outputBinding:
                  glob: run_cleanup.yml
                label: Cleaning Parameters File
              - type:
                  - 'null'
                  - File
                doc: information on souce of errors for cleaning pipeline
                description: The log of the data cleaning run
                id: '#cleaning_log_file'
                outputBinding:
                  glob: log_*_pipeline.yml
                label: Cleaning Log File
              - type:
                  - 'null'
                  - File
                doc: phenotype file prepared for pipeline
                description: The clean phenotypic spreadsheet
                id: '#clean_phenotypic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Phenotypic Spreadsheet
              - type:
                  - 'null'
                  - File
                doc: matrix with gene names mapped and data cleaned
                description: The clean genomic spreadsheet
                id: '#clean_genomic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Genomic Spreadsheet
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        str = ""


                        str += "pipeline_type: " + $job.inputs.pipeline_type +
                        "\n";

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

                        if ($job.inputs.pipeline_type ==
                        "gene_prioritization_pipeline") {
                            str += "correlation_measure: " + $job.inputs.gene_prioritization_corr_measure + "\n";
                        }


                        //str2 = "echo \"" + str + "\" > run_cleanup.yml"

                        //str2 = "echo \"" + str + "\" > run_cleanup.yml &&
                        touch log_X_pipeline.yml && touch GX_ETL.tsv && touch
                        PX_ETL.tsv && touch X_MAP.tsv && touch X_UNMAPPED.tsv"

                        str2 = "echo \"" + str + "\" > run_cleanup.yml && date
                        && python3 /home/src/data_cleanup.py -run_directory ./
                        -run_file run_cleanup.yml && date"


                        str2;
                    filename: run_dc.cmd
                class: CreateFileRequirement
            class: CommandLineTool
            label: Data Cleaning/Preprocessing
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
                'sbg:modifiedOn': 1513886524
                'sbg:revision': 0
            id: mepstein/knoweng-geneprioritization-demo/data-cleaning-copy/0
            'sbg:createdOn': 1513886524
            'sbg:sbgMaintained': false
            doc: checks the inputs of a pipeline for potential sources of errors
            'sbg:cmdPreview': sh run_dc.cmd
            cwlVersion: 'sbg:draft-2'
            'y': 138.3333129882813
            'sbg:project': mepstein/knoweng-geneprioritization-dev
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
                class: DockerRequirement
              - ramMin: 5000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Data_Cleaning_Preprocessing'
          outputs:
            - id: '#Data_Cleaning_Preprocessing.gene_unmap_file'
            - id: '#Data_Cleaning_Preprocessing.gene_map_file'
            - id: '#Data_Cleaning_Preprocessing.cmd_log_file'
            - id: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
            - id: '#Data_Cleaning_Preprocessing.cleaning_log_file'
            - id: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
            - id: '#Data_Cleaning_Preprocessing.clean_genomic_file'
          inputs:
            - id: '#Data_Cleaning_Preprocessing.taxonid'
              source:
                - '#taxonid'
            - id: '#Data_Cleaning_Preprocessing.source_hint'
            - id: '#Data_Cleaning_Preprocessing.redis_port'
              default: 6379
            - id: '#Data_Cleaning_Preprocessing.redis_pass'
              default: KnowEnG
            - id: '#Data_Cleaning_Preprocessing.redis_host'
              default: knowredis.knoweng.org
            - id: '#Data_Cleaning_Preprocessing.pipeline_type'
              default: gene_prioritization_pipeline
            - id: '#Data_Cleaning_Preprocessing.phenotypic_spreadsheet_file'
              source:
                - '#phenotypic_spreadsheet_file'
            - id: '#Data_Cleaning_Preprocessing.genomic_spreadsheet_file'
              source:
                - '#genomic_spreadsheet_file'
            - id: '#Data_Cleaning_Preprocessing.gene_prioritization_corr_measure'
              source:
                - '#Gene_Prioritization_Parameters.correlation_measure_out'
        - 'sbg:x': 689.3333333333335
          'sbg:y': 577.6666666666667
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GenePrioritization_Dev
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            baseCommand:
              - sh
              - run_fetch.cmd
            'sbg:id': mepstein/knoweng-geneprioritization-demo/kn-fetcher-cb/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: the taxonomic id for the species of interest
                description: 'The network species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Network Species Taxon ID
              - 'sbg:toolDefaultValue': Gene
                type:
                  - 'null'
                  - string
                doc: the type of subnetwork
                description: 'The network type (e.g., Gene, Property)'
                default: Gene
                id: '#network_type'
                label: Network Type
              - 'sbg:toolDefaultValue': 'true'
                type:
                  - 'null'
                  - boolean
                required: false
                doc: whether or not to get the network
                description: >-
                  Whether to get the network (or create a dummy/empty network
                  file)
                default: true
                id: '#get_network'
                'sbg:includeInPorts': true
                label: Get Network Flag
              - 'sbg:toolDefaultValue': STRING_experimental
                type:
                  - 'null'
                  - string
                required: false
                doc: the edge type keyword for the subnetwork of interest
                description: >-
                  The network edge type (e.g., STRING_experimental,
                  gene_ontology)
                default: PPI_physical_association
                id: '#edge_type'
                'sbg:includeInPorts': true
                label: Network Edge Type
              - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
                type:
                  - 'null'
                  - string
                doc: the aws s3 bucket
                description: The AWS S3 bucket to fetch the network from
                default: KnowNets/KN-20rep-1706/userKN-20rep-1706
                id: '#bucket'
                label: AWS S3 Bucket Name
            'sbg:publisher': sbg
            x: 689.3333333333335
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
            arguments: []
            'sbg:modifiedOn': 1516299548
            description: >-
              Fetch a knowledge network from an AWS S3 bucket, given a network
              type, an edge type, and a species taxon ID.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The pnode map file
                id: '#pnode_map_file'
                outputBinding:
                  glob: '*.pnode_map'
                label: PNode Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The node map file
                id: '#node_map_file'
                outputBinding:
                  glob: '*.node_map'
                label: Node Map File
              - type:
                  - 'null'
                  - File
                doc: yaml format describing network contents
                description: The network metadata file
                id: '#network_metadata_file'
                outputBinding:
                  glob: '*.metadata'
                label: Network Metadata File
              - type:
                  - 'null'
                  - File
                doc: >-
                  4 column format for subnetwork for single edge type and
                  species
                description: The network edge file
                id: '#network_edge_file'
                outputBinding:
                  glob: '*.edge'
                label: Network Edge File
              - type:
                  - 'null'
                  - File
                doc: log of fetch command
                description: The log of the fetch command
                id: '#cmd_log_file'
                outputBinding:
                  glob: run_fetch.cmd
                label: Command Log File
            requirements:
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        //MYCMD="date && if [ " + $job.inputs.get_network + ' =
                        "true" ]; then /home/kn_fetcher.sh
                        '+$job.inputs.bucket+' '+$job.inputs.network_type+'
                        '+$job.inputs.taxonid+' '+$job.inputs.edge_type+'; else
                        touch empty.edge; fi && date'


                        str = "";


                        str += "date";

                        if ($job.inputs.get_network) {

                        //if ($job.inputs.get_network == "true") {
                            str += " && /home/kn_fetcher.sh " + $job.inputs.bucket + " " + $job.inputs.network_type + 
                        " " + $job.inputs.taxonid + " " + $job.inputs.edge_type;

                        }

                        else {
                            //str += " && touch empty.edge";
                        }

                        str += " && date";


                        str;
                    filename: run_fetch.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Knowledge Network Fetcher
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
                'sbg:modifiedOn': 1516299548
                'sbg:revision': 0
            id: mepstein/knoweng-geneprioritization-demo/kn-fetcher-cb/0
            'sbg:createdOn': 1516299548
            'sbg:sbgMaintained': false
            doc: >-
              Retrieve appropriate subnetwork from KnowEnG Knowledge Network
              from AWS S3 storage
            'sbg:cmdPreview': sh run_fetch.cmd
            cwlVersion: 'sbg:draft-2'
            'y': 577.6666666666667
            'sbg:project': mepstein/knoweng-geneprioritization-dev
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
                class: DockerRequirement
              - ramMin: 2000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Knowledge_Network_Fetcher'
          outputs:
            - id: '#Knowledge_Network_Fetcher.pnode_map_file'
            - id: '#Knowledge_Network_Fetcher.node_map_file'
            - id: '#Knowledge_Network_Fetcher.network_metadata_file'
            - id: '#Knowledge_Network_Fetcher.network_edge_file'
            - id: '#Knowledge_Network_Fetcher.cmd_log_file'
          inputs:
            - id: '#Knowledge_Network_Fetcher.taxonid'
              source:
                - '#taxonid'
            - id: '#Knowledge_Network_Fetcher.network_type'
              default: Gene
            - id: '#Knowledge_Network_Fetcher.get_network'
              source:
                - '#Gene_Prioritization_Parameters.get_network'
            - id: '#Knowledge_Network_Fetcher.edge_type'
              source:
                - '#Gene_Prioritization_Parameters.edge_type'
            - id: '#Knowledge_Network_Fetcher.bucket'
              default: KnowNets/KN-20rep-1706/userKN-20rep-1706
        - 'sbg:x': 984.0000000000003
          'sbg:y': 333.3333333333334
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:job':
              inputs:
                gene_map_file_in:
                  size: 0
                  class: File
                  path: /path/to/gene_map_file.ext
                  secondaryFiles: []
                clean_genomic_file_in:
                  size: 0
                  class: File
                  path: /path/to/genomic_file.ext
                  secondaryFiles: []
                clean_phenotypic_file_in:
                  size: 0
                  class: File
                  path: /path/to/phenotypic_file.ext
                  secondaryFiles: []
                interaction_network_metadata_file_in:
                  size: 0
                  class: File
                  path: /path/to/interaction_network_metadata_file.ext
                  secondaryFiles: []
                use_network: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            baseCommand:
              - sh
              - file_renamer.cmd
            'sbg:id': >-
              mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
            inputs:
              - type:
                  - 'null'
                  - boolean
                'sbg:stageInput': null
                required: false
                description: Whether to use the network
                id: '#use_network'
                'sbg:includeInPorts': true
                label: Use Network Flag
              - description: The interaction network metadata file
                type:
                  - 'null'
                  - File
                id: '#interaction_network_metadata_file_in'
                required: false
                label: Interaction Network Metadata File
              - description: The gene map file
                type:
                  - 'null'
                  - File
                id: '#gene_map_file_in'
                required: false
                label: Gene Map File
              - description: The clean phenotypic spreadsheet
                type:
                  - 'null'
                  - File
                id: '#clean_phenotypic_file_in'
                required: false
                label: Clean Phenotypic Spreadsheet
              - description: The clean genomic spreadsheet
                type:
                  - 'null'
                  - File
                id: '#clean_genomic_file_in'
                required: false
                label: Clean Genomic Spreadsheet
            'sbg:publisher': sbg
            x: 984.0000000000003
            'sbg:cmdPreview': sh file_renamer.cmd
            arguments: []
            'sbg:modifiedOn': 1516830402
            description: >-
              Renames some of the intermediate files produced in the GP workflow
              to their final output names.
            'sbg:image_url': null
            outputs:
              - id: '#interaction_network_metadata_file_out'
                type:
                  - 'null'
                  - File
                description: The interaction network metadata file
                outputBinding:
                  glob: interaction_network.metadata
                label: Interaction Network Metadata File
              - id: '#gene_map_file_out'
                type:
                  - 'null'
                  - File
                description: The gene map file
                outputBinding:
                  glob: gene_map.txt
                label: Gene Map File
              - id: '#clean_phenotypic_file_out'
                type:
                  - 'null'
                  - File
                description: The clean phenotypic spreadsheet
                outputBinding:
                  glob: clean_phenotypic_matrix.txt
                label: Clean Phenotypic Spreadsheet
              - id: '#clean_genomic_file_out'
                type:
                  - 'null'
                  - File
                description: The clean genomic spreadsheet
                outputBinding:
                  glob: clean_genomic_matrix.txt
                label: Clean Genomic Spreadsheet
            requirements:
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >

                        str = "";


                        //demo_GP.genomic_ETL.tsv clean_genomic_matrix.txt

                        if ($job.inputs.clean_genomic_file_in) {
                            str += "cp -p " + $job.inputs.clean_genomic_file_in.path + " clean_genomic_matrix.txt\n";
                        }


                        //demo_GP.phenotypic_ETL.tsv clean_phenotypic_matrix.txt

                        if ($job.inputs.clean_phenotypic_file_in) {
                            str += "cp -p " + $job.inputs.clean_phenotypic_file_in.path + " clean_phenotypic_matrix.txt\n";
                        }


                        //demo_GP.genomic_MAP.tsv gene_map.txt

                        if ($job.inputs.gene_map_file_in) {
                            str += "cp -p " + $job.inputs.gene_map_file_in.path + " gene_map.txt\n";
                        }


                        //9606.STRING_experimental.metadata
                        interaction_network.metadata

                        if ($job.inputs.use_network &&
                        $job.inputs.interaction_network_metadata_file_in) {
                            str += "cp -p " + $job.inputs.interaction_network_metadata_file_in.path + " interaction_network.metadata\n";
                        }


                        str;
                    filename: file_renamer.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            label: Gene_Prioritization_Renamer
            'sbg:revision': 4
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516559629
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516560539
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Renamed input parameters.
                'sbg:modifiedOn': 1516563049
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516830326
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516830402
                'sbg:revision': 4
            'sbg:createdOn': 1516559629
            'sbg:sbgMaintained': false
            'sbg:createdBy': mepstein
            'y': 333.3333333333334
            'sbg:modifiedBy': mepstein
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-geneprioritization-dev
            'sbg:projectName': KnowEnG_GenePrioritization_Dev
            id: >-
              mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
            stdout: ''
            class: CommandLineTool
            stdin: ''
            'sbg:latestRevision': 4
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: ubuntu
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            temporaryFailCodes: []
          id: '#Gene_Prioritization_Renamer'
          outputs:
            - id: >-
                #Gene_Prioritization_Renamer.interaction_network_metadata_file_out
            - id: '#Gene_Prioritization_Renamer.gene_map_file_out'
            - id: '#Gene_Prioritization_Renamer.clean_phenotypic_file_out'
            - id: '#Gene_Prioritization_Renamer.clean_genomic_file_out'
          inputs:
            - id: '#Gene_Prioritization_Renamer.use_network'
              source:
                - '#Gene_Prioritization_Parameters.get_network'
            - id: >-
                #Gene_Prioritization_Renamer.interaction_network_metadata_file_in
              source:
                - '#Knowledge_Network_Fetcher.network_metadata_file'
            - id: '#Gene_Prioritization_Renamer.gene_map_file_in'
              source:
                - '#Data_Cleaning_Preprocessing.gene_map_file'
            - id: '#Gene_Prioritization_Renamer.clean_phenotypic_file_in'
              source:
                - '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
            - id: '#Gene_Prioritization_Renamer.clean_genomic_file_in'
              source:
                - '#Data_Cleaning_Preprocessing.clean_genomic_file'
        - 'sbg:x': 430.66666666666674
          'sbg:y': 461.3333333333335
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:job':
              inputs:
                knowledge_network_edge_type: knowledge_network_edge_type-string-value
                correlation_measure_in: pearson
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            baseCommand:
              - ''
            'sbg:id': >-
              mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
            inputs:
              - type:
                  - 'null'
                  - string
                required: false
                description: The knowledge network edge type (not required)
                id: '#knowledge_network_edge_type'
                'sbg:includeInPorts': true
                label: Knowledge Network Edge Type
              - type:
                  - type: enum
                    name: correlation_measure_in
                    symbols:
                      - pearson
                      - t_test
                required: true
                description: >-
                  The correlation measure to be used for GP (e.g., pearson or
                  t_test)
                id: '#correlation_measure_in'
                'sbg:includeInPorts': true
                label: GP Correlation Measure
            'sbg:publisher': sbg
            x: 430.66666666666674
            'sbg:cmdPreview': ''
            arguments: []
            'sbg:modifiedOn': 1516854156
            description: >-
              Sets the input parameters of some of the intermediate apps in the
              GP workflow based on some of the input parameters to the workflow
              itself.
            'sbg:image_url': null
            outputs:
              - id: '#get_network'
                type:
                  - 'null'
                  - boolean
                description: Whether to get the network
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |

                      if ($job.inputs.knowledge_network_edge_type) {    
                          get_network = true;
                      }
                      else {    
                          get_network = false;
                      }

                      get_network;
                label: Get Network Flag
              - id: '#edge_type'
                type:
                  - 'null'
                  - string
                description: The network edge type
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      $job.inputs.knowledge_network_edge_type;
                label: Network Edge Type
              - id: '#correlation_measure_out'
                type:
                  - 'null'
                  - string
                description: >-
                  The correlation measure to be used for GP (e.g., pearson or
                  t_test)
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      $job.inputs.correlation_measure_in;
                label: GP Correlation Measure
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            label: Gene Prioritization Parameters
            'sbg:revision': 5
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516829688
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516830285
                'sbg:revision': 1
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516842866
                'sbg:revision': 2
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516842939
                'sbg:revision': 3
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': Cleaned up inputs and outputs.
                'sbg:modifiedOn': 1516853520
                'sbg:revision': 4
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': null
                'sbg:modifiedOn': 1516854156
                'sbg:revision': 5
            'sbg:createdOn': 1516829688
            'sbg:sbgMaintained': false
            'sbg:createdBy': mepstein
            'y': 461.3333333333335
            'sbg:modifiedBy': mepstein
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-geneprioritization-dev
            'sbg:projectName': KnowEnG_GenePrioritization_Dev
            id: >-
              mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
            stdout: ''
            class: CommandLineTool
            stdin: ''
            'sbg:latestRevision': 5
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: ubuntu
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            temporaryFailCodes: []
          id: '#Gene_Prioritization_Parameters'
          outputs:
            - id: '#Gene_Prioritization_Parameters.get_network'
            - id: '#Gene_Prioritization_Parameters.edge_type'
            - id: '#Gene_Prioritization_Parameters.correlation_measure_out'
          inputs:
            - id: '#Gene_Prioritization_Parameters.knowledge_network_edge_type'
              source:
                - '#knowledge_network_edge_type'
            - id: '#Gene_Prioritization_Parameters.correlation_measure_in'
              source:
                - '#correlation_measure_in'
        - 'sbg:x': 990.1795247395838
          'sbg:y': 724.7435709635419
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:job':
              inputs:
                correlation_measure: correlation_method-string-value
                drug_response_file:
                  secondaryFiles: []
                  class: File
                  size: 0
                  path: /path/to/drug_response_file.ext
                network_influence_percent: 10
                num_bootstraps: 10
                number_of_top_genes: 5
                spreadsheet_file:
                  secondaryFiles: []
                  class: File
                  size: 0
                  path: /path/to/spreadsheet_file.ext
                network_file:
                  secondaryFiles: []
                  class: File
                  size: 0
                  path: /path/to/network_file.ext
                bootstrap_sample_percent: 2
                use_network: true
              allocatedResources:
                cpu: 1
                mem: 1000
            'sbg:validationErrors': []
            'sbg:contributors':
              - mepstein
            'sbg:project': mepstein/knoweng-geneprioritization-demo
            'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization/1
            inputs:
              - id: '#network_file'
                type:
                  - 'null'
                  - File
                'sbg:stageInput': link
                description: The knowledge network file
                label: Knowledge Network File
              - id: '#spreadsheet_file'
                type:
                  - File
                'sbg:stageInput': link
                description: The genomic spreadsheet file
                label: Genomic Spreadsheet File
              - id: '#drug_response_file'
                type:
                  - File
                'sbg:stageInput': link
                description: The drug response file
                label: Drug Response File
              - description: 'The correlation measure (e.g., t_test or pearson)'
                type:
                  - string
                id: '#correlation_measure'
                'sbg:includeInPorts': true
                label: Correlation Measure
              - 'sbg:toolDefaultValue': '0'
                type:
                  - 'null'
                  - int
                description: The number of bootstraps
                id: '#num_bootstraps'
                'sbg:includeInPorts': true
                label: Number of Bootstraps
              - 'sbg:toolDefaultValue': 'False'
                type:
                  - 'null'
                  - boolean
                description: Whether to use the network
                id: '#use_network'
                'sbg:includeInPorts': true
                label: Use Network Flag
              - 'sbg:toolDefaultValue': '100'
                type:
                  - 'null'
                  - int
                'sbg:stageInput': null
                id: '#number_of_top_genes'
                description: The number of top genes to find
                'sbg:includeInPorts': true
                label: Number of Top Genes
              - 'sbg:toolDefaultValue': '50'
                type:
                  - 'null'
                  - int
                description: >-
                  The amount of network influence (as a percent; default 50%); a
                  greater value means greater contribution from the network
                  interactions
                id: '#network_influence_percent'
                'sbg:includeInPorts': true
                label: Amount of Network Influence
              - 'sbg:toolDefaultValue': '80'
                type:
                  - 'null'
                  - int
                'sbg:stageInput': null
                id: '#bootstrap_sample_percent'
                description: The bootstrap sample percent
                'sbg:includeInPorts': true
                label: Bootstrap Sample Percent
            'sbg:publisher': sbg
            'sbg:revisionNotes': >-
              Copy of
              mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
            'sbg:createdOn': 1517287763
            'sbg:modifiedOn': 1523639904
            description: >-
              Network-guided gene prioritization method implementation by
              KnowEnG that ranks gene measurements by their correlation to
              observed phenotypes.
            'sbg:image_url': null
            outputs:
              - id: '#output_name'
                type:
                  - 'null'
                  - items: File
                    type: array
                outputBinding:
                  glob: '*bootstrap_net_correlation*'
              - description: The genes ranked file
                type:
                  - 'null'
                  - File
                id: '#genes_ranked_file'
                outputBinding:
                  glob: genes_ranked_per_phenotype.txt
                label: Genes Ranked File
              - description: The top genes file
                type:
                  - 'null'
                  - File
                id: '#top_genes_file'
                outputBinding:
                  glob: top_genes_per_phenotype_matrix.txt
                label: Top Genes File
              - description: The README file that describes the output files
                type:
                  - 'null'
                  - File
                id: '#readme'
                outputBinding:
                  glob: README-GP.md
                label: The README file
              - description: The configuration parameters specified for the GP run
                type:
                  - 'null'
                  - File
                id: '#run_params_yml'
                outputBinding:
                  glob: run_params.yml
                label: Configuration Parameters File
            requirements:
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >

                        str = "";


                        str += "correlation_measure: " +
                        $job.inputs.correlation_measure + "\n";

                        str += "drop_method: drop_NA\n";

                        str += "phenotype_name_full_path: " +
                        $job.inputs.drug_response_file.path + "\n";

                        str += "results_directory: ./\n";

                        str += "spreadsheet_name_full_path: " +
                        $job.inputs.spreadsheet_file.path + "\n";

                        //str += "top_beta_of_sort: 100\n";

                        if ($job.inputs.number_of_top_genes &&
                            $job.inputs.number_of_top_genes >= 0) {
                            str += "top_beta_of_sort: " + $job.inputs.number_of_top_genes + "\n";
                        }

                        else {
                            str += "top_beta_of_sort: 100\n";
                        }


                        method = "correlation";

                        if ($job.inputs.use_network) {

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

                        if ($job.inputs.num_bootstraps &&
                            $job.inputs.num_bootstraps > 1) {
                            method = "bootstrap_" + method;
                            str += "number_of_bootstraps: " + $job.inputs.num_bootstraps + "\n";
                            //str += "cols_sampling_fraction: 0.8\n";
                            if ($job.inputs.bootstrap_sample_percent &&
                                $job.inputs.bootstrap_sample_percent >= 0 && $job.inputs.bootstrap_sample_percent <= 100) {
                                str += "cols_sampling_fraction: " + $job.inputs.bootstrap_sample_percent/100 + "\n";
                            }
                            else {
                                str += "cols_sampling_fraction: 0.8\n";
                            }
                            str += "rows_sampling_fraction: 1.0\n";
                        }

                        str += "method: " + method + "\n";


                        str2 = "echo \"" + str + "\" > run_params.yml && python3
                        /home/src/gene_prioritization.py -run_directory ./
                        -run_file run_params.yml";


                        str2;
                    filename: run_gp.cmd
                  - fileContent: |-
                      #!/bin/bash

                      if [ $# -ne 3 ]; then
                          echo "Usage: $0 input_directory output_filename1 output_filename2"
                          exit 1
                      fi

                      # The directory to find the *_viz.tsv files; usually "./"
                      DIRECTORY=$1
                      # The file to place the concatenation of *_viz.tsv files;
                      # usually "genes_ranked_per_phenotype.txt"
                      OUTPUT_FILENAME1=$2
                      # The file to place the top_genes_per_phenotype_* file;
                      # usually "top_genes_per_phenotype_matrix.txt"
                      OUTPUT_FILENAME2=$3

                      if [ ! -d $DIRECTORY ]; then
                          echo "$DIRECTORY is not a directory"
                          exit 1
                      fi

                      HEADERS=

                      # To get the glob to return files in the desired order
                      LANG=C

                      for FILE in $DIRECTORY/*_viz.tsv; do
                          #echo $FILE
                          if [ -z "$HEADERS" ]; then
                              cat $FILE > $DIRECTORY/$OUTPUT_FILENAME1
                              HEADERS="done"
                          else
                              tail -n +2 $FILE >> $DIRECTORY/$OUTPUT_FILENAME1
                          fi
                      done

                      if [ -f $DIRECTORY/top_genes_per_phenotype_* ]; then
                          cp -p $DIRECTORY/top_genes_per_phenotype_* $DIRECTORY/$OUTPUT_FILENAME2
                      fi
                    filename: create_ranked_genes.sh
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
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: ProGENI
            'sbg:revision': 1
            'sbg:revisionsInfo':
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Copy of
                  mepstein/knoweng-geneprioritization-dev/gene-prioritization/6
                'sbg:modifiedOn': 1517287763
                'sbg:revision': 0
              - 'sbg:modifiedBy': mepstein
                'sbg:revisionNotes': >-
                  Copy of
                  mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
                'sbg:modifiedOn': 1523639904
                'sbg:revision': 1
            id: >-
              https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-demo/gene-prioritization/1/raw/
            arguments: []
            $namespaces:
              sbg: 'https://sevenbridges.com'
            'sbg:sbgMaintained': false
            'sbg:cmdPreview': >-
              sh run_gp.cmd && sh create_ranked_genes.sh ./
              genes_ranked_per_phenotype.txt top_genes_per_phenotype_matrix.txt
              && python3 wget.py
              https://raw.githubusercontent.com/KnowEnG/quickstart-demos/f93695fdd5d603412e6b3d4e7a74e6f2a079929f/pipeline_readmes/README-GP.md
              README-GP.md
            cwlVersion: 'sbg:draft-2'
            baseCommand:
              - sh
              - run_gp.cmd
              - '&&'
              - sh
              - create_ranked_genes.sh
              - ./
              - genes_ranked_per_phenotype.txt
              - top_genes_per_phenotype_matrix.txt
              - '&&'
              - python3
              - wget.py
              - >-
                https://raw.githubusercontent.com/KnowEnG/quickstart-demos/f93695fdd5d603412e6b3d4e7a74e6f2a079929f/pipeline_readmes/README-GP.md
              - README-GP.md
            'sbg:projectName': KnowEnG_GenePrioritization_Demo
            'sbg:modifiedBy': mepstein
            stdout: ''
            'sbg:createdBy': mepstein
            stdin: ''
            'sbg:latestRevision': 1
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: 'knowengdev/gene_prioritization_pipeline:07_26_2017'
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:copyOf': mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
            temporaryFailCodes: []
          id: '#ProGENI'
          outputs:
            - id: '#ProGENI.output_name'
            - id: '#ProGENI.genes_ranked_file'
            - id: '#ProGENI.top_genes_file'
            - id: '#ProGENI.readme'
            - id: '#ProGENI.run_params_yml'
          inputs:
            - id: '#ProGENI.network_file'
              source:
                - '#Knowledge_Network_Fetcher.network_edge_file'
            - id: '#ProGENI.spreadsheet_file'
              source:
                - '#Data_Cleaning_Preprocessing.clean_genomic_file'
            - id: '#ProGENI.drug_response_file'
              source:
                - '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
            - id: '#ProGENI.correlation_measure'
              source:
                - '#Gene_Prioritization_Parameters.correlation_measure_out'
            - id: '#ProGENI.num_bootstraps'
              source:
                - '#num_bootstraps'
            - id: '#ProGENI.use_network'
              source:
                - '#Gene_Prioritization_Parameters.get_network'
            - id: '#ProGENI.number_of_top_genes'
              source:
                - '#number_of_top_genes'
            - id: '#ProGENI.network_influence_percent'
              source:
                - '#network_influence_percent'
            - id: '#ProGENI.bootstrap_sample_percent'
              source:
                - '#bootstrap_sample_percent'
      'sbg:links':
        - id: 'https://knoweng.org/'
          label: KnowEnG Main Website
        - id: 'https://knoweng.org/analyze/'
          label: KnowEnG Analytics
        - id: 'https://knoweng.org/kn-overview/'
          label: Knowledge Network Overview
        - id: 'https://knoweng.org/pipelines/'
          label: Knowledge-Guided Pipelines
        - id: 'https://knoweng.org/pipelines/#gene_prioritization'
          label: GP Pipeline
        - id: 'https://knoweng.org/quick-start/'
          label: Pipeline Quickstart Guides
        - id: 'https://knoweng.org/wp-content/uploads/2017/08/GP_Quickstart.pdf'
          label: GP Pipeline Quickstart
        - id: 'https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf'
          label: CGC GP Pipeline Quickstart
        - id: 'https://www.youtube.com/channel/UCjyIIolCaZIGtZC20XLBOyg'
          label: KnowEnG YouTube Channel
      'sbg:createdBy': mepstein
      cwlVersion: 'sbg:draft-2'
      'sbg:latestRevision': 0
      hints: []
      'sbg:toolAuthor': KnowEnG
      'sbg:canvas_y': -17
      'sbg:copyOf': >-
        mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/4
      class: Workflow
    id: '#Gene_Prioritization_Workflow'
    outputs:
      - id: '#Gene_Prioritization_Workflow.top_genes_file'
      - id: '#Gene_Prioritization_Workflow.run_params_yml'
      - id: '#Gene_Prioritization_Workflow.readme'
      - id: '#Gene_Prioritization_Workflow.interaction_network_metadata_file_out'
      - id: '#Gene_Prioritization_Workflow.genes_ranked_file'
      - id: '#Gene_Prioritization_Workflow.gene_map_file_out'
      - id: '#Gene_Prioritization_Workflow.clean_phenotypic_file_out'
      - id: '#Gene_Prioritization_Workflow.clean_genomic_file_out'
  - 'sbg:x': 891.0936737060549
    inputs:
      - id: '#Gene_Set_Characterization_Workflow.taxonid'
        default: '9606'
      - id: '#Gene_Set_Characterization_Workflow.pg_edge_type'
        source:
          - '#pg_edge_type'
      - id: '#Gene_Set_Characterization_Workflow.network_smoothing_percent'
        source:
          - '#network_smoothing_percent'
      - id: '#Gene_Set_Characterization_Workflow.gg_edge_type'
        source:
          - '#gg_edge_type'
      - id: '#Gene_Set_Characterization_Workflow.genomic_spreadsheet_file'
        source:
          - '#Gene_Prioritization_Workflow.top_genes_file'
    'sbg:y': 270.52787780761724
    run:
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:projectName': Lung_Signatures
      'sbg:canvas_zoom': 0.7999999999999998
      'sbg:validationErrors': []
      'sbg:contributors':
        - mepstein
      'sbg:id': mepstein/lung/gene-set-characterization/0
      inputs:
        - type:
            - string
          required: true
          'sbg:y': 82.5000027120109
          id: '#taxonid'
          description: >-
            The species taxon ID (e.g., 9606 for human).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
            possible values (KN Contents by Species).
          'sbg:x': 110.0000238865596
          'sbg:includeInPorts': false
          label: Species Taxon ID
        - type:
            - string
          required: true
          'sbg:y': 216.2499565184135
          id: '#pg_edge_type'
          description: >-
            The gene set property network edge type (e.g., gene_ontology).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type]
            for possible values (KN Contents by Property-Gene Edge Type).
          'sbg:x': 107.50000047683673
          'sbg:includeInPorts': true
          label: Gene Set Property Network Edge Type
        - type:
            - 'null'
            - int
          required: false
          'sbg:y': 619.9997800141683
          id: '#network_smoothing_percent'
          description: >-
            The amount of network smoothing (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          'sbg:x': 105.00002351403057
          'sbg:includeInPorts': true
          label: Amount of Network Smoothing
        - type:
            - 'null'
            - string
          required: false
          'sbg:y': 479.99997153878223
          id: '#gg_edge_type'
          description: >-
            The knowledge network edge type (e.g., STRING_experimental).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type]
            for possible values (KN Contents by Gene-Gene Edge Type).  Leave
            this blank to not use the Knowledge Network.
          'sbg:x': 111.25000944733532
          'sbg:includeInPorts': true
          label: Knowledge Network Edge Type
        - type:
            - File
          required: true
          'sbg:y': 350.0000096559507
          id: '#genomic_spreadsheet_file'
          description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
          'sbg:x': 102.50005492567655
          'sbg:includeInPorts': true
          label: Genomic Spreadsheet File
      'sbg:toolkitVersion': v1.0
      'sbg:publisher': KnowEnG
      'sbg:revisionNotes': >-
        Copy of
        mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/4
      'sbg:modifiedOn': 1530641550
      description: >-
        This [KnowEnG](https://knoweng.org/) Gene Set Characterization workflow
        tests a gene set for enrichment against a large compendium of
        [annotations](https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type).


        This workflow starts with a user-submitted gene set (or multiple gene
        sets) and determines if each gene set is enriched for a pathway, a [Gene
        Ontology](https://www.ncbi.nlm.nih.gov/pubmed/25428369) term, or other
        types of annotations.  This pipeline tests your gene set for enrichment
        against a large compendium of annotations.  Gene Set Characterization
        can be done using a standard [statistical
        test](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.fisher_exact.html#scipy.stats.fisher_exact)
        or in a Knowledge Network-guided mode (using
        [DRaWR](https://www.ncbi.nlm.nih.gov/pubmed/27153592)).


        A network-guided analysis can offer various benefits over a standard
        one, including considering not just significant genes but also their
        network neighbors, and inferring properties of poorly annotated genes.


        ### Required inputs


        This workflow has one required input file:


        1. Genomic Spreadsheet File (ID: *genomic_spreadsheet_file*).  This
        currently must be a TSV file (a spreadsheet with tab-separated values). 
        The first row (header) should contain the names of the gene sets in the
        corresponding columns.  The first column of the spreadsheet should be
        the gene identifiers corresponding to each row.  For each entry in the
        spreadsheet table, a “1” indicates that the corresponding row gene is
        part of the corresponding column gene set, a “0” means it is not.  There
        should be no NA values/empty cells.


        A sample input file,
        [demo_GSC.spreadsheet.txt](https://cgc.sbgenomics.com/public/files/5a2820bf4f0cbd94bfb86b3b/),
        as described in the [quickstart guide for this
        workflow](https://knoweng.org/wp-content/uploads/2017/12/GSC_CGC_Quickstart.pdf),
        is available.


        Example of Genomic Spreadsheet File Format:


        | &nbsp; | GeneSet1 | GeneSet2 | GeneSet3 | 

        | --- | --- | --- | --- | --- |

        |**Gene1**| 0 | 1 | 1 |

        |**Gene2**| 0 | 0 | 0 |

        |**Gene3**| 1 | 0 | 1 |

        |**Gene4**| 0 | 1 | 0 |

        |**Gene5**| 1 | 0 | 0 |

        |...| ... | ... | ... |


        There are two required input parameters:


        1. Species Taxon ID (ID: *taxonid*; type: string).  The ID of the
        species to be used in the analysis, e.g., "9606" for human.  Possible
        values are listed in parentheses in the first column of the [KnowEnG
        Supported
        Species](https://knoweng.org/kn-data-references/#kn_contents_by_species)
        table (“KN Contents by Species”).


        2. Gene Set Property Network Edge Type (ID: *pg_edge_type*; type:
        string).  The edge type for the gene set property network, e.g.,
        "gene_ontology".  Possible values are listed in parentheses in the first
        column of the [KnowEnG Gene Set
        Collections](https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type)
        table (“KN Contents by Property-Gene Edge Type”).


        ### Optional inputs


        There are two optional input parameters:


        1. Knowledge Network Edge Type (ID: *gg_edge_type*; type: string).  The
        edge type for the knowledge network (i.e., interaction network), e.g.,
        "STRING_experimental".  Possible values are listed in parentheses in the
        first column of the [KnowEnG Interaction
        Networks](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type)
        table (KN Contents by Gene-Gene Edge Type“”)(use one of the values in
        parentheses).  If no value is specified, no knowledge network will be
        used in the analysis.


        2. Amount of Network Smoothing (ID: *network_smoothing_percent*; type:
        int).  The amount of network smoothing.  This should be an integer
        between 0 and 100 (inclusive).  If no value is specified (or the value
        is outside that range), 50% will be used.  A greater value means greater
        contribution from the network interactions.  (This value is only
        relevant if the knowledge network is used.)


        ### Outputs


        This workflow generates nine output files.  These are outlined below. 
        The structure and order specified here may not match what's listed on
        the completed task page.  The README output file goes into more detail
        on the purpose and the contents of the various output files.  That file
        can also be found
        [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-GSC.md).


        #### Results


        * GSC Results (file name: `gsc_results.txt`).


        * README (file name: `README-GSC.txt`).  This file describes the various
        output files.


        #### Mapping


        * Gene Map File (file name: `gene_map.txt`).


        * Clean Genomic File (file name: `clean_gene_set_matrix.txt`).


        * Gene Set Name Map File (file name: `gene_set_name_map.txt`).


        * Raw Enrichment Scores (file name format:
        `DRaWR_sorted_by_property_score_<string_based_on_date_time>.df` or
        `fisher_sorted_by_property_score_<string_based_on_date_time>.df`).


        #### Metadata and run info


        * Gene Set Property Network Metadata File (file name format:
        `<taxonid>.<edge_type>.metadata`, e.g., `9606.gene_ontology.metadata`).


        * Interaction Network Metadata File (file name format:
        `<taxonid>.<edge_type>.metadata`, e.g.,
        `9606.STRING_experimental.metadata`).  This file will only be present if
        a knowledge network was used in the analysis.


        * GSC Run Params yml (file name: `run_params.yml`).


        ### Additional Resources


        [Quickstart
        Guide](https://knoweng.org/wp-content/uploads/2017/11/GSC_CGC_Quickstart.pdf)
        for this workflow


        [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
        knowledge-guided analysis


        [YouTube Tutorial](https://youtu.be/nP4wtVZOY3E) for this workflow in
        KnowEnG Platform


        [Additional Pipelines](https://knoweng.org/pipelines/) supported by
        KnowEnG


        ### Acknowledgements


        The KnowEnG BD2K center is supported by grant U54GM114838 awarded by
        NIGMS through funds provided by the trans-NIH Big Data to Knowledge
        (BD2K) initiative.


        Questions or comments can be sent to knoweng-support@illinois.edu.


        ### References


        Blatti C, Sinha S. Characterizing gene sets using discriminative random
        walks with restart on heterogeneous biological networks. Bioinformatics.
        2016;32(14):2167-75.


        Gene Ontology Consortium: going forward. Nucleic Acids Res.
        2015;43(Database issue):D1049-56.
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/lung/gene-set-characterization/0.png
      outputs:
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 448.74994266033366
          id: '#run_params_yml'
          description: The configuration parameters specified for the GSC run
          'sbg:x': 1247.4998056590632
          'sbg:includeInPorts': true
          label: GSC Run Params yml
          source:
            - '#Gene_Set_Characterization.run_params_yml'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 382.499916091565
          id: '#readme'
          description: README-GSC.txt
          'sbg:x': 1109.999571055196
          'sbg:includeInPorts': true
          label: README
          source:
            - '#Gene_Set_Characterization.readme'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 236.24997073412038
          id: '#new_data_file'
          description: 'GSC enrichment scores, with names mapped'
          'sbg:x': 1106.2496927529721
          'sbg:includeInPorts': true
          label: GSC Results
          source:
            - '#Join_Names.new_data_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 314.99988959730223
          id: '#interaction_network_metadata_file'
          description: The interaction network metadata file
          'sbg:x': 1248.7494408637579
          'sbg:includeInPorts': true
          label: Interaction Network Metadata File
          source:
            - '#Join_Names.interaction_network_metadata_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 63.74997279048104
          id: '#gene_set_network_metadata_file'
          description: The gene set property network metadata file
          'sbg:x': 1118.749081209353
          'sbg:includeInPorts': true
          label: Gene Set Property Network Metadata File
          source:
            - '#Knowledge_Network_Fetcher_1.network_metadata_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 159.99999165534976
          id: '#gene_set_name_map_file'
          description: The gene set name map file
          'sbg:x': 1248.7498052120284
          'sbg:includeInPorts': true
          label: Gene Set Name Map File
          source:
            - '#Join_Names.name_map_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 601.2500250488484
          id: '#gene_map_file'
          description: The gene map file
          'sbg:x': 1247.499927133322
          'sbg:includeInPorts': true
          label: Gene Map File
          source:
            - '#Gene_Set_Characterization.gene_map_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 678.7499595433475
          id: '#enrichment_scores'
          description: The GSC raw enrichment scores
          'sbg:x': 1112.4998140782193
          'sbg:includeInPorts': true
          label: Raw Enrichment Scores
          source:
            - '#Gene_Set_Characterization.enrichment_scores'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 519.9999691545964
          id: '#clean_genomic_file'
          description: The clean genomic spreadsheet file
          'sbg:x': 1109.9998150467948
          'sbg:includeInPorts': true
          label: Clean Genomic File
          source:
            - '#Gene_Set_Characterization.genomic_file_out'
      x: 891.0936737060549
      'sbg:modifiedBy': mepstein
      label: Gene Set Characterization Workflow
      'sbg:revision': 0
      'sbg:canvas_x': 137
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/4
          'sbg:modifiedOn': 1530641550
          'sbg:revision': 0
      'sbg:createdOn': 1530641550
      'sbg:license': >-
        Copyright (c) 2017, University of Illinois Board of Trustees; All rights
        reserved.
      'sbg:sbgMaintained': false
      'y': 270.52787780761724
      id: mepstein/lung/gene-set-characterization/0
      requirements: []
      'sbg:categories':
        - Analysis
        - Characterization
        - Enrichment
      'sbg:project': mepstein/lung
      'sbg:toolkit': KnowEnG_CGC
      steps:
        - 'sbg:x': 346.2497055977747
          'sbg:y': 495.01529136208785
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - ''
            'sbg:id': >-
              mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
            inputs:
              - type:
                  - 'null'
                  - string
                required: false
                description: The knowledge network edge type (not required)
                id: '#knowledge_network_edge_type'
                'sbg:includeInPorts': true
                label: Knowledge Network Edge Type
            'sbg:publisher': sbg
            x: 346.2497055977747
            'sbg:cmdPreview': ''
            'sbg:revisionNotes': >-
              Copy of
              mepstein/genesetcharacterization/gene-set-characterization-parameters/5
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
            stdout: ''
            'sbg:modifiedOn': 1512041611
            description: >-
              Sets the input parameters of some of the intermediate apps in the
              GSC workflow based on some of the input parameters to the workflow
              itself.
            'sbg:image_url': null
            outputs:
              - id: '#gsc_method'
                type:
                  - 'null'
                  - string
                description: 'The GSC method to use (e.g., DRaWR, fisher)'
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      if ($job.inputs.knowledge_network_edge_type) {
                          gsc_method = "DRaWR";
                      }
                      else {
                          gsc_method = "fisher";
                      }

                      gsc_method;
                label: GSC Method
              - id: '#get_network'
                type:
                  - 'null'
                  - boolean
                description: Whether to get the network
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      if ($job.inputs.knowledge_network_edge_type) {
                          get_network = true;
                      }
                      else {
                          get_network = false;
                      }

                      get_network;
                label: Get Network Flag
              - id: '#edge_type'
                type:
                  - 'null'
                  - string
                description: The network edge type
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      $job.inputs.knowledge_network_edge_type;
                label: Network Edge Type
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Gene Set Characterization Parameters
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': >-
                  Copy of
                  mepstein/genesetcharacterization/gene-set-characterization-parameters/5
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512041611
                'sbg:revision': 0
            'sbg:createdOn': 1512041611
            'sbg:sbgMaintained': false
            'y': 495.01529136208785
            id: >-
              mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: ubuntu
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:copyOf': >-
              mepstein/genesetcharacterization/gene-set-characterization-parameters/5
            'sbg:job':
              inputs:
                knowledge_network_edge_type: knowlege_network_edge_type-string-value
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Gene_Set_Characterization_Parameters'
          outputs:
            - id: '#Gene_Set_Characterization_Parameters.gsc_method'
            - id: '#Gene_Set_Characterization_Parameters.get_network'
            - id: '#Gene_Set_Characterization_Parameters.edge_type'
          inputs:
            - id: >-
                #Gene_Set_Characterization_Parameters.knowledge_network_edge_type
              source:
                - '#gg_edge_type'
        - 'sbg:x': 857.2497657984607
          'sbg:y': 194.01553714182688
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - sh
              - file_renamer.cmd
              - '&&'
              - python3
              - join_names.py
            'sbg:id': mepstein/knoweng-genesetcharacterization/join-names/0
            inputs:
              - description: The output file name
                type:
                  - string
                id: '#output_file_name'
                required: true
                label: Output File Name
              - type:
                  - File
                required: true
                inputBinding:
                  prefix: '-m'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#name_map_file'
                description: The name map file
                'sbg:fileTypes': TSV
                label: Name Map File
              - description: The interaction network metadata file
                type:
                  - 'null'
                  - File
                id: '#interaction_network_metadata_file'
                required: false
                label: Interaction Network Metadata File
              - type:
                  - File
                required: true
                inputBinding:
                  prefix: '-f'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#data_file'
                description: The data file
                'sbg:fileTypes': TSV
                label: Data File
            'sbg:publisher': sbg
            x: 857.2497657984607
            'sbg:cmdPreview': >-
              sh file_renamer.cmd && python3 join_names.py -f
              /path/to/data_file.ext -m /path/to/name_map_file.ext >
              output_file_name-string-value
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/join-names/4
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/join-names/0
            stdout:
              engine: '#cwl-js-engine'
              class: Expression
              script: $job.inputs.output_file_name
            'sbg:modifiedOn': 1512042115
            description: >-
              This program adds columns to a file by matching keys in a
              designated column of that file to keys/lines in another file.
            'sbg:image_url': null
            outputs:
              - id: '#new_data_file'
                type:
                  - 'null'
                  - File
                description: The new data file
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: $job.inputs.output_file_name
                label: New Data File
              - id: '#name_map_file_out'
                type:
                  - 'null'
                  - File
                description: The name map file
                outputBinding:
                  glob: gene_set_name_map.txt
                label: Name Map File
              - id: '#interaction_network_metadata_file_out'
                type:
                  - 'null'
                  - File
                description: The interaction network metadata file
                outputBinding:
                  glob: interaction_network.metadata
                label: Interaction Network Metadata File
            requirements:
              - fileDef:
                  - fileContent: >-
                      #!/usr/bin/env python3



                      """

                      This program adds columns to a file by matching keys in a
                      designated

                      column of that file to keys/lines in another file.


                      More specifically:

                      This program takes two required arguments, a data_file
                      (-f) and a name_map_file (-m).

                      Each of these are delimiter-separated files (-d, default
                      '\t').


                      For the data_file, one column is designated as the
                      data_column (-c, default 1).


                      For the name_map_file, one column is designated as the
                      key_column (-k, default 1).


                      The program loops through the lines of the data_file, uses
                      the data in

                      the data_column as a key, finds that key in the
                      name_map_file, and

                      adds columns from that line of the name_map_file (starting
                      at the

                      add_column, -a, default 3) to the end of that line of the
                      data_file.

                      If the key is not found, columns of empty strings are
                      added.


                      It outputs (to stdout) this modified version of the
                      data_file.

                      """



                      import argparse



                      DEFAULT_KEY_COLUMN = 1


                      DEFAULT_DATA_COLUMN = 1


                      DEFAULT_ADD_COLUMN = 3


                      DEFAULT_DELIMITER = '\t'


                      DATA_FILE_HAS_HEADERS = True


                      NAME_MAP_FILE_HAS_HEADERS = False


                      NEW_HEADERS = ['alias', 'description']



                      def parse_args():
                          parser = argparse.ArgumentParser()

                          parser.add_argument('-f', '--data_file', required=True)
                          parser.add_argument('-m', '--name_map_file', required=True)
                          parser.add_argument('-k', '--key_column', default=DEFAULT_KEY_COLUMN)
                          parser.add_argument('-c', '--data_column', default=DEFAULT_DATA_COLUMN)
                          parser.add_argument('-a', '--add_column', default=DEFAULT_ADD_COLUMN)
                          parser.add_argument('-d', '--delimiter', default=DEFAULT_DELIMITER)
                          parser.add_argument('-e', '--empty_headers', action='store_true')

                          args = parser.parse_args()

                          return args


                      def read_name_map_file(name_map_file, key_column,
                      delimiter):
                          name_data = {}

                          with open(name_map_file, 'r') as f:
                              if NAME_MAP_FILE_HAS_HEADERS:
                                  line = next(f)
                                  headers = line.rstrip().split(sep=delimiter)
                              else:
                                  headers = []
                              for line in f:
                                  fields = line.rstrip().split(sep=delimiter)
                                  key = fields[key_column]
                                  name_data[key] = fields
                                  length = len(fields)

                          return name_data, headers, length


                      def main():
                          args = parse_args()

                          name_data, name_data_headers, name_data_length = \
                            read_name_map_file(args.name_map_file, args.key_column, args.delimiter)
                          added_length = name_data_length - args.add_column

                          keys_not_found = {}

                          with open(args.data_file, 'r') as f:
                              if DATA_FILE_HAS_HEADERS:
                                  line = next(f)
                                  fields = line.rstrip().split(sep=args.delimiter)
                                  if NAME_MAP_FILE_HAS_HEADERS:
                                      fields.extend(name_data_headers[args.add_column:])
                                  else:
                                      if args.empty_headers:
                                          new_headers = [''] * added_length
                                      else:
                                          if added_length > len(NEW_HEADERS):
                                              new_headers = NEW_HEADERS +  [''] * (added_length - len(NEW_HEADERS))
                                          elif added_length == len(NEW_HEADERS):
                                              new_headers = NEW_HEADERS
                                          else:
                                              new_headers = NEW_HEADERS[:added_length]
                                      fields.extend(new_headers)
                                  print(args.delimiter.join(fields))
                              for line in f:
                                  fields = line.rstrip().split(sep=args.delimiter)
                                  key = fields[args.data_column]
                                  if key in name_data:
                                      fields.extend(name_data[key][args.add_column:])
                                  else:
                                      if key in keys_not_found:
                                          keys_not_found[key] += 1
                                      else:
                                          keys_not_found[key] = 1
                                      fields.extend([''] * added_length)
                                  print(args.delimiter.join(fields))


                      if __name__ == "__main__":
                          main()
                    filename: join_names.py
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: |
                        str = ""

                        if ($job.inputs.interaction_network_metadata_file) {
                            str += "cp -p " + $job.inputs.interaction_network_metadata_file.path + " interaction_network.metadata\n";
                        }

                        if ($job.inputs.name_map_file) {
                            str += "cp -p " + $job.inputs.name_map_file.path + " gene_set_name_map.txt\n";
                        }

                        str;
                    filename: file_renamer.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Join Names
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/join-names/4
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512042115
                'sbg:revision': 0
            'sbg:createdOn': 1512042115
            'sbg:sbgMaintained': false
            'y': 194.01553714182688
            id: mepstein/knoweng-genesetcharacterization/join-names/0
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: 'cblatti3/py3_slim:0.1'
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/join-names/4
            'sbg:job':
              inputs:
                name_map_file:
                  size: 0
                  class: File
                  path: /path/to/name_map_file.ext
                  secondaryFiles: []
                data_file:
                  size: 0
                  class: File
                  path: /path/to/data_file.ext
                  secondaryFiles: []
                output_file_name: output_file_name-string-value
                interaction_network_metadata_file:
                  size: 0
                  class: File
                  path: /path/to/interaction_network_metadata_file.ext
                  secondaryFiles: []
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Join_Names'
          outputs:
            - id: '#Join_Names.new_data_file'
            - id: '#Join_Names.name_map_file_out'
            - id: '#Join_Names.interaction_network_metadata_file_out'
          inputs:
            - id: '#Join_Names.output_file_name'
              default: gsc_results.txt
            - id: '#Join_Names.name_map_file'
              source:
                - '#Knowledge_Network_Fetcher_1.pnode_map_file'
            - id: '#Join_Names.interaction_network_metadata_file'
              source:
                - '#Knowledge_Network_Fetcher.network_metadata_file'
            - id: '#Join_Names.data_file'
              source:
                - '#Gene_Set_Characterization.enrichment_scores'
        - 'sbg:x': 371.99973487855465
          'sbg:y': 82.26555809285858
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - sh
              - run_fetch.cmd
            'sbg:id': mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: the taxonomic id for the species of interest
                description: 'The network species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Network Species Taxon ID
              - 'sbg:toolDefaultValue': Gene
                type:
                  - 'null'
                  - string
                required: false
                doc: the type of subnetwork
                description: 'The network type (e.g., Gene, Property)'
                default: Gene
                id: '#network_type'
                label: Network Type
              - 'sbg:toolDefaultValue': 'true'
                type:
                  - 'null'
                  - boolean
                required: false
                doc: whether or not to get the network
                description: >-
                  Whether to get the network (or create a dummy/empty network
                  file)
                default: true
                id: '#get_network'
                label: Get Network Flag
              - 'sbg:toolDefaultValue': STRING_experimental
                type:
                  - 'null'
                  - string
                required: false
                doc: the edge type keyword for the subnetwork of interest
                description: >-
                  The network edge type (e.g., STRING_experimental,
                  gene_ontology)
                default: PPI_physical_association
                id: '#edge_type'
                'sbg:includeInPorts': true
                label: Network Edge Type
              - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
                type:
                  - 'null'
                  - string
                required: false
                doc: the aws s3 bucket
                description: The AWS S3 bucket to fetch the network from
                default: KnowNets/KN-20rep-1706/userKN-20rep-1706
                id: '#bucket'
                label: AWS S3 Bucket Name
            'sbg:publisher': sbg
            x: 371.99973487855465
            'sbg:cmdPreview': sh run_fetch.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            stdout: ''
            'sbg:modifiedOn': 1512037727
            description: >-
              Fetch a knowledge network from an AWS S3 bucket, given a network
              type, an edge type, and a species taxon ID.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The pnode map file
                id: '#pnode_map_file'
                outputBinding:
                  glob: '*.pnode_map'
                label: PNode Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The node map file
                id: '#node_map_file'
                outputBinding:
                  glob: '*.node_map'
                label: Node Map File
              - type:
                  - 'null'
                  - File
                doc: yaml format describing network contents
                description: The network metadata file
                id: '#network_metadata_file'
                outputBinding:
                  glob: '*.metadata'
                label: Network Metadata File
              - type:
                  - 'null'
                  - File
                doc: >-
                  4 column format for subnetwork for single edge type and
                  species
                description: The network edge file
                id: '#network_edge_file'
                outputBinding:
                  glob: '*.edge'
                label: Network Edge File
              - type:
                  - 'null'
                  - File
                doc: log of fetch command
                description: The log of the fetch command
                id: '#cmd_log_file'
                outputBinding:
                  glob: run_fetch.cmd
                label: Command Log File
            requirements:
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        //MYCMD="date && if [ " + $job.inputs.get_network + ' =
                        "true" ]; then /home/kn_fetcher.sh
                        '+$job.inputs.bucket+' '+$job.inputs.network_type+'
                        '+$job.inputs.taxonid+' '+$job.inputs.edge_type+'; else
                        touch empty.edge; fi && date'


                        str = "";


                        str += "date";

                        if ($job.inputs.get_network) {

                        //if ($job.inputs.get_network == "true") {
                            str += " && /home/kn_fetcher.sh " + $job.inputs.bucket + " " + $job.inputs.network_type + 
                        " " + $job.inputs.taxonid + " " + $job.inputs.edge_type;

                        }

                        else {
                            //str += " && touch empty.edge";
                        }

                        str += " && date";


                        str;
                    filename: run_fetch.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Knowledge Network Fetcher
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512037727
                'sbg:revision': 0
            'sbg:createdOn': 1512037727
            'sbg:sbgMaintained': false
            doc: >-
              Retrieve appropriate subnetwork from KnowEnG Knowledge Network
              from AWS S3 storage
            id: mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            cwlVersion: 'sbg:draft-2'
            'y': 82.26555809285858
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
                class: DockerRequirement
              - ramMin: 2000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Knowledge_Network_Fetcher_1'
          outputs:
            - id: '#Knowledge_Network_Fetcher_1.pnode_map_file'
            - id: '#Knowledge_Network_Fetcher_1.node_map_file'
            - id: '#Knowledge_Network_Fetcher_1.network_metadata_file'
            - id: '#Knowledge_Network_Fetcher_1.network_edge_file'
            - id: '#Knowledge_Network_Fetcher_1.cmd_log_file'
          inputs:
            - id: '#Knowledge_Network_Fetcher_1.taxonid'
              source:
                - '#taxonid'
            - id: '#Knowledge_Network_Fetcher_1.network_type'
              default: Property
            - id: '#Knowledge_Network_Fetcher_1.get_network'
              default: true
            - id: '#Knowledge_Network_Fetcher_1.edge_type'
              source:
                - '#pg_edge_type'
            - id: '#Knowledge_Network_Fetcher_1.bucket'
              default: KnowNets/KN-20rep-1706/userKN-20rep-1706
        - 'sbg:x': 567.249511778382
          'sbg:y': 252.0154585084038
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - sh
              - run_dc.cmd
            'sbg:id': mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: taxon id of species related to genomic spreadsheet
                description: 'The species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Species Taxon ID
              - 'sbg:toolDefaultValue': ''''''
                type:
                  - 'null'
                  - string
                required: false
                doc: >-
                  suggestion for ID source database used to resolve ambiguities
                  in mapping
                description: The source hint for the redis queries (can be '')
                default: \'\'
                id: '#source_hint'
                label: ID Source Hint
              - 'sbg:toolDefaultValue': 6379
                type:
                  - 'null'
                  - int
                required: false
                doc: port for Redis db
                description: The redis DB port
                default: 6379
                id: '#redis_port'
                label: RedisDB Port
              - 'sbg:toolDefaultValue': KnowEnG
                type:
                  - 'null'
                  - string
                required: false
                doc: password for Redis db
                description: The redis DB password
                default: KnowEnG
                id: '#redis_pass'
                label: RedisDB Password
              - 'sbg:toolDefaultValue': knowredis.knoweng.org
                type:
                  - 'null'
                  - string
                required: false
                doc: url of Redis db
                description: The redis DB host name
                default: knowredis.knoweng.org
                id: '#redis_host'
                label: RedisDB Host
              - type:
                  - string
                required: true
                doc: >-
                  keywork name of pipeline from following list
                  ['gene_prioritization_pipeline',
                  'samples_clustering_pipeline',
                  'geneset_characterization_pipeline']
                description: >-
                  The name of the pipeline that will be run (i.e., data cleaning
                  is pipeline-specific)
                id: '#pipeline_type'
                label: Name of Pipeline
              - 'sbg:toolDefaultValue':
                  location: /bin/sh
                  class: File
                type:
                  - 'null'
                  - File
                required: false
                doc: >-
                  the phenotypic spreadsheet input for the pipeline [may be
                  optional]
                description: The phenotypic spreadsheet file (optional)
                default:
                  location: /bin/sh
                  class: File
                id: '#phenotypic_spreadsheet_file'
                label: Phenotypic Spreadsheet File (optional)
              - type:
                  - File
                required: true
                doc: the genomic spreadsheet input for the pipeline
                description: The genomic spreadsheet file
                id: '#genomic_spreadsheet_file'
                label: Genomic Spreadsheet File
              - 'sbg:toolDefaultValue': missing
                type:
                  - 'null'
                  - string
                required: false
                doc: >-
                  if pipeline_type=='gene_prioritization_pipeline', then must be
                  one of either ['t_test', 'pearson']
                description: >-
                  The correlation measure to be used for GP (e.g., t_test or
                  pearson)
                default: missing
                id: '#gene_prioritization_corr_measure'
                label: GP Correlation Measure
            'sbg:publisher': sbg
            x: 567.249511778382
            'sbg:cmdPreview': sh run_dc.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
            stdout: ''
            'sbg:modifiedOn': 1512038144
            description: >-
              Clean/preprocess input data (genomic and optionally phenotypic)
              for use with other tools/pipelines.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: two columns for original gene ids and unmapped reason code
                description: The genes that were not mapped
                id: '#gene_unmap_file'
                outputBinding:
                  glob: '*_UNMAPPED.tsv'
                label: Gene Unmapped File
              - type:
                  - 'null'
                  - File
                doc: two columns for internal gene ids and original gene ids
                description: The gene map file
                id: '#gene_map_file'
                outputBinding:
                  glob: '*_MAP.tsv'
                label: Gene Map File
              - id: '#cmd_log_file'
                type:
                  - 'null'
                  - File
                description: The log of the data cleaning command
                outputBinding:
                  glob: run_dc.cmd
                label: Command Log File
              - type:
                  - 'null'
                  - File
                doc: data cleaning parameters in yaml format
                description: >-
                  The configuration parameters specified for the data cleaning
                  run
                id: '#cleaning_parameters_yml'
                outputBinding:
                  glob: run_cleanup.yml
                label: Cleaning Parameters File
              - type:
                  - 'null'
                  - File
                doc: information on souce of errors for cleaning pipeline
                description: The log of the data cleaning run
                id: '#cleaning_log_file'
                outputBinding:
                  glob: log_*_pipeline.yml
                label: Cleaning Log File
              - type:
                  - 'null'
                  - File
                doc: phenotype file prepared for pipeline
                description: The clean phenotypic spreadsheet
                id: '#clean_phenotypic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Phenotypic Spreadsheet
              - type:
                  - 'null'
                  - File
                doc: matrix with gene names mapped and data cleaned
                description: The clean genomic spreadsheet
                id: '#clean_genomic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Genomic Spreadsheet
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        str = ""


                        str += "pipeline_type: " + $job.inputs.pipeline_type +
                        "\n";

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

                        if ($job.inputs.pipeline_type ==
                        "gene_prioritization_pipeline") {
                            str += "correlation_measure: " + $job.inputs.gene_prioritization_corr_measure + "\n";
                        }


                        //str2 = "echo \"" + str + "\" > run_cleanup.yml"

                        //str2 = "echo \"" + str + "\" > run_cleanup.yml &&
                        touch log_X_pipeline.yml && touch GX_ETL.tsv && touch
                        PX_ETL.tsv && touch X_MAP.tsv && touch X_UNMAPPED.tsv"

                        str2 = "echo \"" + str + "\" > run_cleanup.yml && date
                        && python3 /home/src/data_cleanup.py -run_directory ./
                        -run_file run_cleanup.yml && date"


                        str2;
                    filename: run_dc.cmd
                class: CreateFileRequirement
            class: CommandLineTool
            label: Data Cleaning/Preprocessing
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512038144
                'sbg:revision': 0
            'sbg:createdOn': 1512038144
            'sbg:sbgMaintained': false
            doc: checks the inputs of a pipeline for potential sources of errors
            id: mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
            cwlVersion: 'sbg:draft-2'
            'y': 252.0154585084038
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
                class: DockerRequirement
              - ramMin: 5000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Pipeline_Preprocessing'
          outputs:
            - id: '#Pipeline_Preprocessing.gene_unmap_file'
            - id: '#Pipeline_Preprocessing.gene_map_file'
            - id: '#Pipeline_Preprocessing.cmd_log_file'
            - id: '#Pipeline_Preprocessing.cleaning_parameters_yml'
            - id: '#Pipeline_Preprocessing.cleaning_log_file'
            - id: '#Pipeline_Preprocessing.clean_phenotypic_file'
            - id: '#Pipeline_Preprocessing.clean_genomic_file'
          inputs:
            - id: '#Pipeline_Preprocessing.taxonid'
              source:
                - '#taxonid'
            - id: '#Pipeline_Preprocessing.source_hint'
              default: ''''''
            - id: '#Pipeline_Preprocessing.redis_port'
              default: 6379
            - id: '#Pipeline_Preprocessing.redis_pass'
              default: KnowEnG
            - id: '#Pipeline_Preprocessing.redis_host'
              default: knowredis.knoweng.org
            - id: '#Pipeline_Preprocessing.pipeline_type'
              default: geneset_characterization_pipeline
            - id: '#Pipeline_Preprocessing.phenotypic_spreadsheet_file'
            - id: '#Pipeline_Preprocessing.genomic_spreadsheet_file'
              source:
                - '#genomic_spreadsheet_file'
            - id: '#Pipeline_Preprocessing.gene_prioritization_corr_measure'
        - 'sbg:x': 582.4998470097854
          'sbg:y': 641.2693711060639
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:id': mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: the taxonomic id for the species of interest
                description: 'The network species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Network Species Taxon ID
              - 'sbg:toolDefaultValue': Gene
                type:
                  - 'null'
                  - string
                required: false
                doc: the type of subnetwork
                description: 'The network type (e.g., Gene, Property)'
                default: Gene
                id: '#network_type'
                label: Network Type
              - 'sbg:toolDefaultValue': 'true'
                type:
                  - 'null'
                  - boolean
                required: false
                doc: whether or not to get the network
                description: >-
                  Whether to get the network (or create a dummy/empty network
                  file)
                default: true
                id: '#get_network'
                'sbg:includeInPorts': true
                label: Get Network Flag
              - 'sbg:toolDefaultValue': STRING_experimental
                type:
                  - 'null'
                  - string
                required: false
                doc: the edge type keyword for the subnetwork of interest
                description: >-
                  The network edge type (e.g., STRING_experimental,
                  gene_ontology)
                default: PPI_physical_association
                id: '#edge_type'
                'sbg:includeInPorts': true
                label: Network Edge Type
              - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
                type:
                  - 'null'
                  - string
                required: false
                doc: the aws s3 bucket
                description: The AWS S3 bucket to fetch the network from
                default: KnowNets/KN-20rep-1706/userKN-20rep-1706
                id: '#bucket'
                label: AWS S3 Bucket Name
            'sbg:publisher': sbg
            x: 582.4998470097854
            'sbg:cmdPreview': sh run_fetch.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            stdout: ''
            'sbg:modifiedOn': 1512037727
            description: >-
              Fetch a knowledge network from an AWS S3 bucket, given a network
              type, an edge type, and a species taxon ID.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The pnode map file
                id: '#pnode_map_file'
                outputBinding:
                  glob: '*.pnode_map'
                label: PNode Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The node map file
                id: '#node_map_file'
                outputBinding:
                  glob: '*.node_map'
                label: Node Map File
              - type:
                  - 'null'
                  - File
                doc: yaml format describing network contents
                description: The network metadata file
                id: '#network_metadata_file'
                outputBinding:
                  glob: '*.metadata'
                label: Network Metadata File
              - type:
                  - 'null'
                  - File
                doc: >-
                  4 column format for subnetwork for single edge type and
                  species
                description: The network edge file
                id: '#network_edge_file'
                outputBinding:
                  glob: '*.edge'
                label: Network Edge File
              - type:
                  - 'null'
                  - File
                doc: log of fetch command
                description: The log of the fetch command
                id: '#cmd_log_file'
                outputBinding:
                  glob: run_fetch.cmd
                label: Command Log File
            requirements:
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        //MYCMD="date && if [ " + $job.inputs.get_network + ' =
                        "true" ]; then /home/kn_fetcher.sh
                        '+$job.inputs.bucket+' '+$job.inputs.network_type+'
                        '+$job.inputs.taxonid+' '+$job.inputs.edge_type+'; else
                        touch empty.edge; fi && date'


                        str = "";


                        str += "date";

                        if ($job.inputs.get_network) {

                        //if ($job.inputs.get_network == "true") {
                            str += " && /home/kn_fetcher.sh " + $job.inputs.bucket + " " + $job.inputs.network_type + 
                        " " + $job.inputs.taxonid + " " + $job.inputs.edge_type;

                        }

                        else {
                            //str += " && touch empty.edge";
                        }

                        str += " && date";


                        str;
                    filename: run_fetch.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Knowledge Network Fetcher
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512037727
                'sbg:revision': 0
            'sbg:createdOn': 1512037727
            'sbg:sbgMaintained': false
            doc: >-
              Retrieve appropriate subnetwork from KnowEnG Knowledge Network
              from AWS S3 storage
            id: mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            cwlVersion: 'sbg:draft-2'
            'y': 641.2693711060639
            baseCommand:
              - sh
              - run_fetch.cmd
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
                class: DockerRequirement
              - ramMin: 2000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Knowledge_Network_Fetcher'
          outputs:
            - id: '#Knowledge_Network_Fetcher.pnode_map_file'
            - id: '#Knowledge_Network_Fetcher.node_map_file'
            - id: '#Knowledge_Network_Fetcher.network_metadata_file'
            - id: '#Knowledge_Network_Fetcher.network_edge_file'
            - id: '#Knowledge_Network_Fetcher.cmd_log_file'
          inputs:
            - id: '#Knowledge_Network_Fetcher.taxonid'
              source:
                - '#taxonid'
            - id: '#Knowledge_Network_Fetcher.network_type'
              default: Gene
            - id: '#Knowledge_Network_Fetcher.get_network'
              source:
                - '#Gene_Set_Characterization_Parameters.get_network'
            - id: '#Knowledge_Network_Fetcher.edge_type'
              source:
                - '#Gene_Set_Characterization_Parameters.edge_type'
            - id: '#Knowledge_Network_Fetcher.bucket'
              default: KnowNets/KN-20rep-1706/userKN-20rep-1706
        - 'sbg:x': 740.2494721412951
          'sbg:y': 450.0153550794495
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization_Demo
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
              - mepstein
            baseCommand:
              - sh
              - run_gr.cmd
              - '&&'
              - sh
              - file_renamer.cmd
              - '&&'
              - python3
              - wget.py
              - >-
                https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md
              - README-GSC.md
            'sbg:id': mepstein/knoweng-genesetcharacterization/gsc-runner-copy/1
            inputs:
              - type:
                  - File
                required: true
                doc: property-gene network of interactions in edge format
                description: The gene set property network file
                id: '#pg_network_file'
                label: Gene Set Property Network File
              - 'sbg:toolDefaultValue': '50'
                type:
                  - 'null'
                  - int
                required: false
                description: >-
                  The amount of network smoothing (as a percent; default 50%); a
                  greater value means greater contribution from the network
                  interactions
                id: '#network_smoothing_percent'
                'sbg:includeInPorts': true
                label: Amount of Network Smoothing
              - type:
                  - 'null'
                  - string
                required: false
                doc: 'which method to use for GSC, i.e. DRaWR, fisher'
                description: 'The GSC method to use (e.g., DRaWR, fisher)'
                id: '#gsc_method'
                'sbg:includeInPorts': true
                label: GSC Method
              - type:
                  - 'null'
                  - File
                required: false
                doc: gene-gene network of interactions in edge format
                description: The knowledge network file
                id: '#gg_network_file'
                label: Knowledge Network File
              - type:
                  - File
                required: true
                doc: >-
                  spreadsheet of genomic data with samples as columns and genes
                  as rows
                description: The genomic spreadsheet file
                id: '#genomic_file'
                label: Genomic Spreadsheet File
              - id: '#gene_map_file'
                type:
                  - 'null'
                  - File
                description: The gene map file
                required: false
                label: Gene Map File
            'sbg:publisher': sbg
            x: 740.2494721412951
            'sbg:cmdPreview': >-
              sh run_gr.cmd && sh file_renamer.cmd && python3 wget.py
              https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md
              README-GSC.md
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/17
            stdout: ''
            'sbg:modifiedOn': 1517261405
            description: >-
              Test a gene set for enrichment against a large compendium of
              annotations.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: contains the values used in analysis
                description: The configuration parameters specified for the GSC run
                id: '#run_params_yml'
                outputBinding:
                  glob: run_params.yml
                label: Configuration Parameters File
              - id: '#readme'
                type:
                  - 'null'
                  - File
                description: The README file that describes the output files
                outputBinding:
                  glob: README-GSC.md
                label: The README file
              - id: '#genomic_file_out'
                type:
                  - 'null'
                  - File
                description: The clean genomic spreadsheet
                outputBinding:
                  glob: clean_gene_set_matrix.txt
                label: Genomic Spreadsheet File
              - id: '#gene_map_file_out'
                type:
                  - 'null'
                  - File
                description: The gene map file
                outputBinding:
                  glob: gene_map.txt
                label: Gene Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  Edge format file with first three columns (user gene set,
                  public gene set, score)
                description: GSC enrichment scores
                id: '#enrichment_scores'
                outputBinding:
                  glob: '*_sorted_by_property_score_*'
                label: GSC Enrichment Scores
              - id: '#cmd_log_file'
                type:
                  - 'null'
                  - File
                description: The log of the GSC run command
                outputBinding:
                  glob: run_gr.cmd
                label: Command Log File
            requirements:
              - class: ShellCommandRequirement
              - class: InlineJavascriptRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        str = "";


                        str += "spreadsheet_name_full_path: " +
                        $job.inputs.genomic_file.path + "\n";

                        str += "pg_network_name_full_path: " +
                        $job.inputs.pg_network_file.path + "\n";

                        //str += "gene_names_map: dummy.map\n";

                        if ($job.inputs.gene_map_file) {
                            str += "gene_names_map: " + $job.inputs.gene_map_file.path + "\n";
                        }

                        else {
                            str += "gene_names_map: dummy.map\n";
                        }

                        str += "results_directory: ./\n";

                        str += "method: " + $job.inputs.gsc_method + "\n";

                        //str += "gg_network_name_full_path: " +
                        $job.inputs.gg_network_file.path + "\n";

                        if ($job.inputs.gg_network_file) {
                            str += "gg_network_name_full_path: " + $job.inputs.gg_network_file.path + "\n";
                            str += "rwr_convergence_tolerence: 0.0001\n";
                            str += "rwr_max_iterations: 500\n";
                            //str += "rwr_restart_probability: 0.5\n";
                            if ($job.inputs.network_smoothing_percent &&
                                $job.inputs.network_smoothing_percent >= 0 && $job.inputs.network_smoothing_percent <= 100) {
                                //restart_prob = 1 - ($job.inputs.network_smoothing_percent/100);
                                restart_prob = $job.inputs.network_smoothing_percent/100;
                                str += "rwr_restart_probability: " + restart_prob + "\n";
                            }
                            else {
                                str += "rwr_restart_probability: 0.5\n";
                            }
                        }


                        str2 = "echo \"" + str + "\" > run_params.yml && tail
                        -n+2 " + $job.inputs.genomic_file.path + " | awk '{print
                        \$1\"\\t\"\$1}' > dummy.map && python3
                        /home/src/geneset_characterization.py -run_directory ./
                        -run_file run_params.yml";


                        str2;
                    filename: run_gr.cmd
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: |
                        str = ""

                        if ($job.inputs.gene_map_file) {
                            str += "cp -p " + $job.inputs.gene_map_file.path + " gene_map.txt\n";
                        }

                        if ($job.inputs.genomic_file) {
                            str += "cp -p " + $job.inputs.genomic_file.path + " clean_gene_set_matrix.txt\n";
                        }

                        str;
                    filename: file_renamer.cmd
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
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Gene Set Characterization
            'sbg:revision': 1
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/16
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512041775
                'sbg:revision': 0
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/17
                'sbg:modifiedBy': mepstein
                'sbg:modifiedOn': 1517261405
                'sbg:revision': 1
            'sbg:createdOn': 1512041775
            'sbg:sbgMaintained': false
            doc: >-
              Network-guided gene set characterization method implementation by
              KnowEnG that relates public gene sets to user gene sets
            id: mepstein/knoweng-genesetcharacterization/gsc-runner-copy/1
            cwlVersion: 'sbg:draft-2'
            'y': 450.0153550794495
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': mepstein
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 1
            hints:
              - dockerPull: 'knowengdev/geneset_characterization_pipeline:07_26_2017'
                class: DockerRequirement
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/gsc-runner-copy/17
            'sbg:job':
              inputs:
                network_smoothing_percent: 9
                gene_map_file:
                  size: 0
                  class: File
                  path: /path/to/gene_map_file.ext
                  secondaryFiles: []
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Gene_Set_Characterization'
          outputs:
            - id: '#Gene_Set_Characterization.run_params_yml'
            - id: '#Gene_Set_Characterization.readme'
            - id: '#Gene_Set_Characterization.genomic_file_out'
            - id: '#Gene_Set_Characterization.gene_map_file_out'
            - id: '#Gene_Set_Characterization.enrichment_scores'
            - id: '#Gene_Set_Characterization.cmd_log_file'
          inputs:
            - id: '#Gene_Set_Characterization.pg_network_file'
              source:
                - '#Knowledge_Network_Fetcher_1.network_edge_file'
            - id: '#Gene_Set_Characterization.network_smoothing_percent'
              source:
                - '#network_smoothing_percent'
            - id: '#Gene_Set_Characterization.gsc_method'
              source:
                - '#Gene_Set_Characterization_Parameters.gsc_method'
            - id: '#Gene_Set_Characterization.gg_network_file'
              source:
                - '#Knowledge_Network_Fetcher.network_edge_file'
            - id: '#Gene_Set_Characterization.genomic_file'
              source:
                - '#Pipeline_Preprocessing.clean_genomic_file'
            - id: '#Gene_Set_Characterization.gene_map_file'
              source:
                - '#Pipeline_Preprocessing.gene_map_file'
      'sbg:links':
        - id: 'https://knoweng.org/'
          label: KnowEnG Main Website
        - id: 'https://knoweng.org/analyze/'
          label: KnowEnG Analytics
        - id: 'https://knoweng.org/kn-overview/'
          label: Knowledge Network Overview
        - id: 'https://knoweng.org/pipelines/'
          label: Knowledge-Guided Pipelines
        - id: 'https://knoweng.org/pipelines/#gene_set_characterization'
          label: GSC Pipeline
        - id: 'https://knoweng.org/quick-start/'
          label: Pipeline Quickstart Guides
        - id: 'https://knoweng.org/wp-content/uploads/2017/08/GSC_Quickstart.pdf'
          label: GSC Pipeline Quickstart
        - id: >-
            https://knoweng.org/wp-content/uploads/2017/12/GSC_CGC_Quickstart.pdf
          label: CGC GSC Pipeline Quickstart
        - id: 'https://www.youtube.com/channel/UCjyIIolCaZIGtZC20XLBOyg'
          label: KnowEnG YouTube Channel
      'sbg:createdBy': mepstein
      cwlVersion: 'sbg:draft-2'
      'sbg:latestRevision': 0
      hints: []
      'sbg:toolAuthor': KnowEnG
      'sbg:canvas_y': -11
      'sbg:copyOf': >-
        mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/4
      class: Workflow
    id: '#Gene_Set_Characterization_Workflow'
    outputs:
      - id: '#Gene_Set_Characterization_Workflow.run_params_yml'
      - id: '#Gene_Set_Characterization_Workflow.readme'
      - id: '#Gene_Set_Characterization_Workflow.new_data_file'
      - id: '#Gene_Set_Characterization_Workflow.interaction_network_metadata_file'
      - id: '#Gene_Set_Characterization_Workflow.gene_set_network_metadata_file'
      - id: '#Gene_Set_Characterization_Workflow.gene_set_name_map_file'
      - id: '#Gene_Set_Characterization_Workflow.gene_map_file'
      - id: '#Gene_Set_Characterization_Workflow.enrichment_scores'
      - id: '#Gene_Set_Characterization_Workflow.clean_genomic_file'
  - 'sbg:x': 878.8235294117649
    inputs:
      - id: '#Gene_Set_Characterization_Workflow_1.taxonid'
        default: '9606'
      - id: '#Gene_Set_Characterization_Workflow_1.pg_edge_type'
        source:
          - '#pg_edge_type'
      - id: '#Gene_Set_Characterization_Workflow_1.network_smoothing_percent'
      - id: '#Gene_Set_Characterization_Workflow_1.gg_edge_type'
      - id: '#Gene_Set_Characterization_Workflow_1.genomic_spreadsheet_file'
        source:
          - '#Gene_Prioritization_Workflow.top_genes_file'
    'sbg:y': 594.1176470588236
    run:
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:projectName': Lung_Signatures
      'sbg:canvas_zoom': 0.7999999999999998
      'sbg:validationErrors': []
      'sbg:contributors':
        - mepstein
      'sbg:id': mepstein/lung/gene-set-characterization/0
      inputs:
        - type:
            - string
          'sbg:y': 82.5000027120109
          id: '#taxonid'
          description: >-
            The species taxon ID (e.g., 9606 for human).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
            possible values (KN Contents by Species).
          'sbg:x': 110.0000238865596
          'sbg:includeInPorts': false
          label: Species Taxon ID
        - type:
            - string
          required: true
          'sbg:y': 216.2499565184135
          id: '#pg_edge_type'
          description: >-
            The gene set property network edge type (e.g., gene_ontology).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type]
            for possible values (KN Contents by Property-Gene Edge Type).
          'sbg:x': 107.50000047683673
          'sbg:includeInPorts': true
          label: Gene Set Property Network Edge Type
        - type:
            - 'null'
            - int
          'sbg:y': 619.9997800141683
          id: '#network_smoothing_percent'
          description: >-
            The amount of network smoothing (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          'sbg:x': 105.00002351403057
          'sbg:includeInPorts': false
          label: Amount of Network Smoothing
        - type:
            - 'null'
            - string
          'sbg:y': 479.99997153878223
          id: '#gg_edge_type'
          description: >-
            The knowledge network edge type (e.g., STRING_experimental).  See
            [https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type]
            for possible values (KN Contents by Gene-Gene Edge Type).  Leave
            this blank to not use the Knowledge Network.
          'sbg:x': 111.25000944733532
          'sbg:includeInPorts': false
          label: Knowledge Network Edge Type
        - type:
            - File
          required: true
          'sbg:y': 350.0000096559507
          id: '#genomic_spreadsheet_file'
          description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
          'sbg:x': 102.50005492567655
          'sbg:includeInPorts': true
          label: Genomic Spreadsheet File
      'sbg:toolkitVersion': v1.0
      'sbg:publisher': KnowEnG
      'sbg:revisionNotes': >-
        Copy of
        mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/4
      'sbg:modifiedOn': 1530641550
      description: >-
        This [KnowEnG](https://knoweng.org/) Gene Set Characterization workflow
        tests a gene set for enrichment against a large compendium of
        [annotations](https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type).


        This workflow starts with a user-submitted gene set (or multiple gene
        sets) and determines if each gene set is enriched for a pathway, a [Gene
        Ontology](https://www.ncbi.nlm.nih.gov/pubmed/25428369) term, or other
        types of annotations.  This pipeline tests your gene set for enrichment
        against a large compendium of annotations.  Gene Set Characterization
        can be done using a standard [statistical
        test](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.fisher_exact.html#scipy.stats.fisher_exact)
        or in a Knowledge Network-guided mode (using
        [DRaWR](https://www.ncbi.nlm.nih.gov/pubmed/27153592)).


        A network-guided analysis can offer various benefits over a standard
        one, including considering not just significant genes but also their
        network neighbors, and inferring properties of poorly annotated genes.


        ### Required inputs


        This workflow has one required input file:


        1. Genomic Spreadsheet File (ID: *genomic_spreadsheet_file*).  This
        currently must be a TSV file (a spreadsheet with tab-separated values). 
        The first row (header) should contain the names of the gene sets in the
        corresponding columns.  The first column of the spreadsheet should be
        the gene identifiers corresponding to each row.  For each entry in the
        spreadsheet table, a “1” indicates that the corresponding row gene is
        part of the corresponding column gene set, a “0” means it is not.  There
        should be no NA values/empty cells.


        A sample input file,
        [demo_GSC.spreadsheet.txt](https://cgc.sbgenomics.com/public/files/5a2820bf4f0cbd94bfb86b3b/),
        as described in the [quickstart guide for this
        workflow](https://knoweng.org/wp-content/uploads/2017/12/GSC_CGC_Quickstart.pdf),
        is available.


        Example of Genomic Spreadsheet File Format:


        | &nbsp; | GeneSet1 | GeneSet2 | GeneSet3 | 

        | --- | --- | --- | --- | --- |

        |**Gene1**| 0 | 1 | 1 |

        |**Gene2**| 0 | 0 | 0 |

        |**Gene3**| 1 | 0 | 1 |

        |**Gene4**| 0 | 1 | 0 |

        |**Gene5**| 1 | 0 | 0 |

        |...| ... | ... | ... |


        There are two required input parameters:


        1. Species Taxon ID (ID: *taxonid*; type: string).  The ID of the
        species to be used in the analysis, e.g., "9606" for human.  Possible
        values are listed in parentheses in the first column of the [KnowEnG
        Supported
        Species](https://knoweng.org/kn-data-references/#kn_contents_by_species)
        table (“KN Contents by Species”).


        2. Gene Set Property Network Edge Type (ID: *pg_edge_type*; type:
        string).  The edge type for the gene set property network, e.g.,
        "gene_ontology".  Possible values are listed in parentheses in the first
        column of the [KnowEnG Gene Set
        Collections](https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type)
        table (“KN Contents by Property-Gene Edge Type”).


        ### Optional inputs


        There are two optional input parameters:


        1. Knowledge Network Edge Type (ID: *gg_edge_type*; type: string).  The
        edge type for the knowledge network (i.e., interaction network), e.g.,
        "STRING_experimental".  Possible values are listed in parentheses in the
        first column of the [KnowEnG Interaction
        Networks](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type)
        table (KN Contents by Gene-Gene Edge Type“”)(use one of the values in
        parentheses).  If no value is specified, no knowledge network will be
        used in the analysis.


        2. Amount of Network Smoothing (ID: *network_smoothing_percent*; type:
        int).  The amount of network smoothing.  This should be an integer
        between 0 and 100 (inclusive).  If no value is specified (or the value
        is outside that range), 50% will be used.  A greater value means greater
        contribution from the network interactions.  (This value is only
        relevant if the knowledge network is used.)


        ### Outputs


        This workflow generates nine output files.  These are outlined below. 
        The structure and order specified here may not match what's listed on
        the completed task page.  The README output file goes into more detail
        on the purpose and the contents of the various output files.  That file
        can also be found
        [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-GSC.md).


        #### Results


        * GSC Results (file name: `gsc_results.txt`).


        * README (file name: `README-GSC.txt`).  This file describes the various
        output files.


        #### Mapping


        * Gene Map File (file name: `gene_map.txt`).


        * Clean Genomic File (file name: `clean_gene_set_matrix.txt`).


        * Gene Set Name Map File (file name: `gene_set_name_map.txt`).


        * Raw Enrichment Scores (file name format:
        `DRaWR_sorted_by_property_score_<string_based_on_date_time>.df` or
        `fisher_sorted_by_property_score_<string_based_on_date_time>.df`).


        #### Metadata and run info


        * Gene Set Property Network Metadata File (file name format:
        `<taxonid>.<edge_type>.metadata`, e.g., `9606.gene_ontology.metadata`).


        * Interaction Network Metadata File (file name format:
        `<taxonid>.<edge_type>.metadata`, e.g.,
        `9606.STRING_experimental.metadata`).  This file will only be present if
        a knowledge network was used in the analysis.


        * GSC Run Params yml (file name: `run_params.yml`).


        ### Additional Resources


        [Quickstart
        Guide](https://knoweng.org/wp-content/uploads/2017/11/GSC_CGC_Quickstart.pdf)
        for this workflow


        [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
        knowledge-guided analysis


        [YouTube Tutorial](https://youtu.be/nP4wtVZOY3E) for this workflow in
        KnowEnG Platform


        [Additional Pipelines](https://knoweng.org/pipelines/) supported by
        KnowEnG


        ### Acknowledgements


        The KnowEnG BD2K center is supported by grant U54GM114838 awarded by
        NIGMS through funds provided by the trans-NIH Big Data to Knowledge
        (BD2K) initiative.


        Questions or comments can be sent to knoweng-support@illinois.edu.


        ### References


        Blatti C, Sinha S. Characterizing gene sets using discriminative random
        walks with restart on heterogeneous biological networks. Bioinformatics.
        2016;32(14):2167-75.


        Gene Ontology Consortium: going forward. Nucleic Acids Res.
        2015;43(Database issue):D1049-56.
      $namespaces:
        sbg: 'https://sevenbridges.com'
      'sbg:image_url': >-
        https://cgc.sbgenomics.com/ns/brood/images/mepstein/lung/gene-set-characterization/0.png
      outputs:
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 448.74994266033366
          id: '#run_params_yml'
          description: The configuration parameters specified for the GSC run
          'sbg:x': 1247.4998056590632
          'sbg:includeInPorts': true
          label: GSC Run Params yml
          source:
            - '#Gene_Set_Characterization.run_params_yml'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 382.499916091565
          id: '#readme'
          description: README-GSC.txt
          'sbg:x': 1109.999571055196
          'sbg:includeInPorts': true
          label: README
          source:
            - '#Gene_Set_Characterization.readme'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 236.24997073412038
          id: '#new_data_file'
          description: 'GSC enrichment scores, with names mapped'
          'sbg:x': 1106.2496927529721
          'sbg:includeInPorts': true
          label: GSC Results
          source:
            - '#Join_Names.new_data_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 314.99988959730223
          id: '#interaction_network_metadata_file'
          description: The interaction network metadata file
          'sbg:x': 1248.7494408637579
          'sbg:includeInPorts': true
          label: Interaction Network Metadata File
          source:
            - '#Join_Names.interaction_network_metadata_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 63.74997279048104
          id: '#gene_set_network_metadata_file'
          description: The gene set property network metadata file
          'sbg:x': 1118.749081209353
          'sbg:includeInPorts': true
          label: Gene Set Property Network Metadata File
          source:
            - '#Knowledge_Network_Fetcher_1.network_metadata_file'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 159.99999165534976
          id: '#gene_set_name_map_file'
          description: The gene set name map file
          'sbg:x': 1248.7498052120284
          'sbg:includeInPorts': true
          label: Gene Set Name Map File
          source:
            - '#Join_Names.name_map_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 601.2500250488484
          id: '#gene_map_file'
          description: The gene map file
          'sbg:x': 1247.499927133322
          'sbg:includeInPorts': true
          label: Gene Map File
          source:
            - '#Gene_Set_Characterization.gene_map_file_out'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 678.7499595433475
          id: '#enrichment_scores'
          description: The GSC raw enrichment scores
          'sbg:x': 1112.4998140782193
          'sbg:includeInPorts': true
          label: Raw Enrichment Scores
          source:
            - '#Gene_Set_Characterization.enrichment_scores'
        - type:
            - 'null'
            - File
          required: false
          'sbg:y': 519.9999691545964
          id: '#clean_genomic_file'
          description: The clean genomic spreadsheet file
          'sbg:x': 1109.9998150467948
          'sbg:includeInPorts': true
          label: Clean Genomic File
          source:
            - '#Gene_Set_Characterization.genomic_file_out'
      x: 878.8235294117649
      'sbg:modifiedBy': mepstein
      label: Gene Set Characterization Workflow
      'sbg:revision': 0
      'sbg:canvas_x': 137
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/4
          'sbg:modifiedOn': 1530641550
          'sbg:revision': 0
      'sbg:createdOn': 1530641550
      'sbg:license': >-
        Copyright (c) 2017, University of Illinois Board of Trustees; All rights
        reserved.
      'sbg:sbgMaintained': false
      'y': 594.1176470588236
      id: mepstein/lung/gene-set-characterization/0
      requirements: []
      'sbg:categories':
        - Analysis
        - Characterization
        - Enrichment
      'sbg:project': mepstein/lung
      'sbg:toolkit': KnowEnG_CGC
      steps:
        - 'sbg:x': 346.2497055977747
          'sbg:y': 495.01529136208785
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - ''
            'sbg:id': >-
              mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
            inputs:
              - type:
                  - 'null'
                  - string
                required: false
                description: The knowledge network edge type (not required)
                id: '#knowledge_network_edge_type'
                'sbg:includeInPorts': true
                label: Knowledge Network Edge Type
            'sbg:publisher': sbg
            x: 346.2497055977747
            'sbg:cmdPreview': ''
            'sbg:revisionNotes': >-
              Copy of
              mepstein/genesetcharacterization/gene-set-characterization-parameters/5
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
            stdout: ''
            'sbg:modifiedOn': 1512041611
            description: >-
              Sets the input parameters of some of the intermediate apps in the
              GSC workflow based on some of the input parameters to the workflow
              itself.
            'sbg:image_url': null
            outputs:
              - id: '#gsc_method'
                type:
                  - 'null'
                  - string
                description: 'The GSC method to use (e.g., DRaWR, fisher)'
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      if ($job.inputs.knowledge_network_edge_type) {
                          gsc_method = "DRaWR";
                      }
                      else {
                          gsc_method = "fisher";
                      }

                      gsc_method;
                label: GSC Method
              - id: '#get_network'
                type:
                  - 'null'
                  - boolean
                description: Whether to get the network
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      if ($job.inputs.knowledge_network_edge_type) {
                          get_network = true;
                      }
                      else {
                          get_network = false;
                      }

                      get_network;
                label: Get Network Flag
              - id: '#edge_type'
                type:
                  - 'null'
                  - string
                description: The network edge type
                outputBinding:
                  outputEval:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: |
                      $job.inputs.knowledge_network_edge_type;
                label: Network Edge Type
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Gene Set Characterization Parameters
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': >-
                  Copy of
                  mepstein/genesetcharacterization/gene-set-characterization-parameters/5
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512041611
                'sbg:revision': 0
            'sbg:createdOn': 1512041611
            'sbg:sbgMaintained': false
            'y': 495.01529136208785
            id: >-
              mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: ubuntu
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:copyOf': >-
              mepstein/genesetcharacterization/gene-set-characterization-parameters/5
            'sbg:job':
              inputs:
                knowledge_network_edge_type: knowlege_network_edge_type-string-value
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Gene_Set_Characterization_Parameters'
          outputs:
            - id: '#Gene_Set_Characterization_Parameters.gsc_method'
            - id: '#Gene_Set_Characterization_Parameters.get_network'
            - id: '#Gene_Set_Characterization_Parameters.edge_type'
          inputs:
            - id: >-
                #Gene_Set_Characterization_Parameters.knowledge_network_edge_type
              source:
                - '#gg_edge_type'
        - 'sbg:x': 857.2497657984607
          'sbg:y': 194.01553714182688
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - sh
              - file_renamer.cmd
              - '&&'
              - python3
              - join_names.py
            'sbg:id': mepstein/knoweng-genesetcharacterization/join-names/0
            inputs:
              - description: The output file name
                type:
                  - string
                id: '#output_file_name'
                required: true
                label: Output File Name
              - type:
                  - File
                required: true
                inputBinding:
                  prefix: '-m'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#name_map_file'
                description: The name map file
                'sbg:fileTypes': TSV
                label: Name Map File
              - description: The interaction network metadata file
                type:
                  - 'null'
                  - File
                id: '#interaction_network_metadata_file'
                required: false
                label: Interaction Network Metadata File
              - type:
                  - File
                required: true
                inputBinding:
                  prefix: '-f'
                  'sbg:cmdInclude': true
                  separate: true
                id: '#data_file'
                description: The data file
                'sbg:fileTypes': TSV
                label: Data File
            'sbg:publisher': sbg
            x: 857.2497657984607
            'sbg:cmdPreview': >-
              sh file_renamer.cmd && python3 join_names.py -f
              /path/to/data_file.ext -m /path/to/name_map_file.ext >
              output_file_name-string-value
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/join-names/4
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/join-names/0
            stdout:
              engine: '#cwl-js-engine'
              class: Expression
              script: $job.inputs.output_file_name
            'sbg:modifiedOn': 1512042115
            description: >-
              This program adds columns to a file by matching keys in a
              designated column of that file to keys/lines in another file.
            'sbg:image_url': null
            outputs:
              - id: '#new_data_file'
                type:
                  - 'null'
                  - File
                description: The new data file
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
                    script: $job.inputs.output_file_name
                label: New Data File
              - id: '#name_map_file_out'
                type:
                  - 'null'
                  - File
                description: The name map file
                outputBinding:
                  glob: gene_set_name_map.txt
                label: Name Map File
              - id: '#interaction_network_metadata_file_out'
                type:
                  - 'null'
                  - File
                description: The interaction network metadata file
                outputBinding:
                  glob: interaction_network.metadata
                label: Interaction Network Metadata File
            requirements:
              - fileDef:
                  - fileContent: >-
                      #!/usr/bin/env python3



                      """

                      This program adds columns to a file by matching keys in a
                      designated

                      column of that file to keys/lines in another file.


                      More specifically:

                      This program takes two required arguments, a data_file
                      (-f) and a name_map_file (-m).

                      Each of these are delimiter-separated files (-d, default
                      '\t').


                      For the data_file, one column is designated as the
                      data_column (-c, default 1).


                      For the name_map_file, one column is designated as the
                      key_column (-k, default 1).


                      The program loops through the lines of the data_file, uses
                      the data in

                      the data_column as a key, finds that key in the
                      name_map_file, and

                      adds columns from that line of the name_map_file (starting
                      at the

                      add_column, -a, default 3) to the end of that line of the
                      data_file.

                      If the key is not found, columns of empty strings are
                      added.


                      It outputs (to stdout) this modified version of the
                      data_file.

                      """



                      import argparse



                      DEFAULT_KEY_COLUMN = 1


                      DEFAULT_DATA_COLUMN = 1


                      DEFAULT_ADD_COLUMN = 3


                      DEFAULT_DELIMITER = '\t'


                      DATA_FILE_HAS_HEADERS = True


                      NAME_MAP_FILE_HAS_HEADERS = False


                      NEW_HEADERS = ['alias', 'description']



                      def parse_args():
                          parser = argparse.ArgumentParser()

                          parser.add_argument('-f', '--data_file', required=True)
                          parser.add_argument('-m', '--name_map_file', required=True)
                          parser.add_argument('-k', '--key_column', default=DEFAULT_KEY_COLUMN)
                          parser.add_argument('-c', '--data_column', default=DEFAULT_DATA_COLUMN)
                          parser.add_argument('-a', '--add_column', default=DEFAULT_ADD_COLUMN)
                          parser.add_argument('-d', '--delimiter', default=DEFAULT_DELIMITER)
                          parser.add_argument('-e', '--empty_headers', action='store_true')

                          args = parser.parse_args()

                          return args


                      def read_name_map_file(name_map_file, key_column,
                      delimiter):
                          name_data = {}

                          with open(name_map_file, 'r') as f:
                              if NAME_MAP_FILE_HAS_HEADERS:
                                  line = next(f)
                                  headers = line.rstrip().split(sep=delimiter)
                              else:
                                  headers = []
                              for line in f:
                                  fields = line.rstrip().split(sep=delimiter)
                                  key = fields[key_column]
                                  name_data[key] = fields
                                  length = len(fields)

                          return name_data, headers, length


                      def main():
                          args = parse_args()

                          name_data, name_data_headers, name_data_length = \
                            read_name_map_file(args.name_map_file, args.key_column, args.delimiter)
                          added_length = name_data_length - args.add_column

                          keys_not_found = {}

                          with open(args.data_file, 'r') as f:
                              if DATA_FILE_HAS_HEADERS:
                                  line = next(f)
                                  fields = line.rstrip().split(sep=args.delimiter)
                                  if NAME_MAP_FILE_HAS_HEADERS:
                                      fields.extend(name_data_headers[args.add_column:])
                                  else:
                                      if args.empty_headers:
                                          new_headers = [''] * added_length
                                      else:
                                          if added_length > len(NEW_HEADERS):
                                              new_headers = NEW_HEADERS +  [''] * (added_length - len(NEW_HEADERS))
                                          elif added_length == len(NEW_HEADERS):
                                              new_headers = NEW_HEADERS
                                          else:
                                              new_headers = NEW_HEADERS[:added_length]
                                      fields.extend(new_headers)
                                  print(args.delimiter.join(fields))
                              for line in f:
                                  fields = line.rstrip().split(sep=args.delimiter)
                                  key = fields[args.data_column]
                                  if key in name_data:
                                      fields.extend(name_data[key][args.add_column:])
                                  else:
                                      if key in keys_not_found:
                                          keys_not_found[key] += 1
                                      else:
                                          keys_not_found[key] = 1
                                      fields.extend([''] * added_length)
                                  print(args.delimiter.join(fields))


                      if __name__ == "__main__":
                          main()
                    filename: join_names.py
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: |
                        str = ""

                        if ($job.inputs.interaction_network_metadata_file) {
                            str += "cp -p " + $job.inputs.interaction_network_metadata_file.path + " interaction_network.metadata\n";
                        }

                        if ($job.inputs.name_map_file) {
                            str += "cp -p " + $job.inputs.name_map_file.path + " gene_set_name_map.txt\n";
                        }

                        str;
                    filename: file_renamer.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Join Names
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/join-names/4
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512042115
                'sbg:revision': 0
            'sbg:createdOn': 1512042115
            'sbg:sbgMaintained': false
            'y': 194.01553714182688
            id: mepstein/knoweng-genesetcharacterization/join-names/0
            cwlVersion: 'sbg:draft-2'
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
              - dockerPull: 'cblatti3/py3_slim:0.1'
                dockerImageId: ''
                class: DockerRequirement
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/join-names/4
            'sbg:job':
              inputs:
                name_map_file:
                  size: 0
                  class: File
                  path: /path/to/name_map_file.ext
                  secondaryFiles: []
                data_file:
                  size: 0
                  class: File
                  path: /path/to/data_file.ext
                  secondaryFiles: []
                output_file_name: output_file_name-string-value
                interaction_network_metadata_file:
                  size: 0
                  class: File
                  path: /path/to/interaction_network_metadata_file.ext
                  secondaryFiles: []
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Join_Names'
          outputs:
            - id: '#Join_Names.new_data_file'
            - id: '#Join_Names.name_map_file_out'
            - id: '#Join_Names.interaction_network_metadata_file_out'
          inputs:
            - id: '#Join_Names.output_file_name'
              default: gsc_results.txt
            - id: '#Join_Names.name_map_file'
              source:
                - '#Knowledge_Network_Fetcher_1.pnode_map_file'
            - id: '#Join_Names.interaction_network_metadata_file'
              source:
                - '#Knowledge_Network_Fetcher.network_metadata_file'
            - id: '#Join_Names.data_file'
              source:
                - '#Gene_Set_Characterization.enrichment_scores'
        - 'sbg:x': 371.99973487855465
          'sbg:y': 82.26555809285858
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - sh
              - run_fetch.cmd
            'sbg:id': mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: the taxonomic id for the species of interest
                description: 'The network species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Network Species Taxon ID
              - 'sbg:toolDefaultValue': Gene
                type:
                  - 'null'
                  - string
                required: false
                doc: the type of subnetwork
                description: 'The network type (e.g., Gene, Property)'
                default: Gene
                id: '#network_type'
                label: Network Type
              - 'sbg:toolDefaultValue': 'true'
                type:
                  - 'null'
                  - boolean
                required: false
                doc: whether or not to get the network
                description: >-
                  Whether to get the network (or create a dummy/empty network
                  file)
                default: true
                id: '#get_network'
                label: Get Network Flag
              - 'sbg:toolDefaultValue': STRING_experimental
                type:
                  - 'null'
                  - string
                required: false
                doc: the edge type keyword for the subnetwork of interest
                description: >-
                  The network edge type (e.g., STRING_experimental,
                  gene_ontology)
                default: PPI_physical_association
                id: '#edge_type'
                'sbg:includeInPorts': true
                label: Network Edge Type
              - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
                type:
                  - 'null'
                  - string
                required: false
                doc: the aws s3 bucket
                description: The AWS S3 bucket to fetch the network from
                default: KnowNets/KN-20rep-1706/userKN-20rep-1706
                id: '#bucket'
                label: AWS S3 Bucket Name
            'sbg:publisher': sbg
            x: 371.99973487855465
            'sbg:cmdPreview': sh run_fetch.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            stdout: ''
            'sbg:modifiedOn': 1512037727
            description: >-
              Fetch a knowledge network from an AWS S3 bucket, given a network
              type, an edge type, and a species taxon ID.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The pnode map file
                id: '#pnode_map_file'
                outputBinding:
                  glob: '*.pnode_map'
                label: PNode Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The node map file
                id: '#node_map_file'
                outputBinding:
                  glob: '*.node_map'
                label: Node Map File
              - type:
                  - 'null'
                  - File
                doc: yaml format describing network contents
                description: The network metadata file
                id: '#network_metadata_file'
                outputBinding:
                  glob: '*.metadata'
                label: Network Metadata File
              - type:
                  - 'null'
                  - File
                doc: >-
                  4 column format for subnetwork for single edge type and
                  species
                description: The network edge file
                id: '#network_edge_file'
                outputBinding:
                  glob: '*.edge'
                label: Network Edge File
              - type:
                  - 'null'
                  - File
                doc: log of fetch command
                description: The log of the fetch command
                id: '#cmd_log_file'
                outputBinding:
                  glob: run_fetch.cmd
                label: Command Log File
            requirements:
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        //MYCMD="date && if [ " + $job.inputs.get_network + ' =
                        "true" ]; then /home/kn_fetcher.sh
                        '+$job.inputs.bucket+' '+$job.inputs.network_type+'
                        '+$job.inputs.taxonid+' '+$job.inputs.edge_type+'; else
                        touch empty.edge; fi && date'


                        str = "";


                        str += "date";

                        if ($job.inputs.get_network) {

                        //if ($job.inputs.get_network == "true") {
                            str += " && /home/kn_fetcher.sh " + $job.inputs.bucket + " " + $job.inputs.network_type + 
                        " " + $job.inputs.taxonid + " " + $job.inputs.edge_type;

                        }

                        else {
                            //str += " && touch empty.edge";
                        }

                        str += " && date";


                        str;
                    filename: run_fetch.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Knowledge Network Fetcher
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512037727
                'sbg:revision': 0
            'sbg:createdOn': 1512037727
            'sbg:sbgMaintained': false
            doc: >-
              Retrieve appropriate subnetwork from KnowEnG Knowledge Network
              from AWS S3 storage
            id: mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            cwlVersion: 'sbg:draft-2'
            'y': 82.26555809285858
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
                class: DockerRequirement
              - ramMin: 2000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Knowledge_Network_Fetcher_1'
          outputs:
            - id: '#Knowledge_Network_Fetcher_1.pnode_map_file'
            - id: '#Knowledge_Network_Fetcher_1.node_map_file'
            - id: '#Knowledge_Network_Fetcher_1.network_metadata_file'
            - id: '#Knowledge_Network_Fetcher_1.network_edge_file'
            - id: '#Knowledge_Network_Fetcher_1.cmd_log_file'
          inputs:
            - id: '#Knowledge_Network_Fetcher_1.taxonid'
              source:
                - '#taxonid'
            - id: '#Knowledge_Network_Fetcher_1.network_type'
              default: Property
            - id: '#Knowledge_Network_Fetcher_1.get_network'
              default: true
            - id: '#Knowledge_Network_Fetcher_1.edge_type'
              source:
                - '#pg_edge_type'
            - id: '#Knowledge_Network_Fetcher_1.bucket'
              default: KnowNets/KN-20rep-1706/userKN-20rep-1706
        - 'sbg:x': 567.249511778382
          'sbg:y': 252.0154585084038
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            baseCommand:
              - sh
              - run_dc.cmd
            'sbg:id': mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: taxon id of species related to genomic spreadsheet
                description: 'The species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Species Taxon ID
              - 'sbg:toolDefaultValue': ''''''
                type:
                  - 'null'
                  - string
                required: false
                doc: >-
                  suggestion for ID source database used to resolve ambiguities
                  in mapping
                description: The source hint for the redis queries (can be '')
                default: \'\'
                id: '#source_hint'
                label: ID Source Hint
              - 'sbg:toolDefaultValue': 6379
                type:
                  - 'null'
                  - int
                required: false
                doc: port for Redis db
                description: The redis DB port
                default: 6379
                id: '#redis_port'
                label: RedisDB Port
              - 'sbg:toolDefaultValue': KnowEnG
                type:
                  - 'null'
                  - string
                required: false
                doc: password for Redis db
                description: The redis DB password
                default: KnowEnG
                id: '#redis_pass'
                label: RedisDB Password
              - 'sbg:toolDefaultValue': knowredis.knoweng.org
                type:
                  - 'null'
                  - string
                required: false
                doc: url of Redis db
                description: The redis DB host name
                default: knowredis.knoweng.org
                id: '#redis_host'
                label: RedisDB Host
              - type:
                  - string
                required: true
                doc: >-
                  keywork name of pipeline from following list
                  ['gene_prioritization_pipeline',
                  'samples_clustering_pipeline',
                  'geneset_characterization_pipeline']
                description: >-
                  The name of the pipeline that will be run (i.e., data cleaning
                  is pipeline-specific)
                id: '#pipeline_type'
                label: Name of Pipeline
              - 'sbg:toolDefaultValue':
                  location: /bin/sh
                  class: File
                type:
                  - 'null'
                  - File
                required: false
                doc: >-
                  the phenotypic spreadsheet input for the pipeline [may be
                  optional]
                description: The phenotypic spreadsheet file (optional)
                default:
                  location: /bin/sh
                  class: File
                id: '#phenotypic_spreadsheet_file'
                label: Phenotypic Spreadsheet File (optional)
              - type:
                  - File
                required: true
                doc: the genomic spreadsheet input for the pipeline
                description: The genomic spreadsheet file
                id: '#genomic_spreadsheet_file'
                label: Genomic Spreadsheet File
              - 'sbg:toolDefaultValue': missing
                type:
                  - 'null'
                  - string
                required: false
                doc: >-
                  if pipeline_type=='gene_prioritization_pipeline', then must be
                  one of either ['t_test', 'pearson']
                description: >-
                  The correlation measure to be used for GP (e.g., t_test or
                  pearson)
                default: missing
                id: '#gene_prioritization_corr_measure'
                label: GP Correlation Measure
            'sbg:publisher': sbg
            x: 567.249511778382
            'sbg:cmdPreview': sh run_dc.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
            stdout: ''
            'sbg:modifiedOn': 1512038144
            description: >-
              Clean/preprocess input data (genomic and optionally phenotypic)
              for use with other tools/pipelines.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: two columns for original gene ids and unmapped reason code
                description: The genes that were not mapped
                id: '#gene_unmap_file'
                outputBinding:
                  glob: '*_UNMAPPED.tsv'
                label: Gene Unmapped File
              - type:
                  - 'null'
                  - File
                doc: two columns for internal gene ids and original gene ids
                description: The gene map file
                id: '#gene_map_file'
                outputBinding:
                  glob: '*_MAP.tsv'
                label: Gene Map File
              - id: '#cmd_log_file'
                type:
                  - 'null'
                  - File
                description: The log of the data cleaning command
                outputBinding:
                  glob: run_dc.cmd
                label: Command Log File
              - type:
                  - 'null'
                  - File
                doc: data cleaning parameters in yaml format
                description: >-
                  The configuration parameters specified for the data cleaning
                  run
                id: '#cleaning_parameters_yml'
                outputBinding:
                  glob: run_cleanup.yml
                label: Cleaning Parameters File
              - type:
                  - 'null'
                  - File
                doc: information on souce of errors for cleaning pipeline
                description: The log of the data cleaning run
                id: '#cleaning_log_file'
                outputBinding:
                  glob: log_*_pipeline.yml
                label: Cleaning Log File
              - type:
                  - 'null'
                  - File
                doc: phenotype file prepared for pipeline
                description: The clean phenotypic spreadsheet
                id: '#clean_phenotypic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Phenotypic Spreadsheet
              - type:
                  - 'null'
                  - File
                doc: matrix with gene names mapped and data cleaned
                description: The clean genomic spreadsheet
                id: '#clean_genomic_file'
                outputBinding:
                  glob:
                    engine: '#cwl-js-engine'
                    class: Expression
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
                label: Clean Genomic Spreadsheet
            requirements:
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        str = ""


                        str += "pipeline_type: " + $job.inputs.pipeline_type +
                        "\n";

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

                        if ($job.inputs.pipeline_type ==
                        "gene_prioritization_pipeline") {
                            str += "correlation_measure: " + $job.inputs.gene_prioritization_corr_measure + "\n";
                        }


                        //str2 = "echo \"" + str + "\" > run_cleanup.yml"

                        //str2 = "echo \"" + str + "\" > run_cleanup.yml &&
                        touch log_X_pipeline.yml && touch GX_ETL.tsv && touch
                        PX_ETL.tsv && touch X_MAP.tsv && touch X_UNMAPPED.tsv"

                        str2 = "echo \"" + str + "\" > run_cleanup.yml && date
                        && python3 /home/src/data_cleanup.py -run_directory ./
                        -run_file run_cleanup.yml && date"


                        str2;
                    filename: run_dc.cmd
                class: CreateFileRequirement
            class: CommandLineTool
            label: Data Cleaning/Preprocessing
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512038144
                'sbg:revision': 0
            'sbg:createdOn': 1512038144
            'sbg:sbgMaintained': false
            doc: checks the inputs of a pipeline for potential sources of errors
            id: mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
            cwlVersion: 'sbg:draft-2'
            'y': 252.0154585084038
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
                class: DockerRequirement
              - ramMin: 5000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Pipeline_Preprocessing'
          outputs:
            - id: '#Pipeline_Preprocessing.gene_unmap_file'
            - id: '#Pipeline_Preprocessing.gene_map_file'
            - id: '#Pipeline_Preprocessing.cmd_log_file'
            - id: '#Pipeline_Preprocessing.cleaning_parameters_yml'
            - id: '#Pipeline_Preprocessing.cleaning_log_file'
            - id: '#Pipeline_Preprocessing.clean_phenotypic_file'
            - id: '#Pipeline_Preprocessing.clean_genomic_file'
          inputs:
            - id: '#Pipeline_Preprocessing.taxonid'
              source:
                - '#taxonid'
            - id: '#Pipeline_Preprocessing.source_hint'
              default: ''''''
            - id: '#Pipeline_Preprocessing.redis_port'
              default: 6379
            - id: '#Pipeline_Preprocessing.redis_pass'
              default: KnowEnG
            - id: '#Pipeline_Preprocessing.redis_host'
              default: knowredis.knoweng.org
            - id: '#Pipeline_Preprocessing.pipeline_type'
              default: geneset_characterization_pipeline
            - id: '#Pipeline_Preprocessing.phenotypic_spreadsheet_file'
            - id: '#Pipeline_Preprocessing.genomic_spreadsheet_file'
              source:
                - '#genomic_spreadsheet_file'
            - id: '#Pipeline_Preprocessing.gene_prioritization_corr_measure'
        - 'sbg:x': 582.4998470097854
          'sbg:y': 641.2693711060639
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:id': mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            inputs:
              - 'sbg:toolDefaultValue': '9606'
                type:
                  - 'null'
                  - string
                required: false
                doc: the taxonomic id for the species of interest
                description: 'The network species taxon ID (e.g., 9606 for human)'
                default: '9606'
                id: '#taxonid'
                'sbg:includeInPorts': true
                label: Network Species Taxon ID
              - 'sbg:toolDefaultValue': Gene
                type:
                  - 'null'
                  - string
                required: false
                doc: the type of subnetwork
                description: 'The network type (e.g., Gene, Property)'
                default: Gene
                id: '#network_type'
                label: Network Type
              - 'sbg:toolDefaultValue': 'true'
                type:
                  - 'null'
                  - boolean
                required: false
                doc: whether or not to get the network
                description: >-
                  Whether to get the network (or create a dummy/empty network
                  file)
                default: true
                id: '#get_network'
                'sbg:includeInPorts': true
                label: Get Network Flag
              - 'sbg:toolDefaultValue': STRING_experimental
                type:
                  - 'null'
                  - string
                required: false
                doc: the edge type keyword for the subnetwork of interest
                description: >-
                  The network edge type (e.g., STRING_experimental,
                  gene_ontology)
                default: PPI_physical_association
                id: '#edge_type'
                'sbg:includeInPorts': true
                label: Network Edge Type
              - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
                type:
                  - 'null'
                  - string
                required: false
                doc: the aws s3 bucket
                description: The AWS S3 bucket to fetch the network from
                default: KnowNets/KN-20rep-1706/userKN-20rep-1706
                id: '#bucket'
                label: AWS S3 Bucket Name
            'sbg:publisher': sbg
            x: 582.4998470097854
            'sbg:cmdPreview': sh run_fetch.cmd
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
            appUrl: >-
              /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            stdout: ''
            'sbg:modifiedOn': 1512037727
            description: >-
              Fetch a knowledge network from an AWS S3 bucket, given a network
              type, an edge type, and a species taxon ID.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The pnode map file
                id: '#pnode_map_file'
                outputBinding:
                  glob: '*.pnode_map'
                label: PNode Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  5 column node map with [original_node_id, mapped_node_id,
                  node_type, node_alias, node_description]
                description: The node map file
                id: '#node_map_file'
                outputBinding:
                  glob: '*.node_map'
                label: Node Map File
              - type:
                  - 'null'
                  - File
                doc: yaml format describing network contents
                description: The network metadata file
                id: '#network_metadata_file'
                outputBinding:
                  glob: '*.metadata'
                label: Network Metadata File
              - type:
                  - 'null'
                  - File
                doc: >-
                  4 column format for subnetwork for single edge type and
                  species
                description: The network edge file
                id: '#network_edge_file'
                outputBinding:
                  glob: '*.edge'
                label: Network Edge File
              - type:
                  - 'null'
                  - File
                doc: log of fetch command
                description: The log of the fetch command
                id: '#cmd_log_file'
                outputBinding:
                  glob: run_fetch.cmd
                label: Command Log File
            requirements:
              - class: InlineJavascriptRequirement
              - class: ShellCommandRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        //MYCMD="date && if [ " + $job.inputs.get_network + ' =
                        "true" ]; then /home/kn_fetcher.sh
                        '+$job.inputs.bucket+' '+$job.inputs.network_type+'
                        '+$job.inputs.taxonid+' '+$job.inputs.edge_type+'; else
                        touch empty.edge; fi && date'


                        str = "";


                        str += "date";

                        if ($job.inputs.get_network) {

                        //if ($job.inputs.get_network == "true") {
                            str += " && /home/kn_fetcher.sh " + $job.inputs.bucket + " " + $job.inputs.network_type + 
                        " " + $job.inputs.taxonid + " " + $job.inputs.edge_type;

                        }

                        else {
                            //str += " && touch empty.edge";
                        }

                        str += " && date";


                        str;
                    filename: run_fetch.cmd
                class: CreateFileRequirement
              - id: '#cwl-js-engine'
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Knowledge Network Fetcher
            'sbg:revision': 0
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512037727
                'sbg:revision': 0
            'sbg:createdOn': 1512037727
            'sbg:sbgMaintained': false
            doc: >-
              Retrieve appropriate subnetwork from KnowEnG Knowledge Network
              from AWS S3 storage
            id: mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
            cwlVersion: 'sbg:draft-2'
            'y': 641.2693711060639
            baseCommand:
              - sh
              - run_fetch.cmd
            'sbg:modifiedBy': viktorian_miok
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 0
            hints:
              - dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
                class: DockerRequirement
              - ramMin: 2000
                outdirMin: 512000
                class: ResourceRequirement
                coresMin: 1
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
            'sbg:job':
              inputs: {}
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Knowledge_Network_Fetcher'
          outputs:
            - id: '#Knowledge_Network_Fetcher.pnode_map_file'
            - id: '#Knowledge_Network_Fetcher.node_map_file'
            - id: '#Knowledge_Network_Fetcher.network_metadata_file'
            - id: '#Knowledge_Network_Fetcher.network_edge_file'
            - id: '#Knowledge_Network_Fetcher.cmd_log_file'
          inputs:
            - id: '#Knowledge_Network_Fetcher.taxonid'
              source:
                - '#taxonid'
            - id: '#Knowledge_Network_Fetcher.network_type'
              default: Gene
            - id: '#Knowledge_Network_Fetcher.get_network'
              source:
                - '#Gene_Set_Characterization_Parameters.get_network'
            - id: '#Knowledge_Network_Fetcher.edge_type'
              source:
                - '#Gene_Set_Characterization_Parameters.edge_type'
            - id: '#Knowledge_Network_Fetcher.bucket'
              default: KnowNets/KN-20rep-1706/userKN-20rep-1706
        - 'sbg:x': 740.2494721412951
          'sbg:y': 450.0153550794495
          run:
            'sbg:appVersion':
              - 'sbg:draft-2'
            'sbg:projectName': KnowEnG_GeneSetCharacterization_Demo
            'sbg:validationErrors': []
            'sbg:contributors':
              - viktorian_miok
              - mepstein
            baseCommand:
              - sh
              - run_gr.cmd
              - '&&'
              - sh
              - file_renamer.cmd
              - '&&'
              - python3
              - wget.py
              - >-
                https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md
              - README-GSC.md
            'sbg:id': mepstein/knoweng-genesetcharacterization/gsc-runner-copy/1
            inputs:
              - type:
                  - File
                required: true
                doc: property-gene network of interactions in edge format
                description: The gene set property network file
                id: '#pg_network_file'
                label: Gene Set Property Network File
              - 'sbg:toolDefaultValue': '50'
                type:
                  - 'null'
                  - int
                required: false
                description: >-
                  The amount of network smoothing (as a percent; default 50%); a
                  greater value means greater contribution from the network
                  interactions
                id: '#network_smoothing_percent'
                'sbg:includeInPorts': true
                label: Amount of Network Smoothing
              - type:
                  - 'null'
                  - string
                required: false
                doc: 'which method to use for GSC, i.e. DRaWR, fisher'
                description: 'The GSC method to use (e.g., DRaWR, fisher)'
                id: '#gsc_method'
                'sbg:includeInPorts': true
                label: GSC Method
              - type:
                  - 'null'
                  - File
                required: false
                doc: gene-gene network of interactions in edge format
                description: The knowledge network file
                id: '#gg_network_file'
                label: Knowledge Network File
              - type:
                  - File
                required: true
                doc: >-
                  spreadsheet of genomic data with samples as columns and genes
                  as rows
                description: The genomic spreadsheet file
                id: '#genomic_file'
                label: Genomic Spreadsheet File
              - id: '#gene_map_file'
                type:
                  - 'null'
                  - File
                description: The gene map file
                required: false
                label: Gene Map File
            'sbg:publisher': sbg
            x: 740.2494721412951
            'sbg:cmdPreview': >-
              sh run_gr.cmd && sh file_renamer.cmd && python3 wget.py
              https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md
              README-GSC.md
            'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/17
            stdout: ''
            'sbg:modifiedOn': 1517261405
            description: >-
              Test a gene set for enrichment against a large compendium of
              annotations.
            'sbg:image_url': null
            outputs:
              - type:
                  - 'null'
                  - File
                doc: contains the values used in analysis
                description: The configuration parameters specified for the GSC run
                id: '#run_params_yml'
                outputBinding:
                  glob: run_params.yml
                label: Configuration Parameters File
              - id: '#readme'
                type:
                  - 'null'
                  - File
                description: The README file that describes the output files
                outputBinding:
                  glob: README-GSC.md
                label: The README file
              - id: '#genomic_file_out'
                type:
                  - 'null'
                  - File
                description: The clean genomic spreadsheet
                outputBinding:
                  glob: clean_gene_set_matrix.txt
                label: Genomic Spreadsheet File
              - id: '#gene_map_file_out'
                type:
                  - 'null'
                  - File
                description: The gene map file
                outputBinding:
                  glob: gene_map.txt
                label: Gene Map File
              - type:
                  - 'null'
                  - File
                doc: >-
                  Edge format file with first three columns (user gene set,
                  public gene set, score)
                description: GSC enrichment scores
                id: '#enrichment_scores'
                outputBinding:
                  glob: '*_sorted_by_property_score_*'
                label: GSC Enrichment Scores
              - id: '#cmd_log_file'
                type:
                  - 'null'
                  - File
                description: The log of the GSC run command
                outputBinding:
                  glob: run_gr.cmd
                label: Command Log File
            requirements:
              - class: ShellCommandRequirement
              - class: InlineJavascriptRequirement
              - fileDef:
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: >
                        str = "";


                        str += "spreadsheet_name_full_path: " +
                        $job.inputs.genomic_file.path + "\n";

                        str += "pg_network_name_full_path: " +
                        $job.inputs.pg_network_file.path + "\n";

                        //str += "gene_names_map: dummy.map\n";

                        if ($job.inputs.gene_map_file) {
                            str += "gene_names_map: " + $job.inputs.gene_map_file.path + "\n";
                        }

                        else {
                            str += "gene_names_map: dummy.map\n";
                        }

                        str += "results_directory: ./\n";

                        str += "method: " + $job.inputs.gsc_method + "\n";

                        //str += "gg_network_name_full_path: " +
                        $job.inputs.gg_network_file.path + "\n";

                        if ($job.inputs.gg_network_file) {
                            str += "gg_network_name_full_path: " + $job.inputs.gg_network_file.path + "\n";
                            str += "rwr_convergence_tolerence: 0.0001\n";
                            str += "rwr_max_iterations: 500\n";
                            //str += "rwr_restart_probability: 0.5\n";
                            if ($job.inputs.network_smoothing_percent &&
                                $job.inputs.network_smoothing_percent >= 0 && $job.inputs.network_smoothing_percent <= 100) {
                                //restart_prob = 1 - ($job.inputs.network_smoothing_percent/100);
                                restart_prob = $job.inputs.network_smoothing_percent/100;
                                str += "rwr_restart_probability: " + restart_prob + "\n";
                            }
                            else {
                                str += "rwr_restart_probability: 0.5\n";
                            }
                        }


                        str2 = "echo \"" + str + "\" > run_params.yml && tail
                        -n+2 " + $job.inputs.genomic_file.path + " | awk '{print
                        \$1\"\\t\"\$1}' > dummy.map && python3
                        /home/src/geneset_characterization.py -run_directory ./
                        -run_file run_params.yml";


                        str2;
                    filename: run_gr.cmd
                  - fileContent:
                      engine: '#cwl-js-engine'
                      class: Expression
                      script: |
                        str = ""

                        if ($job.inputs.gene_map_file) {
                            str += "cp -p " + $job.inputs.gene_map_file.path + " gene_map.txt\n";
                        }

                        if ($job.inputs.genomic_file) {
                            str += "cp -p " + $job.inputs.genomic_file.path + " clean_gene_set_matrix.txt\n";
                        }

                        str;
                    filename: file_renamer.cmd
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
                requirements:
                  - dockerPull: rabix/js-engine
                    class: DockerRequirement
                class: ExpressionEngineRequirement
            class: CommandLineTool
            label: Gene Set Characterization
            'sbg:revision': 1
            'sbg:revisionsInfo':
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/16
                'sbg:modifiedBy': viktorian_miok
                'sbg:modifiedOn': 1512041775
                'sbg:revision': 0
              - 'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/17
                'sbg:modifiedBy': mepstein
                'sbg:modifiedOn': 1517261405
                'sbg:revision': 1
            'sbg:createdOn': 1512041775
            'sbg:sbgMaintained': false
            doc: >-
              Network-guided gene set characterization method implementation by
              KnowEnG that relates public gene sets to user gene sets
            id: mepstein/knoweng-genesetcharacterization/gsc-runner-copy/1
            cwlVersion: 'sbg:draft-2'
            'y': 450.0153550794495
            'sbg:project': mepstein/knoweng-genesetcharacterization
            'sbg:modifiedBy': mepstein
            'sbg:createdBy': viktorian_miok
            stdin: ''
            arguments: []
            'sbg:latestRevision': 1
            hints:
              - dockerPull: 'knowengdev/geneset_characterization_pipeline:07_26_2017'
                class: DockerRequirement
              - class: 'sbg:CPURequirement'
                value: 1
              - class: 'sbg:MemRequirement'
                value: 1000
            successCodes: []
            'sbg:copyOf': mepstein/genesetcharacterization/gsc-runner-copy/17
            'sbg:job':
              inputs:
                network_smoothing_percent: 9
                gene_map_file:
                  size: 0
                  class: File
                  path: /path/to/gene_map_file.ext
                  secondaryFiles: []
              allocatedResources:
                cpu: 1
                mem: 1000
            temporaryFailCodes: []
          id: '#Gene_Set_Characterization'
          outputs:
            - id: '#Gene_Set_Characterization.run_params_yml'
            - id: '#Gene_Set_Characterization.readme'
            - id: '#Gene_Set_Characterization.genomic_file_out'
            - id: '#Gene_Set_Characterization.gene_map_file_out'
            - id: '#Gene_Set_Characterization.enrichment_scores'
            - id: '#Gene_Set_Characterization.cmd_log_file'
          inputs:
            - id: '#Gene_Set_Characterization.pg_network_file'
              source:
                - '#Knowledge_Network_Fetcher_1.network_edge_file'
            - id: '#Gene_Set_Characterization.network_smoothing_percent'
              source:
                - '#network_smoothing_percent'
            - id: '#Gene_Set_Characterization.gsc_method'
              source:
                - '#Gene_Set_Characterization_Parameters.gsc_method'
            - id: '#Gene_Set_Characterization.gg_network_file'
              source:
                - '#Knowledge_Network_Fetcher.network_edge_file'
            - id: '#Gene_Set_Characterization.genomic_file'
              source:
                - '#Pipeline_Preprocessing.clean_genomic_file'
            - id: '#Gene_Set_Characterization.gene_map_file'
              source:
                - '#Pipeline_Preprocessing.gene_map_file'
      'sbg:links':
        - id: 'https://knoweng.org/'
          label: KnowEnG Main Website
        - id: 'https://knoweng.org/analyze/'
          label: KnowEnG Analytics
        - id: 'https://knoweng.org/kn-overview/'
          label: Knowledge Network Overview
        - id: 'https://knoweng.org/pipelines/'
          label: Knowledge-Guided Pipelines
        - id: 'https://knoweng.org/pipelines/#gene_set_characterization'
          label: GSC Pipeline
        - id: 'https://knoweng.org/quick-start/'
          label: Pipeline Quickstart Guides
        - id: 'https://knoweng.org/wp-content/uploads/2017/08/GSC_Quickstart.pdf'
          label: GSC Pipeline Quickstart
        - id: >-
            https://knoweng.org/wp-content/uploads/2017/12/GSC_CGC_Quickstart.pdf
          label: CGC GSC Pipeline Quickstart
        - id: 'https://www.youtube.com/channel/UCjyIIolCaZIGtZC20XLBOyg'
          label: KnowEnG YouTube Channel
      'sbg:createdBy': mepstein
      cwlVersion: 'sbg:draft-2'
      'sbg:latestRevision': 0
      hints: []
      'sbg:toolAuthor': KnowEnG
      'sbg:canvas_y': -11
      'sbg:copyOf': >-
        mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/4
      class: Workflow
    id: '#Gene_Set_Characterization_Workflow_1'
    outputs:
      - id: '#Gene_Set_Characterization_Workflow_1.run_params_yml'
      - id: '#Gene_Set_Characterization_Workflow_1.readme'
      - id: '#Gene_Set_Characterization_Workflow_1.new_data_file'
      - id: >-
          #Gene_Set_Characterization_Workflow_1.interaction_network_metadata_file
      - id: '#Gene_Set_Characterization_Workflow_1.gene_set_network_metadata_file'
      - id: '#Gene_Set_Characterization_Workflow_1.gene_set_name_map_file'
      - id: '#Gene_Set_Characterization_Workflow_1.gene_map_file'
      - id: '#Gene_Set_Characterization_Workflow_1.enrichment_scores'
      - id: '#Gene_Set_Characterization_Workflow_1.clean_genomic_file'
inputs:
  - type:
      - 'null'
      - type: enum
        name: similarity_measure
        symbols:
          - cosine
          - pearson
          - spearman
    'sbg:y': 486.9239637586806
    id: '#similarity_measure'
    description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
    'sbg:x': 154.35672336154516
    'sbg:includeInPorts': true
    label: Similarity Measure
  - type:
      - 'null'
      - File
    'sbg:y': 439.9297688802085
    id: '#signatures_file'
    description: The input signatures file
    'sbg:x': 56.584777832031264
    'sbg:includeInPorts': true
    label: Signatures File
  - type:
      - 'null'
      - boolean
    'sbg:y': 343.33333333333337
    id: '#normalize'
    description: >-
      Whether to normalize the spreadsheet (default: False) (currently the only
      normalization available is z-score)
    'sbg:x': 147.77778625488284
    'sbg:includeInPorts': true
    label: Normalize Flag
  - type:
      - 'null'
      - float
    'sbg:y': 163.2359967912947
    id: '#filter_min_percentage'
    description: >-
      If present, rows with a lower percentage of values below the filter
      threshold will be dropped; this is a float between 0.0 and 1.0; default:
      0.0 (no filtering).
    'sbg:x': 59.12719726562502
    'sbg:includeInPorts': true
    label: Filter Minimum Percentage
  - type:
      - 'null'
      - float
    'sbg:y': 195.12864854600696
    id: '#filter_threshold'
    description: 'The filter threshold (see filter minimum percentage); default: 1.0'
    'sbg:x': 155.88302612304688
    'sbg:includeInPorts': true
    label: Filter Threshold
  - type:
      - items: File
        type: array
        name: input_files
    'sbg:y': 55.403503417968764
    id: '#input_files'
    description: 'Input files (e.g., input array of TCGA data files)'
    'sbg:x': 59.55554199218752
    'sbg:includeInPorts': true
    label: Input Files
  - type:
      - 'null'
      - int
    'sbg:y': 590.6515938895092
    id: '#number_of_top_genes'
    description: The number of top genes to find
    'sbg:x': 57.853022984096
    'sbg:includeInPorts': true
    label: Number of Top Genes
  - type:
      - 'null'
      - string
    'sbg:y': 824.603184291295
    id: '#gg_edge_type'
    description: The knowledge network edge type
    'sbg:x': 57.04367501395091
    'sbg:includeInPorts': true
    label: Knowledge Network Edge Type
  - type:
      - 'null'
      - int
    'sbg:y': 889.7221374511721
    id: '#network_smoothing_percent'
    description: >-
      The amount of network influence (as a percent; default 50%); a greater
      value means greater contribution from the network interactions
    'sbg:x': 146.11114501953128
    'sbg:includeInPorts': true
    label: Amount of Network Influence
  - type:
      - string
    'sbg:y': 715.7143293108262
    id: '#pg_edge_type'
    description: The gene set property network edge type
    'sbg:x': 57.14283534458708
    'sbg:includeInPorts': true
    label: Gene Set Property Network Edge Type
  - type:
      - 'null'
      - string
    'sbg:y': 288.7836303710938
    id: '#expected_header_key'
    description: >-
      The metadata key to use for the Sample ID (acutally, this can be a
      comma-separated list of keys to try; the first one that is found in the
      metadata will be used; the default is "aliquot_id,sample_id"; if the key
      is not found in the metadata, an error will be thrown)
    'sbg:x': 53.36842854817709
    'sbg:includeInPorts': true
    label: Metadata Sample ID Key
'sbg:projectName': Lung_Signatures_Public
description: >-
  This workflow is a compilation of other [KnowEnG](https://knoweng.org/)
  workflows.  It takes some input gene expressions files (typically TCGA), and
  uses the [Spreadsheet Builder
  workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder)
  to create genomic and phenotypic spreadsheet files.  The genomic file, along
  with an input signatures file, is passed to the [Signature Analysis
  workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-signature-analysis-public/signature-analysis-workflow),
  which outputs a binary similarity matrix.  This binary matrix, along with the
  genomic file, is passed to the [Gene Prioritization
  workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow),
  to create a top genes file output.  This top genes file, along with property
  gene set network information, is then passed to two [Gene Set Characterization
  workflows](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-genesetcharacterization-public/gene-set-characterization),
  one running in DRaWR mode (with an associated Interaction Knowledge Network)
  and one in Fisher mode (no knowledge network).
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/lung/knoweng-analysis-of-lusc-subtypes/7.png
outputs:
  - type:
      - 'null'
      - File
    required: false
    'sbg:y': 337.9657363891602
    id: '#new_data_file'
    'sbg:x': 1143.61930847168
    'sbg:includeInPorts': true
    label: GSC DRaWR Results
    source:
      - '#Gene_Set_Characterization_Workflow.new_data_file'
  - type:
      - 'null'
      - File
    required: false
    'sbg:y': 493.529510498047
    id: '#top_genes_file'
    'sbg:x': 1143.8970947265627
    'sbg:includeInPorts': true
    label: Top Genes File
    source:
      - '#Gene_Prioritization_Workflow.top_genes_file'
  - type:
      - 'null'
      - File
    required: false
    'sbg:y': 646.1029815673829
    id: '#new_data_file_1'
    'sbg:x': 1152.79411315918
    'sbg:includeInPorts': true
    label: GSC Fisher Results
    source:
      - '#Gene_Set_Characterization_Workflow_1.new_data_file'
  - type:
      - 'null'
      - File
    required: false
    'sbg:y': 86.25000000000001
    id: '#output_matrix_1'
    'sbg:x': 1143.7500000000002
    'sbg:includeInPorts': true
    label: Clean Genomic Matrix
    source:
      - '#Spreadsheet_Builder.output_matrix_1'
  - type:
      - 'null'
      - File
    required: false
    'sbg:y': 198.75000000000006
    id: '#output_matrix'
    'sbg:x': 1145.0000000000002
    'sbg:includeInPorts': true
    label: Clean Phenotypic Matrix
    source:
      - '#Spreadsheet_Builder.output_matrix'
requirements: []
hints: []
'sbg:canvas_x': 96
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531253113
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531253773
    'sbg:revisionNotes': Initial development of app (incomplete).
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531255410
    'sbg:revisionNotes': Initial version of app.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531340152
    'sbg:revisionNotes': >-
      Modified the inputs and outputs (mostly removed inputs, added output), and
      added second GSC for Fisher (first is doing DRaWR).
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531348576
    'sbg:revisionNotes': Documented input and outputs.
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531349721
    'sbg:revisionNotes': Added description information.
  - 'sbg:revision': 6
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1531352773
    'sbg:revisionNotes': Added links to description.
  - 'sbg:revision': 7
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1536089129
    'sbg:revisionNotes': Updated documentation on some inputs.
cwlVersion: 'sbg:draft-2'
'sbg:toolkit': KnowEnG_CGC
class: Workflow
label: KnowEnG Analysis of LUSC Subtypes
'sbg:canvas_y': -1
'sbg:canvas_zoom': 0.6999999999999997
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/lung/knoweng-analysis-of-lusc-subtypes/7/raw/
'sbg:id': mepstein/lung/knoweng-analysis-of-lusc-subtypes/7
'sbg:revision': 7
'sbg:revisionNotes': Updated documentation on some inputs.
'sbg:modifiedOn': 1536089129
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1531253113
'sbg:createdBy': mepstein
'sbg:project': mepstein/lung
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 7
'sbg:content_hash': null
