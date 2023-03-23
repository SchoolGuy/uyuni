#!/bin/bash

# Credits to: https://stackoverflow.com/a/246128/4730773
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
# Credits to: https://stackoverflow.com/a/192337/4730773
SCRIPT_NAME=$(basename "$0")
# Configuration for the script
CONTAINER_NAME="cobbler-rpm-testsuite"
IMAGE="registry.opensuse.org/systemsmanagement/uyuni/master/docker/containers/uyuni-master-cobbler"
# registry.suse.de/devel/galaxy/manager/head/docker/containers/suma-head-cobbler:latest
# registry.suse.de/devel/galaxy/manager/4.3/docker/containers/suma-4.3-cobbler:latest
TAG="latest"
EXECUTOR="docker"

function log() {
    echo "[COBBLER TESTS] $1"
}

function pull_image() {
    log "Pulling container $IMAGE:$TAG"
    $EXECUTOR pull "$IMAGE:$TAG"
}

function cleanup_container() {
    log "Cleaning up old container"
    CONTAINER_ID=$($EXECUTOR ps --format "{{.ID}}" -a -f "name=$CONTAINER_NAME")
    if [ -z "$CONTAINER_ID" ]; then
        log "No container to remove"

    else
        log "Removed container $CONTAINER_ID"
        $EXECUTOR rm "$CONTAINER_ID"
    fi
}

function run_default() {
    log "Starting container"
    mkdir -p "$SCRIPT_DIR/../../../../cobbler_reports"
    $EXECUTOR run -d --name "$CONTAINER_NAME" -v "$SCRIPT_DIR/../../../../cobbler_reports:/reports" "$IMAGE:$TAG"
}

function execute_tests() {
    log "Prepare testcontainer"
    # Required to not back the certificate into the image
    $EXECUTOR exec "$CONTAINER_NAME" sh -c "/code/docker/develop/scripts/setup-openldap.sh"
    # Required to install a package that is not present in the OBS/IBS project
    $EXECUTOR exec "$CONTAINER_NAME" sh -c "/code/docker/develop/scripts/setup-reposync.sh"
    # Required because LDAP certificates are not part of the image
    $EXECUTOR exec "$CONTAINER_NAME" sh -c "ldapadd -Y EXTERNAL -H ldapi:/// -f /code/docker/develop/openldap/test.ldif"

    log "Running cobbler tests"
    $EXECUTOR exec "$CONTAINER_NAME" sh -c "pytest --junitxml=/reports/cobbler.xml /code/tests/"
}

function execute_shell() {
    log "Spawning a shell inside of the cobbler tests container"
    $EXECUTOR exec -ti --entrypoint=/usr/bin/bash "$CONTAINER_NAME"
}

function print_help() {
    echo "Usage: $SCRIPT_NAME [-e|-i|-t|-h]"
    echo
    echo "Options:"
    echo "e <argument>: Switches the image executor to a user defined one. (Default: docker)"
    echo "i <argument>: Sets the image that is being used to a custom one."
    echo "t <argument>: Set the image tag to a custom one. (Default: latest)"
    echo "h: Displays this message."
}

while getopts e:i:t:h flag; do
    case "${flag}" in
    e) EXECUTOR=${OPTARG} ;;
    i) IMAGE=${OPTARG} ;;
    t) TAG=${OPTARG} ;;
    h) print_help ;;
    *) echo "Unknown option" ;;
    esac
done

pull_image
cleanup_container
run_default
execute_tests
