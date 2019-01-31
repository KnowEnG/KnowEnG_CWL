hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: 'knowengdev/samples_clustering_pipeline:04_09_2018'
    dockerImageId: ''
'sbg:revisionNotes': Copy of mepstein/knoweng-samples-clustering-dev/samples-clustering/11
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


            str += "spreadsheet_name_full_path: " +
            $job.inputs.spreadsheet_file.path + "\n";

            //str += "phenotype_name_full_path: " +
            $job.inputs.phenotype_file.path + "\n";

            if ($job.inputs.phenotype_file) {
                str += "phenotype_name_full_path: " + $job.inputs.phenotype_file.path + "\n";
            }


            str += "results_directory: ./\n";

            str += "tmp_directory: ./tmp\n";


            str += "number_of_clusters: " + $job.inputs.number_of_clusters +
            "\n";

            str += "threshold: 15\n";

            str += "nmf_conv_check_freq: 50\n";

            str += "nmf_max_invariance: 200\n";

            str += "nmf_max_iterations: 10000\n";

            str += "nmf_penalty_parameter: 1400\n";


            //str += "top_number_of_genes: 100\n";

            if ($job.inputs.number_of_top_genes &&
                $job.inputs.number_of_top_genes >= 0) {
                str += "top_number_of_genes: " + $job.inputs.number_of_top_genes + "\n";
            }

            else {
                str += "top_number_of_genes: 100\n";
            }


            method = "nmf";


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
                method = "cc_" + method;
                str += "number_of_bootstraps: " + $job.inputs.num_bootstraps + "\n";
                str += "rows_sampling_fraction: 1.0\n";
                //str += "cols_sampling_fraction: 0.8\n";
                if ($job.inputs.bootstrap_sample_percent &&
                    $job.inputs.bootstrap_sample_percent >= 0 && $job.inputs.bootstrap_sample_percent <= 100) {
                    //str += "rows_sampling_fraction: " + $job.inputs.bootstrap_sample_percent/100 + "\n";
                    str += "cols_sampling_fraction: " + $job.inputs.bootstrap_sample_percent/100 + "\n";
                }
                else {
                    //str += "rows_sampling_fraction: 0.8\n";
                    str += "cols_sampling_fraction: 0.8\n";
                }
                // processing_method: serial or parallel
                //str += "processing_method: " + $job.inputs.processing_method + "\n";
                if ($job.inputs.processing_method && 
                    $job.inputs.processing_method == "parallel") {
                    str += "processing_method: " + $job.inputs.processing_method + "\n";
                    if ($job.inputs.parallelism &&
                        $job.inputs.parallelism >= 0) {
                        str += "parallelism: " + $job.inputs.parallelism + "\n";
                    }
                    else {
                        str += "parallelism: 4\n";
                    }
                    //str += "cluster_shared_volumn: none\n";
                }
                else {
                    str += "processing_method: serial\n";
                }
            }


            str += "method: " + method + "\n";



            str2 = "echo \"" + str + "\" > run_params.yml && python3
            /home/src/samples_clustering.py -run_directory ./ -run_file
            run_params.yml";


            str2;
        filename: run_sc.cmd
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
          script: >

            var str = "";


            //str += "cp -p samples_label_by_cluster*
            sample_labels_by_cluster.txt\n";

            str += "echo '\\tcluster_assignment' >
            sample_labels_by_cluster.txt\n";

            str += "cat samples_label_by_cluster* >>
            sample_labels_by_cluster.txt\n";

            str += "cp -p consensus_matrix* consensus_matrix.txt\n";

            //str += "cp -p genes_averages_by_cluster*
            gene_avgs_by_cluster.txt\n";

            //str += "cp -p top_genes_by_cluster* top_genes_by_cluster.txt\n";

            if ($job.inputs.node_map_file) {
                str += "python3 map_net_genes.py -f genes_averages_by_cluster* -n " + $job.inputs.spreadsheet_file.path + " -m " + $job.inputs.node_map_file.path + " -o gene_avgs_by_cluster.txt\n";
                str += "python3 map_net_genes.py -f top_genes_by_cluster* -n " + $job.inputs.spreadsheet_file.path + " -m " + $job.inputs.node_map_file.path + " -o top_genes_by_cluster.txt\n";
            }

            else {
                str += "cp -p genes_averages_by_cluster* gene_avgs_by_cluster.txt\n";
                str += "cp -p top_genes_by_cluster* top_genes_by_cluster.txt\n";
            }


            //str += "cp -p clustering_evaluation_result*
            clustering_evaluations.txt\n";

            str += "if [ -f clustering_evaluation_result* ]; then\n";

            str += "    cp -p clustering_evaluation_result*
            clustering_evaluations.txt\n";

            str += "fi\n";


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
      - fileContent: >-
          #!/usr/bin/env python3


          # ./map_net_genes.py -f _7_gene_avgs_by_cluster.txt -n _5_gene_map.txt
          -m 9606.STRING_experimental.node_map -o Z1

          # /map_net_genes.py -f _7_top_genes_by_cluster.txt -n _5_gene_map.txt
          -m 9606.STRING_experimental.node_map -o Z2


          FILE = '_7_gene_avgs_by_cluster.txt'

          #FILE = '_7_top_genes_by_cluster.txt'


          # Either one of these will work

          USER_NODES_FILE = '_5_gene_map.txt'

          #USER_NODES_FILE = '_5_clean_genomic_matrix.txt'


          NODE_MAP_FILE = '9606.STRING_experimental.node_map'


          import argparse


          def parse_args():
              parser = argparse.ArgumentParser()
              parser.add_argument('-f', '--file', required=True)
              parser.add_argument('-n', '--user_nodes_file', required=True)
              parser.add_argument('-m', '--node_map_file', required=True)
              parser.add_argument('-o', '--output_filename', required=True)
              args = parser.parse_args()
              return args

          def read_user_nodes(user_nodes_file):
              user_nodes = {}
              with open(user_nodes_file, 'r') as f:
                  for line in f:
                      fields = line.rstrip().split(sep="\t")
                      node = fields[0]
                      if node:
                          user_nodes[node] = 1
              return user_nodes

          def read_node_map(node_map_file):
              node_map = {}
              with open(node_map_file, 'r') as f:
                  for line in f:
                      fields = line.rstrip().split(sep="\t")
                      orig = fields[0]
                      mapped = fields[3]
                      node_map[orig] = mapped
              return node_map

          def map_file(map_file, user_nodes, node_map, output_filename):
              lines = []
              with open(map_file, 'r') as f:
                  for line in f:
                      fields = line.rstrip().split(sep="\t")
                      node = fields[0]
                      if not node:
                          #print(line, end="")
                          lines.append(line)
                          continue
                      if node in user_nodes:
                          #print(line, end="")
                          lines.append(line)
                          continue
                      if node not in node_map:
                          raise RuntimeError("Node not in node map (%s)" % (node))
                      #print(node)
                      fields[0] = node_map[node]
                      #print("\t".join(fields))
                      lines.append("\t".join(fields) + "\n")
              with open(output_filename, 'w') as f:
                  print("".join(lines), file=f, end="")

          def main():
              args = parse_args()
              #args.file = FILE
              #args.user_nodes_file = USER_NODES_FILE
              #args.node_map_file = NODE_MAP_FILE

              user_nodes = read_user_nodes(args.user_nodes_file)
              node_map = read_node_map(args.node_map_file)
              map_file(args.file, user_nodes, node_map, args.output_filename)

          if __name__ == "__main__":
              main()
        filename: map_net_genes.py
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: Samples Clustering
temporaryFailCodes: []
baseCommand:
  - sh
  - run_sc.cmd
  - '&&'
  - sh
  - file_renamer.cmd
  - '&&'
  - python3
  - wget.py
  - >-
    https://raw.githubusercontent.com/KnowEnG/quickstart-demos/573a3a09c46929083994a285497d1f43016aa1a6/pipeline_readmes/README-SC.md
  - README-SC.md
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    number_of_top_genes: 100
    parallelism: 4
    network_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/network_file.ext
    phenotype_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/phenotype_file.ext
    bootstrap_sample_percent: 79
    processing_method: serial
    spreadsheet_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/spreadsheet_file.ext
    number_of_clusters: 11
    network_influence_percent: 50
    num_bootstraps: 8
    node_map_file:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/node_map_file.ext
    use_network: false
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Sample Labels
    id: '#sample_labels'
    type:
      - 'null'
      - File
    outputBinding:
      glob: sample_labels_by_cluster.txt
    description: Sample labels by cluster
  - label: Consensus Matrix
    id: '#consensus_matrix'
    type:
      - 'null'
      - File
    outputBinding:
      glob: consensus_matrix.txt
    description: Consensus matrix
  - label: Gene Averages
    id: '#gene_avgs'
    type:
      - 'null'
      - File
    outputBinding:
      glob: gene_avgs_by_cluster.txt
    description: Gene averages by cluster
  - label: Top Genes
    id: '#top_genes'
    type:
      - 'null'
      - File
    outputBinding:
      glob: top_genes_by_cluster.txt
    description: Top genes by cluster
  - label: Clustering Evaluations
    id: '#clustering_evaluations'
    type:
      - 'null'
      - File
    outputBinding:
      glob: clustering_evaluations.txt
    description: Clustering evaluations
  - label: Configuration Parameters File
    id: '#run_params_yml'
    type:
      - 'null'
      - File
    outputBinding:
      glob: run_params.yml
    description: The configuration parameters specified for the SC run
  - label: The README file
    id: '#readme'
    type:
      - 'null'
      - File
    outputBinding:
      glob: README-SC.md
    description: The README file that describes the output files
'sbg:cmdPreview': >-
  sh run_sc.cmd && sh file_renamer.cmd && python3 wget.py
  https://raw.githubusercontent.com/KnowEnG/quickstart-demos/573a3a09c46929083994a285497d1f43016aa1a6/pipeline_readmes/README-SC.md
  README-SC.md
description: ''
'sbg:projectName': KnowEnG_Samples_Clustering_Demo
class: CommandLineTool
'sbg:image_url': null
inputs:
  - label: Genomic Spreadsheet File
    type:
      - File
    description: The genomic spreadsheet file
    id: '#spreadsheet_file'
  - label: Phenotype File
    type:
      - 'null'
      - File
    description: The phenotype spreadsheet file
    id: '#phenotype_file'
  - label: Knowledge Network File
    type:
      - 'null'
      - File
    description: The knowledge network file
    id: '#network_file'
  - label: Number of Clusters
    id: '#number_of_clusters'
    'sbg:stageInput': null
    description: The number of clusters
    type:
      - int
  - 'sbg:toolDefaultValue': '100'
    label: Number of Top Genes
    description: The number of top genes to find
    'sbg:stageInput': null
    id: '#number_of_top_genes'
    type:
      - 'null'
      - int
  - 'sbg:toolDefaultValue': 'False'
    label: Use Network Flag
    description: Whether to use the network
    'sbg:stageInput': null
    id: '#use_network'
    type:
      - 'null'
      - boolean
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
  - label: Processing Method
    id: '#processing_method'
    'sbg:stageInput': null
    description: 'The processing method (e.g., serial or parallel, default: serial)'
    type:
      - 'null'
      - symbols:
          - serial
          - parallel
        name: processing_method
        type: enum
  - 'sbg:toolDefaultValue': '4'
    label: Parallelism
    description: 'The parallelism (if the processing method is parallel; default: 4)'
    'sbg:stageInput': null
    id: '#parallelism'
    type:
      - 'null'
      - int
  - label: The Node Map File
    type:
      - 'null'
      - File
    id: '#node_map_file'
    description: The node map file (from the KN Fetcher)
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529391221
    'sbg:revisionNotes': Copy of mepstein/knoweng-samples-clustering-dev/samples-clustering/11
'sbg:publisher': sbg
stdin: ''
successCodes: []
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-samples-clustering-demo/samples-clustering/0/raw/
'sbg:id': mepstein/knoweng-samples-clustering-demo/samples-clustering/0
'sbg:revision': 0
'sbg:modifiedOn': 1529391221
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529391221
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-samples-clustering-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-samples-clustering-dev/samples-clustering/11
