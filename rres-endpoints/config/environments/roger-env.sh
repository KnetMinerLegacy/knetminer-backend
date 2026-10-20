# ROGER environment for the oxl -> rdf -> neo endpoint pipeline (ported from rres-env.sh).
#
# Strategy: run the WHOLE pipeline locally inside one ROGER `ulmn` sbatch (snakemake --cores all) --
# rdf-export, tdb_load, rdf2neo and a LOCAL Neo4j all on the 900 GB big-memory node. No snakemake
# SLURM executor and no separate Neo4j-as-a-service job (the fiddliest rothhpc4 bits), which keeps the
# port tractable and testable. Snakemake must already be on PATH (activate the conda env in the sbatch).
#
# Java: two runtimes, chosen independently (see the Java block below): Java 21 in JAVA_HOME for Neo4j, and
# whatever the deployed Ondex jars need (25 since 2026-09-30) first on PATH for rdf-export and rdf2neo.

export KNET_HOME=/home/data/knetminer
export KNET_SOFTWARE="$KNET_HOME/software"

# Test output area (NOT the production pub/endpoints); Neo4j dump + zipped TDB land here.
export KETL_OUT_HOME="$KNET_HOME/etl-test/temp/endpoints"

# ROGER exports APPTAINER_TMPDIR/CACHEDIR to a read-only system path (/home/gpuapps/apptainer) which
# snakemake 9.x tries to use for its metadata and fails with PermissionError. This pipeline uses no
# containers, so redirect them to a writable location.
export APPTAINER_TMPDIR="$KETL_OUT_HOME/.apptainer/tmp"
export APPTAINER_CACHEDIR="$KETL_OUT_HOME/.apptainer/cache"
mkdir -p "$APPTAINER_TMPDIR" "$APPTAINER_CACHEDIR" 2>/dev/null || true

###### Software (shared /home/data -- same tools rothhpc4 uses)
export KETL_RDFEXP_HOME="$KNET_SOFTWARE/rdf-export-2-cli"          # Ondex OXL->RDF exporter
export JENA_HOME="$KNET_SOFTWARE/jena"                              # tdb2.xloader for tdb_load
export KETL_NEOEXPORT_HOME="$KNET_SOFTWARE/ondex-mini/tools/neo4j-exporter"  # rdf2neo
export KNET_WEBAPP="$KNET_SOFTWARE/knetminer"
export KNET_INITIALIZER_HOME="$KNET_SOFTWARE/knetminer-nova/knetminer-initializer"

###### Java
# - JAVA_HOME = Java 21 (conda `nextflow` env) for Neo4j: 5.26 supports only Java 17/21, and bin/neo4j, neo4j-admin
#   and cypher-shell all take JAVA_HOME (unless JAVACMD is set). Jena's tdb2.tdbloader also uses it.
# - The first `java` on PATH = what the deployed Ondex jars need. rdf-export-2-cli (odx2rdf.sh, add-uris.sh,
#   oxl-descriptor.sh), rdf2neo (ondex2neo.sh) and Jena's tdb2.xloader call `java` from PATH. The Ondex tools are
#   redeployed by cron from knetbuilder master (software/ondex-deploy/) and moved to Java 25 on 2026-09-30, so the
#   version is read from their jars at run time by the shared resolver in knet-pipelines, not pinned here.
export JAVA_HOME="$KNET_SOFTWARE/envs/nextflow"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$KNET_SOFTWARE/bin:$PATH"
# Last PATH change, so the Ondex JDK stays first:
_ondex_java_lib="$KNET_HOME/etl-test/knet-pipelines/ETL_scripts/slurm/roger/_lib/ondex_java.sh"
[ -r "$_ondex_java_lib" ] || { echo "!! FATAL roger-env.sh: $_ondex_java_lib not found (knet-pipelines checkout)" >&2; exit 1; }
source "$_ondex_java_lib"
ondex_java_setup --path-only "$KETL_RDFEXP_HOME" "$KETL_NEOEXPORT_HOME"

# Heap for tdb2.xloader / rdf-export / rdf2neo. NOTE: Neo4j also reads JAVA_TOOL_OPTIONS, so keep this
# below the node's memory and let neo4j.conf govern the DB heap; 200G is ample for the veg-scale TDB.
export JAVA_TOOL_OPTIONS="-Xmx200G"

###### Snakemake: run everything on THIS node (no SLURM profile / cluster executor).
# build-endpoint.sh already passes `--cores all --until all`, so leave this empty (setting the rres
# `--profile config/snakemake/slurm` here is exactly what we are avoiding).
export KETL_SNAKE_OPTS="--rerun-incomplete"

###### Neo4j: LOCAL on this sbatch node. Deliberately DO NOT override KETL_NEO_START/STOP to the
# -slurm variants (keep the default local launchers from default-cfg.sh) and keep the default
# ketl_get_neo_url = bolt://localhost:7687. KETL_HAS_NEO4J / NEO4J_HOME / KETL_NEO_VERSION come from
# the dataset's -common.sh.
export KETL_NEO_IDX_PAUSE_TIME='5m'
