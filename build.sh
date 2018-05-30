#!/bin/bash
npm install
git config --global user.name Netlify
git config --global user.email anbuchelva@gmail.com
sed -i'' "s~git@github.com:anbuchelva/blog.git~https://${GH_TOKEN}:x-oauth-basic@github.com/anbuchelva/blog.git~" _config.yml
hexo clean
hexo algolia
pwd #to identify present working directory
hexo generate
cp source/admin/config.yml public/admin/config.yml
# cp ../source/admin/netlify.css ../public/admin/netlify.css