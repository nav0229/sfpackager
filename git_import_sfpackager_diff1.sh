1#!/usr/bin/sh
ORGname=AIE
staging="dev_sandbox"
GitRepo="sfpackager"
URL="https://github.com/nav0229/sfpackager.git"

	git checkout dev1
	cp -R ./retrieveUnpackaged/* ./src/
	git add ./src/*
	git commit -m "checkin"
	git push

echo " 3) ---Starting calculation diff between UAT1 and team branch ----"
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager/bin
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager
git checkout uat1
git checkout dev1
C:/SF_PACKAGER/full_packager/sf-packager/index.js uat1 dev1 ./pkg_diff

