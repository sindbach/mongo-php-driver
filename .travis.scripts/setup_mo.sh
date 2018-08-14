#!/bin/bash

echo Loading MO for $DEPLOYMENT

if [[ -z $TRAVIS_BUILD_DIR ]]; then
    TRAVIS_BUILD_DIR=`pwd`;
fi

case $DEPLOYMENT in
  SHARDED_CLUSTER)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/sharded_clusters/cluster.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_uri;' > /tmp/uri.txt
    ;;
  STANDALONE_AUTH)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/standalone/standalone-auth.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_auth_uri;' > /tmp/uri.txt
    ;;
  STANDALONE_OLD)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/standalone/standalone-old.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_uri;' > /tmp/uri.txt
    ;;
  STANDALONE_SSL)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/standalone/standalone-ssl.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_uri, "/?ssl=true&sslallowinvalidcertificates=true";' > /tmp/uri.txt
    ;;
  REPLICASET)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/replica_sets/replicaset.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_uri;' > /tmp/uri.txt
    ;;
  REPLICASET_AUTH)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/replica_sets/replicaset-auth.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_auth_uri;' > /tmp/uri.txt
    ;;
  REPLICASET_OLD)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/replica_sets/replicaset-old.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_uri;' > /tmp/uri.txt
    ;;
  *)
    ${TRAVIS_BUILD_DIR}/.travis.scripts/mo.sh ${TRAVIS_BUILD_DIR}/scripts/presets/travis/standalone/standalone.json start > /tmp/mo-result.json
    cat /tmp/mo-result.json | tail -n 1 | php -r 'echo json_decode(file_get_contents("php://stdin"))->mongodb_uri;' > /tmp/uri.txt
    ;;
esac

echo -n "MongoDB Test URI: "
cat /tmp/uri.txt
echo

echo "Raw MO Response:"
cat /tmp/mo-result.json

echo
