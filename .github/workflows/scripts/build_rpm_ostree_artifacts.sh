#!/bin/bash
set -euxo pipefail
BRANCH=fedora/stable/x86_64/iot

dnf install -y ostree rpm-ostree git selinux-policy

mkdir -p rpm_ostree_artifacts
pushd rpm_ostree_artifacts

ostree init --mode=archive --repo=repo
mkdir -p cache
git clone https://pagure.io/fedora-iot/ostree.git -n fedora-iot-spec/ || true
git -C fedora-iot-spec checkout c1eb922887dcb3301b73a8d5f058340eaef5c6b1

rpm-ostree compose tree --unified-core --cachedir="cache" --repo="repo" "fedora-iot-spec/fedora-iot.yaml"
ostree summary --repo=repo --update


tar cf repo_v1.tar repo

git -C fedora-iot-spec checkout f40

PARENT_COMMIT=$(ostree --repo=repo rev-parse $BRANCH)
rpm-ostree compose tree --force-nocache --unified-core --cachedir="cache" --repo="repo" --parent=$PARENT_COMMIT --previous-commit=$PARENT_COMMIT "fedora-iot-spec/fedora-iot.yaml"
ostree summary --repo=repo --update


tar cf repo_v2.tar repo

popd