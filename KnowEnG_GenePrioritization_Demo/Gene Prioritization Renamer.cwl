inputs:
  - label: Use Network Flag
    type:
      - 'null'
      - boolean
    'sbg:stageInput': null
    id: '#use_network'
    description: Whether to use the network
  - label: Clean Genomic Spreadsheet
    type:
      - 'null'
      - File
    id: '#clean_genomic_file_in'
    description: The clean genomic spreadsheet
  - label: Clean Phenotypic Spreadsheet
    type:
      - 'null'
      - File
    id: '#clean_phenotypic_file_in'
    description: The clean phenotypic spreadsheet
  - label: Gene Map File
    type:
      - 'null'
      - File
    id: '#gene_map_file_in'
    description: The gene map file
  - label: Interaction Network Metadata File
    type:
      - 'null'
      - File
    id: '#interaction_network_metadata_file_in'
    description: The interaction network metadata file
outputs:
  - label: Clean Genomic Spreadsheet
    id: '#clean_genomic_file_out'
    type:
      - 'null'
      - File
    outputBinding:
      glob: clean_genomic_matrix.txt
    description: The clean genomic spreadsheet
  - label: Clean Phenotypic Spreadsheet
    id: '#clean_phenotypic_file_out'
    type:
      - 'null'
      - File
    outputBinding:
      glob: clean_phenotypic_matrix.txt
    description: The clean phenotypic spreadsheet
  - label: Gene Map File
    id: '#gene_map_file_out'
    type:
      - 'null'
      - File
    outputBinding:
      glob: gene_map.txt
    description: The gene map file
  - label: Interaction Network Metadata File
    id: '#interaction_network_metadata_file_out'
    type:
      - 'null'
      - File
    outputBinding:
      glob: interaction_network.metadata
    description: The interaction network metadata file
stdout: ''
'sbg:cmdPreview': sh file_renamer.cmd
description: >-
  Renames some of the intermediate files produced in the GP workflow to their
  final output names.
'sbg:projectName': KnowEnG_GenePrioritization_Demo
requirements:
  - class: CreateFileRequirement
    fileDef:
      - fileContent:
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


            //9606.STRING_experimental.metadata interaction_network.metadata

            if ($job.inputs.use_network &&
            $job.inputs.interaction_network_metadata_file_in) {
                str += "cp -p " + $job.inputs.interaction_network_metadata_file_in.path + " interaction_network.metadata\n";
            }


            str;
        filename: file_renamer.cmd
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
class: CommandLineTool
arguments: []
successCodes: []
baseCommand:
  - sh
  - file_renamer.cmd
label: Gene Prioritization Renamer
temporaryFailCodes: []
'sbg:job':
  inputs:
    interaction_network_metadata_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/interaction_network_metadata_file.ext
    clean_phenotypic_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/phenotypic_file.ext
    clean_genomic_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/genomic_file.ext
    gene_map_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/gene_map_file.ext
    use_network: true
  allocatedResources:
    cpu: 1
    mem: 1000
'sbg:image_url': null
cwlVersion: 'sbg:draft-2'
'sbg:publisher': sbg
stdin: ''
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517287711
    'sbg:revisionNotes': >-
      Copy of
      mepstein/knoweng-geneprioritization-dev/gene-prioritization-renamer/4
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
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0/raw/
'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
'sbg:revision': 0
'sbg:revisionNotes': Copy of mepstein/knoweng-geneprioritization-dev/gene-prioritization-renamer/4
'sbg:modifiedOn': 1517287711
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1517287711
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 0
'sbg:content_hash': null
'sbg:copyOf': mepstein/knoweng-geneprioritization-dev/gene-prioritization-renamer/4
