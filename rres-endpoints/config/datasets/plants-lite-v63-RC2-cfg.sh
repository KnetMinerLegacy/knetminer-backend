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
Version v63-RC1 2026-07:\n\
\n\
- Ensembl Plants release 63; genome, protein/CDS FASTA, GFF and species data from the Ensembl Beta website.\n\
- New Arabidopsis MAGIC pan-genome layer: Col-0/Can-0 accession presence/absence variation (PAV), per-accession expression and Can-vs-Col differential expression (SLOLA, Genome Biology 2025).\n\
- Bread wheat updated to IWGSC RefSeq v2.1; Brassica napus (rapeseed) and Camelina sativa generated from Ensembl Beta.\n\
- HomologyTree nodes and part_of relations from proteins, computed with FastOMA. Read more: https://github.com/KnetMiner/knetminer-etl/issues/1\n\
---------------------------\n\
Version v62-RC1 24-01-2026:\n\
\n\
- New Arabidopsis Thaliana (Thale Cress) pangenome nodes with gene presence/absence variation (PAV) data.\n\
- New gene-phenotype association extracted with LLM from recent publications.\n\
---------------------------\n\
Version v61-RC1 04-08-2025:\n\
\n\
- New semantic motif categories. Read more: https://github.com/KnetMiner/knetminer-schemas/tree/main/semantic-motif-taxonomy/knet-motif-categories-doc\n\
- Removed redundant alternative names for Arabidopsis Thaliana (Thale Cress).\n\
- Fixed character encoding for non-English letters is publication titles/authors/etc.\n\
- Replaced hash code identifiers in Phenotype nodes with short LLM-generated labels. Read more: https://github.com/KnetMiner/knetML/tree/main/Entity_Relation_extraction/bedrock_phenotype_title\n\
- Added release notes to the graphs!\n\
---------------------------\n\
"
. "$KETL_HOME/config/datasets/${KETL_DATASET_ID}-${KETL_DATASET_VERSION_NUM}-cfg.sh"
