#!/bin/bash

# Define the images to check
images=("alpine:3.17.9" "nginx:1.27.0-alpine3.19" "busybox:1.35.0")
digests=()

# Pull the images and get their digests
for image in "${images[@]}"; do
  docker pull $image
  digest=$(docker inspect $image --format='{{index .RepoDigests 0}}')
  digests+=($digest)
done

# Read the digests from the answer file
readarray -t answer_digests < /opt/digest/answer

# Check if the number of digests match
if [ ${#digests[@]} -ne ${#answer_digests[@]} ]; then
  exit 1
fi

# Verify each digest
for i in "${!digests[@]}"; do
  if [ "${digests[$i]}" != "${answer_digests[$i]}" ]; then
    exit 1
  fi
done

exit 0
