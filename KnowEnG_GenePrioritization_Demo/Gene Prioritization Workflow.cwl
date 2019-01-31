inputs:
  - label: Genomic Spreadsheet File
    'sbg:x': 218.82352701822924
    description: 'The genomic spreadsheet file, genes x samples, tab-separated.'
    'sbg:y': 149.68627929687503
    'sbg:includeInPorts': true
    id: '#genomic_spreadsheet_file'
    type:
      - File
  - label: Bootstrap Sample Percent
    'sbg:x': 228.92311604817715
    description: >-
      The bootstrap sample percent (an integer between 0 and 100, inclusive;
      default 80%).
    'sbg:y': 894.0512695312502
    'sbg:includeInPorts': true
    id: '#bootstrap_sample_percent'
    type:
      - 'null'
      - int
  - label: Correlation Measure
    'sbg:x': 216.00000000000006
    description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
    'sbg:y': 548.0000000000001
    'sbg:includeInPorts': true
    id: '#correlation_measure_in'
    type:
      - symbols:
          - pearson
          - t_test
        name: correlation_measure_in
        type: enum
  - label: Species Taxon ID
    'sbg:x': 80.00000000000003
    description: >-
      The species taxon ID (e.g., 9606 for human).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_species] for
      possible values (KN Contents by Species).
    'sbg:y': 69.00000000000003
    'sbg:includeInPorts': true
    id: '#taxonid'
    type:
      - string
  - label: Phenotypic Spreadsheet File
    'sbg:x': 85.23531087239586
    description: The phenotypic spreadsheet file
    'sbg:y': 277.94116210937506
    'sbg:includeInPorts': true
    id: '#phenotypic_spreadsheet_file'
    type:
      - File
  - label: Amount of Network Influence
    'sbg:x': 91.37254842122398
    description: >-
      The amount of network influence (as a percent, i.e., an integer between 0
      and 100, inclusive; default 50%); a greater value means greater
      contribution from the network interactions.  This value is only used if
      the knowledge network is used in the analysis.
    'sbg:y': 634.1569010416669
    'sbg:includeInPorts': true
    id: '#network_influence_percent'
    type:
      - 'null'
      - int
  - label: Knowledge Network Edge Type
    'sbg:x': 96.00000000000001
    description: >-
      The knowledge network edge type (e.g., STRING_experimental).  See
      [https://knoweng.org/kn-data-references/#kn_contents_by_gene-gene_edge_type]
      for possible values (KN Contents by Gene-Gene Edge Type).  Leave this
      blank to not use the knowledge network in the analysis.
    'sbg:y': 458.6666666666668
    'sbg:includeInPorts': true
    id: '#knowledge_network_edge_type'
    type:
      - 'null'
      - string
  - label: Number of Top Genes
    'sbg:x': 225.25488281250006
    description: The number of top genes to find (default 100).
    'sbg:y': 729.0196126302085
    'sbg:includeInPorts': true
    id: '#number_of_top_genes'
    type:
      - 'null'
      - int
  - label: Number of Bootstraps
    'sbg:x': 87.96982828776045
    description: The number of bootstraps to use (0 means no bootstrapping; default 0).
    'sbg:y': 804.0180664062502
    'sbg:includeInPorts': true
    id: '#num_bootstraps'
    type:
      - 'null'
      - int
'sbg:revisionNotes': Updated version of ProGENI.
'sbg:canvas_zoom': 0.6999999999999997
'sbg:toolkitVersion': v1.0
'sbg:canvas_x': 53
cwlVersion: 'sbg:draft-2'
'sbg:canvas_y': 15
outputs:
  - label: GP Run Params yml
    'sbg:x': 1312.0000000000005
    description: The configuration parameters specified for the GP run
    'sbg:y': 662.6666666666669
    source:
      - '#ProGENI.run_params_yml'
    'sbg:includeInPorts': true
    id: '#run_params_yml'
    required: false
    type:
      - 'null'
      - File
  - label: Interaction Network Metadata File
    'sbg:x': 1488.0000000000005
    description: The interaction network metadata file
    'sbg:y': 364.0000000000001
    source:
      - '#Gene_Prioritization_Renamer.interaction_network_metadata_file_out'
    'sbg:includeInPorts': true
    id: '#interaction_network_metadata_file_out'
    required: false
    type:
      - 'null'
      - File
  - label: README
    'sbg:x': 1488.0000000000005
    description: README-GP.md
    'sbg:y': 742.6666666666669
    source:
      - '#ProGENI.readme'
    'sbg:includeInPorts': true
    id: '#readme'
    required: false
    type:
      - 'null'
      - File
  - label: Gene Map File
    'sbg:x': 1313.3333333333337
    description: The gene map file
    'sbg:y': 256.00000000000006
    source:
      - '#Gene_Prioritization_Renamer.gene_map_file_out'
    'sbg:includeInPorts': true
    id: '#gene_map_file_out'
    required: false
    type:
      - 'null'
      - File
  - label: Clean Genomic File
    'sbg:x': 1320.0000000000005
    description: The clean genomic spreadsheet file
    'sbg:y': 65.33333333333334
    source:
      - '#Gene_Prioritization_Renamer.clean_genomic_file_out'
    'sbg:includeInPorts': true
    id: '#clean_genomic_file_out'
    required: false
    type:
      - 'null'
      - File
  - label: Clean Phenotypic File
    'sbg:x': 1488.0000000000005
    description: The clean phenotypic spreadsheet file
    'sbg:y': 164.00000000000006
    source:
      - '#Gene_Prioritization_Renamer.clean_phenotypic_file_out'
    'sbg:includeInPorts': true
    id: '#clean_phenotypic_file_out'
    required: false
    type:
      - 'null'
      - File
  - label: Ranked Genes File
    'sbg:x': 1308.0000000000005
    description: The genes ranked file
    'sbg:y': 476.00000000000017
    source:
      - '#ProGENI.genes_ranked_file'
    'sbg:includeInPorts': true
    id: '#genes_ranked_file'
    required: false
    type:
      - 'null'
      - File
  - label: Top Genes File
    'sbg:x': 1485.3333333333337
    description: The top genes file
    'sbg:y': 556.0000000000001
    source:
      - '#ProGENI.top_genes_file'
    'sbg:includeInPorts': true
    id: '#top_genes_file'
    required: false
    type:
      - 'null'
      - File
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
  [here](https://github.com/KnowEnG/quickstart-demos/blob/master/pipeline_readmes/README-GP.md).


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
'sbg:projectName': KnowEnG_GenePrioritization_Demo
label: Gene Prioritization Workflow
class: Workflow
'sbg:image_url': >-
  https://cgc.sbgenomics.com/ns/brood/images/mepstein/knoweng-geneprioritization-demo/gene-prioritization-workflow/4.png
requirements: []
'sbg:categories':
  - Analysis
  - Prioritization
steps:
  - inputs:
      - source:
          - '#taxonid'
        id: '#Data_Cleaning_Preprocessing.taxonid'
      - id: '#Data_Cleaning_Preprocessing.source_hint'
      - id: '#Data_Cleaning_Preprocessing.redis_port'
        default: 6379
      - id: '#Data_Cleaning_Preprocessing.redis_pass'
        default: KnowEnG
      - id: '#Data_Cleaning_Preprocessing.redis_host'
        default: knowredis.knoweng.org
      - id: '#Data_Cleaning_Preprocessing.pipeline_type'
        default: gene_prioritization_pipeline
      - source:
          - '#phenotypic_spreadsheet_file'
        id: '#Data_Cleaning_Preprocessing.phenotypic_spreadsheet_file'
      - source:
          - '#genomic_spreadsheet_file'
        id: '#Data_Cleaning_Preprocessing.genomic_spreadsheet_file'
      - source:
          - '#Gene_Prioritization_Parameters.correlation_measure_out'
        id: '#Data_Cleaning_Preprocessing.gene_prioritization_corr_measure'
    outputs:
      - id: '#Data_Cleaning_Preprocessing.gene_unmap_file'
      - id: '#Data_Cleaning_Preprocessing.gene_map_file'
      - id: '#Data_Cleaning_Preprocessing.cmd_log_file'
      - id: '#Data_Cleaning_Preprocessing.cleaning_parameters_yml'
      - id: '#Data_Cleaning_Preprocessing.cleaning_log_file'
      - id: '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
      - id: '#Data_Cleaning_Preprocessing.clean_genomic_file'
    'sbg:x': 687.777750651042
    run:
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
          type:
            - 'null'
            - string
          id: '#source_hint'
          doc: >-
            suggestion for ID source database used to resolve ambiguities in
            mapping
          default: \'\'
        - 'sbg:toolDefaultValue': 6379
          label: RedisDB Port
          description: The redis DB port
          type:
            - 'null'
            - int
          id: '#redis_port'
          doc: port for Redis db
          default: 6379
        - 'sbg:toolDefaultValue': KnowEnG
          label: RedisDB Password
          description: The redis DB password
          type:
            - 'null'
            - string
          id: '#redis_pass'
          doc: password for Redis db
          default: KnowEnG
        - 'sbg:toolDefaultValue': knowredis.knoweng.org
          label: RedisDB Host
          description: The redis DB host name
          type:
            - 'null'
            - string
          id: '#redis_host'
          doc: url of Redis db
          default: knowredis.knoweng.org
        - label: Name of Pipeline
          description: >-
            The name of the pipeline that will be run (i.e., data cleaning is
            pipeline-specific)
          id: '#pipeline_type'
          doc: >-
            keywork name of pipeline from following list
            ['gene_prioritization_pipeline', 'samples_clustering_pipeline',
            'geneset_characterization_pipeline']
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
          'sbg:includeInPorts': true
          id: '#gene_prioritization_corr_measure'
          required: false
          default: missing
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
      'sbg:modifiedOn': 1513886524
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 687.777750651042
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
      'sbg:createdBy': mepstein
      label: Data Cleaning/Preprocessing
      'sbg:copyOf': mepstein/genesetcharacterization/data-cleaning-copy/18
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-geneprioritization-demo/data-cleaning-copy/0
      'sbg:latestRevision': 0
      baseCommand:
        - sh
        - run_dc.cmd
      id: mepstein/knoweng-geneprioritization-demo/data-cleaning-copy/0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      outputs:
        - label: Gene Unmapped File
          description: The genes that were not mapped
          type:
            - 'null'
            - File
          id: '#gene_unmap_file'
          doc: two columns for original gene ids and unmapped reason code
          outputBinding:
            glob: '*_UNMAPPED.tsv'
        - label: Gene Map File
          description: The gene map file
          type:
            - 'null'
            - File
          id: '#gene_map_file'
          doc: two columns for internal gene ids and original gene ids
          outputBinding:
            glob: '*_MAP.tsv'
        - label: Command Log File
          id: '#cmd_log_file'
          type:
            - 'null'
            - File
          outputBinding:
            glob: run_dc.cmd
          description: The log of the data cleaning command
        - label: Cleaning Parameters File
          description: The configuration parameters specified for the data cleaning run
          type:
            - 'null'
            - File
          id: '#cleaning_parameters_yml'
          doc: data cleaning parameters in yaml format
          outputBinding:
            glob: run_cleanup.yml
        - label: Cleaning Log File
          description: The log of the data cleaning run
          type:
            - 'null'
            - File
          id: '#cleaning_log_file'
          doc: information on souce of errors for cleaning pipeline
          outputBinding:
            glob: log_*_pipeline.yml
        - label: Clean Phenotypic Spreadsheet
          description: The clean phenotypic spreadsheet
          type:
            - 'null'
            - File
          id: '#clean_phenotypic_file'
          doc: phenotype file prepared for pipeline
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
        - label: Clean Genomic Spreadsheet
          description: The clean genomic spreadsheet
          type:
            - 'null'
            - File
          id: '#clean_genomic_file'
          doc: matrix with gene names mapped and data cleaned
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
      'sbg:modifiedBy': mepstein
      'sbg:revision': 0
      'sbg:cmdPreview': sh run_dc.cmd
      description: >-
        Clean/preprocess input data (genomic and optionally phenotypic) for use
        with other tools/pipelines.
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      class: CommandLineTool
      'sbg:image_url': null
      'y': 138.3333129882813
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      doc: checks the inputs of a pipeline for potential sources of errors
      successCodes: []
      'sbg:createdOn': 1513886524
      'sbg:publisher': sbg
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/data-cleaning-copy/18
          'sbg:modifiedOn': 1513886524
          'sbg:revision': 0
      hints:
        - class: DockerRequirement
          dockerPull: 'knowengdev/data_cleanup_pipeline:07_26_2017'
        - outdirMin: 512000
          class: ResourceRequirement
          coresMin: 1
          ramMin: 5000
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
    'sbg:y': 138.3333129882813
    id: '#Data_Cleaning_Preprocessing'
  - inputs:
      - source:
          - '#taxonid'
        id: '#Knowledge_Network_Fetcher.taxonid'
      - id: '#Knowledge_Network_Fetcher.network_type'
        default: Gene
      - source:
          - '#Gene_Prioritization_Parameters.get_network'
        id: '#Knowledge_Network_Fetcher.get_network'
      - source:
          - '#Gene_Prioritization_Parameters.edge_type'
        id: '#Knowledge_Network_Fetcher.edge_type'
      - id: '#Knowledge_Network_Fetcher.bucket'
        default: KnowNets/KN-20rep-1706/userKN-20rep-1706
    outputs:
      - id: '#Knowledge_Network_Fetcher.pnode_map_file'
      - id: '#Knowledge_Network_Fetcher.node_map_file'
      - id: '#Knowledge_Network_Fetcher.network_metadata_file'
      - id: '#Knowledge_Network_Fetcher.network_edge_file'
      - id: '#Knowledge_Network_Fetcher.cmd_log_file'
    'sbg:x': 689.3333333333335
    run:
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
          type:
            - 'null'
            - string
          id: '#network_type'
          doc: the type of subnetwork
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
          type:
            - 'null'
            - string
          id: '#bucket'
          doc: the aws s3 bucket
          default: KnowNets/KN-20rep-1706/userKN-20rep-1706
      'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
      'sbg:modifiedOn': 1516299548
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 689.3333333333335
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
      'sbg:createdBy': mepstein
      label: Knowledge Network Fetcher
      'sbg:copyOf': mepstein/genesetcharacterization/kn-fetcher-cb/9
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-geneprioritization-demo/kn-fetcher-cb/0
      'sbg:latestRevision': 0
      baseCommand:
        - sh
        - run_fetch.cmd
      id: mepstein/knoweng-geneprioritization-demo/kn-fetcher-cb/0
      'sbg:job':
        inputs: {}
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      outputs:
        - label: PNode Map File
          description: The pnode map file
          type:
            - 'null'
            - File
          id: '#pnode_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
          outputBinding:
            glob: '*.pnode_map'
        - label: Node Map File
          description: The node map file
          type:
            - 'null'
            - File
          id: '#node_map_file'
          doc: >-
            5 column node map with [original_node_id, mapped_node_id, node_type,
            node_alias, node_description]
          outputBinding:
            glob: '*.node_map'
        - label: Network Metadata File
          description: The network metadata file
          type:
            - 'null'
            - File
          id: '#network_metadata_file'
          doc: yaml format describing network contents
          outputBinding:
            glob: '*.metadata'
        - label: Network Edge File
          description: The network edge file
          type:
            - 'null'
            - File
          id: '#network_edge_file'
          doc: 4 column format for subnetwork for single edge type and species
          outputBinding:
            glob: '*.edge'
        - label: Command Log File
          description: The log of the fetch command
          type:
            - 'null'
            - File
          id: '#cmd_log_file'
          doc: log of fetch command
          outputBinding:
            glob: run_fetch.cmd
      'sbg:modifiedBy': mepstein
      'sbg:revision': 0
      'sbg:cmdPreview': sh run_fetch.cmd
      description: >-
        Fetch a knowledge network from an AWS S3 bucket, given a network type,
        an edge type, and a species taxon ID.
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      class: CommandLineTool
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
      successCodes: []
      'sbg:createdOn': 1516299548
      'sbg:publisher': sbg
      stdin: ''
      'sbg:revisionsInfo':
        - 'sbg:modifiedBy': mepstein
          'sbg:revisionNotes': Copy of mepstein/genesetcharacterization/kn-fetcher-cb/9
          'sbg:modifiedOn': 1516299548
          'sbg:revision': 0
      hints:
        - class: DockerRequirement
          dockerPull: 'quay.io/cblatti3/kn_fetcher:latest'
        - outdirMin: 512000
          class: ResourceRequirement
          coresMin: 1
          ramMin: 2000
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
    'sbg:y': 577.6666666666667
    id: '#Knowledge_Network_Fetcher'
  - inputs:
      - source:
          - '#Gene_Prioritization_Parameters.get_network'
        id: '#Gene_Prioritization_Renamer.use_network'
      - source:
          - '#Knowledge_Network_Fetcher.network_metadata_file'
        id: '#Gene_Prioritization_Renamer.interaction_network_metadata_file_in'
      - source:
          - '#Data_Cleaning_Preprocessing.gene_map_file'
        id: '#Gene_Prioritization_Renamer.gene_map_file_in'
      - source:
          - '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
        id: '#Gene_Prioritization_Renamer.clean_phenotypic_file_in'
      - source:
          - '#Data_Cleaning_Preprocessing.clean_genomic_file'
        id: '#Gene_Prioritization_Renamer.clean_genomic_file_in'
    outputs:
      - id: '#Gene_Prioritization_Renamer.interaction_network_metadata_file_out'
      - id: '#Gene_Prioritization_Renamer.gene_map_file_out'
      - id: '#Gene_Prioritization_Renamer.clean_phenotypic_file_out'
      - id: '#Gene_Prioritization_Renamer.clean_genomic_file_out'
    'sbg:x': 984.0000000000003
    run:
      'sbg:modifiedBy': mepstein
      inputs:
        - label: Use Network Flag
          description: Whether to use the network
          'sbg:includeInPorts': true
          'sbg:stageInput': null
          id: '#use_network'
          required: false
          type:
            - 'null'
            - boolean
        - label: Interaction Network Metadata File
          description: The interaction network metadata file
          id: '#interaction_network_metadata_file_in'
          required: false
          type:
            - 'null'
            - File
        - label: Gene Map File
          description: The gene map file
          id: '#gene_map_file_in'
          required: false
          type:
            - 'null'
            - File
        - label: Clean Phenotypic Spreadsheet
          description: The clean phenotypic spreadsheet
          id: '#clean_phenotypic_file_in'
          required: false
          type:
            - 'null'
            - File
        - label: Clean Genomic Spreadsheet
          description: The clean genomic spreadsheet
          id: '#clean_genomic_file_in'
          required: false
          type:
            - 'null'
            - File
      'sbg:modifiedOn': 1516830402
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 984.0000000000003
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


                  //9606.STRING_experimental.metadata
                  interaction_network.metadata

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
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Gene_Prioritization_Renamer
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
      'sbg:latestRevision': 4
      baseCommand:
        - sh
        - file_renamer.cmd
      id: mepstein/knoweng-geneprioritization-demo/gene-prioritization-renamer/0
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
      outputs:
        - label: Interaction Network Metadata File
          id: '#interaction_network_metadata_file_out'
          type:
            - 'null'
            - File
          outputBinding:
            glob: interaction_network.metadata
          description: The interaction network metadata file
        - label: Gene Map File
          id: '#gene_map_file_out'
          type:
            - 'null'
            - File
          outputBinding:
            glob: gene_map.txt
          description: The gene map file
        - label: Clean Phenotypic Spreadsheet
          id: '#clean_phenotypic_file_out'
          type:
            - 'null'
            - File
          outputBinding:
            glob: clean_phenotypic_matrix.txt
          description: The clean phenotypic spreadsheet
        - label: Clean Genomic Spreadsheet
          id: '#clean_genomic_file_out'
          type:
            - 'null'
            - File
          outputBinding:
            glob: clean_genomic_matrix.txt
          description: The clean genomic spreadsheet
      'sbg:revision': 4
      'sbg:cmdPreview': sh file_renamer.cmd
      description: >-
        Renames some of the intermediate files produced in the GP workflow to
        their final output names.
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      class: CommandLineTool
      'sbg:image_url': null
      'y': 333.3333333333334
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      successCodes: []
      'sbg:createdOn': 1516559629
      'sbg:publisher': sbg
      stdin: ''
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
      hints:
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
        - class: DockerRequirement
          dockerImageId: ''
          dockerPull: ubuntu
    'sbg:y': 333.3333333333334
    id: '#Gene_Prioritization_Renamer'
  - inputs:
      - source:
          - '#knowledge_network_edge_type'
        id: '#Gene_Prioritization_Parameters.knowledge_network_edge_type'
      - source:
          - '#correlation_measure_in'
        id: '#Gene_Prioritization_Parameters.correlation_measure_in'
    outputs:
      - id: '#Gene_Prioritization_Parameters.get_network'
      - id: '#Gene_Prioritization_Parameters.edge_type'
      - id: '#Gene_Prioritization_Parameters.correlation_measure_out'
    'sbg:x': 430.66666666666674
    run:
      'sbg:modifiedBy': mepstein
      inputs:
        - label: Knowledge Network Edge Type
          description: The knowledge network edge type (not required)
          'sbg:includeInPorts': true
          id: '#knowledge_network_edge_type'
          required: false
          type:
            - 'null'
            - string
        - label: GP Correlation Measure
          description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
          'sbg:includeInPorts': true
          id: '#correlation_measure_in'
          required: true
          type:
            - symbols:
                - pearson
                - t_test
              name: correlation_measure_in
              type: enum
      'sbg:modifiedOn': 1516854156
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      x: 430.66666666666674
      requirements:
        - class: ExpressionEngineRequirement
          id: '#cwl-js-engine'
          requirements:
            - class: DockerRequirement
              dockerPull: rabix/js-engine
      arguments: []
      'sbg:validationErrors': []
      'sbg:createdBy': mepstein
      label: Gene Prioritization Parameters
      temporaryFailCodes: []
      'sbg:id': >-
        mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
      'sbg:latestRevision': 5
      baseCommand:
        - ''
      id: >-
        mepstein/knoweng-geneprioritization-demo/gene-prioritization-parameters/0
      'sbg:job':
        inputs:
          correlation_measure_in: pearson
          knowledge_network_edge_type: knowledge_network_edge_type-string-value
        allocatedResources:
          cpu: 1
          mem: 1000
      'sbg:sbgMaintained': false
      outputs:
        - label: Get Network Flag
          id: '#get_network'
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
          description: Whether to get the network
        - label: Network Edge Type
          id: '#edge_type'
          type:
            - 'null'
            - string
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                $job.inputs.knowledge_network_edge_type;
          description: The network edge type
        - label: GP Correlation Measure
          id: '#correlation_measure_out'
          type:
            - 'null'
            - string
          outputBinding:
            outputEval:
              class: Expression
              engine: '#cwl-js-engine'
              script: |
                $job.inputs.correlation_measure_in;
          description: 'The correlation measure to be used for GP (e.g., pearson or t_test)'
      'sbg:revision': 5
      'sbg:cmdPreview': ''
      description: >-
        Sets the input parameters of some of the intermediate apps in the GP
        workflow based on some of the input parameters to the workflow itself.
      'sbg:project': mepstein/knoweng-geneprioritization-dev
      class: CommandLineTool
      'sbg:image_url': null
      'y': 461.3333333333335
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:contributors':
        - mepstein
      'sbg:projectName': KnowEnG_GenePrioritization_Dev
      successCodes: []
      'sbg:createdOn': 1516829688
      'sbg:publisher': sbg
      stdin: ''
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
      hints:
        - value: 1
          class: 'sbg:CPURequirement'
        - value: 1000
          class: 'sbg:MemRequirement'
        - class: DockerRequirement
          dockerImageId: ''
          dockerPull: ubuntu
    'sbg:y': 461.3333333333335
    id: '#Gene_Prioritization_Parameters'
  - inputs:
      - source:
          - '#Knowledge_Network_Fetcher.network_edge_file'
        id: '#ProGENI.network_file'
      - source:
          - '#Data_Cleaning_Preprocessing.clean_genomic_file'
        id: '#ProGENI.spreadsheet_file'
      - source:
          - '#Data_Cleaning_Preprocessing.clean_phenotypic_file'
        id: '#ProGENI.drug_response_file'
      - source:
          - '#Gene_Prioritization_Parameters.correlation_measure_out'
        id: '#ProGENI.correlation_measure'
      - source:
          - '#num_bootstraps'
        id: '#ProGENI.num_bootstraps'
      - source:
          - '#Gene_Prioritization_Parameters.get_network'
        id: '#ProGENI.use_network'
      - source:
          - '#number_of_top_genes'
        id: '#ProGENI.number_of_top_genes'
      - source:
          - '#network_influence_percent'
        id: '#ProGENI.network_influence_percent'
      - source:
          - '#bootstrap_sample_percent'
        id: '#ProGENI.bootstrap_sample_percent'
    outputs:
      - id: '#ProGENI.output_name'
      - id: '#ProGENI.genes_ranked_file'
      - id: '#ProGENI.top_genes_file'
      - id: '#ProGENI.readme'
      - id: '#ProGENI.run_params_yml'
    'sbg:x': 988.8461914062503
    run:
      inputs:
        - label: Knowledge Network File
          id: '#network_file'
          'sbg:stageInput': link
          description: The knowledge network file
          type:
            - 'null'
            - File
        - label: Genomic Spreadsheet File
          id: '#spreadsheet_file'
          'sbg:stageInput': link
          description: The genomic spreadsheet file
          type:
            - File
        - label: Drug Response File
          id: '#drug_response_file'
          'sbg:stageInput': link
          description: The drug response file
          type:
            - File
        - label: Correlation Measure
          description: 'The correlation measure (e.g., t_test or pearson)'
          'sbg:includeInPorts': true
          id: '#correlation_measure'
          type:
            - string
        - 'sbg:toolDefaultValue': '0'
          label: Number of Bootstraps
          description: The number of bootstraps
          'sbg:includeInPorts': true
          id: '#num_bootstraps'
          type:
            - 'null'
            - int
        - 'sbg:toolDefaultValue': 'False'
          label: Use Network Flag
          description: Whether to use the network
          'sbg:includeInPorts': true
          id: '#use_network'
          type:
            - 'null'
            - boolean
        - 'sbg:toolDefaultValue': '100'
          label: Number of Top Genes
          description: The number of top genes to find
          'sbg:includeInPorts': true
          'sbg:stageInput': null
          id: '#number_of_top_genes'
          type:
            - 'null'
            - int
        - 'sbg:toolDefaultValue': '50'
          label: Amount of Network Influence
          description: >-
            The amount of network influence (as a percent; default 50%); a
            greater value means greater contribution from the network
            interactions
          'sbg:includeInPorts': true
          id: '#network_influence_percent'
          type:
            - 'null'
            - int
        - 'sbg:toolDefaultValue': '80'
          label: Bootstrap Sample Percent
          description: The bootstrap sample percent
          'sbg:includeInPorts': true
          'sbg:stageInput': null
          id: '#bootstrap_sample_percent'
          type:
            - 'null'
            - int
      'sbg:revisionNotes': Copy of mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
      'sbg:modifiedOn': 1523639904
      stdout: ''
      cwlVersion: 'sbg:draft-2'
      requirements:
        - class: CreateFileRequirement
          fileDef:
            - fileContent:
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
              filename: run_gp.cmd
            - fileContent: |-
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
              filename: create_ranked_genes.sh
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
      'sbg:createdBy': mepstein
      label: ProGENI
      'sbg:modifiedBy': mepstein
      temporaryFailCodes: []
      'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization/1
      'sbg:latestRevision': 1
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
      $namespaces:
        sbg: 'https://sevenbridges.com'
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
      description: >-
        Network-guided gene prioritization method implementation by KnowEnG that
        ranks gene measurements by their correlation to observed phenotypes.
      outputs:
        - id: '#output_name'
          outputBinding:
            glob: '*bootstrap_net_correlation*'
          type:
            - 'null'
            - items: File
              type: array
        - label: Genes Ranked File
          description: The genes ranked file
          type:
            - 'null'
            - File
          outputBinding:
            glob: genes_ranked_per_phenotype.txt
          id: '#genes_ranked_file'
        - label: Top Genes File
          description: The top genes file
          type:
            - 'null'
            - File
          outputBinding:
            glob: top_genes_per_phenotype_matrix.txt
          id: '#top_genes_file'
        - label: The README file
          description: The README file that describes the output files
          type:
            - 'null'
            - File
          outputBinding:
            glob: README-GP.md
          id: '#readme'
        - label: Configuration Parameters File
          description: The configuration parameters specified for the GP run
          type:
            - 'null'
            - File
          outputBinding:
            glob: run_params.yml
          id: '#run_params_yml'
      id: >-
        https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-demo/gene-prioritization/1/raw/
      'sbg:revision': 1
      'sbg:cmdPreview': >-
        sh run_gp.cmd && sh create_ranked_genes.sh ./
        genes_ranked_per_phenotype.txt top_genes_per_phenotype_matrix.txt &&
        python3 wget.py
        https://raw.githubusercontent.com/KnowEnG/quickstart-demos/f93695fdd5d603412e6b3d4e7a74e6f2a079929f/pipeline_readmes/README-GP.md
        README-GP.md
      'sbg:project': mepstein/knoweng-geneprioritization-demo
      'sbg:projectName': KnowEnG_GenePrioritization_Demo
      class: CommandLineTool
      'sbg:image_url': null
      'sbg:createdOn': 1517287763
      'sbg:appVersion':
        - 'sbg:draft-2'
      'sbg:sbgMaintained': false
      'sbg:contributors':
        - mepstein
      'sbg:copyOf': mepstein/knoweng-geneprioritization-dev/gene-prioritization/7
      successCodes: []
      'sbg:publisher': sbg
      stdin: ''
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
      hints:
        - class: 'sbg:CPURequirement'
          value: 1
        - class: 'sbg:MemRequirement'
          value: 1000
        - class: DockerRequirement
          dockerImageId: ''
          dockerPull: 'knowengdev/gene_prioritization_pipeline:07_26_2017'
    'sbg:y': 724.7435709635419
    id: '#ProGENI'
'sbg:toolAuthor': KnowEnG
'sbg:license': >-
  Copyright (c) 2017, University of Illinois Board of Trustees; All rights
  reserved.
'sbg:toolkit': KnowEnG_CGC
'sbg:publisher': sbg
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517287835
    'sbg:revisionNotes': null
  - 'sbg:revision': 1
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517287903
    'sbg:revisionNotes': Imported Gene Prioritization Workflow.
  - 'sbg:revision': 2
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517346588
    'sbg:revisionNotes': Imported Gene Prioritization Workflow.
  - 'sbg:revision': 3
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1517586716
    'sbg:revisionNotes': Added links to public files in description.
  - 'sbg:revision': 4
    'sbg:modifiedBy': mepstein
    'sbg:modifiedOn': 1523639979
    'sbg:revisionNotes': Updated version of ProGENI.
hints: []
$namespaces:
  sbg: 'https://sevenbridges.com'
'sbg:appVersion':
  - 'sbg:draft-2'
id: >-
  https://cgc-api.sbgenomics.com/v2/apps/mepstein/knoweng-geneprioritization-demo/gene-prioritization-workflow/4/raw/
'sbg:id': mepstein/knoweng-geneprioritization-demo/gene-prioritization-workflow/4
'sbg:revision': 4
'sbg:modifiedOn': 1523639979
'sbg:modifiedBy': mepstein
'sbg:createdOn': 1517287835
'sbg:createdBy': mepstein
'sbg:project': mepstein/knoweng-geneprioritization-demo
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - mepstein
'sbg:latestRevision': 4
'sbg:content_hash': null
