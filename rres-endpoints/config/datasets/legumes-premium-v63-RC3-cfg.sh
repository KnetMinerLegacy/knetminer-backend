export KETL_REL_NOTES="\n\
---------------------------\n\
Version ${KETL_DATASET_VERSION} 2026-11:\n\
\n\
- Gene names: each gene now has one display name and at most 10 synonyms. The name is the gene's own (genome\n\
  annotation, then its UniProt entry), else one shared by its orthologs, else a BLAST match. No name taken from\n\
  other genes is used for more than 50 genes of a species. Each named gene records where its name came from\n\
  (attribute NameSource: own, ortholog or blast); a gene whose only candidate name was too widely shared gets a\n\
  NameHint instead. Gene-publication text mining was rerun with the new names.\n\
- Gene and protein accessions are labelled with where their links go: REFSEQ for genomes with an NCBI RefSeq\n\
  annotation, GENBANK for the others, NC_NP for proteins that NCBI Protein knows by our id.\n\
  The Arabidopsis reference keeps its TAIR ids. Previous versions labelled them all Ensembl.\n\
- Arabidopsis reference moved to release 63 downloads (TAIR12 gene models unchanged). Removed 48,321 duplicate\n\
  Arabidopsis and 6,600 yeast proteins whose ids were whole FASTA header lines (OMA orthologs now attach to the real\n\
  proteins); GO annotations from the current GO Consortium file; UniProt now lists 59,498 Arabidopsis entries (was\n\
  136,324: redundant unreviewed entries removed upstream).\n\
---------------------------\n\
Version v63-RC2 2026-09-07:\n\
\n\
- Shortened gene display names. Genes with no curated symbol previously displayed their full assembly-prefixed accession (for example arahy.Tifrunner.gnm2.ann2.AH04G462800); they now display the informative part alone (AH04G462800). Affects Arachis hypogaea and Vicia faba.\n\
- Gene identifiers and accessions are unchanged: this affects the displayed label only, so existing links, searches and saved queries by gene ID continue to work.\n\
---------------------------\n\
Version v63-RC1 2026-07-29:\n\
\n\
- Added 2 species: Medicago truncatula (model legume) and Cicer arietinum (chickpea), taking the bundle to 7.\n\
- Upgraded Glycine max to Glycine_max_v4.0 (Wm82.a4) and Phaseolus vulgaris to v2.0, both sourced from NCBI/JGI.\n\
- Orthology now from FastOMA RootHOGs, replacing Ensembl Compara.\n\
- Gene names transferred from curated Arabidopsis symbols over hierarchical orthologous groups.\n\
- Gene-publication evidence from HunFlair2 NER plus a PubTator3 hybrid layer with LLM-extracted evidence summaries.\n\
- Chromosome labels derived from each assembly's own GFF3 region records, so genome-browser basemaps align with the gene nodes.\n\
---------------------------\n\
"
. "$KETL_HOME/config/datasets/${KETL_DATASET_ID}-${KETL_DATASET_VERSION_NUM}-cfg.sh"
