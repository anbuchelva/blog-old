#!/bin/bash
npm install
git config --global user.name anbuchelva
git config --global user.email anbuchelva@gmail.com
sed -i'' "s~git@github.com:anbuchelva/blog.git~https://${GH_TOKEN}:x-oauth-basic@github.com/anbuchelva/blog.git~" _config.yml
cp -rf themes/blog_tranquilpeak/* themes/tranquilpeak
cd themes/tranquilpeak
npm install
npm install grunt-cli -g
npm install bower -g
bower install
grunt buildProd
cd ..
hexo clean
hexo algolia
#pwd #to identify present working directory
cp ../source/admin/config.yml ../public/admin/config.yml
# cp ../source/admin/netlify.css ../public/admin/netlify.css
# hexo generate
hexo deploy --silent