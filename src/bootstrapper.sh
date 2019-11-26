#!/bin/bash
if [[ ${REGION} != "" ]]
then
    URL="gs://${REGION}.artifacts.$PROJECT.appspot.com"
else
    URL="gs://artifacts.$PROJECT.appspot.com"
fi

{ gsutil ls ${URL} >/dev/null && echo "Bucket already exists"; } || \
{ gcloud auth configure-docker -q && docker build -t $IMAGE_NAME $DOCKERFILE_PATH && docker push $IMAGE_NAME && \
docker rmi $IMAGE_NAME && gcloud container images delete $IMAGE_NAME --quiet --force-delete-tags; }
