#!/bin/bash
npm install
git config --global user.name anbuchelva
git config --global user.email anbuchelva@gmail.com
sed -i'' "s~git@github.com:anbuchelva/hyperion.git~https://${GH_TOKEN}:x-oauth-basic@github.com/anbuchelva/hyperion.git~" _config.yml
cp -rf themes/pure_hyperion/* themes/pure/
npm run generate
cp source/admin/config.yml public/admin/config.yml
npm run deploy