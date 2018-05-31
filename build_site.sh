#!/bin/bash
npm install
sed -i'' "s~git@github.com:anbuchelva/blog.git~https://${GH_TOKEN}:x-oauth-basic@github.com/anbuchelva/blog.git~" _config.yml
hexo clean
hexo algolia
pwd #to identify present working directory
hexo generate
cp source/admin/config.yml public/admin/config.yml
# cp ../source/admin/netlify.css ../public/admin/netlify.css
if [ ${ci}="Netlify" ]; then
	git config --global user.name 'anbuchelva via Netlify'
	git config --global user.email netlify@netlify.com
elif [ ${ci}="Travis-CI" ]; then
	git config --global user.name 'anbuchelva via Travis-CI'
	git config --global user.email travis-ci@Travis-CI.org
else
	git config --global user.name anbuchelva
	git config --global user.email anbuchelva@gmail.com
fi
echo ${ci}
hexo deploy --silent