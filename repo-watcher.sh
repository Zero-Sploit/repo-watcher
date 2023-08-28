#!/bin/sh

repos=("Owner1/repo_name1" "Owner2/repo_name2")
local_versions=("unlshd-062" "v1.7.4")  # Update with your local versions

for ((i=0; i<${#repos[@]}; i++)); do
    repo=${repos[i]}
    local_version=${local_versions[i]}

    owner=$(echo "$repo" | cut -d'/' -f1)
    repo_name=$(echo "$repo" | cut -d'/' -f2)

    latest_version=$(curl -s "https://api.github.com/repos/$owner/$repo_name/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

    if [[ "$latest_version" == "$local_version" ]]; then
        echo "Repository $repo is up to date (Version $local_version)."
    else
        echo "Repository $repo is not up to date. Latest version is $latest_version."
    fi
done
