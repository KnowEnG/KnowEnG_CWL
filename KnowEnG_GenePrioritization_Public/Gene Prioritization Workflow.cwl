class: Workflow
steps:
  - id: '#Data_Cleaning_Preprocessing'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      id: mepstein/knoweng-geneprioritization-demo/data-cleaning-copy/0
      label: Data Cleaning/Preprocessing
      description: >-
        Clean/preprocess input data (genomic and optionally phenotypic) for use
        with other tools/pipelines.
      baseCommand:
        - sh
        - run_dc.cmd
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          doc: taxon id of species related to genomic spreadsheet
          'sbg:includeInPorts': true
          required: false
          default: '9606'
          type:
            - 'null'
            - string
          label: Species Taxon ID
          description: 'The species taxon ID (e.g., 9606 for human)'
          id: '#taxonid'
        - 'sbg:toolDefaultValue': ''''''
          doc: >-
            suggestion for ID source database used to resolve ambiguities in
            mapping
          default: \'\'
          type:
            - 'null'
            - string
          label: ID Source Hint
          description: The source hint for the redis queries (can be '')
          id: '#source_hint'
        - 'sbg:toolDefaultValue': 6379
          doc: port for Redis db
          default: 6379
          type:
            - 'null'
            - int
          label: RedisDB Port
          description: The redis DB port
          id: '#redis_port'
        - 'sbg:toolDefaultValue': KnowEnG
          doc: password for Redis db
          default: KnowEnG
          type:
            - 'null'
            - string
          label: RedisDB Password
          description: The redis DB password
          id: '#redis_pass'
        - 'sbg:toolDefaultValue': knowredis.knoweng.org
          doc: url of Redis db
          default: knowredis.knoweng.org
          type:
            - 'null'
            - string
          label: RedisDB Host
          description: The redis DB host name
          id: '#redis_host'
        - doc: >-
            keywork name of pipeline from following list
            ['gene_prioritization_pipeline', 'samples_clustering_pipeline',
            'geneset_characterization_pipeline']
          type:
            - string
          label: Name of Pipeline
          description: >-
            The name of the pipeline that will be run (i.e., data cleaning is
            pipeline-specific)
          id: '#pipeline_type'
        - 'sbg:toolDefaultValue':
            class: File
            location: /bin/sh
          doc: 'the phenotypic spreadsheet input for the pipeline [may be optional]'
          required: false
          default:
            class: File
            location: /bin/sh
          type:
            - 'null'
            - File
          label: Phenotypic Spreadsheet File (optional)
          description: The phenotypic spreadsheet file (optional)
          id: '#phenotypic_spreadsheet_file'
        - doc: the genomic spreadsheet input for the pipeline
          required: true
          type:
            - File
          label: Genomic Spreadsheet File
          description: The genomic spreadsheet file
          id: '#genomic_spreadsheet_file'
        - 'sbg:toolDefaultValue': missing
          doc: >-
            if pipeline_type=='gene_prioritization_pipeline', then must be one
            of either ['t_test', 'pearson']
          'sbg:includeInPorts': true
          required: false
          default: missing
          type:
            - 'null'
            - string
          label: GP Correlation Measure
          description: 'The correlation measure to be used for GP (e.g., t_test or pearson)'
          id: '#gene_prioritization_corr_measure'
      outputs:
        - type:
            - 'null'
            - File
          label: Gene Unmapped File
          description: The genes that were not mapped
          outputBinding:
            glob: '*_UNMAPPED.tsv'
          id: '#gene_unmap_file'
          doc: two columns for original gene ids and unmapped reason code
        - type:
            - 'null'
            - File
          label: Gene Map File
          description: The gene map file
          outputBinding:
            glob: '*_MAP.tsv'
          id: '#gene_map_file'
          doc: two columns for internal gene ids and original gene ids
        - type:
            - 'null'
            - File
          label: Command Log File
          description: The log of the data cleaning command
          outputBinding:
            glob: run_dc.cmd
          id: '#cmd_log_file'
        - type:
            - 'null'
            - File
          label: Cleaning Parameters File
          description: The configuration parameters specified for the data cleaning run
          outputBinding:
            glob: run_cleanup.yml
          id: '#cleaning_parameters_yml'
          doc: data cleaning parameters in yaml format
        - type:
            - 'null'
            - File
          label: Cleaning Log File
          description: The log of the data cleaning run
          outputBinding:
            glob: log_*_pipeline.yml
          id: '#cleaning_log_file'
          doc: information on souce of errors for cleaning pipeline
        - type:
            - 'null'
            - File
          label: Clean Phenotypic Spreadsheet
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
        - type:
            - 'null'
            - File
          label: Clean Genomic Spreadsheet
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
            - filename: run_dc.cmd
              fileContent:
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
      hints:
        - class: ResourceRequirement
          outdirMin: 512000
          coresMin: 1
          ramMin: 5000
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
      'sbg:modifiedOn': 1513886524
      x: 687.777750651042
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
      'sbg:id': mepstein/knoweng-geneprioritization-demo/data-cleaning-copy/0
      'sbg:latestRevision': 0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      'sbg:modifiedBy': mepstein
      'sbg:revision': 0
      'sbg:cmdPreview': sh run_dc.cmd
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      'sbg:image_url': null
      'y': 138.3333129882813
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      doc: checks the inputs of a pipeline for potential sources of errors
      'sbg:createdOn': 1513886524
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
          'sbg:modifiedOn': 1513886524
          'sbg:revision': 0
    inputs:
      - id: '#Data_Cleaning_Preprocessing.taxonid'
        source: '#taxonid'
      - id: '#Data_Cleaning_Preprocessing.source_hint'
      - id: '#Data_Cleaning_Preprocessing.redis_port'
        default: 6379
      - id: '#Data_Cleaning_Preprocessing.redis_pass'
        default: KnowEnG
      - id: '#Data_Cleaning_Preprocessing.redis_host'
        default: knowredis.knoweng.org
      - id: '#Data_Cleaning_Preprocessing.pipeline_type'
        default: gene_prioritization_pipeline
      - id: '#Data_Cleaning_Preprocessing.phenotypic_spreadsheet_file'
        source: '#phenotypic_spreadsheet_file'
      - id: '#Data_Cleaning_Preprocessing.genomic_spreadsheet_file'
        source: '#genomic_spreadsheet_file'
      - id: '#Data_Cleaning_Preprocessing.gene_prioritization_corr_measure'
        source: '#Gene_Prioritization_Parameters.correlation_measure_out'
    outputs:
      - id: '#Data_Cleaning_Preprocessing.gene_unmap_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Data_Cleaning_Preprocessing.cmd_log_file'
      - id: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
      - id: '#Data_Cleaning_Preprocessing.cleaning_log_file'
      - id: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Data_Cleaning_Preprocessing.clean_genomic_file'
    'sbg:x': 687.777750651042
    'sbg:y': 138.3333129882813
  - id: '#Knowledge_Network_Fetcher'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      id: mepstein/knoweng-geneprioritization-demo/kn-fetcher-cb/0
      label: Knowledge Network Fetcher
      description: >-
        Fetch a knowledge network from an AWS S3 bucket, given a network type,
        an edge type, and a species taxon ID.
      baseCommand:
        - sh
        - run_fetch.cmd
      inputs:
        - 'sbg:toolDefaultValue': '9606'
          doc: the taxonomic id for the species of interest
          'sbg:includeInPorts': true
          required: false
          default: '9606'
          type:
            - 'null'
            - string
          label: Network Species Taxon ID
          description: 'The network species taxon ID (e.g., 9606 for human)'
          id: '#taxonid'
        - 'sbg:toolDefaultValue': Gene
          doc: the type of subnetwork
          default: Gene
          type:
            - 'null'
            - string
          label: Network Type
          description: 'The network type (e.g., Gene, Property)'
          id: '#network_type'
        - 'sbg:toolDefaultValue': 'true'
          doc: whether or not to get the network
          'sbg:includeInPorts': true
          required: false
          default: true
          type:
            - 'null'
            - boolean
          label: Get Network Flag
          description: Whether to get the network (or create a dummy/empty network file)
          id: '#get_network'
        - 'sbg:toolDefaultValue': STRING_experimental
          doc: the edge type keyword for the subnetwork of interest
          'sbg:includeInPorts': true
          required: false
          default: PPI_physical_association
          type:
            - 'null'
            - string
          label: Network Edge Type
          description: 'The network edge type (e.g., STRING_experimental, gene_ontology)'
          id: '#edge_type'
        - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
          doc: the aws s3 bucket
          default: KnowNets/KN-20rep-1706/userKN-20rep-1706
          type:
            - 'null'
            - string
          label: AWS S3 Bucket Name
          description: The AWS S3 bucket to fetch the network from
          id: '#bucket'
      outputs:
        - type:
            - 'null'
            - File
          label: PNode Map File
          description: The pnode map file
          outputBinding:
            glob: '*.pnode_map'
          id: '#pnode_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
        - type:
            - 'null'
            - File
          label: Node Map File
          description: The node map file
          outputBinding:
            glob: '*.node_map'
          id: '#node_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
        - type:
            - 'null'
            - File
          label: Network Metadata File
          description: The network metadata file
          outputBinding:
            glob: '*.metadata'
          id: '#network_metadata_file'
          doc: yaml format describing network contents
        - type:
            - 'null'
            - File
          label: Network Edge File
          description: The network edge file
          outputBinding:
            glob: '*.edge'
          id: '#network_edge_file'
          doc: 4 column format for subnetwork for single edge type and species
        - type:
            - 'null'
            - File
          label: Command Log File
          description: The log of the fetch command
          outputBinding:
            glob: run_fetch.cmd
          id: '#cmd_log_file'
          doc: log of fetch command
      requirements:
        - class: InlineJavascriptRequirement
        - class: ShellCommandRequirement
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: CreateFileRequirement
          fileDef:
            - filename: run_fetch.cmd
              fileContent:
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
      hints:
        - class: ResourceRequirement
          outdirMin: 512000
          coresMin: 1
          ramMin: 2000
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:modifiedOn': 1516299548
      x: 689.3333333333335
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:id': mepstein/knoweng-geneprioritization-demo/kn-fetcher-cb/0
      'sbg:latestRevision': 0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      'sbg:modifiedBy': mepstein
      'sbg:revision': 0
      'sbg:cmdPreview': sh run_fetch.cmd
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      'sbg:image_url': null
      'y': 577.6666666666667
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      doc: >-
        Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS
        S3 storage
      'sbg:createdOn': 1516299548
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
          'sbg:modifiedOn': 1516299548
          'sbg:revision': 0
    inputs:
      - id: '#Knowledge_Network_Fetcher.taxonid'
        source: '#taxonid'
      - id: '#Knowledge_Network_Fetcher.network_type'
        default: Gene
      - id: '#Knowledge_Network_Fetcher.get_network'
        source: '#Gene_Prioritization_Parameters.get_network'
      - id: '#Knowledge_Network_Fetcher.edge_type'
        source: '#Gene_Prioritization_Parameters.edge_type'
      - id: '#Knowledge_Network_Fetcher.bucket'
        default: KnowNets/KN-20rep-1706/userKN-20rep-1706
    outputs:
      - id: '#Knowledge_Network_Fetcher.pnode_map_file'
      - id: '#Knowledge_Network_Fetcher.node_map_file'
      - id: '#Knowledge_Network_Fetcher.network_metadata_file'
      - id: '#Knowledge_Network_Fetcher.network_edge_file'
      - id: '#Knowledge_Network_Fetcher.cmd_log_file'
    'sbg:x': 689.3333333333335
    'sbg:y': 577.6666666666667
  - id: '#Gene_Prioritization_Renamer'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      id: mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
      label: Gene_Prioritization_Renamer
      description: >-
        Renames some of the intermediate files produced in the GP workflow to
        their final output names.
      baseCommand:
        - sh
        - file_renamer.cmd
      inputs:
        - 'sbg:includeInPorts': true
          'sbg:stageInput': null
          required: false
          type:
            - 'null'
            - boolean
          label: Use Network Flag
          description: Whether to use the network
          id: '#use_network'
        - required: false
          type:
            - 'null'
            - File
          label: Interaction Network Metadata File
          description: The interaction network metadata file
          id: '#interaction_network_metadata_file_in'
        - required: false
          type:
            - 'null'
            - File
          label: Gene Map File
          description: The gene map file
          id: '#gene_map_file_in'
        - required: false
          type:
            - 'null'
            - File
          label: Clean Phenotypic Spreadsheet
          description: The clean phenotypic spreadsheet
          id: '#clean_phenotypic_file_in'
        - required: false
          type:
            - 'null'
            - File
          label: Clean Genomic Spreadsheet
          description: The clean genomic spreadsheet
          id: '#clean_genomic_file_in'
      outputs:
        - type:
            - 'null'
            - File
          label: Interaction Network Metadata File
          description: The interaction network metadata file
          outputBinding:
            glob: interaction_network.metadata
          id: '#interaction_network_metadata_file_out'
        - type:
            - 'null'
            - File
          label: Gene Map File
          description: The gene map file
          outputBinding:
            glob: gene_map.txt
          id: '#gene_map_file_out'
        - type:
            - 'null'
            - File
          label: Clean Phenotypic Spreadsheet
          description: The clean phenotypic spreadsheet
          outputBinding:
            glob: clean_phenotypic_matrix.txt
          id: '#clean_phenotypic_file_out'
        - type:
            - 'null'
            - File
          label: Clean Genomic Spreadsheet
          description: The clean genomic spreadsheet
          outputBinding:
            glob: clean_genomic_matrix.txt
          id: '#clean_genomic_file_out'
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: CreateFileRequirement
          fileDef:
            - filename: file_renamer.cmd
              fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >

                  str = "";


                  //demo_GP.genomic_ETL.tsv clean_genomic_matrix.txt

                  if ($job.inputs.clean_genomic_file_in) {
                      str += "cp -p " + $job.inputs.clean_genomic_file_in.path + " clean_genomic_matrix.txt\n";
                  }


                  //demo_GP.phenotypic_ETL.tsv clean_phenotypic_matrix.txt

                  if ($job.inputs.clean_phenotypic_file_in) {
                      str += "cp -p " + $job.inputs.clean_phenotypic_file_in.path + " clean_phenotypic_matrix.txt\n";
                  }


                  //demo_GP.genomic_MAP.tsv gene_map.txt

                  if ($job.inputs.gene_map_file_in) {
                      str += "cp -p " + $job.inputs.gene_map_file_in.path + " gene_map.txt\n";
                  }


                  //9606.STRING_experimental.metadata
                  interaction_network.metadata

                  if ($job.inputs.use_network &&
                  $job.inputs.interaction_network_metadata_file_in) {
                      str += "cp -p " + $job.inputs.interaction_network_metadata_file_in.path + " interaction_network.metadata\n";
                  }


                  str;
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: ubuntu
      'sbg:modifiedBy': mepstein
      'sbg:modifiedOn': 1516830402
      x: 984.0000000000003
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
      'sbg:latestRevision': 4
      'sbg:job':
        inputs:
          gene_map_file_in:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/gene_map_file.ext
          interaction_network_metadata_file_in:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/interaction_network_metadata_file.ext
          clean_genomic_file_in:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/genomic_file.ext
          clean_phenotypic_file_in:
            class: File
            secondaryFiles: []
            size: 0
            path: /path/to/phenotypic_file.ext
          use_network: true
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      'sbg:revision': 4
      'sbg:cmdPreview': sh file_renamer.cmd
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      'sbg:image_url': null
      'y': 333.3333333333334
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      'sbg:createdOn': 1516559629
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516559629
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516560539
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Renamed input parameters.
          'sbg:modifiedOn': 1516563049
          'sbg:revision': 2
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516830326
          'sbg:revision': 3
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516830402
          'sbg:revision': 4
    inputs:
      - id: '#Gene_Prioritization_Renamer.use_network'
        source: '#Gene_Prioritization_Parameters.get_network'
      - id: '#Gene_Prioritization_Renamer.interaction_network_metadata_file_in'
        source: '#Knowledge_Network_Fetcher.network_metadata_file'
      - id: '#Gene_Prioritization_Renamer.gene_map_file_in'
        source: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Gene_Prioritization_Renamer.clean_phenotypic_file_in'
        source: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Gene_Prioritization_Renamer.clean_genomic_file_in'
        source: '#Data_Cleaning_Preprocessing.clean_genomic_file'
    outputs:
      - id: '#Gene_Prioritization_Renamer.interaction_network_metadata_file_out'
      - id: '#Gene_Prioritization_Renamer.gene_map_file_out'
      - id: '#Gene_Prioritization_Renamer.clean_phenotypic_file_out'
      - id: '#Gene_Prioritization_Renamer.clean_genomic_file_out'
    'sbg:x': 984.0000000000003
    'sbg:y': 333.3333333333334
  - id: '#Gene_Prioritization_Parameters'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      id: >-
        mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
      label: Gene Prioritization Parameters
      description: >-
        Sets the input parameters of some of the intermediate apps in the GP
        workflow based on some of the input parameters to the workflow itself.
      baseCommand: []
      inputs:
        - 'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - string
          label: Knowledge Network Edge Type
          description: The knowledge network edge type (not required)
          id: '#knowledge_network_edge_type'
        - 'sbg:includeInPorts': true
          required: true
          type:
            - type: enum
              symbols:
                - pearson
                - t_test
              name: correlation_measure_in
          label: GP Correlation Measure
          description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
          id: '#correlation_measure_in'
      outputs:
        - type:
            - 'null'
            - boolean
          label: Get Network Flag
          description: Whether to get the network
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
          id: '#get_network'
        - type:
            - 'null'
            - string
          label: Network Edge Type
          description: The network edge type
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                $job.inputs.knowledge_network_edge_type;
          id: '#edge_type'
        - type:
            - 'null'
            - string
          label: GP Correlation Measure
          description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                $job.inputs.correlation_measure_in;
          id: '#correlation_measure_out'
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: ubuntu
      'sbg:modifiedBy': mepstein
      'sbg:modifiedOn': 1516854156
      x: 430.66666666666674
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      'sbg:id': >-
        mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
      'sbg:latestRevision': 5
      'sbg:job':
        inputs:
          correlation_measure_in: pearson
          knowledge_network_edge_type: knowledge_network_edge_type-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      'sbg:revision': 5
      'sbg:cmdPreview': ''
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      'sbg:image_url': null
      'y': 461.3333333333335
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      'sbg:createdOn': 1516829688
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516829688
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516830285
          'sbg:revision': 1
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516842866
          'sbg:revision': 2
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516842939
          'sbg:revision': 3
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Cleaned up inputs and outputs.
          'sbg:modifiedOn': 1516853520
          'sbg:revision': 4
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:modifiedOn': 1516854156
          'sbg:revision': 5
    inputs:
      - id: '#Gene_Prioritization_Parameters.knowledge_network_edge_type'
        source: '#knowledge_network_edge_type'
      - id: '#Gene_Prioritization_Parameters.correlation_measure_in'
        source: '#correlation_measure_in'
    outputs:
      - id: '#Gene_Prioritization_Parameters.get_network'
      - id: '#Gene_Prioritization_Parameters.edge_type'
      - id: '#Gene_Prioritization_Parameters.correlation_measure_out'
    'sbg:x': 430.66666666666674
    'sbg:y': 461.3333333333335
  - id: '#ProGENI'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      $namespaces:
        sbg: 'https://sevenbridges.com'
      id: mepstein/knoweng-geneprioritization-demo/gene-prioritization/1
      label: ProGENI
      description: >-
        Network-guided gene prioritization method implementation by KnowEnG that
        ranks gene measurements by their correlation to observed phenotypes.
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
      inputs:
        - 'sbg:toolDefaultValue': 'False'
          'sbg:includeInPorts': true
          type:
            - 'null'
            - boolean
          label: Use Network Flag
          description: Whether to use the network
          id: '#use_network'
          required: false
        - 'sbg:stageInput': link
          type:
            - File
          label: Genomic Spreadsheet File
          description: The genomic spreadsheet file
          id: '#spreadsheet_file'
          required: true
        - 'sbg:toolDefaultValue': '100'
          'sbg:includeInPorts': true
          'sbg:stageInput': null
          type:
            - 'null'
            - int
          label: Number of Top Genes
          description: The number of top genes to find
          id: '#number_of_top_genes'
          required: false
        - 'sbg:toolDefaultValue': '0'
          'sbg:includeInPorts': true
          type:
            - 'null'
            - int
          label: Number of Bootstraps
          description: The number of bootstraps
          id: '#num_bootstraps'
          required: false
        - 'sbg:toolDefaultValue': '50'
          'sbg:includeInPorts': true
          type:
            - 'null'
            - int
          label: Amount of Network Influence
          description: >-
            The amount of network influence (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          id: '#network_influence_percent'
          required: false
        - 'sbg:stageInput': link
          type:
            - 'null'
            - File
          label: Knowledge Network File
          description: The knowledge network file
          id: '#network_file'
          required: false
        - 'sbg:stageInput': link
          type:
            - File
          label: Drug Response File
          description: The drug response file
          id: '#drug_response_file'
          required: true
        - 'sbg:includeInPorts': true
          type:
            - string
          label: Correlation Measure
          description: 'The correlation measure (e.g., t_test or pearson)'
          id: '#correlation_measure'
          required: true
        - 'sbg:toolDefaultValue': '80'
          'sbg:includeInPorts': true
          'sbg:stageInput': null
          type:
            - 'null'
            - int
          label: Bootstrap Sample Percent
          description: The bootstrap sample percent
          id: '#bootstrap_sample_percent'
          required: false
      outputs:
        - type:
            - 'null'
            - File
          label: Top Genes File
          description: The top genes file
          outputBinding:
            glob: top_genes_per_phenotype_matrix.txt
          id: '#top_genes_file'
        - type:
            - 'null'
            - File
          label: Configuration Parameters File
          description: The configuration parameters specified for the GP run
          outputBinding:
            glob: run_params.yml
          id: '#run_params_yml'
        - type:
            - 'null'
            - File
          label: The README file
          description: The README file that describes the output files
          outputBinding:
            glob: README-GP.md
          id: '#readme'
        - type:
            - 'null'
            - type: array
              items: File
          outputBinding:
            glob: '*bootstrap_net_correlation*'
          id: '#output_name'
        - type:
            - 'null'
            - File
          label: Genes Ranked File
          description: The genes ranked file
          outputBinding:
            glob: genes_ranked_per_phenotype.txt
          id: '#genes_ranked_file'
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: CreateFileRequirement
          fileDef:
            - filename: run_gp.cmd
              fileContent:
                class: Expression
                engine: '#cwl-js-engine'
                script: >

                  str = "";


                  str += "correlation_measure: " +
                  $job.inputs.correlation_measure + "\n";

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
            - filename: create_ranked_genes.sh
              fileContent: |-
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
            - filename: wget.py
              fileContent: >-
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
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'knowengdev/gene_prioritization_pipeline:07_26_2017'
      'sbg:revisionNotes': Copy of mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
      'sbg:modifiedOn': 1523639904
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      'sbg:modifiedBy': mepstein
      'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization/1
      'sbg:latestRevision': 1
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
      'sbg:revision': 1
      'sbg:cmdPreview': >-
        sh run_gp.cmd && sh create_ranked_genes.sh ./
        genes_ranked_per_phenotype.txt top_genes_per_phenotype_matrix.txt &&
        python3 wget.py
        https://raw.githubusercontent.com/KnowEnG/quickstart-demos/f93695fdd5d603412e6b3d4e7a74e6f2a079929f/pipeline_readmes/README-GP.md
        README-GP.md
      'sbg:project': mepstein/knoweng-geneprioritization-demo
      'sbg:projectName': KnowEnG_GenePrioritization_Demo
      'sbg:image_url': null
      'sbg:createdOn': 1517287763
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:sbgMaintained': false
      'sbg:contributors':
        - mepstein
      'sbg:copyOf': mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
      'sbg:publisher': sbg
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-geneprioritization-dev/gene-prioritization/6
          'sbg:modifiedOn': 1517287763
          'sbg:revision': 0
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Copy of
            mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
          'sbg:modifiedOn': 1523639904
          'sbg:revision': 1
      x: 990.1795247395838
      'y': 724.7435709635419
    inputs:
      - id: '#ProGENI.use_network'
        source: '#Gene_Prioritization_Parameters.get_network'
      - id: '#ProGENI.spreadsheet_file'
        source: '#Data_Cleaning_Preprocessing.clean_genomic_file'
      - id: '#ProGENI.number_of_top_genes'
        source: '#number_of_top_genes'
      - id: '#ProGENI.num_bootstraps'
        source: '#num_bootstraps'
      - id: '#ProGENI.network_influence_percent'
        source: '#network_influence_percent'
      - id: '#ProGENI.network_file'
        source: '#Knowledge_Network_Fetcher.network_edge_file'
      - id: '#ProGENI.drug_response_file'
        source: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#ProGENI.correlation_measure'
        source: '#Gene_Prioritization_Parameters.correlation_measure_out'
      - id: '#ProGENI.bootstrap_sample_percent'
        source: '#bootstrap_sample_percent'
    outputs:
      - id: '#ProGENI.top_genes_file'
      - id: '#ProGENI.run_params_yml'
      - id: '#ProGENI.readme'
      - id: '#ProGENI.output_name'
      - id: '#ProGENI.genes_ranked_file'
    'sbg:x': 990.1795247395838
    'sbg:y': 724.7435709635419
requirements: []
inputs:
  - type:
      - File
    label: Genomic Spreadsheet File
    description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
    id: '#genomic_spreadsheet_file'
    'sbg:x': 218.82352701822924
    'sbg:y': 149.68627929687503
    'sbg:includeInPorts': true
    'sbg:suggestedValue':
      class: File
      name: demo_GP.genomic.txt
      path: 5a70e0e74f0c4abaed589c98
  - type:
      - 'null'
      - int
    label: Bootstrap Sample Percent
    description: >-
      The bootstrap sample percent (an integer between 0 and 100, inclusive;
      default 80%).
    id: '#bootstrap_sample_percent'
    'sbg:x': 228.92311604817715
    'sbg:y': 894.0512695312502
    'sbg:includeInPorts': true
  - type:
      - type: enum
        symbols:
          - pearson
          - t_test
        name: correlation_measure_in
    label: Correlation Measure
    description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
    id: '#correlation_measure_in'
    'sbg:x': 216.00000000000006
    'sbg:y': 548.0000000000001
    'sbg:includeInPorts': true
  - type:
      - string
    label: Species Taxon ID
    description: >-
      The species taxon ID (e.g., 9606 for human).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
      possible values (KN Contents by Species).
    id: '#taxonid'
    'sbg:x': 80.00000000000003
    'sbg:y': 69.00000000000003
    'sbg:includeInPorts': true
  - type:
      - File
    label: Phenotypic Spreadsheet File
    description: The phenotypic spreadsheet file
    id: '#phenotypic_spreadsheet_file'
    'sbg:x': 85.23531087239586
    'sbg:y': 277.94116210937506
    'sbg:includeInPorts': true
    'sbg:suggestedValue':
      class: File
      name: demo_GP.phenotypic.txt
      path: 5a70e0e74f0c4abaed589c97
  - type:
      - 'null'
      - int
    label: Amount of Network Influence
    description: >-
      The amount of network influence (as a percent, i.e., an integer between 0
      and 100, inclusive; default 50%); a greater value means greater
      contribution from the network interactions.  This value is only used if
      the knowledge network is used in the analysis.
    id: '#network_influence_percent'
    'sbg:x': 91.37254842122398
    'sbg:y': 634.1569010416669
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - string
    label: Knowledge Network Edge Type
    description: >-
      The knowledge network edge type (e.g., STRING_experimental).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type]
      for possible values (KN Contents by Gene-Gene Edge Type).  Leave this
      blank to not use the knowledge network in the analysis.
    id: '#knowledge_network_edge_type'
    'sbg:x': 96.00000000000001
    'sbg:y': 458.6666666666668
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Number of Top Genes
    description: The number of top genes to find (default 100).
    id: '#number_of_top_genes'
    'sbg:x': 225.25488281250006
    'sbg:y': 729.0196126302085
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Number of Bootstraps
    description: The number of bootstraps to use (0 means no bootstrapping; default 0).
    id: '#num_bootstraps'
    'sbg:x': 87.96982828776045
    'sbg:y': 804.0180664062502
    'sbg:includeInPorts': true
outputs:
  - id: '#run_params_yml'
    label: GP Run Params yml
    description: The configuration parameters specified for the GP run
    type:
      - 'null'
      - File
    'sbg:x': 1312.0000000000005
    'sbg:y': 662.6666666666669
    'sbg:includeInPorts': true
    required: false
    source:
      - '#ProGENI.run_params_yml'
  - id: '#interaction_network_metadata_file_out'
    label: Interaction Network Metadata File
    description: The interaction network metadata file
    type:
      - 'null'
      - File
    'sbg:x': 1488.0000000000005
    'sbg:y': 364.0000000000001
    'sbg:includeInPorts': true
    required: false
    source:
      - '#Gene_Prioritization_Renamer.interaction_network_metadata_file_out'
  - id: '#readme'
    label: README
    description: README-GP.md
    type:
      - 'null'
      - File
    'sbg:x': 1488.0000000000005
    'sbg:y': 742.6666666666669
    'sbg:includeInPorts': true
    required: false
    source:
      - '#ProGENI.readme'
  - id: '#gene_map_file_out'
    label: Gene Map File
    description: The gene map file
    type:
      - 'null'
      - File
    'sbg:x': 1313.3333333333337
    'sbg:y': 256.00000000000006
    'sbg:includeInPorts': true
    required: false
    source:
      - '#Gene_Prioritization_Renamer.gene_map_file_out'
  - id: '#clean_genomic_file_out'
    label: Clean Genomic File
    description: The clean genomic spreadsheet file
    type:
      - 'null'
      - File
    'sbg:x': 1320.0000000000005
    'sbg:y': 65.33333333333334
    'sbg:includeInPorts': true
    required: false
    source:
      - '#Gene_Prioritization_Renamer.clean_genomic_file_out'
  - id: '#clean_phenotypic_file_out'
    label: Clean Phenotypic File
    description: The clean phenotypic spreadsheet file
    type:
      - 'null'
      - File
    'sbg:x': 1488.0000000000005
    'sbg:y': 164.00000000000006
    'sbg:includeInPorts': true
    required: false
    source:
      - '#Gene_Prioritization_Renamer.clean_phenotypic_file_out'
  - id: '#genes_ranked_file'
    label: Ranked Genes File
    description: The genes ranked file
    type:
      - 'null'
      - File
    'sbg:x': 1308.0000000000005
    'sbg:y': 476.00000000000017
    'sbg:includeInPorts': true
    required: false
    source:
      - '#ProGENI.genes_ranked_file'
  - id: '#top_genes_file'
    label: Top Genes File
    description: The top genes file
    type:
      - 'null'
      - File
    'sbg:x': 1485.3333333333337
    'sbg:y': 556.0000000000001
    'sbg:includeInPorts': true
    required: false
    source:
      - '#ProGENI.top_genes_file'
'sbg:canvas_zoom': 0.7499999999999998
'sbg:toolkitVersion': v1.0
'sbg:canvas_x': 14
'sbg:canvas_y': -17
'sbg:links':
  - label: KnowEnG Main Website
    id: 'https://knoweng.org/'
  - label: KnowEnG Analytics
    id: 'https://knoweng.org/analyze/'
  - label: Knowledge Network Overview
    id: 'https://knoweng.org/kn-overview/'
  - label: Knowledge-Guided Pipelines
    id: 'https://knoweng.org/pipelines/'
  - label: GP Pipeline
    id: 'https://knoweng.org/pipelines/#gene_prioritization'
  - label: Pipeline Quickstart Guides
    id: 'https://knoweng.org/quick-start/'
  - label: GP Pipeline Quickstart
    id: 'https://knoweng.org/wp-content/uploads/2017/08/GP_Quickstart.pdf'
  - label: CGC GP Pipeline Quickstart
    id: 'https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf'
  - label: KnowEnG YouTube Channel
    id: 'https://www.youtube.com/channel/UCjyIIolCaZIGtZC20XLBOyg'
'sbg:projectName': KnowEnG_GenePrioritization_Public
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/6.png
'sbg:categories':
  - Analysis
  - Prioritization
'sbg:toolAuthor': KnowEnG
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:toolkit': KnowEnG_CGC
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517288013
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517288048
    'sbg:revisionNotes': Imported Gene Prioritization Workflow.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517346653
    'sbg:revisionNotes': Imported Gene Prioritization Workflow.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517586861
    'sbg:revisionNotes': Added links to public files in description.
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1523640090
    'sbg:revisionNotes': Updated version of ProGENI.
  - 'sbg:revision': 5
    'sbg:modifiedBy': charles_blatti
    'sbg:modifiedOn': 1560524502
    'sbg:revisionNotes': Update URLs
  - 'sbg:revision': 6
    'sbg:modifiedBy': charles_blatti
    'sbg:modifiedOn': 1560526309
    'sbg:revisionNotes': Added suggested input files
label: Gene Prioritization Workflow
description: >-
  This [KnowEnG](https://knoweng.org/) Gene Prioritization workflow identifies
  genes whose genomic measurements are most strongly associated with a
  collection of observed phenotypes.


  In this pipeline, the user submits a spreadsheet of gene-level transcriptomic
  (or other omics) profiles of a collection of biological samples.  Each sample
  is also annotated with a numeric phenotype (e.g., drug response) or binary
  phenotype (e.g., metastatic status).  This pipeline scores each gene by the
  correlation between its “omic” value (e.g., expression) and the phenotype, and
  reports the top phenotype-related genes.  Gene prioritization can be done in a
  Knowledge Network-guided mode (using
  [ProGENI](https://www.ncbi.nlm.nih.gov/pubmed/28800781)), and with optional
  use of bootstrapping to achieve robust prioritization.


  A network-guided analysis can offer various benefits over a standard one,
  since it evaluates the associations while considering the activity levels of
  the gene’s network neighbors. As a result, it can identify genes that both
  directly and indirectly (through their neighbors) affect the phenotype.



  ### Required inputs


  This workflow has two required input files:


  1. Genomic Spreadsheet File (ID: *genomic_spreadsheet_file*).  This currently
  must be a TSV file (a spreadsheet with tab-separated values).  The first row
  (header) should contain the identifiers for the biological samples that
  provide the data for the corresponding columns.  The first column of the
  spreadsheet should be the gene identifiers corresponding to each row.  Each
  entry in the spreadsheet table should be a numeric value (positive or
  negative) indicating the genomic measurement of the corresponding row gene in
  the corresponding column sample.  There should be no NA values/empty cells.


  A sample input file,
  [demo_GP.genomic.txt](https://cgc.sbgenomics.com/public/files/5a7474014f0cfede55af6472/),
  as described in the [quickstart guide for this
  workflow](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf),
  is available.


  Example of Genomic Spreadsheet File Format:


  | &nbsp; |Sample1 | Sample2 | Sample3 |

  | --- | --- | --- | --- | --- |

  |**Gene1**| -0.2 | 1.5 | 4.1 |

  |**Gene2**| 0.9 | -3.0 | -0.6 |

  |**Gene3**| -1.1 | 0.2 | -3.1 |

  |**Gene4**| -0.8 | 0.1 | -0.2 |

  |**Gene5**| 1.7 | 0.6 | -1.0 |

  |...| ... | ... | ... |


  2. Phenotypic Spreadsheet File (ID: *phenotypic_spreadsheet_file*).  This
  currently must be a TSV file (a spreadsheet with tab-separated values).  The
  first row (header) of the spreadsheet should be the phenotypes corresponding
  to each column.  The first column should contain the identifiers for the
  biological samples that have had their phenotypes measured in the
  corresponding rows.  The phenotypic spreadsheet file cells must either contain
  numeric (positive or negative) values or NAs.  For Correlation Measure =
  `t_test`, the numeric values must be either “0” or “1”.  For Correlation
  Measure = `pearson`, continuous numeric values are preferred.


  A sample input file,
  [demo_GP.phenotypic.txt](https://cgc.sbgenomics.com/public/files/5a7474014f0cfede55af6473/),
  as described in the [quickstart guide for this
  workflow](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf),
  is available.


  Example of Phenotypic Spreadsheet File Format (for Correlation Measure =
  `t_test`):


  | &nbsp; | Pheno1 | Pheno2 | Pheno3 |

  | --- | --- | --- | --- | --- |

  |**Sample1**| 0 | 1 | 1 |

  |**Sample2**| 0 | 0 | 0 |

  |**Sample3**| 1 | 0 | 1 |

  |**Sample**| 0 | 1 | 0 |

  |**Sample**| 1 | 0 | 0 |

  |...| ... | ... | ... |


  There are three required input parameters:


  1. Species Taxon ID (ID: *taxonid*; type: string).  The ID of the species to
  be used in the analysis, e.g., "9606" for human.  Possible values are listed
  in parentheses in the first column of the [KnowEnG Supported
  Species](https://knoweng.org/kn-data-references/#kn_contents_by_species) table
  ("KN Contents by Species").


  2. Number of Top Genes (ID: *number_of_top_genes*; type: int).  This is the
  number of top ranking genes that will be returned by the method.


  3. Correlation Measure (ID: *correlation_measure_in*; type enum/string).  This
  is the correlation measure that will be used in the gene prioritization.  The
  values currently available are `pearson` (for continuous values) and `t_test`
  (for binary data).


  ### Optional inputs


  There are four optional input parameters.


  If you use the Knowledge Network, these two parameters should be specified:


  1. Knowledge Network Edge Type (ID: *knowlege_network_edge_type*; type:
  string).  The edge type for the knowledge network (i.e., interaction network),
  e.g., "STRING_experimental".  Possible values are listed in parentheses in the
  first column of the [KnowEnG Interaction
  Networks](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type)
  table (KN Contents by Gene-Gene Edge Type"")(use one of the values in
  parentheses).  If no value is specified, no knowledge network will be used in
  the analysis.


  2. Amount of Network Influence (ID: *network_influence_percent*; type: int). 
  The amount of network influence.  This should be an integer between 0 and 100
  (inclusive).  If no value is specified (or the value is outside that range),
  50% will be used.  A greater value means greater contribution from the network
  interactions.  (This value is only relevant if the knowledge network is used.)


  If you use bootstrapping, these two parameters should be specified:


  1. Number of Bootstraps (ID: *num_bootstraps*; type: int).  The number of
  bootstraps to use.  If no value is specified, no bootstrapping will be done.


  2. Bootstrap Sample Percent (ID: *bootstrap_sample_percent*; type: int).  The
  percent of columns that will be sampled on each bootstrap.  This should be an
  integer between 0 and 100 (inclusive).  If no value is specified (or the value
  is outside that range), 80% will be used.  (This value is only relevant if
  bootstrapping is done.)


  ### Outputs


  This workflow generates eight output files.  These are outlined below.  The
  structure and order specified here may not match what's listed on the
  completed task page.  The README output file goes into more detail on the
  purpose and the contents of the various output files.  That file can also be
  found
  [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-FP.md).


  #### Results


  * Ranked Genes File (file name: `genes_ranked_per_phenotype.txt`).


  * Top Genes File (file name: `top_genes_per_phenotype_matrix.txt`).


  * README (file name: `README-GP.md`).  This file describes the various output
  files.


  #### Mapping


  * Gene Map File (file name: `gene_map.txt`).


  * Clean Genomic File (file name: `clean_genomic_matrix.txt`).


  * Clean Phenotypic File (file name: `clean_phenotypic_matrix.txt`).


  #### Metadata and run info


  * Interaction Network Metadata File (file name:
  `interaction_network.metadata`).  This file will only be present if a
  knowledge network was used in the analysis.


  * GP Run Params yml (file name: `run_params.yml`).


  ### Additional Resources


  [Quickstart
  Guide](https://knoweng.org/wp-content/uploads/2018/02/GP_CGC_Quickstart.pdf)
  for this workflow


  [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
  knowledge-guided analysis


  [YouTube Tutorial](https://youtu.be/Vp76-Oz-Yuc) for this workflow in KnowEnG
  Platform


  [Additional Pipelines](https://knoweng.org/pipelines/) supported by KnowEnG


  ### Acknowledgements


  The KnowEnG BD2K center is supported by grant U54GM114838 awarded by NIGMS
  through funds provided by the trans-NIH Big Data to Knowledge (BD2K)
  initiative.


  Questions or comments can be sent to knoweng-support@illinois.edu.


  ### References


  Emad A, Cairns J, Kalari KR, Wang L, Sinha S. Knowledge-guided gene
  prioritization reveals new insights into the mechanisms of chemoresistance.
  Genome Biol. 2017;18(1):153.


  Rees MG, Seashore-ludlow B, Cheah JH, et al. Correlating chemical sensitivity
  and basal gene expression reveals mechanism of action. Nat Chem Biol.
  2016;12(2):109-16.
hints: []
cwlVersion: 'sbg:draft-2'
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/6/raw/
'sbg:id': mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow/6
'sbg:revision': 6
'sbg:revisionNotes': Added suggested input files
'sbg:modifiedOn': 1560526309
'sbg:modifiedBy': charles_blatti
'sbg:createdOn': 1517288013
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-public
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
  - charles_blatti
'sbg:latestRevision': 6
'sbg:publisher': KnowEnG
'sbg:content_hash': abeef0e36e047a0aaf21935652488d928a87df7a0b83740556b5aa4a5adea19ae
