#!/usr/bin/sh
ORGname=AIE
staging="dev_sandbox"
GitRepo="sfpackager"
URL="https://github.com/nav0229/sfpackager.git"
branch="dev1"

	git checkout "$branch"
	cp -R ./retrieveUnpackaged/* ./src/
	git add ./src/*
	git commit -m "checkin"
	git push

echo " 3) ---Starting calculation diff between UAT1 and team branch ----"
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager/bin
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager
git checkout uat1
git checkout "$branch"
C:/SF_PACKAGER/full_packager/sf-packager/index.js uat1 "$branch" ./pkg_diff_"$TODAY"

