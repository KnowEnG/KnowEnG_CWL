hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: ubuntu
    dockerImageId: ''
'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: CreateFileRequirement
    fileDef:
      - fileContent: >-
          #!/usr/bin/bash


          INPUT=$1

          OUTPUT=$2


          # As seen on:

          #
          https://unix.stackexchange.com/questions/30173/how-to-remove-duplicate-lines-inside-a-text-file

          <$INPUT nl -b a -s : |          # number the lines

          sort -t : -k 2 -u |             # sort and uniquify ignoring the line
          numbers

          sort -t : -k 1n |               # sort according to the line numbers

          cut -d : -f 2- >$OUTPUT         # remove the line numbers


          # Using awk:

          # <input awk '!seen[$0]++'
        filename: rem_dups.sh
      - fileContent:
          class: Expression
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
        filename: renamer.sh
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: Signature Analysis Renamer
temporaryFailCodes: []
baseCommand:
  - sh
  - renamer.sh
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    gene_map2_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/gene_map2_in.ext
    gene_map1_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/gene_map1_in.ext
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Gene Map File
    type:
      - 'null'
      - File
    id: '#gene_map_file_out'
    outputBinding:
      glob: gene_map.txt
    description: The gene map file
'sbg:cmdPreview': sh renamer.sh
description: ''
'sbg:projectName': KnowEnG_Signature_Analysis_Dev
class: CommandLineTool
'sbg:image_url': null
inputs:
  - label: Gene Map File 1 Input
    type:
      - 'null'
      - File
    id: '#gene_map1_in'
    description: Gene Map File 1 Input
  - label: Gene Map File 2 Input
    type:
      - 'null'
      - File
    id: '#gene_map2_in'
    description: Gene Map File 2 Input
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526539333
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526540443
    'sbg:revisionNotes': Initial version.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526542055
    'sbg:revisionNotes': Changed how shell script called in renamer.sh.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526570997
    'sbg:revisionNotes': Removed "-e" from echo call in renamer.sh.
'sbg:publisher': sbg
stdin: ''
successCodes: []
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3/raw/
'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis-renamer/3
'sbg:revision': 3
'sbg:modifiedOn': 1526570997
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1526539333
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 3
'sbg:content_hash': null
