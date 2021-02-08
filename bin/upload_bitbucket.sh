#!/bin/bash

if [ -z "${BITBUCKET_REPO_OWNER}" ]; then
    echo "Error: BITBUCKET_REPO_OWNER is not available."
    exit 1
fi

if [ -z "${BITBUCKET_REPO_SLUG}" ]; then
    echo "Error: BITBUCKET_REPO_SLUG is not available."
    exit 1
fi

if [ -z "${BB_AUTH_STRING}" ]; then
    echo "Error: BB_AUTH_STRING is not available."
    exit 1
fi

if [ ${BITBUCKET_EXIT_CODE} -ne 0 ]; then
    echo "Build was failed. Do not perform deployment."
    exit 1
fi

artifact=main.pdf

if [ ! -z "${BITBUCKET_TAG}" ]; then
    echo "Tag '${BITBUCKET_TAG}' found."
    tagged_artifact=main-${BITBUCKET_TAG}.pdf
    cp ${artifact} ${tagged_artifact}
    artifact=${tagged_artifact}
    echo "Upload artifact as ${tagged_artifact}"
fi

repo=${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}
echo "Upload artifact to ${repo}"
curl -X POST \
    --user "${BB_AUTH_STRING}" \
    "https://api.bitbucket.org/2.0/repositories/${repo}/downloads" \
    --form files=@"${artifact}"
echo "Done"

