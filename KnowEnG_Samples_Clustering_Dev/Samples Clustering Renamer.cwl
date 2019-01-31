hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: 'sbg:MemRequirement'
    value: 1000
  - class: DockerRequirement
    dockerPull: ubuntu
    dockerImageId: ''
'sbg:revisionNotes': Added dcp_run_parms_yml_in/_out input and output.
stdout: ''
cwlVersion: 'sbg:draft-2'
requirements:
  - class: CreateFileRequirement
    fileDef:
      - fileContent:
          class: Expression
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


            //9606.STRING_experimental.metadata interaction_network.metadata

            if ($job.inputs.use_network &&
            $job.inputs.interaction_network_metadata_file_in) {
                str += "cp -p " + $job.inputs.interaction_network_metadata_file_in.path + " interaction_network.metadata\n";
            }


            if ($job.inputs.dcp_run_params_yml_in) {
                str += "cp -p " + $job.inputs.dcp_run_params_yml_in.path + " run_cleanup_params.yml";
            }


            str;
        filename: file_renamer.cmd
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
arguments: []
label: Samples Clustering Renamer
temporaryFailCodes: []
baseCommand:
  - sh
  - file_renamer.cmd
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:job':
  inputs:
    gene_map_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/gene_map_file_in.ext
    interaction_network_metadata_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/interaction_network_metadata_file_in.ext
    dcp_run_params_yml_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/dcp_run_params_yml_in.ext
    clean_genomic_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/clean_genomic_file_in.ext
    clean_phenotypic_file_in:
      class: File
      secondaryFiles: []
      size: 0
      path: /path/to/clean_phenotypic_file_in.ext
    use_network: true
  allocatedResources:
    cpu: 1
    mem: 1000
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
  - label: DCP Run Params File
    type:
      - 'null'
      - File
    id: '#dcp_run_params_yml_out'
    outputBinding:
      glob: run_cleanup_params.yml
    description: The data cleaning pipeline run parameters file
'sbg:cmdPreview': sh file_renamer.cmd
description: >-
  Renames some of the intermediate files produced in the SC workflow to their
  final output names.
'sbg:projectName': KnowEnG_Samples_Clustering_Dev
class: CommandLineTool
'sbg:image_url': null
inputs:
  - label: Use Network Flag
    id: '#use_network'
    'sbg:stageInput': null
    description: Whether to use the network
    type:
      - 'null'
      - boolean
  - label: Clean Genomic Spreadsheet
    type:
      - 'null'
      - File
    description: The clean genomic spreadsheet
    id: '#clean_genomic_file_in'
  - label: Clean Phenotypic Spreadsheet
    type:
      - 'null'
      - File
    description: The clean phenotypic spreadsheet
    id: '#clean_phenotypic_file_in'
  - label: Gene Map File
    type:
      - 'null'
      - File
    description: The gene map file
    id: '#gene_map_file_in'
  - label: Interaction Network Metadata File
    type:
      - 'null'
      - File
    description: The interaction network metadata file
    id: '#interaction_network_metadata_file_in'
  - label: DCP Run Params File
    type:
      - 'null'
      - File
    id: '#dcp_run_params_yml_in'
    description: The data cleaning pipeline run parameters file
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1523045919
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1523046548
    'sbg:revisionNotes': Initial version.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1525979998
    'sbg:revisionNotes': Added dcp_run_parms_yml_in/_out input and output.
'sbg:publisher': sbg
stdin: ''
successCodes: []
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-samples-clustering-dev/samples-clustering-renamer/2/raw/
'sbg:id': mepstein/knoweng-samples-clustering-dev/samples-clustering-renamer/2
'sbg:revision': 2
'sbg:modifiedOn': 1525979998
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1523045919
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-samples-clustering-dev
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 2
'sbg:content_hash': null
