#! /bin/bash

mkdir $1
cd $1
curl "http://www.freesound.org/apiv2/search/text/?query="$1"&token=a1e39f6de957344efe56bfb034195f33addb0a0d" | jq-osx-amd64 '.results | .[] |  .id' | while read line; do

oggfile=$(curl "http://www.freesound.org/apiv2/sounds/"$line"/?token=a1e39f6de957344efe56bfb034195f33addb0a0d" | jq-osx-amd64 '.previews | .["preview-hq-ogg"]'  )

echo $oggfile
#remove quotes
oggfile="${oggfile%\"}"
oggfile="${oggfile#\"}"

curl -O $oggfile #'/?token=a1e39f6de957344efe56bfb034195f33addb0a0d'

done

#token=a1e39f6de957344efe56bfb034195f33addb0a0d" 




