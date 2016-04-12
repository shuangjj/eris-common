#!/usr/bin/env bash

declare -a checks

repo_base="chainlex"
tag="latest"

dep=(
  "armhfbuild/golang"
  "armv7/armhf-ubuntu:14.04"
)

tobuild=(
  "base"
  "data"
#  "ipfs"
  "btcd"
  "ubuntu"
  "tools"
  "eth"
  "node"
  "gulp"
  "commonform"
  "sunit_base"
  "embark_base"
  "bitcoincore"
  "bitcoinclassic"
  "openbazaar"
  "zcash"
)

tobuildscript=(
  "keys"
  "compilers"
)

pull_deps() {
  for d in "${dep[@]}"
  do
    echo ""
    echo "Pulling => $d"
    #echo ""
    #echo ""
    docker pull $d
    #echo ""
    echo -n ":-) "
    echo "Finished Pulling."
    echo ""
  done
}

build_and_push() {
  ele=$1
  echo ""
  echo "Building => $repo_base/eris-$ele:$tag"
  #echo ""
  #echo ""
  docker build --no-cache -t $repo_base/eris-$ele:$tag $ele 1>/dev/null
  #echo ""
  echo -n ":-) "
  echo "Finished Building."
  echo "Pushing => eris-$ele:$tag"
  #echo ""
  #echo ""
  docker push $repo_base/eris-$ele:$tag 1>/dev/null
  echo -n ":-)"
  echo "Finished Pushing."
  echo ""
}

buildscript_and_push() {
  ele=$1
  echo "Building => $repo_base/$ele"
  echo ""
  echo ""
  cd $ele
  ./build.sh
  cd ..
  echo ""
  echo ""
  echo "Finished Building."
  echo "Pushing => $ele"
  echo ""
  echo ""
  docker push $repo_base/$ele 1>/dev/null
  echo "Finished Pushing."
}

pull_deps

for ele in "${tobuild[@]}"
do
  set -e
  build_and_push $ele
  set +e
done

#for ele in "${tobuildscript[@]}"
#do
#  set -e
#  buildscript_and_push $ele
#  set +e
#done
