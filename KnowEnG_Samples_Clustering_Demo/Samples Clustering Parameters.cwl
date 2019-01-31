hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: ubuntu
    dockerImageId: ''
'sbg:revisionNotes': >-
  Copy of
  mepstein/knoweng-samples-clustering-dev/samples-clustering-parameters/1
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: Samples Clustering Parameters
temporaryFailCodes: []
baseCommand:
  - ''
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    knowledge_network_edge_type: knowledge_network_edge_type-string-value
  allocatedResources:
    cpu: 1
    mem: 1000
outputs:
  - label: Get Network Flag
    description: Whether to get the network
    type:
      - 'null'
      - boolean
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
  - label: Network Edge Type
    description: The network edge type
    type:
      - 'null'
      - string
    outputBinding:
      outputEval:
        class: Expression
        engine: '#cwl-js-engine'
        script: |
          $job.inputs.knowledge_network_edge_type;
    id: '#edge_type'
inputs:
  - label: Knowledge Network Edge Type
    description: The knowledge network edge type (not required)
    id: '#knowledge_network_edge_type'
    type:
      - 'null'
      - string
'sbg:cmdPreview': ''
description: >-
  Sets the input parameters of some of the intermediate apps in the SC workflow
  based on some of the input parameters to the workflow itself.
'sbg:projectName': KnowEnG_Samples_Clustering_Demo
class: CommandLineTool
'sbg:image_url': null
successCodes: []
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1529391247
    'sbg:revisionNotes': >-
      Copy of
      mepstein/knoweng-samples-clustering-dev/samples-clustering-parameters/1
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-samples-clustering-demo/samples-clustering-parameters/0/raw/
'sbg:id': mepstein/knoweng-samples-clustering-demo/samples-clustering-parameters/0
'sbg:revision': 0
'sbg:modifiedOn': 1529391247
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1529391247
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-samples-clustering-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-samples-clustering-dev/samples-clustering-parameters/1
