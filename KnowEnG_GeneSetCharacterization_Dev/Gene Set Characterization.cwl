inputs:
  - label: Gene Set Property Network File
    type:
      - File
    id: '#pg_network_file'
    doc: property-gene network of interactions in edge format
    description: The gene set property network file
  - label: Knowledge Network File
    type:
      - 'null'
      - File
    id: '#gg_network_file'
    doc: gene-gene network of interactions in edge format
    description: The knowledge network file
  - label: Genomic Spreadsheet File
    type:
      - File
    id: '#genomic_file'
    doc: spreadsheet of genomic data with samples as columns and genes as rows
    description: The genomic spreadsheet file
  - label: GSC Method
    type:
      - 'null'
      - string
    id: '#gsc_method'
    doc: 'which method to use for GSC, i.e. DRaWR, fisher'
    description: 'The GSC method to use (e.g., DRaWR, fisher)'
  - label: Gene Map File
    type:
      - 'null'
      - File
    id: '#gene_map_file'
    description: The gene map file
  - 'sbg:toolDefaultValue': '50'
    label: Amount of Network Smoothing
    type:
      - 'null'
      - int
    description: >-
      The amount of network smoothing (as a percent; default 50%); a greater
      value means greater contribution from the network interactions
    id: '#network_smoothing_percent'
'sbg:revisionNotes': >-
  Updated calculation of rwr restart probability; added wget.py to get
  README-GSC.md.
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: CreateFileRequirement
    fileDef:
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
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


            str2 = "echo \"" + str + "\" > run_params.yml && tail -n+2 " +
            $job.inputs.genomic_file.path + " | awk '{print \$1\"\\t\"\$1}' >
            dummy.map && python3 /home/src/geneset_characterization.py
            -run_directory ./ -run_file run_params.yml";


            str2;
        filename: run_gr.cmd
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
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
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: Gene Set Characterization
temporaryFailCodes: []
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
'sbg:job':
  inputs:
    gene_map_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/gene_map_file.ext
    network_smoothing_percent: 9
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: GSC Enrichment Scores
    id: '#enrichment_scores'
    description: GSC enrichment scores
    outputBinding:
      glob: '*_sorted_by_property_score_*'
    doc: >-
      Edge format file with first three columns (user gene set, public gene set,
      score)
    type:
      - 'null'
      - File
  - label: Configuration Parameters File
    id: '#run_params_yml'
    description: The configuration parameters specified for the GSC run
    outputBinding:
      glob: run_params.yml
    doc: contains the values used in analysis
    type:
      - 'null'
      - File
  - label: Command Log File
    description: The log of the GSC run command
    type:
      - 'null'
      - File
    outputBinding:
      glob: run_gr.cmd
    id: '#cmd_log_file'
  - label: The README file
    description: The README file that describes the output files
    type:
      - 'null'
      - File
    outputBinding:
      glob: README-GSC.md
    id: '#readme'
  - label: Gene Map File
    description: The gene map file
    type:
      - 'null'
      - File
    outputBinding:
      glob: gene_map.txt
    id: '#gene_map_file_out'
  - label: Genomic Spreadsheet File
    description: The clean genomic spreadsheet
    type:
      - 'null'
      - File
    outputBinding:
      glob: clean_gene_set_matrix.txt
    id: '#genomic_file_out'
'sbg:cmdPreview': >-
  sh run_gr.cmd && sh file_renamer.cmd && python3 wget.py
  https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md
  README-GSC.md
description: Test a gene set for enrichment against a large compendium of annotations.
'sbg:projectName': KnowEnG_GeneSetCharacterization_Dev
class: CommandLineTool
'sbg:image_url': null
successCodes: []
doc: >-
  Network-guided gene set characterization method implementation by KnowEnG that
  relates public gene sets to user gene sets
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1505406378
    'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner/1
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1505406402
    'sbg:revisionNotes': null
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1505414680
    'sbg:revisionNotes': null
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1505768631
    'sbg:revisionNotes': null
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1506019861
    'sbg:revisionNotes': null
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1506547484
    'sbg:revisionNotes': null
  - 'sbg:revision': 6
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1506572577
    'sbg:revisionNotes': null
  - 'sbg:revision': 7
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1506623681
    'sbg:revisionNotes': null
  - 'sbg:revision': 8
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1507220508
    'sbg:revisionNotes': null
  - 'sbg:revision': 9
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1507224080
    'sbg:revisionNotes': null
  - 'sbg:revision': 10
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508281282
    'sbg:revisionNotes': null
  - 'sbg:revision': 11
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508284440
    'sbg:revisionNotes': null
  - 'sbg:revision': 12
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508351170
    'sbg:revisionNotes': null
  - 'sbg:revision': 13
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508351634
    'sbg:revisionNotes': null
  - 'sbg:revision': 14
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508948417
    'sbg:revisionNotes': null
  - 'sbg:revision': 15
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1509502379
    'sbg:revisionNotes': null
  - 'sbg:revision': 16
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1509652270
    'sbg:revisionNotes': null
  - 'sbg:revision': 17
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517197168
    'sbg:revisionNotes': >-
      Updated calculation of rwr restart probability; added wget.py to get
      README-GSC.md.
hints:
  - class: DockerRequirement
    dockerPull: 'knowengdev/geneset_characterization_pipeline:07_26_2017'
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/genesetcharacterization/gsc-runner-copy/17/raw/
'sbg:id': mepstein/genesetcharacterization/gsc-runner-copy/17
'sbg:revision': 17
'sbg:modifiedOn': 1517197168
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1505406378
'sbg:createdBy': mepstein
'sbg:project': mepstein/genesetcharacterization
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 17
'sbg:content_hash': null
