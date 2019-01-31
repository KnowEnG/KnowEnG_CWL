inputs:
  - label: Input Files
    id: '#input_files'
    description: Input array of TCGA Level 3 gene expression quantification files
    'sbg:stageInput': link
    'sbg:altPrefix': '--files'
    type:
      - items: File
        type: array
  - label: Output Filename
    id: '#output_filename'
    description: >-
      Prefix to use on the various output files (e.g., the gene expression data
      and the metadata)
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-o'
      valueFrom:
        class: Expression
        engine: '#cwl-js-engine'
        script: >-
          // take what the user gives and pop any extensions to prevent silly
          names like 'file.csv.csv'

          $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '')
      position: 0
    'sbg:altPrefix': '--output_filename'
    type:
      - string
  - 'sbg:toolDefaultValue': 'aliquot_id,sample_id'
    label: Metadata Sample ID Key
    id: '#expected_header_key'
    description: >-
      The metadata key to use for the Sample ID (acutally, this can be a
      comma-separated list of keys to try; the first one that is found in the
      metadata will be used; the default is "aliquot_id,sample_id"; if the key
      is not found in the metadata, an error will be thrown)
    type:
      - 'null'
      - string
  - 'sbg:toolDefaultValue': '\t [TAB]'
    label: Metadata Output Separator
    id: '#separator'
    description: 'The separator to use in the metadata output files (default: ''\t'' [TAB])'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-s'
      position: 0
    'sbg:altPrefix': '--metadata_separator'
    type:
      - 'null'
      - string
  - label: Gene Column Info
    id: '#gene_column_info'
    description: >-
      The name or the index of the column to find the gene in the input data
      files (indexes start at 1); the default behavior is that if there is a
      column labeled "gene", that will be used; else the first column will be
      used.
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-g'
    'sbg:altPrefix': '--gene_column_info'
    type:
      - 'null'
      - string
  - label: Data Column Info
    id: '#data_column_info'
    description: >-
      The name or the index of the column to find the data in the input data
      files (indexes start at 1); the default behavior is that the last column
      will be used.
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-d'
    'sbg:altPrefix': '--data_column_info'
    type:
      - 'null'
      - string
  - 'sbg:toolDefaultValue': '\t [TAB]'
    label: Data Input Separator
    id: '#data_separator'
    description: >-
      The separator used in the input data files (generally ',' or '\t' [TAB];
      default: '\t')
    inputBinding:
      prefix: '-S'
      'sbg:cmdInclude': true
      separate: true
    'sbg:altPrefix': '--data_separator'
    type:
      - 'null'
      - string
hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerImageId: ''
    dockerPull: continuumio/anaconda3
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: CreateFileRequirement
    fileDef:
      - fileContent: >-
          #!/usr/bin/env python3


          """

          usage: munger.py [-h] [-f FILES [FILES ...]] [-r INDEX_FILE] [-c] [-o
          OUTPUT_FILENAME]


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

          # df = pd.read_table(filename, skiprows=1) # to skip the version row


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

          # unless that's a '?', in which case returns the portion after the
          '|'.

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

          def get_gene_column(args, filename, first_row, num_cols, has_headers):
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

          def get_data_column(args, filename, first_row, num_cols, has_headers):
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
          class: Expression
          engine: '#cwl-js-engine'
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
          class: Expression
          engine: '#cwl-js-engine'
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
          class: Expression
          engine: '#cwl-js-engine'
          script: >-
            $job.inputs.input_files.map(function(f){return
            f.path.split('/').pop()}).join('\n');

            // create an index file by taking the filename for each input file
            in the input array

            // an adding each in a new line (\n)
        filename:
          class: Expression
          engine: '#cwl-js-engine'
          script: >-
            // Index File

            $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
            '_file.txt'

            // take processed output_filename and add appropriate suffix
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
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
          class: Expression
          engine: '#cwl-js-engine'
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
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments:
  - separate: false
    valueFrom: '-t'
    position: 0
  - separate: true
    prefix: '-r'
    valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: '$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '''') + ''_file.txt'''
  - separate: false
    valueFrom: '&&'
    position: 5
  - separate: false
    valueFrom: cp
    position: 6
  - separate: false
    valueFrom: '-p'
    position: 7
  - separate: false
    valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: >-
        // Metadata CSV

        //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
        '_metadata.csv';

        extension = 'tsv';

        if ($job.inputs.separator && $job.inputs.separator == ',') {
            extension = '.csv';
        }

        $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') + '_by_gene.'
        + extension;

        // take processed output_filename and add appropriate suffix
    position: 8
  - separate: false
    valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: >-
        // Metadata CSV

        //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
        '_metadata.csv';

        extension = 'tsv';

        if ($job.inputs.separator && $job.inputs.separator == ',') {
            extension = '.csv';
        }

        'genomic.' + extension;
    position: 9
  - separate: true
    prefix: '-m'
    valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: >-
        // Metadata CSV

        //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
        '_metadata.csv';

        extension = 'tsv';

        if ($job.inputs.separator && $job.inputs.separator == ',') {
            extension = '.csv';
        }

        $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') + '_metadata.'
        + extension;

        // take processed output_filename and add appropriate suffix
    position: 0
label: Expression Spreadsheet Builder-V2
temporaryFailCodes: []
'sbg:revisionNotes': Copy of mepstein/knoweng-spreadsheetbuilder-dev/geneexprmunger-v2/0
baseCommand:
  - python
  - munger.py
'sbg:job':
  inputs:
    separator: separator-string-value
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
    expected_header_key: expected_header_key-string-value
    output_filename: output.csv
    data_column_info: data_column_info-string-value
    gene_column_info: gene_column_info-string-value
    data_separator: data_separator-string-value
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Gene Matrix
    id: '#gene'
    description: Genes by Cases (genes X samples)
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: >-
          extension = 'tsv';

          if ($job.inputs.separator && $job.inputs.separator == ',') {
              extension = '.csv';
          }

          $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
          '_by_gene.' + extension;
      'sbg:metadata':
        num_input_files: $job.inputs.input_files.length
      'sbg:inheritMetadataFrom': '#input_files'
    'sbg:fileTypes': CSV
  - label: Case Matrix
    id: '#case'
    description: Transpose of Gene (samples X genes)
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: >-
          extension = 'tsv';

          if ($job.inputs.separator && $job.inputs.separator == ',') {
              extension = '.csv';
          }

          $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
          '_by_sample.' + extension;
      'sbg:metadata':
        num_input_files:
          class: Expression
          engine: '#cwl-js-engine'
          script: $job.inputs.input_files.length
      'sbg:inheritMetadataFrom': '#input_files'
    'sbg:fileTypes': CSV
  - label: Metadata Matrix
    id: '#metadata'
    description: Metadata values for the input files (samples X phenotypes)
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: >-
          //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
          '_metadata.csv';

          extension = 'tsv';

          if ($job.inputs.separator && $job.inputs.separator == ',') {
              extension = '.csv';
          }

          $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
          '_metadata.' + extension;
      'sbg:metadata':
        num_input_files:
          class: Expression
          engine: '#cwl-js-engine'
          script: $job.inputs.input_files.length
    'sbg:fileTypes': CSV
  - label: Index File
    id: '#index'
    description: A file containing a list of the files used in this execution
    type:
      - 'null'
      - File
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
    'sbg:fileTypes': TXT
  - label: Metadata Matrix (Transposed)
    id: '#metadata_t'
    description: 'Metadata for the input files (transposed, phenotypes X samples)'
    type:
      - 'null'
      - File
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: >-
          //$job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
          '_metadata_T.csv';

          extension = 'tsv';

          if ($job.inputs.separator && $job.inputs.separator == ',') {
              extension = '.csv';
          }

          $job.inputs.output_filename.replace(/.*\/|\.[^.]*$/g, '') +
          '_metadata_T.' + extension;
      'sbg:metadata':
        num_input_files:
          class: Expression
          engine: '#cwl-js-engine'
          script: $job.inputs.input_files.length
    'sbg:fileTypes': CSV
  - label: Genomic Spreadsheet File
    id: '#genomic_spreadsheet_file'
    description: The genomic spreadsheet file
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: |-
          extension = 'tsv';
          if ($job.inputs.separator && $job.inputs.separator == ',') {
              extension = '.csv';
          }
          'genomic.' + extension;
    type:
      - 'null'
      - File
'sbg:cmdPreview': >-
  python munger.py -o output -t -r output_file.txt -m output_metadata.tsv && cp
  -p output_by_gene.tsv genomic.tsv
description: >-
  Expression Spreadsheet Builder is a tool built for processing Level 3 RNA-seq
  gene expression data from The Cancer Genome Atlas. It will produce two tables
  of gene expression data (per gene, or per case) as well as a metadata table.
  It is capable of processing any number of files as it will automatically
  create an index for the list of files you specify, and then use that index in
  the command line.


  This code was modified from a version produced by Gaurav Kaushik with
  contributions from Boysha Tijanic for the Seven Bridges + NIH BD2K Hackathon,
  which took place April 1st to 3rd, 2016.
'sbg:projectName': KnowEnG_SpreadsheetBuilder_Demo
class: CommandLineTool
'sbg:image_url': null
successCodes: []
'sbg:toolkitVersion': ''
'sbg:categories':
  - TCGA
  - CCLE
  - spreadsheet
'sbg:toolAuthor': ''
'sbg:license': ''
'sbg:toolkit': ''
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529391516
    'sbg:revisionNotes': Copy of mepstein/knoweng-spreadsheetbuilder-dev/geneexprmunger-v2/0
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-spreadsheetbuilder-demo/geneexprmunger-v2/0/raw/
'sbg:id': mepstein/knoweng-spreadsheetbuilder-demo/geneexprmunger-v2/0
'sbg:revision': 0
'sbg:modifiedOn': 1529391516
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529391516
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-spreadsheetbuilder-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-spreadsheetbuilder-dev/geneexprmunger-v2/0
