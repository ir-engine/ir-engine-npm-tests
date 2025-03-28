#!/bin/bash

# if .env file does not exist, copy if from .env.default

if [ ! -f .env ]; then
  cp .env.default .env
fi

# set local environment variables from .env file
export $(cat .env | xargs)

PACKAGES=("ecs" "hyperflux")

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo SCRIPT_DIR $SCRIPT_DIR

# @todo this breaks vitest
# cd package-test-template
# npm i
# rm -rf package-lock.json
# cd $SCRIPT_DIR

# remove existing links
rm -rf ./packages/

for PACKAGE in ${PACKAGES[@]}; do
  echo "Setting up $PACKAGE"
  cd $ENGINE_PATH/packages/$PACKAGE
  npm run build
  cd ./dist
  npm link
  cd $SCRIPT_DIR
  mkdir -p packages-temp
  cp -r package-test-template/ packages-temp/$PACKAGE
  # write package name to package.json
  sed -i  '' "s/TEMPLATE/test-$PACKAGE/g" packages-temp/$PACKAGE/package.json
  cp tests/$PACKAGE.test.ts packages-temp/$PACKAGE/$PACKAGE.test.ts
  cd packages-temp/$PACKAGE
  npm link @ir-engine/$PACKAGE
  npm i
  cd $SCRIPT_DIR
done

mv packages-temp/ packages/