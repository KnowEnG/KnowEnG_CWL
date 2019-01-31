class: Workflow
steps:
  - id: '#Gene_Set_Characterization_Parameters'
    run:
      hints:
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
        - class: DockerRequirement
          dockerPull: ubuntu
          dockerImageId: ''
      'sbg:revisionNotes': >-
        Copy of
        mepstein/genesetcharacterization/gene-set-characterization-parameters/5
      'sbg:modifiedOn': 1512041611
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 346.2497055977747
      'sbg:publisher': sbg
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': viktorian_miok
      label: Gene Set Characterization Parameters
      stdout: ''
      temporaryFailCodes: []
      'y': 495.01529136208785
      'sbg:id': >-
        mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
      'sbg:latestRevision': 0
      baseCommand:
        - ''
      id: >-
        mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
      'sbg:job':
        inputs:
          knowledge_network_edge_type: knowlege_network_edge_type-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        Sets the input parameters of some of the intermediate apps in the GSC
        workflow based on some of the input parameters to the workflow itself.
      outputs:
        - label: GSC Method
          description: 'The GSC method to use (e.g., DRaWR, fisher)'
          type:
            - 'null'
            - string
          id: '#gsc_method'
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                if ($job.inputs.knowledge_network_edge_type) {
                    gsc_method = "DRaWR";
                }
                else {
                    gsc_method = "fisher";
                }

                gsc_method;
        - label: Get Network Flag
          description: Whether to get the network
          type:
            - 'null'
            - boolean
          id: '#get_network'
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                if ($job.inputs.knowledge_network_edge_type) {
                    get_network = true;
                }
                else {
                    get_network = false;
                }

                get_network;
        - label: Network Edge Type
          description: The network edge type
          type:
            - 'null'
            - string
          id: '#edge_type'
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                $job.inputs.knowledge_network_edge_type;
      'sbg:modifiedBy': viktorian_miok
      'sbg:revision': 0
      'sbg:copyOf': mepstein/genesetcharacterization/gene-set-characterization-parameters/5
      'sbg:projectName': KnowEnG_GeneSetCharacterization
      'sbg:project': mepstein/knoweng-genesetcharacterization
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1512041611
      'sbg:contributors':
        - viktorian_miok
      'sbg:sbgMaintained': false
      appUrl: >-
        /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/gene-set-characterization-parameters/0
      inputs:
        - label: Knowledge Network Edge Type
          description: The knowledge network edge type (not required)
          'sbg:includeInPorts': true
          id: '#knowledge_network_edge_type'
          required: false
          type:
            - 'null'
            - string
      successCodes: []
      'sbg:cmdPreview': ''
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': viktorian_miok
          'sbg:revisionNotes': >-
            Copy of
            mepstein/genesetcharacterization/gene-set-characterization-parameters/5
          'sbg:modifiedOn': 1512041611
          'sbg:revision': 0
    inputs:
      - id: '#Gene_Set_Characterization_Parameters.knowledge_network_edge_type'
        source:
          - '#gg_edge_type'
    outputs:
      - id: '#Gene_Set_Characterization_Parameters.gsc_method'
      - id: '#Gene_Set_Characterization_Parameters.get_network'
      - id: '#Gene_Set_Characterization_Parameters.edge_type'
    'sbg:x': 346.2497055977747
    'sbg:y': 495.01529136208785
  - id: '#Join_Names'
    run:
      hints:
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
        - class: DockerRequirement
          dockerPull: 'cblatti3/py3_slim:0.1'
          dockerImageId: ''
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/join-names/4
      'sbg:modifiedOn': 1512042115
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 857.2497657984607
      'sbg:publisher': sbg
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent: >-
                #!/usr/bin/env python3



                """

                This program adds columns to a file by matching keys in a
                designated

                column of that file to keys/lines in another file.


                More specifically:

                This program takes two required arguments, a data_file (-f) and
                a name_map_file (-m).

                Each of these are delimiter-separated files (-d, default '\t').


                For the data_file, one column is designated as the data_column
                (-c, default 1).


                For the name_map_file, one column is designated as the
                key_column (-k, default 1).


                The program loops through the lines of the data_file, uses the
                data in

                the data_column as a key, finds that key in the name_map_file,
                and

                adds columns from that line of the name_map_file (starting at
                the

                add_column, -a, default 3) to the end of that line of the
                data_file.

                If the key is not found, columns of empty strings are added.


                It outputs (to stdout) this modified version of the data_file.

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


                def read_name_map_file(name_map_file, key_column, delimiter):
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
                class: Expression
                engine: '#cwl-js-engine'
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
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': viktorian_miok
      label: Join Names
      stdout:
        class: Expression
        engine: '#cwl-js-engine'
        script: $job.inputs.output_file_name
      temporaryFailCodes: []
      'y': 194.01553714182688
      'sbg:id': mepstein/knoweng-genesetcharacterization/join-names/0
      'sbg:latestRevision': 0
      baseCommand:
        - sh
        - file_renamer.cmd
        - '&&'
        - python3
        - join_names.py
      id: mepstein/knoweng-genesetcharacterization/join-names/0
      'sbg:job':
        inputs:
          data_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/data_file.ext
          name_map_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/name_map_file.ext
          output_file_name: output_file_name-string-value
          interaction_network_metadata_file:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/interaction_network_metadata_file.ext
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        This program adds columns to a file by matching keys in a designated
        column of that file to keys/lines in another file.
      outputs:
        - label: New Data File
          description: The new data file
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
              script: $job.inputs.output_file_name
          id: '#new_data_file'
          type:
            - 'null'
            - File
        - label: Name Map File
          description: The name map file
          outputBinding:
            glob: gene_set_name_map.txt
          id: '#name_map_file_out'
          type:
            - 'null'
            - File
        - label: Interaction Network Metadata File
          description: The interaction network metadata file
          outputBinding:
            glob: interaction_network.metadata
          id: '#interaction_network_metadata_file_out'
          type:
            - 'null'
            - File
      'sbg:modifiedBy': viktorian_miok
      'sbg:revision': 0
      'sbg:copyOf': mepstein/genesetcharacterization/join-names/4
      'sbg:projectName': KnowEnG_GeneSetCharacterization
      'sbg:project': mepstein/knoweng-genesetcharacterization
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1512042115
      'sbg:contributors':
        - viktorian_miok
      'sbg:sbgMaintained': false
      appUrl: >-
        /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/join-names/0
      inputs:
        - label: Output File Name
          id: '#output_file_name'
          description: The output file name
          required: true
          type:
            - string
        - label: Name Map File
          description: The name map file
          type:
            - File
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-m'
          id: '#name_map_file'
          required: true
          'sbg:fileTypes': TSV
        - label: Interaction Network Metadata File
          id: '#interaction_network_metadata_file'
          description: The interaction network metadata file
          required: false
          type:
            - 'null'
            - File
        - label: Data File
          description: The data file
          type:
            - File
          inputBinding:
            separate: true
            'sbg:cmdInclude': true
            prefix: '-f'
          id: '#data_file'
          required: true
          'sbg:fileTypes': TSV
      successCodes: []
      'sbg:cmdPreview': >-
        sh file_renamer.cmd && python3 join_names.py -f /path/to/data_file.ext
        -m /path/to/name_map_file.ext > output_file_name-string-value
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': viktorian_miok
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/join-names/4
          'sbg:modifiedOn': 1512042115
          'sbg:revision': 0
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
    outputs:
      - id: '#Join_Names.new_data_file'
      - id: '#Join_Names.name_map_file_out'
      - id: '#Join_Names.interaction_network_metadata_file_out'
    'sbg:x': 857.2497657984607
    'sbg:y': 194.01553714182688
  - id: '#Knowledge_Network_Fetcher_1'
    run:
      hints:
        - class: DockerRequirement
          dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
        - class: ResourceRequirement
          outdirMin: 512000
          coresMin: 1
          ramMin: 2000
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:modifiedOn': 1512037727
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 371.99973487855465
      'sbg:publisher': sbg
      requirements:
        - class: InlineJavascriptRequirement
        - class: ShellCommandRequirement
        - class: CreateFileRequirement
          fileDef:
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >
                  //MYCMD="date && if [ " + $job.inputs.get_network + ' = "true"
                  ]; then /home/kn_fetcher.sh '+$job.inputs.bucket+'
                  '+$job.inputs.network_type+' '+$job.inputs.taxonid+'
                  '+$job.inputs.edge_type+'; else touch empty.edge; fi && date'


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
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': viktorian_miok
      label: Knowledge Network Fetcher
      stdout: ''
      temporaryFailCodes: []
      'y': 82.26555809285858
      'sbg:id': mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
      'sbg:latestRevision': 0
      baseCommand:
        - sh
        - run_fetch.cmd
      id: mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        Fetch a knowledge network from an AWS S3 bucket, given a network type,
        an edge type, and a species taxon ID.
      outputs:
        - label: PNode Map File
          description: The pnode map file
          outputBinding:
            glob: '*.pnode_map'
          id: '#pnode_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
          type:
            - 'null'
            - File
        - label: Node Map File
          description: The node map file
          outputBinding:
            glob: '*.node_map'
          id: '#node_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
          type:
            - 'null'
            - File
        - label: Network Metadata File
          description: The network metadata file
          outputBinding:
            glob: '*.metadata'
          id: '#network_metadata_file'
          doc: yaml format describing network contents
          type:
            - 'null'
            - File
        - label: Network Edge File
          description: The network edge file
          outputBinding:
            glob: '*.edge'
          id: '#network_edge_file'
          doc: 4 column format for subnetwork for single edge type and species
          type:
            - 'null'
            - File
        - label: Command Log File
          description: The log of the fetch command
          outputBinding:
            glob: run_fetch.cmd
          id: '#cmd_log_file'
          doc: log of fetch command
          type:
            - 'null'
            - File
      'sbg:modifiedBy': viktorian_miok
      'sbg:revision': 0
      'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:projectName': KnowEnG_GeneSetCharacterization
      'sbg:project': mepstein/knoweng-genesetcharacterization
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1512037727
      'sbg:contributors':
        - viktorian_miok
      'sbg:sbgMaintained': false
      appUrl: >-
        /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          label: Network Species Taxon ID
          description: 'The network species taxon ID (e.g., 9606 for human)'
          doc: the taxonomic id for the species of interest
          type:
            - 'null'
            - string
          'sbg:includeInPorts': true
          id: '#taxonid'
          required: false
          default: '9606'
        - 'sbg:toolDefaultValue': Gene
          label: Network Type
          description: 'The network type (e.g., Gene, Property)'
          doc: the type of subnetwork
          type:
            - 'null'
            - string
          id: '#network_type'
          required: false
          default: Gene
        - 'sbg:toolDefaultValue': 'true'
          label: Get Network Flag
          description: Whether to get the network (or create a dummy/empty network file)
          doc: whether or not to get the network
          type:
            - 'null'
            - boolean
          id: '#get_network'
          required: false
          default: true
        - 'sbg:toolDefaultValue': STRING_experimental
          label: Network Edge Type
          description: 'The network edge type (e.g., STRING_experimental, gene_ontology)'
          doc: the edge type keyword for the subnetwork of interest
          type:
            - 'null'
            - string
          'sbg:includeInPorts': true
          id: '#edge_type'
          required: false
          default: PPI_physical_association
        - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
          label: AWS S3 Bucket Name
          description: The AWS S3 bucket to fetch the network from
          doc: the aws s3 bucket
          type:
            - 'null'
            - string
          id: '#bucket'
          required: false
          default: KnowNets/KN-20rep-1706/userKN-20rep-1706
      successCodes: []
      'sbg:cmdPreview': sh run_fetch.cmd
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': viktorian_miok
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
          'sbg:modifiedOn': 1512037727
          'sbg:revision': 0
      doc: >-
        Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS
        S3 storage
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
    outputs:
      - id: '#Knowledge_Network_Fetcher_1.pnode_map_file'
      - id: '#Knowledge_Network_Fetcher_1.node_map_file'
      - id: '#Knowledge_Network_Fetcher_1.network_metadata_file'
      - id: '#Knowledge_Network_Fetcher_1.network_edge_file'
      - id: '#Knowledge_Network_Fetcher_1.cmd_log_file'
    'sbg:x': 371.99973487855465
    'sbg:y': 82.26555809285858
  - id: '#Pipeline_Preprocessing'
    run:
      hints:
        - class: DockerRequirement
          dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
        - class: ResourceRequirement
          outdirMin: 512000
          coresMin: 1
          ramMin: 5000
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
      'sbg:modifiedOn': 1512038144
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 567.249511778382
      'sbg:publisher': sbg
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: InlineJavascriptRequirement
        - class: ShellCommandRequirement
        - class: CreateFileRequirement
          fileDef:
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >
                  str = ""


                  str += "pipeline_type: " + $job.inputs.pipeline_type + "\n";

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

                  //str2 = "echo \"" + str + "\" > run_cleanup.yml && touch
                  log_X_pipeline.yml && touch GX_ETL.tsv && touch PX_ETL.tsv &&
                  touch X_MAP.tsv && touch X_UNMAPPED.tsv"

                  str2 = "echo \"" + str + "\" > run_cleanup.yml && date &&
                  python3 /home/src/data_cleanup.py -run_directory ./ -run_file
                  run_cleanup.yml && date"


                  str2;
              filename: run_dc.cmd
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': viktorian_miok
      label: Data Cleaning/Preprocessing
      stdout: ''
      temporaryFailCodes: []
      'y': 252.0154585084038
      'sbg:id': mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
      'sbg:latestRevision': 0
      baseCommand:
        - sh
        - run_dc.cmd
      id: mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        Clean/preprocess input data (genomic and optionally phenotypic) for use
        with other tools/pipelines.
      outputs:
        - label: Gene Unmapped File
          description: The genes that were not mapped
          outputBinding:
            glob: '*_UNMAPPED.tsv'
          id: '#gene_unmap_file'
          doc: two columns for original gene ids and unmapped reason code
          type:
            - 'null'
            - File
        - label: Gene Map File
          description: The gene map file
          outputBinding:
            glob: '*_MAP.tsv'
          id: '#gene_map_file'
          doc: two columns for internal gene ids and original gene ids
          type:
            - 'null'
            - File
        - label: Command Log File
          description: The log of the data cleaning command
          outputBinding:
            glob: run_dc.cmd
          id: '#cmd_log_file'
          type:
            - 'null'
            - File
        - label: Cleaning Parameters File
          description: The configuration parameters specified for the data cleaning run
          outputBinding:
            glob: run_cleanup.yml
          id: '#cleaning_parameters_yml'
          doc: data cleaning parameters in yaml format
          type:
            - 'null'
            - File
        - label: Cleaning Log File
          description: The log of the data cleaning run
          outputBinding:
            glob: log_*_pipeline.yml
          id: '#cleaning_log_file'
          doc: information on souce of errors for cleaning pipeline
          type:
            - 'null'
            - File
        - label: Clean Phenotypic Spreadsheet
          description: The clean phenotypic spreadsheet
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
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
          id: '#clean_phenotypic_file'
          doc: phenotype file prepared for pipeline
          type:
            - 'null'
            - File
        - label: Clean Genomic Spreadsheet
          description: The clean genomic spreadsheet
          outputBinding:
            glob:
              class: Expression
              engine: '#cwl-js-engine'
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
          id: '#clean_genomic_file'
          doc: matrix with gene names mapped and data cleaned
          type:
            - 'null'
            - File
      'sbg:modifiedBy': viktorian_miok
      'sbg:revision': 0
      'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
      'sbg:projectName': KnowEnG_GeneSetCharacterization
      'sbg:project': mepstein/knoweng-genesetcharacterization
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1512038144
      'sbg:contributors':
        - viktorian_miok
      'sbg:sbgMaintained': false
      appUrl: >-
        /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/data-cleaning-copy/0
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          label: Species Taxon ID
          description: 'The species taxon ID (e.g., 9606 for human)'
          doc: taxon id of species related to genomic spreadsheet
          type:
            - 'null'
            - string
          'sbg:includeInPorts': true
          id: '#taxonid'
          required: false
          default: '9606'
        - 'sbg:toolDefaultValue': ''''''
          label: ID Source Hint
          description: The source hint for the redis queries (can be '')
          doc: >-
            suggestion for ID source database used to resolve ambiguities in
            mapping
          type:
            - 'null'
            - string
          id: '#source_hint'
          required: false
          default: \'\'
        - 'sbg:toolDefaultValue': 6379
          label: RedisDB Port
          description: The redis DB port
          doc: port for Redis db
          type:
            - 'null'
            - int
          id: '#redis_port'
          required: false
          default: 6379
        - 'sbg:toolDefaultValue': KnowEnG
          label: RedisDB Password
          description: The redis DB password
          doc: password for Redis db
          type:
            - 'null'
            - string
          id: '#redis_pass'
          required: false
          default: KnowEnG
        - 'sbg:toolDefaultValue': knowredis.knoweng.org
          label: RedisDB Host
          description: The redis DB host name
          doc: url of Redis db
          type:
            - 'null'
            - string
          id: '#redis_host'
          required: false
          default: knowredis.knoweng.org
        - label: Name of Pipeline
          description: >-
            The name of the pipeline that will be run (i.e., data cleaning is
            pipeline-specific)
          doc: >-
            keywork name of pipeline from following list
            ['gene_prioritization_pipeline', 'samples_clustering_pipeline',
            'geneset_characterization_pipeline']
          id: '#pipeline_type'
          required: true
          type:
            - string
        - 'sbg:toolDefaultValue':
            class: File
            location: /bin/sh
          label: Phenotypic Spreadsheet File (optional)
          description: The phenotypic spreadsheet file (optional)
          doc: 'the phenotypic spreadsheet input for the pipeline [may be optional]'
          type:
            - 'null'
            - File
          id: '#phenotypic_spreadsheet_file'
          required: false
          default:
            class: File
            location: /bin/sh
        - label: Genomic Spreadsheet File
          description: The genomic spreadsheet file
          doc: the genomic spreadsheet input for the pipeline
          id: '#genomic_spreadsheet_file'
          required: true
          type:
            - File
        - 'sbg:toolDefaultValue': missing
          label: GP Correlation Measure
          description: 'The correlation measure to be used for GP (e.g., t_test or pearson)'
          doc: >-
            if pipeline_type=='gene_prioritization_pipeline', then must be one
            of either ['t_test', 'pearson']
          type:
            - 'null'
            - string
          id: '#gene_prioritization_corr_measure'
          required: false
          default: missing
      successCodes: []
      'sbg:cmdPreview': sh run_dc.cmd
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': viktorian_miok
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
          'sbg:modifiedOn': 1512038144
          'sbg:revision': 0
      doc: checks the inputs of a pipeline for potential sources of errors
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
    outputs:
      - id: '#Pipeline_Preprocessing.gene_unmap_file'
      - id: '#Pipeline_Preprocessing.gene_map_file'
      - id: '#Pipeline_Preprocessing.cmd_log_file'
      - id: '#Pipeline_Preprocessing.cleaning_parameters_yml'
      - id: '#Pipeline_Preprocessing.cleaning_log_file'
      - id: '#Pipeline_Preprocessing.clean_phenotypic_file'
      - id: '#Pipeline_Preprocessing.clean_genomic_file'
    'sbg:x': 567.249511778382
    'sbg:y': 252.0154585084038
  - id: '#Knowledge_Network_Fetcher'
    run:
      hints:
        - class: DockerRequirement
          dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
        - class: ResourceRequirement
          outdirMin: 512000
          coresMin: 1
          ramMin: 2000
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:modifiedOn': 1512037727
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 582.4998470097854
      requirements:
        - class: InlineJavascriptRequirement
        - class: ShellCommandRequirement
        - class: CreateFileRequirement
          fileDef:
            - fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >
                  //MYCMD="date && if [ " + $job.inputs.get_network + ' = "true"
                  ]; then /home/kn_fetcher.sh '+$job.inputs.bucket+'
                  '+$job.inputs.network_type+' '+$job.inputs.taxonid+'
                  '+$job.inputs.edge_type+'; else touch empty.edge; fi && date'


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
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': viktorian_miok
      label: Knowledge Network Fetcher
      stdout: ''
      temporaryFailCodes: []
      'y': 641.2693711060639
      'sbg:id': mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
      'sbg:latestRevision': 0
      baseCommand:
        - sh
        - run_fetch.cmd
      id: mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      description: >-
        Fetch a knowledge network from an AWS S3 bucket, given a network type,
        an edge type, and a species taxon ID.
      outputs:
        - label: PNode Map File
          description: The pnode map file
          outputBinding:
            glob: '*.pnode_map'
          id: '#pnode_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
          type:
            - 'null'
            - File
        - label: Node Map File
          description: The node map file
          outputBinding:
            glob: '*.node_map'
          id: '#node_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
          type:
            - 'null'
            - File
        - label: Network Metadata File
          description: The network metadata file
          outputBinding:
            glob: '*.metadata'
          id: '#network_metadata_file'
          doc: yaml format describing network contents
          type:
            - 'null'
            - File
        - label: Network Edge File
          description: The network edge file
          outputBinding:
            glob: '*.edge'
          id: '#network_edge_file'
          doc: 4 column format for subnetwork for single edge type and species
          type:
            - 'null'
            - File
        - label: Command Log File
          description: The log of the fetch command
          outputBinding:
            glob: run_fetch.cmd
          id: '#cmd_log_file'
          doc: log of fetch command
          type:
            - 'null'
            - File
      'sbg:modifiedBy': viktorian_miok
      'sbg:revision': 0
      'sbg:cmdPreview': sh run_fetch.cmd
      'sbg:projectName': KnowEnG_GeneSetCharacterization
      'sbg:project': mepstein/knoweng-genesetcharacterization
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1512037727
      'sbg:contributors':
        - viktorian_miok
      'sbg:sbgMaintained': false
      appUrl: >-
        /u/mepstein/knoweng-genesetcharacterization/apps/#mepstein/knoweng-genesetcharacterization/kn-fetcher-cb/0
      'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          label: Network Species Taxon ID
          description: 'The network species taxon ID (e.g., 9606 for human)'
          doc: the taxonomic id for the species of interest
          type:
            - 'null'
            - string
          'sbg:includeInPorts': true
          id: '#taxonid'
          required: false
          default: '9606'
        - 'sbg:toolDefaultValue': Gene
          label: Network Type
          description: 'The network type (e.g., Gene, Property)'
          doc: the type of subnetwork
          type:
            - 'null'
            - string
          id: '#network_type'
          required: false
          default: Gene
        - 'sbg:toolDefaultValue': 'true'
          label: Get Network Flag
          description: Whether to get the network (or create a dummy/empty network file)
          doc: whether or not to get the network
          type:
            - 'null'
            - boolean
          'sbg:includeInPorts': true
          id: '#get_network'
          required: false
          default: true
        - 'sbg:toolDefaultValue': STRING_experimental
          label: Network Edge Type
          description: 'The network edge type (e.g., STRING_experimental, gene_ontology)'
          doc: the edge type keyword for the subnetwork of interest
          type:
            - 'null'
            - string
          'sbg:includeInPorts': true
          id: '#edge_type'
          required: false
          default: PPI_physical_association
        - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
          label: AWS S3 Bucket Name
          description: The AWS S3 bucket to fetch the network from
          doc: the aws s3 bucket
          type:
            - 'null'
            - string
          id: '#bucket'
          required: false
          default: KnowNets/KN-20rep-1706/userKN-20rep-1706
      successCodes: []
      'sbg:publisher': sbg
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': viktorian_miok
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
          'sbg:modifiedOn': 1512037727
          'sbg:revision': 0
      doc: >-
        Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS
        S3 storage
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
    outputs:
      - id: '#Knowledge_Network_Fetcher.pnode_map_file'
      - id: '#Knowledge_Network_Fetcher.node_map_file'
      - id: '#Knowledge_Network_Fetcher.network_metadata_file'
      - id: '#Knowledge_Network_Fetcher.network_edge_file'
      - id: '#Knowledge_Network_Fetcher.cmd_log_file'
    'sbg:x': 582.4998470097854
    'sbg:y': 641.2693711060639
  - id: '#Gene_Set_Characterization'
    run:
      hints:
        - class: DockerRequirement
          dockerPull: 'knowengdev/geneset_characterization_pipeline:07_26_2017'
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/17
      'sbg:modifiedOn': 1517261405
      'sbg:appVersion':
        - 'sbg:draft-2'
      cwlVersion: 'sbg:draft-2'
      x: 740.2494721412951
      'sbg:publisher': sbg
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
                  $job.inputs.genomic_file.path + " | awk '{print
                  \$1\"\\t\"\$1}' > dummy.map && python3
                  /home/src/geneset_characterization.py -run_directory ./
                  -run_file run_params.yml";


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
      'sbg:validationErrors': []
      'sbg:createdBy': viktorian_miok
      label: Gene Set Characterization
      stdout: ''
      temporaryFailCodes: []
      'y': 450.0153550794495
      'sbg:id': mepstein/knoweng-genesetcharacterization/gsc-runner-copy/1
      'sbg:latestRevision': 1
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
      id: mepstein/knoweng-genesetcharacterization/gsc-runner-copy/1
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
      'sbg:sbgMaintained': false
      outputs:
        - label: Configuration Parameters File
          description: The configuration parameters specified for the GSC run
          outputBinding:
            glob: run_params.yml
          id: '#run_params_yml'
          doc: contains the values used in analysis
          type:
            - 'null'
            - File
        - label: The README file
          description: The README file that describes the output files
          type:
            - 'null'
            - File
          id: '#readme'
          outputBinding:
            glob: README-GSC.md
        - label: Genomic Spreadsheet File
          description: The clean genomic spreadsheet
          type:
            - 'null'
            - File
          id: '#genomic_file_out'
          outputBinding:
            glob: clean_gene_set_matrix.txt
        - label: Gene Map File
          description: The gene map file
          type:
            - 'null'
            - File
          id: '#gene_map_file_out'
          outputBinding:
            glob: gene_map.txt
        - label: GSC Enrichment Scores
          description: GSC enrichment scores
          outputBinding:
            glob: '*_sorted_by_property_score_*'
          id: '#enrichment_scores'
          doc: >-
            Edge format file with first three columns (user gene set, public
            gene set, score)
          type:
            - 'null'
            - File
        - label: Command Log File
          description: The log of the GSC run command
          type:
            - 'null'
            - File
          id: '#cmd_log_file'
          outputBinding:
            glob: run_gr.cmd
      'sbg:modifiedBy': mepstein
      'sbg:revision': 1
      'sbg:copyOf': mepstein/genesetcharacterization/gsc-runner-copy/17
      'sbg:projectName': KnowEnG_GeneSetCharacterization_Demo
      'sbg:project': mepstein/knoweng-genesetcharacterization
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1512041775
      'sbg:contributors':
        - viktorian_miok
        - mepstein
      description: >-
        Test a gene set for enrichment against a large compendium of
        annotations.
      inputs:
        - label: Gene Set Property Network File
          description: The gene set property network file
          doc: property-gene network of interactions in edge format
          id: '#pg_network_file'
          required: true
          type:
            - File
        - 'sbg:toolDefaultValue': '50'
          label: Amount of Network Smoothing
          description: >-
            The amount of network smoothing (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          'sbg:includeInPorts': true
          id: '#network_smoothing_percent'
          required: false
          type:
            - 'null'
            - int
        - label: GSC Method
          description: 'The GSC method to use (e.g., DRaWR, fisher)'
          doc: 'which method to use for GSC, i.e. DRaWR, fisher'
          'sbg:includeInPorts': true
          id: '#gsc_method'
          required: false
          type:
            - 'null'
            - string
        - label: Knowledge Network File
          description: The knowledge network file
          doc: gene-gene network of interactions in edge format
          id: '#gg_network_file'
          required: false
          type:
            - 'null'
            - File
        - label: Genomic Spreadsheet File
          description: The genomic spreadsheet file
          doc: >-
            spreadsheet of genomic data with samples as columns and genes as
            rows
          id: '#genomic_file'
          required: true
          type:
            - File
        - label: Gene Map File
          type:
            - 'null'
            - File
          id: '#gene_map_file'
          required: false
          description: The gene map file
      successCodes: []
      'sbg:cmdPreview': >-
        sh run_gr.cmd && sh file_renamer.cmd && python3 wget.py
        https://raw.githubusercontent.com/KnowEnG/quickstart-demos/master/pipeline_readmes/README-GSC.md
        README-GSC.md
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': viktorian_miok
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/16
          'sbg:modifiedOn': 1512041775
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/gsc-runner-copy/17
          'sbg:modifiedOn': 1517261405
          'sbg:revision': 1
      doc: >-
        Network-guided gene set characterization method implementation by
        KnowEnG that relates public gene sets to user gene sets
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
    outputs:
      - id: '#Gene_Set_Characterization.run_params_yml'
      - id: '#Gene_Set_Characterization.readme'
      - id: '#Gene_Set_Characterization.genomic_file_out'
      - id: '#Gene_Set_Characterization.gene_map_file_out'
      - id: '#Gene_Set_Characterization.enrichment_scores'
      - id: '#Gene_Set_Characterization.cmd_log_file'
    'sbg:x': 740.2494721412951
    'sbg:y': 450.0153550794495
requirements: []
inputs:
  - label: Species Taxon ID
    'sbg:x': 110.0000238865596
    description: >-
      The species taxon ID (e.g., 9606 for human).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
      possible values (KN Contents by Species).
    'sbg:y': 82.5000027120109
    'sbg:includeInPorts': true
    id: '#taxonid'
    type:
      - string
  - label: Gene Set Property Network Edge Type
    'sbg:x': 107.50000047683673
    description: >-
      The gene set property network edge type (e.g., gene_ontology).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type]
      for possible values (KN Contents by Property-Gene Edge Type).
    'sbg:y': 216.2499565184135
    'sbg:includeInPorts': true
    id: '#pg_edge_type'
    type:
      - string
  - label: Genomic Spreadsheet File
    'sbg:x': 102.50005492567655
    description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
    'sbg:y': 350.0000096559507
    'sbg:includeInPorts': true
    id: '#genomic_spreadsheet_file'
    type:
      - File
  - label: Knowledge Network Edge Type
    'sbg:x': 111.25000944733532
    description: >-
      The knowledge network edge type (e.g., STRING_experimental).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type]
      for possible values (KN Contents by Gene-Gene Edge Type).  Leave this
      blank to not use the Knowledge Network.
    'sbg:y': 479.99997153878223
    'sbg:includeInPorts': true
    id: '#gg_edge_type'
    type:
      - 'null'
      - string
  - label: Amount of Network Smoothing
    'sbg:x': 105.00002351403057
    description: >-
      The amount of network smoothing (as a percent; default 50%); a greater
      value means greater contribution from the network interactions
    'sbg:y': 619.9997800141683
    'sbg:includeInPorts': true
    id: '#network_smoothing_percent'
    type:
      - 'null'
      - int
outputs:
  - label: Gene Set Property Network Metadata File
    'sbg:x': 1118.749081209353
    description: The gene set property network metadata file
    'sbg:y': 63.74997279048104
    'sbg:includeInPorts': true
    id: '#gene_set_network_metadata_file'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Knowledge_Network_Fetcher_1.network_metadata_file'
  - label: Gene Set Name Map File
    'sbg:x': 1248.7498052120284
    description: The gene set name map file
    'sbg:y': 159.99999165534976
    'sbg:includeInPorts': true
    id: '#gene_set_name_map_file'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Join_Names.name_map_file_out'
  - label: GSC Results
    'sbg:x': 1106.2496927529721
    description: 'GSC enrichment scores, with names mapped'
    'sbg:y': 236.24997073412038
    'sbg:includeInPorts': true
    id: '#new_data_file'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Join_Names.new_data_file'
  - label: Interaction Network Metadata File
    'sbg:x': 1248.7494408637579
    description: The interaction network metadata file
    'sbg:y': 314.99988959730223
    'sbg:includeInPorts': true
    id: '#interaction_network_metadata_file'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Join_Names.interaction_network_metadata_file_out'
  - label: README
    'sbg:x': 1109.999571055196
    description: README-GSC.txt
    'sbg:y': 382.499916091565
    'sbg:includeInPorts': true
    id: '#readme'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Gene_Set_Characterization.readme'
  - label: GSC Run Params yml
    'sbg:x': 1247.4998056590632
    description: The configuration parameters specified for the GSC run
    'sbg:y': 448.74994266033366
    'sbg:includeInPorts': true
    id: '#run_params_yml'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Gene_Set_Characterization.run_params_yml'
  - label: Clean Genomic File
    'sbg:x': 1109.9998150467948
    description: The clean genomic spreadsheet file
    'sbg:y': 519.9999691545964
    'sbg:includeInPorts': true
    id: '#clean_genomic_file'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Gene_Set_Characterization.genomic_file_out'
  - label: Gene Map File
    'sbg:x': 1247.499927133322
    description: The gene map file
    'sbg:y': 601.2500250488484
    'sbg:includeInPorts': true
    id: '#gene_map_file'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Gene_Set_Characterization.gene_map_file_out'
  - label: Raw Enrichment Scores
    'sbg:x': 1112.4998140782193
    description: The GSC raw enrichment scores
    'sbg:y': 678.7499595433475
    'sbg:includeInPorts': true
    id: '#enrichment_scores'
    required: false
    type:
      - 'null'
      - File
    source:
      - '#Gene_Set_Characterization.enrichment_scores'
'sbg:canvas_zoom': 0.7999999999999998
'sbg:canvas_y': -11
'sbg:links':
  - label: KnowEnG Main Website
    id: 'https://knoweng.org/'
  - label: KnowEnG Analytics
    id: 'https://knoweng.org/analyze/'
  - label: Knowledge Network Overview
    id: 'https://knoweng.org/kn-overview/'
  - label: Knowledge-Guided Pipelines
    id: 'https://knoweng.org/pipelines/'
  - label: GSC Pipeline
    id: 'https://knoweng.org/pipelines/#gene_set_characterization'
  - label: Pipeline Quickstart Guides
    id: 'https://knoweng.org/quick-start/'
  - label: GSC Pipeline Quickstart
    id: 'https://knoweng.org/wp-content/uploads/2017/08/GSC_Quickstart.pdf'
  - label: CGC GSC Pipeline Quickstart
    id: 'https://knoweng.org/wp-content/uploads/2017/12/GSC_CGC_Quickstart.pdf'
  - label: KnowEnG YouTube Channel
    id: 'https://www.youtube.com/channel/UCjyIIolCaZIGtZC20XLBOyg'
'sbg:projectName': KnowEnG_GeneSetCharacterization_Public
'sbg:canvas_x': 137
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/5.png
'sbg:toolkitVersion': v1.0
'sbg:categories':
  - Analysis
  - Characterization
  - Enrichment
'sbg:toolAuthor': KnowEnG
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:toolkit': KnowEnG_CGC
'sbg:publisher': KnowEnG
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': nikola_jovanovic
    'sbg:modifiedOn': 1512657193
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': nikola_jovanovic
    'sbg:modifiedOn': 1512657548
    'sbg:revisionNotes': Update.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1512664254
    'sbg:revisionNotes': null
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517261822
    'sbg:revisionNotes': Updated version of GSC.
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1519015724
    'sbg:revisionNotes': Fixed a couple of typos (on an input and an output).
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1542343938
    'sbg:revisionNotes': null
'sbg:content_hash': a63760597759a5f74045cc5299baa800960d21fcab36fe8bb876efa035432d18d
label: Gene Set Characterization Workflow
description: >-
  This [KnowEnG](https://knoweng.org/) Gene Set Characterization workflow tests
  a gene set for enrichment against a large compendium of
  [annotations](https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type).


  This workflow starts with a user-submitted gene set (or multiple gene sets)
  and determines if each gene set is enriched for a pathway, a [Gene
  Ontology](https://www.ncbi.nlm.nih.gov/pubmed/25428369) term, or other types
  of annotations.  This pipeline tests your gene set for enrichment against a
  large compendium of annotations.  Gene Set Characterization can be done using
  a standard [statistical
  test](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.fisher_exact.html#scipy.stats.fisher_exact)
  or in a Knowledge Network-guided mode (using
  [DRaWR](https://www.ncbi.nlm.nih.gov/pubmed/27153592)).


  A network-guided analysis can offer various benefits over a standard one,
  including considering not just significant genes but also their network
  neighbors, and inferring properties of poorly annotated genes.


  ### Required inputs


  This workflow has one required input file:


  1. Genomic Spreadsheet File (ID: *genomic_spreadsheet_file*).  This currently
  must be a TSV file (a spreadsheet with tab-separated values).  The first row
  (header) should contain the names of the gene sets in the corresponding
  columns.  The first column of the spreadsheet should be the gene identifiers
  corresponding to each row.  For each entry in the spreadsheet table, a “1”
  indicates that the corresponding row gene is part of the corresponding column
  gene set, a “0” means it is not.  There should be no NA values/empty cells.


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


  1. Species Taxon ID (ID: *taxonid*; type: string).  The ID of the species to
  be used in the analysis, e.g., "9606" for human.  Possible values are listed
  in parentheses in the first column of the [KnowEnG Supported
  Species](https://knoweng.org/kn-data-references/#kn_contents_by_species) table
  (“KN Contents by Species”).


  2. Gene Set Property Network Edge Type (ID: *pg_edge_type*; type: string). 
  The edge type for the gene set property network, e.g., "gene_ontology". 
  Possible values are listed in parentheses in the first column of the [KnowEnG
  Gene Set
  Collections](https://knoweng.org/kn-data-references/#kn_contents_by_property-gene_edge_type)
  table (“KN Contents by Property-Gene Edge Type”).


  ### Optional inputs


  There are two optional input parameters:


  1. Knowledge Network Edge Type (ID: *gg_edge_type*; type: string).  The edge
  type for the knowledge network (i.e., interaction network), e.g.,
  "STRING_experimental".  Possible values are listed in parentheses in the first
  column of the [KnowEnG Interaction
  Networks](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type)
  table (KN Contents by Gene-Gene Edge Type“”)(use one of the values in
  parentheses).  If no value is specified, no knowledge network will be used in
  the analysis.


  2. Amount of Network Smoothing (ID: *network_smoothing_percent*; type: int). 
  The amount of network smoothing.  This should be an integer between 0 and 100
  (inclusive).  If no value is specified (or the value is outside that range),
  50% will be used.  A greater value means greater contribution from the network
  interactions.  (This value is only relevant if the knowledge network is used.)


  ### Outputs


  This workflow generates nine output files.  These are outlined below.  The
  structure and order specified here may not match what's listed on the
  completed task page.  The README output file goes into more detail on the
  purpose and the contents of the various output files.  That file can also be
  found
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
  `<taxonid>.<edge_type>.metadata`, e.g., `9606.STRING_experimental.metadata`). 
  This file will only be present if a knowledge network was used in the
  analysis.


  * GSC Run Params yml (file name: `run_params.yml`).


  ### Additional Resources


  [Quickstart
  Guide](https://knoweng.org/wp-content/uploads/2017/12/GSC_CGC_Quickstart.pdf)
  for this workflow


  [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
  knowledge-guided analysis


  [YouTube Tutorial](https://youtu.be/nP4wtVZOY3E) for this workflow in KnowEnG
  Platform


  [Additional Pipelines](https://knoweng.org/pipelines/) supported by KnowEnG


  ### Acknowledgements


  The KnowEnG BD2K center is supported by grant U54GM114838 awarded by NIGMS
  through funds provided by the trans-NIH Big Data to Knowledge (BD2K)
  initiative.


  Questions or comments can be sent to knoweng-support@illinois.edu.


  ### References


  Blatti C, Sinha S. Characterizing gene sets using discriminative random walks
  with restart on heterogeneous biological networks. Bioinformatics.
  2016;32(14):2167-75.


  Gene Ontology Consortium: going forward. Nucleic Acids Res. 2015;43(Database
  issue):D1049-56.
hints: []
cwlVersion: 'sbg:draft-2'
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/5/raw/
'sbg:id': mepstein/knoweng-genesetcharacterization-public/gene-set-characterization/5
'sbg:revision': 5
'sbg:revisionNotes': null
'sbg:modifiedOn': 1542343938
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1512657193
'sbg:createdBy': nikola_jovanovic
'sbg:project': mepstein/knoweng-genesetcharacterization-public
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
  - nikola_jovanovic
'sbg:latestRevision': 5
