#!/usr/bin/sh
git branch -a
git pull origin
git checkout dev1
cp -R ./retrieveUnpackaged/* ./src/
git add ./src/*
git commit -m "checkin"
rm -fR retrieveUnpackaged
git push
echo " 3) ---Starting calculation diff between UAT1 and team branch ----"
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager/bin
export PATH=$PATH:C:/SF_PACKAGER/full_packager/sf-packager
git pull origin
git checkout dev1
git checkout uat1
C:/SF_PACKAGER/full_packager/sf-packager/index.js uat1 dev1 ./pkg_diff

