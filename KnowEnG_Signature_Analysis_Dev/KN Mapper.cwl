hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerImageId: ''
    dockerPull: 'knoweng/kn_mapper:latest'
'sbg:revisionNotes': Added dont_do_mapping input/behavior.
stdout: ''
cwlVersion: 'sbg:draft-2'
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
label: KN Mapper
temporaryFailCodes: []
baseCommand:
  - sh
  - kn_mapper.sh
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    input_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/input_file.ext
    redis_port: redis_port-string-value
    source_hint: source_hint-string-value
    taxon: taxon-string-value
    redis_pass: redis_pass-string-value
    output_name: output_name-string-value
    dont_cut_first_line: true
    redis_host: redis_host-string-value
    dont_do_mapping: true
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: The Output File
    description: The output file (the gene name map)
    id: '#output_file'
    outputBinding:
      glob: names.node_map.txt
    type:
      - 'null'
      - File
'sbg:cmdPreview': sh kn_mapper.sh -i /path/to/input_file.ext
description: Map the genes in a spreadsheet/file.
'sbg:projectName': KnowEnG_Signature_Analysis_Dev
class: CommandLineTool
'sbg:image_url': null
inputs:
  - label: Input File
    description: The input file
    inputBinding:
      prefix: '-i'
      'sbg:cmdInclude': true
      separate: true
    id: '#input_file'
    type:
      - File
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
  - label: Source Hint
    description: The source hint
    inputBinding:
      prefix: '-s'
      'sbg:cmdInclude': true
      separate: true
    id: '#source_hint'
    type:
      - 'null'
      - string
  - label: Species Taxon ID
    description: The species taxon id
    inputBinding:
      prefix: '-t'
      'sbg:cmdInclude': true
      separate: true
    id: '#taxon'
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
  - label: Dont Cut First Line Flag
    description: >-
      If the input file is a list of gene names rather than a genomic
      spreadsheet, you might want to use this (i.e., the first line won't be
      column headers)
    'sbg:stageInput': null
    inputBinding:
      prefix: '-F'
      'sbg:cmdInclude': true
      separate: true
    id: '#dont_cut_first_line'
    type:
      - 'null'
      - boolean
  - label: Dont Do Mapping Flag
    description: >-
      If present, the names won't be mapped, instead a dummy map (with the two
      columns identical) will be created
    inputBinding:
      prefix: '-n'
      'sbg:cmdInclude': true
      separate: true
    'sbg:stageInput': null
    id: '#dont_do_mapping'
    type:
      - 'null'
      - boolean
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524681212
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524681994
    'sbg:revisionNotes': Initial version.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524687186
    'sbg:revisionNotes': Fixed typo in tail command in kn_mapper.sh.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524842883
    'sbg:revisionNotes': Added dont_do_mapping input/behavior.
'sbg:publisher': sbg
stdin: ''
successCodes: []
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-dev/kn-mapper/3/raw/
'sbg:id': mepstein/knoweng-signature-analysis-dev/kn-mapper/3
'sbg:revision': 3
'sbg:modifiedOn': 1524842883
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1524681212
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 3
'sbg:content_hash': null
