inputs:
  - 'sbg:toolDefaultValue': 'true'
    label: Get Network Flag
    description: Whether to get the network (or create a dummy/empty network file)
    type:
      - 'null'
      - boolean
    id: '#get_network'
    doc: whether or not to get the network
    default: true
  - 'sbg:toolDefaultValue': KnowNets/KN-20rep-1706/userKN-20rep-1706
    label: AWS S3 Bucket Name
    description: The AWS S3 bucket to fetch the network from
    type:
      - 'null'
      - string
    id: '#bucket'
    doc: the aws s3 bucket
    default: KnowNets/KN-20rep-1706/userKN-20rep-1706
  - 'sbg:toolDefaultValue': Gene
    label: Network Type
    description: 'The network type (e.g., Gene, Property)'
    type:
      - 'null'
      - string
    id: '#network_type'
    doc: the type of subnetwork
    default: Gene
  - 'sbg:toolDefaultValue': '9606'
    label: Network Species Taxon ID
    description: 'The network species taxon ID (e.g., 9606 for human)'
    type:
      - 'null'
      - string
    id: '#taxonid'
    doc: the taxonomic id for the species of interest
    default: '9606'
  - 'sbg:toolDefaultValue': STRING_experimental
    label: Network Edge Type
    description: 'The network edge type (e.g., STRING_experimental, gene_ontology)'
    type:
      - 'null'
      - string
    id: '#edge_type'
    doc: the edge type keyword for the subnetwork of interest
    default: PPI_physical_association
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
  - class: ResourceRequirement
    outdirMin: 512000
    coresMin: 1
    ramMin: 2000
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
stdout: ''
'sbg:publisher': sbg
description: >-
  Fetch a knowledge network from an AWS S3 bucket, given a network type, an edge
  type, and a species taxon ID.
'sbg:projectName': KnowEnG_Samples_Clustering_Demo
outputs:
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
  - label: Network Metadata File
    description: The network metadata file
    outputBinding:
      glob: '*.metadata'
    id: '#network_metadata_file'
    doc: yaml format describing network contents
    type:
      - 'null'
      - File
class: CommandLineTool
'sbg:image_url': null
successCodes: []
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: CreateFileRequirement
    fileDef:
      - fileContent:
          class: Expression
          engine: '#cwl-js-engine'
          script: >
            //MYCMD="date && if [ " + $job.inputs.get_network + ' = "true" ];
            then /home/kn_fetcher.sh '+$job.inputs.bucket+'
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
'sbg:cmdPreview': sh run_fetch.cmd
label: Knowledge Network Fetcher
temporaryFailCodes: []
'sbg:job':
  inputs: {}
  allocatedResources:
    cpu: 1
    mem: 1000
arguments: []
cwlVersion: 'sbg:draft-2'
baseCommand:
  - sh
  - run_fetch.cmd
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529391200
    'sbg:revisionNotes': Copy of mepstein/knoweng-samples-clustering-dev/kn-fetcher-cb/0
doc: >-
  Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS S3
  storage
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-samples-clustering-demo/kn-fetcher-cb/0/raw/
'sbg:id': mepstein/knoweng-samples-clustering-demo/kn-fetcher-cb/0
'sbg:revision': 0
'sbg:revisionNotes': Copy of mepstein/knoweng-samples-clustering-dev/kn-fetcher-cb/0
'sbg:modifiedOn': 1529391200
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529391200
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-samples-clustering-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-samples-clustering-dev/kn-fetcher-cb/0
