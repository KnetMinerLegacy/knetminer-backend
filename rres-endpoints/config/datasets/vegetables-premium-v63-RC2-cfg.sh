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
  annotation, GENBANK for the others; both link to an NCBI search.\n\
  The Arabidopsis reference keeps its TAIR ids. Previous versions labelled them all Ensembl.\n\
- Arabidopsis reference moved to release 63 downloads (TAIR12 gene models unchanged). Removed 48,321 duplicate\n\
  Arabidopsis and 6,600 yeast proteins whose ids were whole FASTA header lines (OMA orthologs now attach to the real\n\
  proteins); GO annotations from the current GO Consortium file; UniProt now lists 59,498 Arabidopsis entries (was\n\
  136,324: redundant unreviewed entries removed upstream).\n\
---------------------------\n\
Version v63-RC1 2026-07:\n\
\n\
- Ensembl Plants release 63.\n\
- Hybrid gene-publication literature layer: PubTator3 (text-mined + NCBI-curated) unioned with an\n\
  in-house HunFlair2 NER pipeline; per-link AI functional summaries (LiteratureSnippet nodes).\n\
- Sequence-based Ensembl<->Entrez crosswalk recovering literature links missed by identifier mapping.\n\
- Full annotation pipeline ported to the ROGER GPU cluster.\n\
---------------------------\n\
"
. "$KETL_HOME/config/datasets/${KETL_DATASET_ID}-${KETL_DATASET_VERSION_NUM}-cfg.sh"
