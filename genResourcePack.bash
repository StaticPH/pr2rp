#! /bin/bash
function getFiles(){
	resourcePackDir="$1"
	rawViewPrefix="$2" # This is the prefix shared by the raw view for all files from the repository and branch
	wget -x -nH -i assets.txt --cut-dirs 4 -P "$resourcePackDir" -B "$rawViewPrefix"
}

function makeMeta(){
	description="$1"
cat <<EOF
{
   "pack":{
      "pack_format":3,
      "description":"$description"
   }
}
EOF
}

function assemble(){
	resourcePackDir="$1"
	rawViewPrefix="$2" # This is the prefix shared by the raw view for all files from the repository and branch
	description="$3"
	getFiles "$resourcePackDir" "$rawViewPrefix"
	makeMeta "$description"> "$resourcePackDir/"pack.mcmeta
	rm assets.txt
}


#parameter 1: folder for new resource pack
#parameter 2: prefix shared by the raw view for all files from the repository and branch
#parameter 3: description to use for your resource pack

assemble "$1" "$2" "$3"
