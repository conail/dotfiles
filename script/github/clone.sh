
#!/bin/bash

while read -r ORG; do
    echo $ORG
    mkdir "$HOME/src/github.com/$ORG"
    cd "$HOME/src/github.com/$ORG"
    curl -s "https://api.github.com/users/$ORG/repos?per_page=200" | grep -e "clone_url" | cut -d \" -f 4 | xargs -L1 git clone
done < "$HOME/.files/script/github/orgs.txt"
