#!/usr/bin/sh
#Title	:This script works in 3 steps
# a- retrieve sandbox metadta
# b- commit metadata into branch
# c- Invoke sfpackager and create the package
#
#author		 	 :Navdeep Singh
#date            :04012018
#version         :0.1  
#usage		     :git import + invoke sfpackager to DIFF

TODAY=`date '+%m_%d_%Y'.%H.%M.%S`
ORGname=AIE
staging="dev_sandbox"
GitRepo="pr-071472"
URL="git@bitbucket.org:acumensolutions/pr-071472.git"
branch="dev1"
#Export Variables
export TODAY
export staging
export GitRepo
export URL
export tagname
export ORGname
echo "Todays Date is = $TODAY "
tagname="$ORGname"_"$staging"_import_"$TODAY"
echo " Tag name to be created is = $tagname"
echo "-------"
echo " 1) ---Retrieve metadata from Staging Sandbox"
rm -fR retrieveUnpackaged
ant retrieveUnpackaged
if [[ $? -ne 0 ]]; then
    echo "---Error-----Error--"
	exit 1
	fi
cd ./retrieveUnpackaged
#rm -rf classes triggers pages staticresources components
cd ..

echo "Clean up of existing directory structure / existing GIT repo "
	if [ -d "$GitRepo" ]; then rm -Rf $GitRepo; fi
	echo "cleanup directory Finished"
echo "-------"
echo " 2) ---Clone GIT repo --- $URL"
git clone "$URL"
if [[ $? -ne 0 ]]; then
    echo "---Error occured . Run this command manually-"
	exit 1
	fi
	cd "$GitRepo"
	git checkout "$branch"
	cp -R ../retrieveUnpackaged/* ./src/
	git add ./src/*
	git commit -m "$tagname"
	git push
	#git tag "$tagname" "$branch" -m " "$staging" import -"$TODAY""
	#git push --tags
	
echo "GIT import completed Successfully----------------------"
echo "-------"
echo " 3) ---Starting calculation diff between UAT1 and team branch ----"
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager/bin
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager
git checkout uat1
git checkout "$branch"

C:/SF_PACKAGER/full_packager/sf-packager/index.js uat1 "$branch" ./pkg_diff_"$TODAY"
#index.js uat1 "$branch" ./pkg_diff
if [[ $? -ne 0 ]]; then
    echo "---Error occured during diff. Run manually-"
	exit 1
	fi
echo " --Diff/ Package has been created successfully------"
#echo "-------"
#echo " 4) ---Preparing pkg for the UAT deployment-------"
#rm -fR ../../deploy2test/src
#mkdir -p ../../deploy2test/src
#cp -R ./pkg_diff_"$TODAY"/team_branch/unpackaged/* ../../deploy2test/src/
#if [[ $? -ne 0 ]]; then
#    echo "---Error occured . Run this command manually-"
#	exit 1
#	fi
echo " --Diff/ Package has been GENERATED successfully------"
#cd ../../deploy2test
#./git_deploy_2_test.sh
