#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace

# Load libraries
. /opt/bitnami/scripts/libspark.sh
. /opt/bitnami/scripts/libos.sh

# Load Spark environment variables
eval "$(spark_env)"

if [ "$SPARK_MODE" == "master" ]; then
    # Master constants
    EXEC=$(command -v start-master.sh)
    ARGS=()
    info "** Starting Spark in master mode **"
else
    # Worker constants
    EXEC=$(command -v start-worker.sh)
    ARGS=("$SPARK_MASTER_URL")
    info "** Starting Spark in worker mode **"
fi
if am_i_root; then
    exec gosu "$SPARK_DAEMON_USER" "$EXEC" "${ARGS[@]-}"
else
    exec "$EXEC" "${ARGS[@]-}"
fi
