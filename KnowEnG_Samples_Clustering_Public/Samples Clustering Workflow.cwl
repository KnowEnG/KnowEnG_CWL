class: Workflow
cwlVersion: 'sbg:draft-2'
label: Samples Clustering Workflow
description: >-
  This [KnowEnG](https://knoweng.org/) workflow performs sample clustering on a
  spreadsheet of "omics" data.  With this pipeline, users can find clusters of
  samples that have similar genomic signatures, such as cancer patient
  subtypes.  If you also have phenotypic descriptions for each sample, e.g.,
  treatment outcomes, this pipeline can identify phenotypes that are highly
  correlated with each cluster.  Sample clustering can be done in a  Knowledge
  Network-guided mode, and with optional use of bootstrapping to achieve robust
  cluster assignment.



  ### Required inputs


  This workflow has one required file input:


  1. Genomic Spreadsheet File (ID: *genomic_spreadsheet_file*, type: file).  A
  spreadsheet containing the "omics" data.  This should be a tab-separated file,
  with column labels (the first line) and row labels (the first column), with
  the entries being genomic measurements such as gene expression levels (e.g.,
  z-scores).


  There is one required input parameter:


  1. Number of Clusters (ID: *number_of_clusters*, type: int).  The number of
  clusters to use in the sample clustering.



  ### Optional inputs


  This workflow has one optional file input:


  1. Phenotypic Spreadsheet File (ID: *phenotypic_spreadsheet_file*, type:
  file).


  There are seven optional input parameters:


  1. Number of Top Genes (ID: *number_of_top_genes*, type: int, default: 100). 
  This is the number of top ranking genes that will be returned by the method.


  2. Knowledge Network Edge Type (ID: *knowledge_network_edge_type*; type:
  string).  The edge type for the knowledge network (i.e., interaction network),
  e.g., "STRING_experimental".  Possible values are listed in parentheses in the
  first column of the [KnowEnG Interaction
  Networks](https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type)
  table (KN Contents by Gene-Gene Edge Type) (use one of the values in
  parentheses).  If no value is specified, no knowledge network will be used in
  the analysis.


  3. Species Taxon ID (ID: *taxonid*; type: string, default: "9606").  The ID of
  the species to be used in the analysis, e.g., "9606" for human.  Possible
  values are listed in parentheses in the first column of the [KnowEnG Supported
  Species](https://knoweng.org/kn-data-references/#kn_contents_by_species) table
  ("KN Contents by Species").  This value is only needed if gene name mapping is
  going to be done on either the samples or signatures files.


  4. Amount of Network Influence (ID: *network_influence_percent*, type: int,
  default: 50).  The amount of network influence.  This should be an integer
  between 0 and 100 (inclusive).  If no value is specified (or the value is
  outside that range), 50% will be used.  A greater value means greater
  contribution from the network interactions.  (This value is only relevant if
  the knowledge network is used.)


  5. Number of Bootstraps (ID: *num_bootstraps*; type: int).  The number of
  bootstraps to use.  If no value is specified, no bootstrapping will be done.


  6. Bootstrap Sample Percent (ID: *bootstrap_sample_percent*, type: int,
  default: 80).  The percent of columns that will be sampled on each bootstrap. 
  This should be an integer between 0 and 100 (inclusive).  If no value is
  specified (or the value is outside that range), 80% will be used.  (This value
  is only relevant if bootstrapping is done.)


  7. Processing Method (ID: *processing_method*, type: enum ["serial",
  "parallel"], default: "serial").  The processing method that will be used if
  bootstrapping is done.  (This value is only relevant if bootstrapping is
  done.)



  ### Outputs


  This workflow generates twelve output files.  These are outlined below.  The
  structure and order specified here may not match what's listed on the
  completed task page.  The README output file goes into more detail on the
  purpose and the contents of the various output files.  That file can also be
  found
  [here](https://raw.githubusercontent.com/KnowEnG/quickstart-demos/573a3a09c46929083994a285497d1f43016aa1a6/pipeline_readmes/README-SC.md).


  #### Results


  * Sample Labels (file name: `sample_labels_by_cluster.txt`) - Sample Cluster
  Assignment File


  * Consensus Matrix (file name: `consensus_matrix.txt`) - Bootstrap Consensus
  Matrix File


  * Top Genes File (file name: `top_genes_by_cluster.txt`) - Cluster Genes
  Spreadsheet File


  * Gene Averages File (file name: `gene_avgs_by_cluster.txt`) - Cluster Means
  Spreadsheet File


  * Clustering Evaluations (file name: `clustering_evaluations.txt`) - Phenotype
  Association File (if phenotypic input provided)


  #### Metadata and run info


  * Clean Genomic File (file name: `clean_genomic_matrix.txt`) - Cleaned/Mapped
  Genomic Spreadsheet File


  * Gene Map File (file name: `gene_map.txt`) - Gene ID Mapping File


  * Clean Phenotypic File (file name: `clean_phenotypic_matrix.txt`) - Cleaned
  Genomic Spreadsheet File (if phenotypic input provided)


  * Interaction Network Metadata File (file name:
  `interaction_network.metadata`) - Knowledge Network Metadata (if KN guided
  analysis)


  * Sample Clustering Run Parameters yml (file name: `run_params.yml`) - Sample
  Clustering Run Parameters File


  * Data Cleanup Run Parameters yml (file name: `run_cleanup_params.yml`) - Data
  Cleanup Run Parameters File


  * README (file name: `README-SC.md`) - This file describes the various output
  files.



  ### Additional Resources


  [Quickstart
  Guide](https://knoweng.org/wp-content/uploads/2018/07/SC_CGC_Quickstart.pdf)
  for this workflow


  [KnowEnG Analytics Platform](https://knoweng.org/analyze/) for
  knowledge-guided analysis


  [YouTube Tutorial](https://www.youtube.com/nAZzN100B3w) for this workflow in
  KnowEnG Platform


  [Additional Pipelines](https://knoweng.org/pipelines/) supported by KnowEnG



  ### Acknowledgements


  The KnowEnG BD2K center is supported by grant U54GM114838 awarded by NIGMS
  through funds provided by the trans-NIH Big Data to Knowledge (BD2K)
  initiative.



  Questions or comments can be sent to knoweng-support@illinois.edu.



  ### References


  Matan Hofree, John P Shen, Hannah Carter, Andrew Gross & Trey Ideker. 
  Network-based stratification of tumor mutations.  Nature Methods. 
  2013;10:1108–1115.  [[PubMed:
  24037242](https://www.ncbi.nlm.nih.gov/pubmed/?term=24037242);
  [doi:10.1038/nmeth.2651](https://doi.org/10.1038/nmeth.2651)]
$namespaces:
  sbg: 'https://sevenbridges.com'
inputs:
  - type:
      - 'null'
      - string
    label: Species Taxon ID
    description: >-
      The species taxon ID (e.g., 9606 for human).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
      possible values (KN Contents by Species).
    id: '#taxonid'
    'sbg:x': 68.6388921737671
    'sbg:y': 31.694445610046394
    'sbg:includeInPorts': true
  - type:
      - File
    label: Genomic Spreadsheet File
    description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
    id: '#genomic_spreadsheet_file'
    'sbg:x': 66.66666777928641
    'sbg:y': 151.7221894429804
    'sbg:includeInPorts': true
    'sbg:suggestedValue':
      class: File
      name: demo_SC.genomic.txt
      path: 5b227b6d8950ff8a0673d014
  - type:
      - 'null'
      - File
    label: Phenotypic Spreadsheet File
    description: 'The phenotypic spreadsheet file, samples x phenotypes, tab-separated.'
    id: '#phenotypic_spreadsheet_file'
    'sbg:x': 165.61109542846683
    'sbg:y': 196.0277938842774
    'sbg:includeInPorts': true
    'sbg:suggestedValue':
      class: File
      name: demo_SC.phenotypic.txt
      path: 5b227b6d8950ff8a0673d015
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
    'sbg:x': 56.02777481079103
    'sbg:y': 320.7500076293946
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Amount of Network Influence
    description: >-
      The amount of network influence (as a percent; default 50%); a greater
      value means greater contribution from the network interactions
    id: '#network_influence_percent'
    'sbg:x': 159.11107381184897
    'sbg:y': 387.11103651258685
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Number of Bootstraps
    description: The number of bootstraps to use (0 means no bootstrapping; default 0).
    id: '#num_bootstraps'
    'sbg:x': 64.00000095367433
    'sbg:y': 454.4166183471681
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Bootstrap Sample Percent
    description: 'The bootstrap sample percent (default: 80%)'
    id: '#bootstrap_sample_percent'
    'sbg:x': 164.44442749023438
    'sbg:y': 512.4444580078125
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - type: enum
        symbols:
          - serial
          - parallel
        name: processing_method
    label: Processing Method
    description: 'The processing method (e.g., serial or parallel, default: serial)'
    id: '#processing_method'
    'sbg:x': 68.74999046325685
    'sbg:y': 601.2500000000001
    'sbg:includeInPorts': true
  - type:
      - 'null'
      - int
    label: Number of Top Genes
    description: The number of top genes to find for each cluster (default 100).
    id: '#number_of_top_genes'
    'sbg:x': 165.41171803193936
    'sbg:y': 641.6207347196691
    'sbg:includeInPorts': true
  - type:
      - int
    label: Number of Clusters
    description: The number of clusters
    id: '#number_of_clusters'
    'sbg:x': 74.58333015441896
    'sbg:y': 728.7776947021486
    'sbg:includeInPorts': true
outputs:
  - id: '#clean_genomic_file_out'
    label: Clean Genomic File
    description: The clean genomic spreadsheet
    source:
      - '#Samples_Clustering_Renamer.clean_genomic_file_out'
    type:
      - 'null'
      - File
    'sbg:x': 1112.5981588924635
    'sbg:y': 34.97007482192096
    'sbg:includeInPorts': true
    required: false
  - id: '#gene_map_file_out'
    label: Gene Map File
    description: The gene map file
    source:
      - '#Samples_Clustering_Renamer.gene_map_file_out'
    type:
      - 'null'
      - File
    'sbg:x': 1232.0057508680557
    'sbg:y': 82.70758734809027
    'sbg:includeInPorts': true
    required: false
  - id: '#clean_phenotypic_file_out'
    label: Clean Phenotypic File
    description: The clean phenotypic spreadsheet
    source:
      - '#Samples_Clustering_Renamer.clean_phenotypic_file_out'
    type:
      - 'null'
      - File
    'sbg:x': 1113.0584716796875
    'sbg:y': 167.62573242187503
    'sbg:includeInPorts': true
    required: false
  - id: '#interaction_network_metadata_file_out'
    label: Interaction Network Metadata File
    description: The interaction network metadata file
    source:
      - '#Samples_Clustering_Renamer.interaction_network_metadata_file_out'
    type:
      - 'null'
      - File
    'sbg:x': 1229.5203993055557
    'sbg:y': 226.70759412977432
    'sbg:includeInPorts': true
    required: false
  - id: '#sample_labels'
    label: Sample Labels
    description: 'The sample labels (i.e., clusters)'
    source:
      - '#Samples_Clustering.sample_labels'
    type:
      - 'null'
      - File
    'sbg:x': 1234.2791748046877
    'sbg:y': 390.42400360107433
    'sbg:includeInPorts': true
    required: false
  - id: '#consensus_matrix'
    label: Consensus Matrix
    description: The consensus matrix
    source:
      - '#Samples_Clustering.consensus_matrix'
    type:
      - 'null'
      - File
    'sbg:x': 1112.6621246337893
    'sbg:y': 453.233871459961
    'sbg:includeInPorts': true
    required: false
  - id: '#top_genes'
    label: Top Genes File
    description: The top genes file
    source:
      - '#Samples_Clustering.top_genes'
    type:
      - 'null'
      - File
    'sbg:x': 1117.2794342041018
    'sbg:y': 597.1323394775392
    'sbg:includeInPorts': true
    required: false
  - id: '#gene_avgs'
    label: Gene Averages File
    description: The gene averages file
    source:
      - '#Samples_Clustering.gene_avgs'
    type:
      - 'null'
      - File
    'sbg:x': 1238.1617736816409
    'sbg:y': 525.2206039428712
    'sbg:includeInPorts': true
    required: false
  - id: '#clustering_evaluations'
    label: Clustering Evaluations
    description: The clustering evaluations
    source:
      - '#Samples_Clustering.clustering_evaluations'
    type:
      - 'null'
      - File
    'sbg:x': 1246.723556518555
    'sbg:y': 645.290985107422
    'sbg:includeInPorts': true
    required: false
  - id: '#run_params_yml'
    label: run_params_yml
    description: The configuration parameters specified for the SC run
    source:
      - '#Samples_Clustering.run_params_yml'
    type:
      - 'null'
      - File
    'sbg:x': 1119.8288726806643
    'sbg:y': 712.4488830566407
    'sbg:includeInPorts': true
    required: false
  - id: '#readme'
    label: README
    description: The README file that describes the output files
    source:
      - '#Samples_Clustering.readme'
    type:
      - 'null'
      - File
    'sbg:x': 1253.9532470703127
    'sbg:y': 767.8022766113282
    'sbg:includeInPorts': true
    required: false
  - id: '#dcp_run_params_yml_out'
    label: run_cleanup_params_yml
    description: The data cleaning pipeline run parameters file
    source:
      - '#Samples_Clustering_Renamer.dcp_run_params_yml_out'
    type:
      - 'null'
      - File
    'sbg:x': 1111.54411315918
    'sbg:y': 313.3088302612305
    'sbg:includeInPorts': true
    required: false
steps:
  - id: '#Knowledge_Network_Fetcher'
    inputs:
      - id: '#Knowledge_Network_Fetcher.taxonid'
        source: '#taxonid'
      - id: '#Knowledge_Network_Fetcher.network_type'
        default: Gene
      - id: '#Knowledge_Network_Fetcher.get_network'
        source: '#Samples_Clustering_Parameters.get_network'
      - id: '#Knowledge_Network_Fetcher.edge_type'
        source: '#Samples_Clustering_Parameters.edge_type'
      - id: '#Knowledge_Network_Fetcher.bucket'
        default: KnowNets/KN-20rep-1706/userKN-20rep-1706
    outputs:
      - id: '#Knowledge_Network_Fetcher.pnode_map_file'
      - id: '#Knowledge_Network_Fetcher.node_map_file'
      - id: '#Knowledge_Network_Fetcher.network_metadata_file'
      - id: '#Knowledge_Network_Fetcher.network_edge_file'
      - id: '#Knowledge_Network_Fetcher.cmd_log_file'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      $namespaces:
        sbg: 'https://sevenbridges.com'
      id: mepstein/knoweng-samples-clustering-dev/kn-fetcher-cb/0
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
          default: '9606'
          required: false
          'sbg:includeInPorts': true
          type:
            - 'null'
            - string
          label: Network Species Taxon ID
          description: 'The network species taxon ID (e.g., 9606 for human)'
          id: '#taxonid'
        - 'sbg:toolDefaultValue': Gene
          doc: the type of subnetwork
          default: Gene
          required: false
          'sbg:includeInPorts': false
          type:
            - 'null'
            - string
          label: Network Type
          description: 'The network type (e.g., Gene, Property)'
          id: '#network_type'
        - 'sbg:toolDefaultValue': 'true'
          doc: whether or not to get the network
          default: true
          required: false
          'sbg:includeInPorts': true
          type:
            - 'null'
            - boolean
          label: Get Network Flag
          description: Whether to get the network (or create a dummy/empty network file)
          id: '#get_network'
        - 'sbg:toolDefaultValue': STRING_experimental
          doc: the edge type keyword for the subnetwork of interest
          default: PPI_physical_association
          required: false
          'sbg:includeInPorts': true
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
                class: Expression
      hints:
        - class: ResourceRequirement
          coresMin: 1
          ramMin: 2000
          outdirMin: 512000
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
      'sbg:id': mepstein/knoweng-samples-clustering-dev/kn-fetcher-cb/0
      'sbg:projectName': KnowEnG_Samples_Clustering_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1523043791
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1523043791
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
          'sbg:revision': 0
      'sbg:cmdPreview': sh run_fetch.cmd
      'sbg:revision': 0
      'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:project': mepstein/knoweng-samples-clustering-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:latestRevision': 0
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:modifiedOn': 1523043791
      x: 514
      'sbg:publisher': sbg
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 404
      doc: >-
        Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS
        S3 storage
      'sbg:createdBy': mepstein
      'sbg:sbgMaintained': false
    label: Knowledge Network Fetcher
    'sbg:x': 514
    'sbg:y': 404
  - id: '#Samples_Clustering_Parameters'
    inputs:
      - id: '#Samples_Clustering_Parameters.knowledge_network_edge_type'
        source: '#knowledge_network_edge_type'
    outputs:
      - id: '#Samples_Clustering_Parameters.get_network'
      - id: '#Samples_Clustering_Parameters.edge_type'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      $namespaces:
        sbg: 'https://sevenbridges.com'
      id: mepstein/knoweng-samples-clustering-dev/samples-clustering-parameters/1
      label: Samples Clustering Parameters
      description: >-
        Sets the input parameters of some of the intermediate apps in the SC
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
      outputs:
        - type:
            - 'null'
            - boolean
          label: Get Network Flag
          description: Whether to get the network
          outputBinding:
            outputEval:
              engine: '#cwl-js-engine'
              script: |
                if ($job.inputs.knowledge_network_edge_type) {
                    get_network = true;
                }
                else {
                    get_network = false;
                }

                get_network;
              class: Expression
          id: '#get_network'
        - type:
            - 'null'
            - string
          label: Network Edge Type
          description: The network edge type
          outputBinding:
            outputEval:
              engine: '#cwl-js-engine'
              script: |
                $job.inputs.knowledge_network_edge_type;
              class: Expression
          id: '#edge_type'
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
      'sbg:id': mepstein/knoweng-samples-clustering-dev/samples-clustering-parameters/1
      'sbg:projectName': KnowEnG_Samples_Clustering_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1523045332
      'sbg:job':
        inputs:
          knowledge_network_edge_type: knowledge_network_edge_type-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:cmdPreview': ''
      'sbg:revision': 1
      'sbg:project': mepstein/knoweng-samples-clustering-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:latestRevision': 1
      'sbg:revisionNotes': Initial version.
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1523045332
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1523045654
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
      'sbg:modifiedOn': 1523045654
      x: 287.21052381727435
      'sbg:publisher': sbg
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 377.73095024956604
      'sbg:createdBy': mepstein
      'sbg:sbgMaintained': false
    label: Samples Clustering Parameters
    'sbg:x': 287.21052381727435
    'sbg:y': 377.73095024956604
  - id: '#Samples_Clustering_Renamer'
    inputs:
      - id: '#Samples_Clustering_Renamer.use_network'
        default: false
        source: '#Samples_Clustering_Parameters.get_network'
      - id: '#Samples_Clustering_Renamer.interaction_network_metadata_file_in'
        source: '#Knowledge_Network_Fetcher.network_metadata_file'
      - id: '#Samples_Clustering_Renamer.gene_map_file_in'
        source: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Samples_Clustering_Renamer.dcp_run_params_yml_in'
        source: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
      - id: '#Samples_Clustering_Renamer.clean_phenotypic_file_in'
        source: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Samples_Clustering_Renamer.clean_genomic_file_in'
        source: '#Data_Cleaning_Preprocessing.clean_genomic_file'
    outputs:
      - id: '#Samples_Clustering_Renamer.interaction_network_metadata_file_out'
      - id: '#Samples_Clustering_Renamer.gene_map_file_out'
      - id: '#Samples_Clustering_Renamer.dcp_run_params_yml_out'
      - id: '#Samples_Clustering_Renamer.clean_phenotypic_file_out'
      - id: '#Samples_Clustering_Renamer.clean_genomic_file_out'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      $namespaces:
        sbg: 'https://sevenbridges.com'
      id: mepstein/knoweng-samples-clustering-dev/samples-clustering-renamer/2
      label: Samples Clustering Renamer
      description: >-
        Renames some of the intermediate files produced in the SC workflow to
        their final output names.
      baseCommand:
        - sh
        - file_renamer.cmd
      inputs:
        - 'sbg:stageInput': null
          'sbg:includeInPorts': true
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
          label: DCP Run Params File
          description: The data cleaning pipeline run parameters file
          id: '#dcp_run_params_yml_in'
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
          label: DCP Run Params File
          description: The data cleaning pipeline run parameters file
          outputBinding:
            glob: run_cleanup_params.yml
          id: '#dcp_run_params_yml_out'
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
                engine: '#cwl-js-engine'
                script: >

                  var str = "";


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


                  if ($job.inputs.dcp_run_params_yml_in) {
                      str += "cp -p " + $job.inputs.dcp_run_params_yml_in.path + " run_cleanup_params.yml";
                  }


                  str;
                class: Expression
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: ubuntu
      'sbg:id': mepstein/knoweng-samples-clustering-dev/samples-clustering-renamer/2
      'sbg:projectName': KnowEnG_Samples_Clustering_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1523045919
      'sbg:job':
        inputs:
          dcp_run_params_yml_in:
            class: File
            size: 0
            path: /path/to/dcp_run_params_yml_in.ext
            secondaryFiles: []
          interaction_network_metadata_file_in:
            class: File
            size: 0
            path: /path/to/interaction_network_metadata_file_in.ext
            secondaryFiles: []
          clean_genomic_file_in:
            class: File
            size: 0
            path: /path/to/clean_genomic_file_in.ext
            secondaryFiles: []
          gene_map_file_in:
            class: File
            size: 0
            path: /path/to/gene_map_file_in.ext
            secondaryFiles: []
          clean_phenotypic_file_in:
            class: File
            size: 0
            path: /path/to/clean_phenotypic_file_in.ext
            secondaryFiles: []
          use_network: true
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1523045919
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1523046548
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1525979998
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added dcp_run_parms_yml_in/_out input and output.
          'sbg:revision': 2
      'sbg:cmdPreview': sh file_renamer.cmd
      'sbg:revision': 2
      'sbg:project': mepstein/knoweng-samples-clustering-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:latestRevision': 2
      'sbg:revisionNotes': Added dcp_run_parms_yml_in/_out input and output.
      'sbg:modifiedOn': 1525979998
      x: 840
      'sbg:publisher': sbg
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 184
      'sbg:createdBy': mepstein
      'sbg:sbgMaintained': false
    label: Samples Clustering Renamer
    'sbg:x': 840
    'sbg:y': 184
  - id: '#Samples_Clustering'
    inputs:
      - id: '#Samples_Clustering.use_network'
        source: '#Samples_Clustering_Parameters.get_network'
      - id: '#Samples_Clustering.spreadsheet_file'
        source: '#Data_Cleaning_Preprocessing.clean_genomic_file'
      - id: '#Samples_Clustering.processing_method'
        source: '#processing_method'
      - id: '#Samples_Clustering.phenotype_file'
        source: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Samples_Clustering.parallelism'
        default: 4
      - id: '#Samples_Clustering.number_of_top_genes'
        source: '#number_of_top_genes'
      - id: '#Samples_Clustering.number_of_clusters'
        source: '#number_of_clusters'
      - id: '#Samples_Clustering.num_bootstraps'
        source: '#num_bootstraps'
      - id: '#Samples_Clustering.node_map_file'
        source: '#Knowledge_Network_Fetcher.node_map_file'
      - id: '#Samples_Clustering.network_influence_percent'
        source: '#network_influence_percent'
      - id: '#Samples_Clustering.network_file'
        source: '#Knowledge_Network_Fetcher.network_edge_file'
      - id: '#Samples_Clustering.bootstrap_sample_percent'
        source: '#bootstrap_sample_percent'
    outputs:
      - id: '#Samples_Clustering.top_genes'
      - id: '#Samples_Clustering.sample_labels'
      - id: '#Samples_Clustering.run_params_yml'
      - id: '#Samples_Clustering.readme'
      - id: '#Samples_Clustering.gene_avgs'
      - id: '#Samples_Clustering.consensus_matrix'
      - id: '#Samples_Clustering.clustering_evaluations'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      $namespaces:
        sbg: 'https://sevenbridges.com'
      id: mepstein/knoweng-samples-clustering-dev/samples-clustering/11
      label: Samples Clustering
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
      inputs:
        - 'sbg:toolDefaultValue': 'False'
          'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - boolean
          label: Use Network Flag
          description: Whether to use the network
          id: '#use_network'
        - required: true
          type:
            - File
          label: Genomic Spreadsheet File
          description: The genomic spreadsheet file
          id: '#spreadsheet_file'
        - 'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - type: enum
              symbols:
                - serial
                - parallel
              name: processing_method
          label: Processing Method
          description: 'The processing method (e.g., serial or parallel, default: serial)'
          id: '#processing_method'
        - required: false
          type:
            - 'null'
            - File
          label: Phenotype File
          description: The phenotype spreadsheet file
          id: '#phenotype_file'
        - 'sbg:toolDefaultValue': '4'
          'sbg:stageInput': null
          type:
            - 'null'
            - int
          label: Parallelism
          description: 'The parallelism (if the processing method is parallel; default: 4)'
          id: '#parallelism'
        - 'sbg:toolDefaultValue': '100'
          'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - int
          label: Number of Top Genes
          description: The number of top genes to find
          id: '#number_of_top_genes'
        - 'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: true
          type:
            - int
          label: Number of Clusters
          description: The number of clusters
          id: '#number_of_clusters'
        - 'sbg:toolDefaultValue': '0'
          'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - int
          label: Number of Bootstraps
          description: 'The number of bootstraps (default: 0)'
          id: '#num_bootstraps'
        - required: false
          type:
            - 'null'
            - File
          label: The Node Map File
          description: The node map file (from the KN Fetcher)
          id: '#node_map_file'
        - 'sbg:toolDefaultValue': '50'
          'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - int
          label: Amount of Network Influence
          description: >-
            The amount of network influence (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          id: '#network_influence_percent'
        - required: false
          type:
            - 'null'
            - File
          label: Knowledge Network File
          description: The knowledge network file
          id: '#network_file'
        - 'sbg:toolDefaultValue': '80'
          'sbg:stageInput': null
          'sbg:includeInPorts': true
          required: false
          type:
            - 'null'
            - int
          label: Bootstrap Sample Percent
          description: 'The bootstrap sample percent (default: 80%)'
          id: '#bootstrap_sample_percent'
      outputs:
        - type:
            - 'null'
            - File
          label: Top Genes
          description: Top genes by cluster
          outputBinding:
            glob: top_genes_by_cluster.txt
          id: '#top_genes'
        - type:
            - 'null'
            - File
          label: Sample Labels
          description: Sample labels by cluster
          outputBinding:
            glob: sample_labels_by_cluster.txt
          id: '#sample_labels'
        - type:
            - 'null'
            - File
          label: Configuration Parameters File
          description: The configuration parameters specified for the SC run
          outputBinding:
            glob: run_params.yml
          id: '#run_params_yml'
        - type:
            - 'null'
            - File
          label: The README file
          description: The README file that describes the output files
          outputBinding:
            glob: README-SC.md
          id: '#readme'
        - type:
            - 'null'
            - File
          label: Gene Averages
          description: Gene averages by cluster
          outputBinding:
            glob: gene_avgs_by_cluster.txt
          id: '#gene_avgs'
        - type:
            - 'null'
            - File
          label: Consensus Matrix
          description: Consensus matrix
          outputBinding:
            glob: consensus_matrix.txt
          id: '#consensus_matrix'
        - type:
            - 'null'
            - File
          label: Clustering Evaluations
          description: Clustering evaluations
          outputBinding:
            glob: clustering_evaluations.txt
          id: '#clustering_evaluations'
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
        - class: CreateFileRequirement
          fileDef:
            - filename: run_sc.cmd
              fileContent:
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


                  str += "number_of_clusters: " + $job.inputs.number_of_clusters
                  + "\n";

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
                class: Expression
            - filename: file_renamer.cmd
              fileContent:
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

                  //str += "cp -p top_genes_by_cluster*
                  top_genes_by_cluster.txt\n";

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
                class: Expression
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
            - filename: map_net_genes.py
              fileContent: >-
                #!/usr/bin/env python3


                # ./map_net_genes.py -f _7_gene_avgs_by_cluster.txt -n
                _5_gene_map.txt -m 9606.STRING_experimental.node_map -o Z1

                # /map_net_genes.py -f _7_top_genes_by_cluster.txt -n
                _5_gene_map.txt -m 9606.STRING_experimental.node_map -o Z2


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
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'knowengdev/samples_clustering_pipeline:04_09_2018'
      'sbg:id': mepstein/knoweng-samples-clustering-dev/samples-clustering/11
      'sbg:projectName': KnowEnG_Samples_Clustering_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1522384754
      'sbg:job':
        inputs:
          network_file:
            class: File
            size: 0
            path: /path/to/network_file.ext
            secondaryFiles: []
          network_influence_percent: 50
          phenotype_file:
            class: File
            size: 0
            path: /path/to/phenotype_file.ext
            secondaryFiles: []
          spreadsheet_file:
            class: File
            size: 0
            path: /path/to/spreadsheet_file.ext
            secondaryFiles: []
          bootstrap_sample_percent: 79
          parallelism: 4
          number_of_clusters: 11
          node_map_file:
            class: File
            size: 0
            path: /path/to/node_map_file.ext
            secondaryFiles: []
          number_of_top_genes: 100
          num_bootstraps: 8
          use_network: false
          processing_method: serial
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1522384754
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': null
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1522386484
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Initial version.
          'sbg:revision': 1
        - 'sbg:modifiedOn': 1522911860
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': 'Complete command, including renamer, wget, and output files.'
          'sbg:revision': 2
        - 'sbg:modifiedOn': 1522912887
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Made renaming of clustering_evaluation* conditional on existence of
            file.
          'sbg:revision': 3
        - 'sbg:modifiedOn': 1522913267
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed errors in file_renamer.sh.
          'sbg:revision': 4
        - 'sbg:modifiedOn': 1522913522
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': >-
            Fixed phenotypic_file name -- changed all occurrences of
            "phenotypic" to "phenotype".
          'sbg:revision': 5
        - 'sbg:modifiedOn': 1522913768
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed typos in wget command.
          'sbg:revision': 6
        - 'sbg:modifiedOn': 1523397683
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Changed how rows_sampling_fraction set (always 1.0).
          'sbg:revision': 7
        - 'sbg:modifiedOn': 1523410029
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Updated version of container.
          'sbg:revision': 8
        - 'sbg:modifiedOn': 1525982908
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added node_map_file input and map_net_genes.py.
          'sbg:revision': 9
        - 'sbg:modifiedOn': 1526011763
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Fixed errors in file_renamer.cmd javascript.
          'sbg:revision': 10
        - 'sbg:modifiedOn': 1526585167
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Added header to sample_labels output file; changed URL for wget.py.
          'sbg:revision': 11
      'sbg:cmdPreview': >-
        sh run_sc.cmd && sh file_renamer.cmd && python3 wget.py
        https://raw.githubusercontent.com/KnowEnG/quickstart-demos/573a3a09c46929083994a285497d1f43016aa1a6/pipeline_readmes/README-SC.md
        README-SC.md
      'sbg:revision': 11
      'sbg:project': mepstein/knoweng-samples-clustering-dev
      'sbg:modifiedBy': mepstein
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:latestRevision': 11
      'sbg:revisionNotes': Added header to sample_labels output file; changed URL for wget.py.
      'sbg:modifiedOn': 1526585167
      x: 776
      'sbg:publisher': sbg
      'sbg:image_url': null
      'sbg:validationErrors': []
      'y': 457
      'sbg:createdBy': mepstein
      'sbg:sbgMaintained': false
    label: Samples Clustering
    'sbg:x': 776
    'sbg:y': 457
  - id: '#Data_Cleaning_Preprocessing'
    inputs:
      - id: '#Data_Cleaning_Preprocessing.taxonid'
        source: '#taxonid'
      - id: '#Data_Cleaning_Preprocessing.redis_port'
        default: 6379
      - id: '#Data_Cleaning_Preprocessing.redis_pass'
        default: KnowEnG
      - id: '#Data_Cleaning_Preprocessing.redis_host'
        default: knowredis.knoweng.org
      - id: '#Data_Cleaning_Preprocessing.pipeline_type'
        default: samples_clustering_pipeline
      - id: '#Data_Cleaning_Preprocessing.phenotypic_spreadsheet_file'
        source: '#phenotypic_spreadsheet_file'
      - id: '#Data_Cleaning_Preprocessing.genomic_spreadsheet_file'
        source: '#genomic_spreadsheet_file'
    outputs:
      - id: '#Data_Cleaning_Preprocessing.gene_unmap_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_exceptions_file'
      - id: '#Data_Cleaning_Preprocessing.cmd_log_file'
      - id: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
      - id: '#Data_Cleaning_Preprocessing.cleaning_log_file'
      - id: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Data_Cleaning_Preprocessing.clean_genomic_file'
    run:
      cwlVersion: 'sbg:draft-2'
      class: CommandLineTool
      $namespaces:
        sbg: 'https://sevenbridges.com'
      id: mepstein/knoweng-samples-clustering-dev/data-cleaning-copy/1
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
          default: '9606'
          required: false
          'sbg:includeInPorts': true
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
          default:
            class: File
            location: /bin/sh
          required: false
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
        - type:
            - 'null'
            - type: enum
              symbols:
                - remove
                - average
                - reject
              name: geneset_characterization_impute
          label: GSC Imputation Strategy
          description: >-
            How to handle missing values in the input data (e.g., remove rows,
            fill in with row average, reject)
          id: '#geneset_characterization_impute'
        - doc: >-
            if pipeline_type=='gene_prioritization_pipeline', then must be one
            of either ['t_test', 'pearson']
          default: missing
          'sbg:stageInput': null
          type:
            - 'null'
            - type: enum
              symbols:
                - pearson
                - t_test
              name: gene_prioritization_corr_measure
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
          label: Gene Map Exceptions File
          description: The gene map exceptions file
          outputBinding:
            glob: '*_User_To_Ensembl.tsv'
          id: '#gene_map_exceptions_file'
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
              engine: '#cwl-js-engine'
              class: Expression
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
              engine: '#cwl-js-engine'
              class: Expression
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
                engine: '#cwl-js-engine'
                class: Expression
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
                      //str += "phenotype_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
                      if ($job.inputs.pipeline_type == "signature_analysis_pipeline") {
                          str += "signature_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
                      }
                      else {
                          str += "phenotype_name_full_path: " + $job.inputs.phenotypic_spreadsheet_file.path + "\n";
                      }
                  }


                  if ($job.inputs.pipeline_type ==
                  "gene_prioritization_pipeline") {
                      str += "correlation_measure: " + $job.inputs.gene_prioritization_corr_measure + "\n";
                  }

                  else if ($job.inputs.pipeline_type ==
                  "geneset_characterization_pipeline") {
                      str += "impute: " + $job.inputs.geneset_characterization_impute + "\n";
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
          coresMin: 1
          ramMin: 5000
          outdirMin: 512000
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerPull: 'knowengdev/data_cleanup_pipeline:04_11_2018'
      'sbg:id': mepstein/knoweng-samples-clustering-dev/data-cleaning-copy/1
      'sbg:revisionsInfo':
        - 'sbg:modifiedOn': 1523043785
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/20
          'sbg:revision': 0
        - 'sbg:modifiedOn': 1529390126
          'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
          'sbg:revision': 1
      'sbg:projectName': KnowEnG_Samples_Clustering_Dev
      'sbg:contributors':
        - mepstein
      'sbg:createdOn': 1523043785
      'sbg:job':
        allocatedResources:
          cpu: 1
          mem: 1000
        inputs:
          geneset_characterization_impute: remove
          gene_prioritization_corr_measure: pearson
          pipeline_type: geneset_characterization_pipeline
          genomic_spreadsheet_file:
            secondaryFiles: []
            class: File
            path: /path/to/file.tsv
            size: 0
      'sbg:cmdPreview': sh run_dc.cmd
      'y': 179.66666327582462
      'sbg:revision': 1
      'sbg:image_url': null
      'sbg:validationErrors': []
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:latestRevision': 1
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/21
      'sbg:modifiedBy': mepstein
      'sbg:modifiedOn': 1529390126
      x: 510.4444376627605
      'sbg:publisher': sbg
      'sbg:project': mepstein/knoweng-samples-clustering-dev
      'sbg:sbgMaintained': false
      'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/21
      doc: checks the inputs of a pipeline for potential sources of errors
      'sbg:createdBy': mepstein
    label: Data Cleaning/Preprocessing
    'sbg:x': 510.4444376627605
    'sbg:y': 179.66666327582462
requirements: []
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529393149
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529393192
    'sbg:revisionNotes': Imported SC Workflow.
  - 'sbg:revision': 2
    'sbg:modifiedBy': charles_blatti
    'sbg:modifiedOn': 1560524264
    'sbg:revisionNotes': Updated URLs
  - 'sbg:revision': 3
    'sbg:modifiedBy': charles_blatti
    'sbg:modifiedOn': 1560525912
    'sbg:revisionNotes': Added suggested input files
  - 'sbg:revision': 4
    'sbg:modifiedBy': charles_blatti
    'sbg:modifiedOn': 1560527222
    'sbg:revisionNotes': Improve input descriptions
'sbg:projectName': KnowEnG_Samples_Clustering_Public
'sbg:image_url': null
'sbg:toolAuthor': KnowEnG
'sbg:canvas_y': 20
'sbg:toolkitVersion': v1.0
'sbg:canvas_x': 8
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:categories':
  - Analysis
'sbg:canvas_zoom': 0.7999999999999998
'sbg:toolkit': KnowEnG_CGC
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-samples-clustering-public/samples-clustering-workflow/4/raw/
'sbg:id': mepstein/knoweng-samples-clustering-public/samples-clustering-workflow/4
'sbg:revision': 4
'sbg:revisionNotes': Improve input descriptions
'sbg:modifiedOn': 1560527222
'sbg:modifiedBy': charles_blatti
'sbg:createdOn': 1529393149
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-samples-clustering-public
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
  - charles_blatti
'sbg:latestRevision': 4
'sbg:publisher': KnowEnG
'sbg:content_hash': aca67ef456b83450acbc86b81dfe0272d96768bea08087f9a11b1dab93cf80c46
