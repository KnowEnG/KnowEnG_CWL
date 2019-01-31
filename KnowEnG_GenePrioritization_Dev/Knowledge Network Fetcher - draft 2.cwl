inputs:
  - label: AWS Access Key ID
    id: '#aws_access_key_id'
    description: the aws access key id
    type:
      - string
  - label: AWS Secret Access Key
    id: '#aws_secret_access_key'
    description: the aws secrety access key
    type:
      - string
  - label: AWS S3 Bucket Name
    id: '#bucket'
    default: KNsample
    description: the aws s3 bucket
    type:
      - 'null'
      - string
  - label: Subnetwork Class
    id: '#network_type'
    default: Gene
    description: the type of subnetwork
    type:
      - 'null'
      - string
  - label: Subnetwork Species ID
    id: '#taxon'
    default: '9606'
    description: the taxonomic id for the species of interest
    type:
      - string
  - label: Subnetwork Edge Type
    id: '#edge_type'
    default: PPI_physical_association
    description: the edge type keyword for the subnetwork of interest
    type:
      - string
  - label: Output Filename
    id: '#output_name'
    default: KN.4col.edge
    description: the output file name to save the contents of the key to
    type:
      - 'null'
      - string
outputs:
  - label: Subnetwork Edge File
    id: '#output_file'
    description: 4 column format for subnetwork for single edge type and species
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: $job.inputs.output_name
    type:
      - File
stdout: ''
cwlVersion: 'sbg:draft-2'
description: >-
  Retrieve appropriate subnetwork from KnowEnG Knowledge Network from AWS S3
  storage
'sbg:projectName': KnowEnG_GenePrioritization_Dev
requirements:
  - class: InlineJavascriptRequirement
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
class: CommandLineTool
arguments:
  - prefix: '--access_key'
    valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: $job.inputs.aws_access_key_id
    separate: true
  - prefix: '--secret_key'
    valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: $job.inputs.aws_secret_access_key
    separate: true
  - valueFrom: get
  - valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: >-
        's3://' + $job.inputs.bucket + '/' + $job.inputs.network_type + '/' +
        $job.inputs.taxon + '/' + $job.inputs.edge_type + '/' +
        $job.inputs.taxon + '.' + $job.inputs.edge_type + '.edge'
  - valueFrom:
      class: Expression
      engine: '#cwl-js-engine'
      script: $job.inputs.output_name
successCodes: []
label: Knowledge Network Fetcher - draft 2
stdin: ''
temporaryFailCodes: []
'sbg:job':
  inputs: {}
  allocatedResources:
    cpu: 1
    mem: 1000
'sbg:toolAuthor': KnowEnG
'sbg:cmdPreview': >-
  s3cmd --access_key  --secret_key  get
  s3://undefined/undefined/undefined/undefined/undefined.undefined.edge
baseCommand:
  - s3cmd
'sbg:image_url': null
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1513885131
    'sbg:revisionNotes': Copy of mepstein/geneprioritization/knowledge-network-fetcher/3
hints:
  - class: DockerRequirement
    dockerPull: 'cblatti3/aws:0.1'
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: 'cblatti3/aws:0.1'
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-dev/knowledge-network-fetcher/0/raw/
'sbg:id': mepstein/knoweng-geneprioritization-dev/knowledge-network-fetcher/0
'sbg:revision': 0
'sbg:revisionNotes': Copy of mepstein/geneprioritization/knowledge-network-fetcher/3
'sbg:modifiedOn': 1513885131
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1513885131
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:publisher': sbg
'sbg:content_hash': null
'sbg:copyOf': mepstein/geneprioritization/knowledge-network-fetcher/3
