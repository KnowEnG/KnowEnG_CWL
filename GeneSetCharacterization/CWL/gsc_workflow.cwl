class: Workflow
cwlVersion: v1.0
label: GSC Paired Jobs
doc: Serial combination of KnowEnG tools

requirements:
  - class: StepInputExpressionRequirement

inputs:
  - id: taxonid
    label: Subnetwork Species ID
    doc: the taxonomic id for the species of interest
    type: string
    default: '9606'
  - id: gg_edge_type
    label: GG Network Edge Type
    doc: the edge type keyword for the gg network of interest
    type: string
  - id: gg_network_type
    label: GG Network Network Type
    doc: the network type keyword for the gg network of interest
    type: string
  - id: pg_edge_type
    label: PG Network Edge Type
    doc: the edge type keyword for the pg network of interest
    type: string
  - id: pg_network_type
    label: PG Network Network Type
    doc: the network type keyword for the pg network of interest
    type: string
  - id: genomic_file
    label: Genomic Spreadsheet File
    doc: spreadsheet of genomic data with samples as columns and genes as rows
    type: File
  - id: redis_host
    label: RedisDB host URL
    doc: url of Redis db
    type: ["null", string]
    default: knowredis.knoweng.org
  - id: redis_port
    label: RedisDB Port
    doc: port for Redis db
    type: ["null", int]
    default: 6379
  - id: redis_pass
    label: RedisDB AuthStr
    doc: password for Redis db
    type: ["null", string]
    default: KnowEnG

steps:
  gg_kn_fetch:
    run: kn_fetcher.cwl
    in:
      network_type:
        valueFrom: "Gene"
      taxonid: taxonid
      edge_type: gg_edge_type
      output_name:
        valueFrom: "gg_knf_out"
    out:
      - network_edge_file
      - network_metadata_file
      - cmd_log_file

  pg_kn_fetch:
    run: kn_fetcher.cwl
    in:
      network_type:
        valueFrom: "Property"
      taxonid: taxonid
      edge_type: pg_edge_type
      output_name:
        valueFrom: "pg_knf_out"
    out:
      - network_edge_file
      - network_metadata_file
      - cmd_log_file
      - pnode_map_file

  data_cleaning:
    run: data_cleaning.cwl
    in:
      pipeline_type:
        valueFrom: "geneset_characterization_pipeline"
      genomic_spreadsheet_file: genomic_file
      taxonid: taxonid
      redis_host: redis_host
      redis_port: redis_port
      redis_pass: redis_pass
    out:
      - clean_genomic_file
      - gene_map_file

  gsc_drawr:
    run: gsc_runner.cwl
    in:
      gg_network_file: gg_kn_fetch/network_edge_file
      pg_network_file: pg_kn_fetch/network_edge_file
      #genomic_file: genomic_file
      genomic_file: data_cleaning/clean_genomic_file
      gsc_method:
        valueFrom: "DRaWR"
    out:
      - enrichment_scores
      - params_yml

outputs:
  gg_kn_fetch.out:
    outputSource: gg_kn_fetch/network_edge_file
    type: File
  gg_kn_fetch.out2:
    outputSource: gg_kn_fetch/network_metadata_file
    type: File
  gg_kn_fetch.out3:
    outputSource: gg_kn_fetch/cmd_log_file
    type: File
  pg_kn_fetch.out:
    outputSource: pg_kn_fetch/network_edge_file
    type: File
  pg_kn_fetch.out2:
    outputSource: pg_kn_fetch/network_metadata_file
    type: File
  pg_kn_fetch.out3:
    outputSource: pg_kn_fetch/pnode_map_file
    type: File
  pg_kn_fetch.out4:
    outputSource: pg_kn_fetch/cmd_log_file
    type: File
  data_cleaning.out:
    outputSource: data_cleaning/clean_genomic_file
    type: File
  data_cleaning.out2:
    outputSource: data_cleaning/gene_map_file
    type: File
  gsc_drawr.out:
    outputSource: gsc_drawr/enrichment_scores
    type: File
  gsc_drawr.out2:
    outputSource: gsc_drawr/params_yml
    type: File
