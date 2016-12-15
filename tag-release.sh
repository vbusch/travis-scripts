#!/bin/sh
TAG=$1

TMPDIR=/tmp/enmasse-release-repos
GIT_URL=git@github.com:EnMasseProject
REPOSITORIES="enmasse-rest mqtt-frontend subserv configserv storage-controller artemis-image dockerfiles ragent topic-forwarder openshift-configuration"

mkdir -p $TMPDIR

for repo in $REPOSITORIES
do
    DESTDIR="${TMPDIR}/${repo}"

    if [ -d "$DESTDIR" ]; then
        pushd $DESTDIR
        git reset --hard HEAD
        git checkout master
        git pull
    else
        git clone $GIT_URL/${repo}.git $DESTDIR
        pushd $DESTDIR
    fi

    git tag $TAG
    git push --tags

    popd
done