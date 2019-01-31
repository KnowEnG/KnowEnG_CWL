inputs:
  - label: Input File
    id: '#input_file'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-i'
    description: Input file to be mapped
    type:
      - File
  - label: Map File
    id: '#map_file'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-m'
    description: >-
      Map files with orginal/mapped names in first two columns (default is
      mapped in first, original in second)
    type:
      - File
  - label: Output Filename
    id: '#output_filename'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-o'
    description: Output Filename
    type:
      - string
  - label: Switch Mapped Order
    description: 'If present, the order in the map file is original name/mapped name'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-s'
    'sbg:stageInput': null
    id: '#switch_mapped_order'
    type:
      - 'null'
      - boolean
  - label: Names are Columns
    description: 'If present, the names to be mapped in the input file are columns, not rows'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-c'
    'sbg:stageInput': null
    id: '#names_are_columns'
    type:
      - 'null'
      - boolean
  - label: Drop Unmapped Names Flag
    id: '#drop_unmapped_names'
    inputBinding:
      separate: true
      'sbg:cmdInclude': true
      prefix: '-u'
    description: 'If present, any names that are unmapped will be dropped'
    type:
      - 'null'
      - boolean
'sbg:revisionNotes': Copy of mepstein/knoweng-signature-analysis-dev/map-names/5
stdout: ''
cwlVersion: 'sbg:draft-2'
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
arguments: []
label: Map Names
temporaryFailCodes: []
baseCommand:
  - python3
  - map_names.py
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    input_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/input_file.ext
    names_are_columns: true
    output_filename: output_filename-string-value
    switch_mapped_order: true
    map_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/map_file.ext
    drop_unmapped_names: true
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Output File
    description: Output File
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: $job.inputs.output_filename
    id: '#output_file'
    type:
      - 'null'
      - File
'sbg:cmdPreview': >-
  python3 map_names.py -i /path/to/input_file.ext -m /path/to/map_file.ext -o
  output_filename-string-value
description: Map the names in the input file based on the map file.
'sbg:projectName': KnowEnG_Signature_Analysis_Demo
class: CommandLineTool
'sbg:image_url': null
successCodes: []
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529390990
    'sbg:revisionNotes': Copy of mepstein/knoweng-signature-analysis-dev/map-names/5
hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerImageId: ''
    dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-demo/map-names/0/raw/
'sbg:id': mepstein/knoweng-signature-analysis-demo/map-names/0
'sbg:revision': 0
'sbg:modifiedOn': 1529390990
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529390990
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-signature-analysis-dev/map-names/5
