if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

REGISTRY="ghcr.io/deb4sh"

# parse options
while getopts :r: flag
do
    case "${flag}" in
        r) REGISTRY=${OPTARG};;
    esac
done

# get current tag information
IS_DEV_BUILD=$(git tag -l --contains HEAD)
GIT_TAG=$(git describe --abbrev=0 --tags HEAD)

if [ -z "$IS_DEV_BUILD" ]
then
    TIMESTAMP=$(date +%s)
    TAG=$(echo "$GIT_TAG"-"$TIMESTAMP")
else 
    TAG=$GIT_TAG
fi

if [ -x "$(command -v podman)" ]; then
    cli_cmd="podman"
elif [ -x "$(command -v docker)" ]; then
    cli_cmd="docker"
else
    echo "No container cli tool found! Aborting."
    exit -1
fi

echo "Building docker-jekyll image with tag $TAG"

${cli_cmd}  \
    build . \
    -f Dockerfile \
    --target jekyll \
    -t $(echo "$REGISTRY/docker-jekyll:$TAG")

${cli_cmd}  \
    build . \
    -f Dockerfile \
    --target serve \
    -t $(echo "$REGISTRY/docker-jekyll-serve:$TAG")