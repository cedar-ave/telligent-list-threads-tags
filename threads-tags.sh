# Prerequisites
# Threads.json produced by running https://github.com/cedar-ave/telligent-get-content-data/content.sh
# jq

jq -c -r '.[].Threads[] | del(.Body,.Content[])' api/Threads.json | while read i; do
echo $i > i.json

tag=$(jq -r '.Tags[] | .[]' i.json)
subject=$(jq -r '.Subject' i.json)
groupId=$(jq -r '.GroupId' i.json)
sourceContentTypeId=$(jq -r '.ContentTypeId' i.json)
sourceContentId=$(jq -r '.ContentId' i.json)
date=$(jq -r '.Date' i.json)
empty=""

if [[ $tag != $empty ]]
then

jq -c -r '.Tags[] | .[]' i.json | while read k; do

# Remove hard returns on tags when Tags object has multiple values
hardReturn=$(echo $k | sed -e 's/\r//g')

echo "$hardReturn,$subject,$sourceContentId,$sourceContentTypeId,$groupId" >> threadTags.csv

done
fi

done
