hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: 'knowengdev/signature_analysis_pipeline:05_10_2018'
    dockerImageId: ''
'sbg:revisionNotes': Changed how wget.py called on command line.
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: CreateFileRequirement
    fileDef:
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
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

            str += "similarity_measure: " + $job.inputs.similarity_measure +
            "\n";


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


            var str2 = "cp -pr " + $job.inputs.spreadsheet_file.path + "
            clean_samples_matrix.tsv && cp -pr " +
            $job.inputs.signature_file.path + " clean_signatures_matrix.tsv";


            var str3 = "echo \"" + str + "\" > run_params.yml && " + str2 + " &&
            python3 /home/src/gene_signature.py -run_directory ./ -run_file
            run_params.yml";


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
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: Signature Analysis
temporaryFailCodes: []
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
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    signature_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/signature_file.ext
    similarity_measure: spearman
    num_bootstraps: 0
    parallelism: 4
    network_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/network_file.ext
    network_influence_percent: 50
    bootstrap_sample_percent: 80
    processing_method: serial
    spreadsheet_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/spreadsheet_file.ext
    use_network: false
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Similarity Matrix
    description: The signature similarity results
    outputBinding:
      glob: similarity_matrix.tsv
    id: '#similarity_matrix'
    type:
      - 'null'
      - File
  - label: SA Parameters File
    description: The Signature Analysis parameters
    outputBinding:
      glob: run_params.yml
    id: '#run_params_yml'
    type:
      - 'null'
      - File
  - label: Similarity Matrix Binary
    description: The signature similarity matrix (binary; one 1 per row/gene/feature)
    outputBinding:
      glob: similarity_matrix.binary.tsv
    id: '#similarity_matrix_binary'
    type:
      - 'null'
      - File
  - label: Clean Samples File
    type:
      - 'null'
      - File
    id: '#clean_samples_file'
    outputBinding:
      glob: clean_samples_matrix.tsv
    description: The clean samples file
  - label: Clean Signatures File
    type:
      - 'null'
      - File
    id: '#clean_signatures_file'
    outputBinding:
      glob: clean_signatures_matrix.tsv
    description: The clean signatures file
  - label: The README file
    type:
      - 'null'
      - File
    id: '#readme'
    outputBinding:
      glob: README-SA.md
    description: The README file that describes the output files
'sbg:cmdPreview': >-
  sh run_sa.cmd && cp -pr result*.tsv similarity_matrix.tsv && cp -pr
  Gene_to_TF_Association*.tsv similarity_matrix.binary.tsv && python3 wget.py
  https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-SA.md
  README-SA.md
description: >-
  Calls the KnowEnG Signature Analysis pipeline.


  Note: In the current implementation of Signature Analysis, the only mode
  available is non-network, non-bootstrapping.  That means that the tool behaves
  as if the input parameters use_network is false and num_bootstraps is 0, and
  the input file network_file and the input parameters
  network_influence_percent, bootstrap_sample_percent, processing_method, and
  parallelism are ignored.  (These inputs are still present; this behavior is
  set in the javascript that generates run_sa.cmd.)


  In summary, the only inputs that are used are the input files spreadsheet_file
  and signature_file and the input parameter similarity_measure.
'sbg:projectName': KnowEnG_Signature_Analysis_Dev
class: CommandLineTool
'sbg:image_url': null
inputs:
  - label: Spreadsheet File
    description: The input spreadsheet file
    id: '#spreadsheet_file'
    type:
      - 'null'
      - File
  - label: Signature File
    description: The input signature file
    id: '#signature_file'
    type:
      - 'null'
      - File
  - label: Similarity Measure
    id: '#similarity_measure'
    description: 'The similarity measure (e.g., cosine, pearson, or spearman)'
    type:
      - 'null'
      - symbols:
          - cosine
          - pearson
          - spearman
        name: similarity_measure
        type: enum
  - label: Use Network Flag
    id: '#use_network'
    'sbg:stageInput': null
    description: Whether to use the network
    type:
      - 'null'
      - boolean
  - label: Knowledge Network File
    description: The knowledge network file
    id: '#network_file'
    type:
      - 'null'
      - File
  - 'sbg:toolDefaultValue': '50'
    label: Amount of Network Influence
    description: >-
      The amount of network influence (as a percent; default 50%); a greater
      value means greater contribution from the network interactions
    'sbg:stageInput': null
    id: '#network_influence_percent'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': '0'
    label: Number of Bootstraps
    description: 'The number of bootstraps (default: 0)'
    'sbg:stageInput': null
    id: '#num_bootstraps'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': '80'
    label: Bootstrap Sample Percent
    description: 'The bootstrap sample percent (default: 80%)'
    'sbg:stageInput': null
    id: '#bootstrap_sample_percent'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': serial
    label: The processing method
    description: 'The processing method (e.g., serial or parallel, default: serial)'
    'sbg:stageInput': null
    id: '#processing_method'
    type:
      - 'null'
      - symbols:
          - serial
          - parallel
        name: processing_method
        type: enum
  - 'sbg:toolDefaultValue': '4'
    label: parallelism
    description: 'The parallelism (if the processing method is parallel; default: 4)'
    'sbg:stageInput': null
    id: '#parallelism'
    type:
      - 'null'
      - int
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1520542501
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1520544005
    'sbg:revisionNotes': Initial version.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1520544423
    'sbg:revisionNotes': Fixed glob value on results file.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1520577053
    'sbg:revisionNotes': Modified the default behavior (with regard to certain inputs).
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1521661999
    'sbg:revisionNotes': >-
      Modified run_sa.cmd javascript to run SA in only one mode (non-network,
      non-bootstrapping); added similarity map binary matrix output.
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1522291013
    'sbg:revisionNotes': Modified mbm.py to handle empty spreadsheets.
  - 'sbg:revision': 6
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1524106105
    'sbg:revisionNotes': Updated version of SAP container.
  - 'sbg:revision': 7
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526407664
    'sbg:revisionNotes': >-
      Updated a few things (docker container, output for binary similarity
      matrix, ...).
  - 'sbg:revision': 8
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526482172
    'sbg:revisionNotes': Added outputs for clean samples and signatures files.
  - 'sbg:revision': 9
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526484932
    'sbg:revisionNotes': Modified documentation to include new similar measure (pearson).
  - 'sbg:revision': 10
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526486122
    'sbg:revisionNotes': Fixed js syntax error (missing +).
  - 'sbg:revision': 11
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526540717
    'sbg:revisionNotes': Added call to wget.py.
  - 'sbg:revision': 12
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526540795
    'sbg:revisionNotes': Added readme output file.
  - 'sbg:revision': 13
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1526542156
    'sbg:revisionNotes': Changed how wget.py called on command line.
'sbg:publisher': sbg
stdin: ''
successCodes: []
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-signature-analysis-dev/signature-analysis/13/raw/
'sbg:id': mepstein/knoweng-signature-analysis-dev/signature-analysis/13
'sbg:revision': 13
'sbg:modifiedOn': 1526542156
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1520542501
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-signature-analysis-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 13
'sbg:content_hash': null
