hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: 'knowengdev/gene_prioritization_pipeline:07_26_2017'
    dockerImageId: ''
'sbg:revisionNotes': Modified URL passed to wget (to get older version of README-GP.md).
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: CreateFileRequirement
    fileDef:
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
          script: >

            str = "";


            str += "correlation_measure: " + $job.inputs.correlation_measure +
            "\n";

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
            /home/src/gene_prioritization.py -run_directory ./ -run_file
            run_params.yml";


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
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: ProGENI
temporaryFailCodes: []
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
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    drug_response_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/drug_response_file.ext
    number_of_top_genes: 5
    network_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/network_file.ext
    network_influence_percent: 10
    bootstrap_sample_percent: 2
    spreadsheet_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/spreadsheet_file.ext
    num_bootstraps: 10
    correlation_measure: correlation_method-string-value
    use_network: true
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - type:
      - 'null'
      - items: File
        type: array
    outputBinding:
      glob: '*bootstrap_net_correlation*'
    id: '#output_name'
  - label: Genes Ranked File
    description: The genes ranked file
    type:
      - 'null'
      - File
    outputBinding:
      glob: genes_ranked_per_phenotype.txt
    id: '#genes_ranked_file'
  - label: Top Genes File
    description: The top genes file
    type:
      - 'null'
      - File
    outputBinding:
      glob: top_genes_per_phenotype_matrix.txt
    id: '#top_genes_file'
  - label: The README file
    description: The README file that describes the output files
    type:
      - 'null'
      - File
    outputBinding:
      glob: README-GP.md
    id: '#readme'
  - label: Configuration Parameters File
    description: The configuration parameters specified for the GP run
    type:
      - 'null'
      - File
    outputBinding:
      glob: run_params.yml
    id: '#run_params_yml'
inputs:
  - label: Knowledge Network File
    type:
      - 'null'
      - File
    'sbg:stageInput': link
    description: The knowledge network file
    id: '#network_file'
  - label: Genomic Spreadsheet File
    type:
      - File
    'sbg:stageInput': link
    description: The genomic spreadsheet file
    id: '#spreadsheet_file'
  - label: Drug Response File
    type:
      - File
    'sbg:stageInput': link
    description: The drug response file
    id: '#drug_response_file'
  - label: Correlation Measure
    type:
      - string
    id: '#correlation_measure'
    description: 'The correlation measure (e.g., t_test or pearson)'
  - 'sbg:toolDefaultValue': '0'
    label: Number of Bootstraps
    description: The number of bootstraps
    id: '#num_bootstraps'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': 'False'
    label: Use Network Flag
    description: Whether to use the network
    id: '#use_network'
    type:
      - 'null'
      - boolean
  - 'sbg:toolDefaultValue': '100'
    label: Number of Top Genes
    description: The number of top genes to find
    'sbg:stageInput': null
    id: '#number_of_top_genes'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': '50'
    label: Amount of Network Influence
    description: >-
      The amount of network influence (as a percent; default 50%); a greater
      value means greater contribution from the network interactions
    id: '#network_influence_percent'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': '80'
    label: Bootstrap Sample Percent
    description: The bootstrap sample percent
    'sbg:stageInput': null
    id: '#bootstrap_sample_percent'
    type:
      - 'null'
      - int
'sbg:cmdPreview': >-
  sh run_gp.cmd && sh create_ranked_genes.sh ./ genes_ranked_per_phenotype.txt
  top_genes_per_phenotype_matrix.txt && python3 wget.py
  https://raw.githubusercontent.com/KnowEnG/quickstart-demos/f93695fdd5d603412e6b3d4e7a74e6f2a079929f/pipeline_readmes/README-GP.md
  README-GP.md
description: >-
  Network-guided gene prioritization method implementation by KnowEnG that ranks
  gene measurements by their correlation to observed phenotypes.
'sbg:projectName': KnowEnG_GenePrioritization_Dev
class: CommandLineTool
'sbg:image_url': null
successCodes: []
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1513885139
    'sbg:revisionNotes': Copy of mepstein/geneprioritization/gene-prioritization/2
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1516259479
    'sbg:revisionNotes': null
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1516301429
    'sbg:revisionNotes': null
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1516396315
    'sbg:revisionNotes': Added additional output files.
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1516410509
    'sbg:revisionNotes': Using python3 wget.py instead of perl wget.pl.
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1516553866
    'sbg:revisionNotes': Changed wget.py to use urllib.
  - 'sbg:revision': 6
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1516918772
    'sbg:revisionNotes': 'Updated documentation/required/defaults on inputs, updated run_gp.cmd.'
  - 'sbg:revision': 7
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522899220
    'sbg:revisionNotes': Modified URL passed to wget (to get older version of README-GP.md).
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-dev/gene-prioritization/7/raw/
'sbg:id': mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
'sbg:revision': 7
'sbg:modifiedOn': 1522899220
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1513885139
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 7
'sbg:content_hash': null
