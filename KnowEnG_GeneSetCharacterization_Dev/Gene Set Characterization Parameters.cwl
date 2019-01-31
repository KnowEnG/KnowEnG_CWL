inputs:
  - label: Knowledge Network Edge Type
    type:
      - 'null'
      - string
    description: The knowledge network edge type (not required)
    id: '#knowledge_network_edge_type'
hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: ubuntu
    dockerImageId: ''
stdout: ''
'sbg:cmdPreview': ''
description: >-
  Sets the input parameters of some of the intermediate apps in the GSC workflow
  based on some of the input parameters to the workflow itself.
'sbg:projectName': KnowEnG_GeneSetCharacterization_Dev
outputs:
  - label: Get Network Flag
    id: '#get_network'
    type:
      - 'null'
      - boolean
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
  - label: Network Edge Type
    id: '#edge_type'
    type:
      - 'null'
      - string
    description: The network edge type
    outputBinding:
      outputEval:
        class: Expression
        engine: '#cwl-js-engine'
        script: |
          $job.inputs.knowledge_network_edge_type;
  - label: GSC Method
    id: '#gsc_method'
    type:
      - 'null'
      - string
    description: 'The GSC method to use (e.g., DRaWR, fisher)'
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
class: CommandLineTool
'sbg:image_url': null
successCodes: []
requirements:
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
baseCommand:
  - ''
label: Gene Set Characterization Parameters
temporaryFailCodes: []
arguments: []
cwlVersion: 'sbg:draft-2'
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508907200
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508908202
    'sbg:revisionNotes': null
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508908332
    'sbg:revisionNotes': null
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508947441
    'sbg:revisionNotes': null
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508949007
    'sbg:revisionNotes': null
  - 'sbg:revision': 5
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1508950175
    'sbg:revisionNotes': null
'sbg:job':
  inputs:
    knowledge_network_edge_type: knowlege_network_edge_type-string-value
  allocatedResources:
    cpu: 1
    mem: 1000
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/genesetcharacterization/gene-set-characterization-parameters/5/raw/
'sbg:id': mepstein/genesetcharacterization/gene-set-characterization-parameters/5
'sbg:revision': 5
'sbg:revisionNotes': null
'sbg:modifiedOn': 1508950175
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1508907200
'sbg:createdBy': mepstein
'sbg:project': mepstein/genesetcharacterization
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 5
'sbg:content_hash': null
