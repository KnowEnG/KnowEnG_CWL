hints: []
outputs:
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
cwlVersion: 'sbg:draft-2'
description: ''
'sbg:projectName': KnowEnG_Signature_Analysis_Demo
'sbg:revisionNotes': Copy of mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
class: Workflow
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-signature-analysis-demo/mapper-workflow/0.png
inputs:
  - 'sbg:y': 62
    label: input_file
    'sbg:x': 80
    id: '#input_file'
    type:
      - File
  - label: dont_do_mapping
    'sbg:x': 83
    'sbg:y': 199
    'sbg:includeInPorts': true
    id: '#dont_do_mapping'
    type:
      - 'null'
      - boolean
  - label: taxon
    'sbg:x': 81
    'sbg:y': 326
    'sbg:includeInPorts': true
    id: '#taxon'
    type:
      - 'null'
      - string
  - label: source_hint
    'sbg:x': 86
    'sbg:y': 464
    'sbg:includeInPorts': true
    id: '#source_hint'
    type:
      - 'null'
      - string
  - label: output_filename
    'sbg:x': 87
    'sbg:y': 596
    'sbg:includeInPorts': true
    id: '#output_filename'
    type:
      - string
requirements: []
label: Mapper Workflow
'sbg:canvas_x': 0
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
      'sbg:modifiedBy': mepstein
      'sbg:revisionNotes': Added dont_do_mapping input/behavior.
      'sbg:modifiedOn': 1524842883
      'sbg:contributors':
        - mepstein
      cwlVersion: 'sbg:draft-2'
      x: 495
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
          input_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/input_file.ext
          redis_host: redis_host-string-value
          taxon: taxon-string-value
          redis_pass: redis_pass-string-value
          output_name: output_name-string-value
          source_hint: source_hint-string-value
          dont_cut_first_line: true
          dont_do_mapping: true
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'knoweng/kn_mapper:latest'
          dockerImageId: ''
      outputs:
        - label: The Output File
          description: The output file (the gene name map)
          id: '#output_file'
          outputBinding:
            glob: names.node_map.txt
          type:
            - 'null'
            - File
      inputs:
        - label: Species Taxon ID
          description: The species taxon id
          'sbg:includeInPorts': true
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-t'
          id: '#taxon'
          required: false
          type:
            - 'null'
            - string
        - label: Source Hint
          description: The source hint
          'sbg:includeInPorts': true
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-s'
          id: '#source_hint'
          required: false
          type:
            - 'null'
            - string
        - label: Redis Port
          description: The redis port
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-p'
          id: '#redis_port'
          type:
            - 'null'
            - string
        - label: Redis Password
          description: The redis password
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-P'
          id: '#redis_pass'
          type:
            - 'null'
            - string
        - label: Redis Host
          description: The redis host
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-h'
          id: '#redis_host'
          type:
            - 'null'
            - string
        - label: Output Filename
          description: The output file name
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-o'
          id: '#output_name'
          type:
            - 'null'
            - string
        - label: Input File
          description: The input file
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-i'
          id: '#input_file'
          required: true
          type:
            - File
        - 'sbg:includeInPorts': true
          label: Dont Do Mapping Flag
          description: >-
            If present, the names won't be mapped, instead a dummy map (with the
            two columns identical) will be created
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-n'
          'sbg:stageInput': null
          id: '#dont_do_mapping'
          required: false
          type:
            - 'null'
            - boolean
        - label: Dont Cut First Line Flag
          description: >-
            If the input file is a list of gene names rather than a genomic
            spreadsheet, you might want to use this (i.e., the first line won't
            be column headers)
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-F'
          'sbg:stageInput': null
          id: '#dont_cut_first_line'
          type:
            - 'null'
            - boolean
      'sbg:revision': 3
      'sbg:latestRevision': 3
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1524681212
      'sbg:appVersion':
        - 'sbg:draft-2'
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
      successCodes: []
      'sbg:publisher': sbg
      stdin: ''
      'y': 171
      $namespaces:
        sbg: 'https://sevenbridges.com'
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
      'sbg:modifiedBy': mepstein
      'sbg:revisionNotes': 'Changed docker container, to get newer version of pandas.'
      'sbg:modifiedOn': 1524716022
      'sbg:contributors':
        - mepstein
      cwlVersion: 'sbg:draft-2'
      x: 782
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
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Map Names
      description: Map the names in the input file based on the map file.
      stdout: ''
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-signature-analysis-dev/map-names/5
      'sbg:cmdPreview': >-
        python3 map_names.py -i /path/to/input_file.ext -m /path/to/map_file.ext
        -o output_filename-string-value
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
          names_are_columns: true
          map_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/map_file.ext
          switch_mapped_order: true
          output_filename: output_filename-string-value
          drop_unmapped_names: true
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'clutteredcode/python3-alpine-pandas:latest'
          dockerImageId: ''
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
      inputs:
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
        - label: Output Filename
          description: Output Filename
          'sbg:includeInPorts': true
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-o'
          id: '#output_filename'
          required: true
          type:
            - string
        - label: Names are Columns
          description: >-
            If present, the names to be mapped in the input file are columns,
            not rows
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-c'
          'sbg:stageInput': null
          id: '#names_are_columns'
          type:
            - 'null'
            - boolean
        - label: Map File
          description: >-
            Map files with orginal/mapped names in first two columns (default is
            mapped in first, original in second)
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-m'
          id: '#map_file'
          required: true
          type:
            - File
        - label: Input File
          description: Input file to be mapped
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-i'
          id: '#input_file'
          required: true
          type:
            - File
        - label: Drop Unmapped Names Flag
          description: 'If present, any names that are unmapped will be dropped'
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-u'
          id: '#drop_unmapped_names'
          type:
            - 'null'
            - boolean
      'sbg:revision': 5
      'sbg:latestRevision': 5
      'sbg:projectName': KnowEnG_Signature_Analysis_Dev
      'sbg:project': mepstein/knoweng-signature-analysis-dev
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1522285864
      'sbg:appVersion':
        - 'sbg:draft-2'
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
      successCodes: []
      'sbg:publisher': sbg
      stdin: ''
      'y': 361
      $namespaces:
        sbg: 'https://sevenbridges.com'
    'sbg:y': 361
    id: '#Map_Names'
'sbg:canvas_zoom': 0.95
'sbg:canvas_y': 0
'sbg:publisher': sbg
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529391014
    'sbg:revisionNotes': Copy of mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-demo/mapper-workflow/0/raw/
'sbg:id': mepstein/knoweng-signature-analysis-demo/mapper-workflow/0
'sbg:revision': 0
'sbg:modifiedOn': 1529391014
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529391014
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-signature-analysis-dev/mapper-workflow/2
