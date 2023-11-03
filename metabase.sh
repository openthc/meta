#!/bin/bash
#
# Wrapper to Run Metabase
# Had to find the MB_JETTY options from the source
#

set -o errexit
set -o nounset

f=$(readlink -f "$0")
d=$(dirname "$f")
cd "$d"

if [[ "metabase" != "$USER" ]]
then
	echo "You MUST run this as the 'metabase' user"
	exit 1
fi

# Upgrade
# wget 'https://downloads.metabase.com/v0.47.3/metabase.jar'

# Metabase Vars
export MB_DB_TYPE="postgres"
export MB_DB_HOST="localhost"
export MB_DB_PORT="5432"
export MB_DB_DBNAME="metabase"
export MB_DB_USER="metabase"
export MB_DB_PASS="metabase"
export MB_JETTY_HOST="127.0.0.1"
export MB_JETTY_PORT="3000"

# Metabase becomes inoperable, leaves too many hanging DB connections
# @see https://github.com/metabase/metabase/issues/8679#issuecomment-1791553828
#export MB_JDBC_DATA_WAREHOUSE_UNRETURNED_CONNECTION_TIMEOUT_SECONDS=1200

# metabase_jar="/opt/metabase/source/target/uberjar/metabase.jar"
# metabase_jar="0.34.3/metabase.jar"
metabase_jar="0.47.3/metabase.jar"

#Launch
exec java \
	-Dc3p0.maxConnectionAge=120 \
	-Dc3po.maxIdleTime=120 -Dc3p0.maxPoolSize=8 \
	-jar "$metabase_jar" \
	>metabase.log \
	2>&1 \
	&

pid=$!

echo -n "$pid" > metabase.pid
