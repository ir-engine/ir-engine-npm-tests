# if .env file does not exist, copy if from .env.default

if [ ! -f .env ]; then
  cp .env.default .env
fi

# set local environment variables from .env file
export $(cat .env | xargs)

PACKAGES=(hyperflux)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo SCRIPT_DIR $SCRIPT_DIR

# remove existing links
rm -rf ./node_modules/@ir-engine

for PACKAGE in ${PACKAGES[@]}; do
  echo "Setting up $PACKAGE"
  cd $ENGINE_PATH/packages/$PACKAGE
  npm run build
  cd ./dist
  npm link
  cd $SCRIPT_DIR
  npm link @ir-engine/$PACKAGE
done

