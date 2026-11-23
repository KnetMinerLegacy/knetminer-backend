####################################################################################################
# Fo47 is PINNED to GCA_000271705.2 in config/genomes/fungi-premium.tsv. Do NOT upgrade it without
# regenerating Erika Kroll's fuseff extension inputs (RootHOGs_prefix.tsv + kg-data/*.tsv) and
# clearing it with Keywan/Erika first -- the 2020 assembly renames every Fo47 gene FOZG_* ->
# FOBCDRAFT_*, which breaks the accession-based merge fuseff depends on. That upgrade was built,
# deployed and rolled back once already (2026-08-20), then silently reappeared in the 2026-09-03
# build because only the deployed dump was reverted, not the ETL build tree.
#
# v63-RC3 (2026-10-27) is a join-only rebuild of v63-RC2 with the fixed yeast reference; Fo47 is unchanged.
# v63-RC4 (2026-11-18) rebuilds the A. fumigatus, C. albicans, F. graminearum and Z. tritici cores with normalised
# chromosome names (task 85), then join-only; Fo47 and the fuseff extension are unchanged.
# v63-RC5 (2026-11) rebuilds every core with the new gene names and link labels (tasks 96, 86); Fo47 and the
# fuseff extension are unchanged.
#
# The v63-RC2 dump in S3 was replaced 2026-09-07 19:36 (6,316,645,436 bytes) with a build verified
# at FOZG_ 18,191 / FOBCDRAFT_ 0. See knet-pipelines docs/session-handover.md, 2026-09-07.
####################################################################################################
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
  The yeast reference keeps its SGD ids. Previous versions labelled them all Ensembl.\n\
---------------------------\n\
Version v63-RC4 2026-11-18:\n\
\n\
- Genes of Aspergillus fumigatus, Candida albicans, Fusarium graminearum PH-1 and Zymoseptoria tritici appear on\n\
  the Map View again: their chromosome names match the genome maps. In v63-RC3 they kept the raw sequence names\n\
  (1_A_fumigatus_Af293, CP017623.1, HG970332, chr_1...).\n\
---------------------------\n\
Version v63-RC3 2026-10-27:\n\
\n\
- Saccharomyces cerevisiae (the reference organism) proteins now carry their species (TAXID 559292),\n\
  and the SGD accessions added by the yeast extension now attach to the real yeast proteins. Removed\n\
  6,600 spurious yeast proteins named after transcripts (Y..._MRNA) and two header-row artefacts.\n\
---------------------------\n\
Version v63-RC2 2026-09-07:\n\
\n\
- PHI-base provenance now stamped directly on organism protein/gene nodes (a PHIBASE-namespace\n\
  accession carrying the matched PHI-base target's UniProtKB ID, >=80 percent BLAST identity), not\n\
  just on a separate linked node reachable only via an h_s_s edge. Makes PHI-base-derived genes\n\
  identifiable without a graph traversal (knet-pipelines#35).\n\
- Chromosome density bands added to all basemaps (50 bins per chromosome, gene counts per bin).\n\
\n\
Note: Fusarium oxysporum Fo47 remains on GCA_000271705.2, unchanged from v63-RC1. A 2020\n\
chromosome-level assembly exists and would fix Map View for this organism, but it renames every\n\
Fo47 gene and breaks the Fusarium effector (fuseff) extension that merges onto them by accession.\n\
---------------------------\n\
Version v63-RC1 2026-07-15:\n\
\n\
- Added 4 new species (Fusarium odoratissimum, Fusarium oxysporum lycopersici, Fusarium oxysporum Fo47, Verticillium dahliae) to legacy Ascomycota-Premium bundle and created Fungi-Premium.\n\
---------------------------\n\
"
. "$KETL_HOME/config/datasets/${KETL_DATASET_ID}-${KETL_DATASET_VERSION_NUM}-cfg.sh"
