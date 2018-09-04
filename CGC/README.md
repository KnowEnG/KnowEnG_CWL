
## KnowEnG Workflows on the Cancer Genomics Cloud

In this document, we'll demonstrate the usage of a number of our [KnowEnG](https://knoweng.org/) tools on the [Cancer Genomics Cloud (CGC)](https://cgc.sbgenomics.com/).

Several KnowEnG workflows are available on the CGC.  These include
the [Spreadsheet Builder workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder),
the [Signature Analysis workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-signature-analysis-public/signature-analysis-workflow),
the [Gene Prioritization workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow),
and the [Gene Set Characterization workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-genesetcharacterization-public/gene-set-characterization),

In the first several sections of this document, these workflows will be run individually.  We have also created a workflow on the CGC that combines the running of these workflows as described in this document.  This worklow is called
the [KnowEnG Analysis of LUSC Subtypes (KALS) workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/lung/knoweng-analysis-of-lusc-subtypes).
The last section of this document,
[Running the KnowEnG Analysis of LUSC Subtypes (KALS) workflow](#running-the-knoweng-analysis-of-lusc-subtypes-kals-workflow),
describes running this combined workflow.

This combined workflow allows running the overall process in a simpler fashion, albeit with fewer options, as a number of the input parameters available in the individual workflows have been preset with specific values.  It also demonstrates how workflows can be built up on the CGC.


### Contents

* [Gathering the TCGA input files](#gathering-the-tcga-input-files)
* [Running the Spreadsheet Builder workflow](#running-the-spreadsheet-builder-workflow)
* [Running the Signature Analysis workflow](#running-the-signature-analysis-workflow)
* [Running the Gene Prioritization workflow](#running-the-gene-prioritization-workflow)
* [Running the Gene Set Characterization workflow](#running-the-gene-set-characterization-workflow)
* [Running the KnowEnG Analysis of LUSC Subtypes (KALS) workflow](#running-the-knoweng-analysis-of-lusc-subtypes-kals-workflow)


### Gathering the TCGA input files

First, we'll pull some data from some of the TCGA data sets on the CGC.

To get the TCDA data files we used, in the CGC Data Browser, select a set of files using a query like the following:

```
Dataset: TCGA GRCh38
  Entity: File
    Properties:
      Data category: Transcriptome Profiling
      Data format: TXT
  Entity: Investigation
    Properties:
      Disease type: Lung Squamous Cell Carcinoma
```

More specifically: From a page on the CGC, go to the "Data" pulldown menu, and click on "Data Browser".  Select "TCGA GRCh38" and click on "Explore selected".  Under "Add entity", click on "File".

Under "File", click on "Add property".  Scroll down to "Data category" and click on it (you may need to move the "File" block up by clicking/holding in the "File" header and dragging it up); check the box to the left of "Transcriptome Profiling" (it may only show part of it, like "Transriptome ..."); and click on "Add property".  Do the same for the property "Data format" and the value "TXT".

Then, in the "Add entity" block to the right of the "File" block, click on "Investigation" (if that block is not present, click in the "File" block).  Do as above for the property "Disease type" and the value "Lung Squamous Cell Carcinoma" (which may be shown only as something like "Lung Squamou...").

The bottom half of the window shows some of the files that have been selected, with counts for the number of files and investigations.  These counts will get crossed out as your search gets more specific.  To refresh the counts, click the refresh circular arrows to the left of the "File" count box.

The above query yields 1,653 files (in 1 investigation).  Some of the files are not needed and can be deleted, but that needs to be done in the project, from the "Files" tab.  For now, copy these files to the project, using the "Copy files to project" button.  You'll be prompted for the project to copy them to, and then given the option to tag the files (recommended).  In this case, I used the tag "LUSC_1".  After specifying the tag, click the "Copy selected files" button.

You can also save this query (under the "Queries" pulldown menu, click on "Save").

The file names end in three patterns, `.htseq.counts.tz`, `.FPKM-UQ.txt`, and `.FPKM.txt`.  Only the last of these is needed.  To delete the unnecessary files, go back to the project dashboard page, then click on the "Files" tab.  Use the tag specified when you copied the files to the project to show all the files.  Enter "htseq.counts" in the search box to show only those files (there should be 551 of them).  In the pulldown menu to the left of "File name", click "Select all".  Then, in the "..." pulldown menu, click "Delete".  Do the same for "FPKM-UQ".  After this, you will be left with just the ".FPKM.txt" files (551 of them).


### Running the Spreadsheet Builder workflow

To get the data from the TCGA files into the format we need for our later pipelines, we'll use our [Spreadsheet Builder workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-spreadsheetbuilder-public/spreadsheet-builder).

Use the TCGA input files gathered earlier as the input files, and set the following parameter values:

```
Metadata Sample ID Key: aliquot_id
Category Max Value: 24
Filter Minimum Percentage: 0.1
Filter Threshold: 1
Map Names Flag: False
Normalize Flag: True
```

This should take about 5-10 minutes to run and cost under $.10 (using spot instances).

The main output file of interest is the Genomic Spreadsheet File (`genomic.tsv`).

Others that may be useful in certain situations are the phenotypic files -- the Phenotypic Spreadsheet File (`phenotypic.tsv`), the Binary Phenotypic Spreadsheet File (`phenotypic.binary.tsv`), and the Numeric Phenotypic Spreadsheet File (`phenotypic.numeric.tsv`).


### Running the Signature Analysis workflow

Next comes running the [Signature Analysis workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-signature-analysis-public/signature-analysis-workflow).  This requires two input files, a Samples File and a Signatures File.  The Samples File will be the Genomic Spreadsheet File output from the Spreadsheet Builder run (`genomic.tsv`).  The Signatures File will be the demo signatures file (`demo_SA.signatures.txt`).

You should use the following parameter values:

```
Species Taxon ID (in three places): 9606
Similarity Measure: spearman
```

This should take under 5 minutes to run and cost under $.05 (using spot instances).

The main output file of interest is the Similarity Matrix File (`similarity_matrix.tsv`), although in some cases, including this example, you'll want the Similarity Matrix Binary file (`similarity_matrix.binary.tsv`).


### Running the Gene Prioritization workflow

After this, you're ready to run the [Gene Prioritization workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-geneprioritization-public/gene-prioritization-workflow).  This takes two input files, a Genomic Spreadsheet File and a Phenotypic Spreadsheet File.  For the Genomic Spreadsheet File, we need to again use the Genomic Spreadsheet File output from the Spreadsheet Builder run (`genomic.tsv`).  For the Phenotypic Spreadsheet File, use the Similarity Matrix Binary file from the Signature Analysis run (`similarity_matrix.binary.tsv`).

You should use the following parameter values:

```
Species Taxon ID (in two places): 9606
Correlation Measure: t_test
```

Use `t_test` for the Correlation Measure since the phenotypic file we're using has binary values.

This should take under 5 minutes to run and cost under $.05 (using spot instances).

The main output files of interest are the Ranked Genes File (`genes_ranked_per_phenotype.txt`) and the Top Genes File (`top_genes_per_phenotype_matrix.txt`).  In this case, we'll be using the Top Genes File as the input file for the next step.


### Running the Gene Set Characterization workflow

The last step is to run the [Gene Set Characterization workflow](https://cgc.sbgenomics.com/public/apps#workflow/mepstein/knoweng-genesetcharacterization-public/gene-set-characterization).  This takes one input file, a Genomic Spreadsheet File; for this we'll use the Top Genes File output from the Gene Prioritization run (`top_genes_per_phenotype_matrix.txt`).

For the parameter values, we'll use:

```
Species Taxon ID (in three places): 9606
Knowledge Network Edge Type: hn_IntNet
Gene Set Property Network Edge Type: enrichr_pathway
```

This should take under 5 minutes to run and cost under $.05 (using spot instances).

The main output file of interest is the GSC Results (`gsc_results.txt`), and possibly the Raw Enrichment Scores (`DRaWR_sorted_by_property_score_....df`)


### Running the KnowEnG Analysis of LUSC Subtypes (KALS) workflow

To run this combined workflow, you will still need to [create the input files from the TCGA data](#gathering-the-tcga-input-files).  The other input file is the Signatures File, as described [above](#running-the-signature-analysis-workflow).

The following parameters match up with those for
[the Spreadsheet Builder workflow](#running-the-spreadsheet-builder-workflow):

expected_header_key 	Expected Header Key 	string 	No
filter_min_percentage 	Filter Minimum Percentage 	float 	No
filter_threshold 	Filter Threshold 	float 	No
normalize 	Normalize Flag 	boolean 	No

The following parameter matches up with one for
[the Signature Analysis workflow](#running-the-signature-analysis-workflow):

similarity_measure 	Similarity Measure 	enum 	No

The following parameter is one for
[the Gene Prioritization workflow](#running-the-gene-prioritization-workflow)
(although it is not specified above, as the default value, 100, is used):

number_of_top_genes 	Number of Top Genes 	int 	No

The following parameters match up with those for
[the Gene Set Characterization workflow](#running-the-gene-set-characterization-workflow)
(similar to `Number of Top Genes`, `Amount of Network Influence` is not specified above, as its default value, `50%` has been used):

gg_edge_type 	Knowledge Network Edge Type 	string 	No
network_smoothing_percent 	Amount of Network Influence 	int 	No
pg_edge_type 	Gene Set Property Network Edge Type 	string 	Yes

Note that `Species Taxon ID` is not available as a parameter here; it has been hard-coded to be `9606` (`human`).

