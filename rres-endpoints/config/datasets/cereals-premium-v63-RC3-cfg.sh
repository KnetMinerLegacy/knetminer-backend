export KETL_REL_NOTES="\n\
---------------------------\n\
Version ${KETL_DATASET_VERSION} 2026-11-11:\n\
\n\
- Gene and protein accessions are labelled with the database their links go to (link policy 2026-11): NCBI Gene\n\
  for rice (japonica), wheat, maize, sorghum, Brachypodium and the Arabidopsis reference; the new Ensembl gene pages\n\
  for oat, barley, indica rice and durum wheat; proteins to NCBI Protein (sorghum, Brachypodium) or the genome's NCBI\n\
  page. v63-RC1 labelled them all Ensembl.\n\
- Oat (Avena sativa OT3098) genes are now in the graph: v63-RC1 listed oat, but its 65,025 genes were not joined\n\
  (only taxid-less oat proteins from the homology groups were present).\n\
- Arabidopsis reference moved to release 63 downloads (TAIR12 gene models unchanged). Removed 48,321 duplicate\n\
  Arabidopsis and 6,600 yeast proteins whose ids were whole FASTA header lines (OMA orthologs now attach to the real\n\
  proteins); GO annotations from the current GO Consortium file; UniProt now lists 59,498 Arabidopsis entries (was\n\
  136,324: redundant unreviewed entries removed upstream).\n\
---------------------------\n\
Version v63-RC1 2026-07:\n\
\n\
- Ensembl Plants release 63; bread wheat on IWGSC RefSeq v2.1.\n\
- Nine cereals/grasses incl. hexaploid wheat + oat; Arabidopsis reference by orthology.\n\
- Homoeolog-aware gene naming + literature text-mining for polyploids.\n\
- Hybrid gene-publication layer (PubTator3 text-mined + NCBI-curated + HunFlair2) with AI summaries.\n\
- Curated crop-genomics extension (co-expression, GWAS/markers, cultivar PAV, gene regulation) for\n\
  wheat, maize and rice; v1.1->v2.1 wheat id mapping.\n\
- Full annotation + KG pipeline on the ROGER GPU cluster.\n\
---------------------------\n\
"
. "$KETL_HOME/config/datasets/${KETL_DATASET_ID}-${KETL_DATASET_VERSION_NUM}-cfg.sh"
