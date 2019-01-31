inputs:
  - label: Knowledge Network Edge Type
    type:
      - 'null'
      - string
    id: '#knowledge_network_edge_type'
    description: The knowledge network edge type (not required)
  - label: GP Correlation Measure
    type:
      - symbols:
          - pearson
          - t_test
        name: correlation_measure_in
        type: enum
    id: '#correlation_measure_in'
    description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
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
  - label: GP Correlation Measure
    description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
    type:
      - 'null'
      - string
    outputBinding:
      outputEval:
        class: Expression
        engine: '#cwl-js-engine'
        script: |
          $job.inputs.correlation_measure_in;
    id: '#correlation_measure_out'
stdout: ''
'sbg:cmdPreview': ''
description: >-
  Sets the input parameters of some of the intermediate apps in the GP workflow
  based on some of the input parameters to the workflow itself.
'sbg:projectName': KnowEnG_GenePrioritization_Demo
requirements:
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
class: CommandLineTool
'sbg:image_url': null
successCodes: []
baseCommand:
  - ''
label: Gene Prioritization Parameters
temporaryFailCodes: []
'sbg:job':
  inputs:
    correlation_measure_in: pearson
    knowledge_network_edge_type: knowledge_network_edge_type-string-value
  allocatedResources:
    cpu: 1
    mem: 1000
arguments: []
cwlVersion: 'sbg:draft-2'
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517287702
    'sbg:revisionNotes': >-
      Copy of
      mepstein/knoweng-geneprioritization-dev/gene-prioritization-parameters/5
hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerImageId: ''
    dockerPull: ubuntu
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0/raw/
'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
'sbg:revision': 0
'sbg:revisionNotes': >-
  Copy of
  mepstein/knoweng-geneprioritization-dev/gene-prioritization-parameters/5
'sbg:modifiedOn': 1517287702
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1517287702
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-geneprioritization-dev/gene-prioritization-parameters/5
