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
URL="https://github.com/nav0229/sfpackager.git"
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
	#cd "$GitRepo"
	git checkout "$branch"
	cp -R ../retrieveUnpackaged/* ./src/
	git add ./src/*
	git commit -m "$tagname"
	git push

echo " 3) ---Starting calculation diff between UAT1 and team branch ----"
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager/bin
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager
git checkout uat1
git checkout "$branch"
C:/SF_PACKAGER/full_packager/sf-packager/index.js uat1 "$branch" ./pkg_diff_"$TODAY"

