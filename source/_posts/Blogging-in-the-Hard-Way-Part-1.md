---
title: Blogging in the Hard Way - Part 1
coverImage: ../../assets/images/hexo.jpg
coverMeta: in
coverSize: partial
metaAlignment: center
meta: Yes
clearReading: true
autoThumbnailImage: false
thumbnailImagePosition: left
thumbnailImage: ../../assets/images/hexo-logo.png
comments: true
actions: true
date: 2018-06-02 14:17:52
category:
  - Blog
tags:
  - Hexo
  - Blog
  - Netlify
  - Travis-CI
  - Tranquilpeak
  - "Github Pages"
keywords:
  - Hexo
  - Blog
  - Netlify
  - Travis-CI
  - Tranquilpeak
  - "Github Pages"
coverCaption:
disqusIdentifier: anbu-blog
---
I have started this blog in last November, after that I did not write anything, as like the way it happens everytime.  We start something and forget, until we make it as routine.  Meanwhile, I was doing some analysis and checks, etc on the blogging platform.  Like to share the same here..
<!---more--->
<!-- toc -->
# The Staitc Blog
Why Static Blog?  I have tried using the ready-made blogging platforms such as Blogger, WordPress, etc., But I settled with Static blogging platform, for its simplicity and speed.  Whenever I make changes and push the commits to git repository, the CI automatically build the site as `HTML` pages.  When the user opens up the website, they access the webpages which are built already.  There's no to and fro data movement to load the pages.  

The blog uses the following platforms.  
1. [Hexo](https://hexo.io/) - The platform that generates static sites
2. [Markdown](https://en.wikipedia.org/wiki/Markdown) - The language is being used to write posts
3. [Github](https://github.com) - where the source of this blog is saved
4. [Github Pages](https://github.com/pages) - The Hosting place
5. [Hexo-tranquilpeak-theme](https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak) - The Hexo theme used in this blog designed by [Louis Barranqueiro](https://github.com/LouisBarranqueiro)
7. [Travis-CI](gittps://travis-ci.org) for building the theme & site
6. [Cloudflare](https://www.cloudflare.com/) - for CDN and security purposes
8. [Disqus](https://disqus.com/) - For comments
9. [Google Domains](https://domains.google.com/) - for the https://anbuchelva.in domain

## Blog PlatForm
Before I choose Hexo, tried handful of static site generates as listed below
* Jekyll - Lot of themes available, Github build the pages automatically.  But, felt it is slow.  Still my primary domain page https://anbuchelva.in is running on Jekyll.
* Hugo - Good, thought to use
* Hexo - Good, thought to use
* Ghost - Good, but subscription based 
* Gatsby - Too complex for a regular user to setup a simple blog

So, I have chosen to use Hugo or Hexo, analysing further Hexo has handful of plugins (though most of the users are from china, thanks to google translate).

## Gitlab vs. Github
Gitlab and Github provides similar kind services to store the source contents of the blog.  Few differences when comparing Gitlab and Github.

|Service| Gitlab| Github|
|---|---|---|
|__Private Repository__| Unlimited private repositories | Not available |
|__Continuous Integration__|2000 Hours of CI engine per Month| Not available, <br> have to depend on other CI cervices like Travis-CI, Circe-CI, Netlify|
|__Encryption__|The connection is encrypted between Gitlab and Cloudflare | No encryption provided for custom domain |
|__Server Response Time__|Slow|Fast <br> improvement in Google Page Speed test for more than 20 points|
|__Netlify CMS Integration__| Not available yet | Available|

Gitlab gives more options compared to github.  However, I am hosting the blog in Github, due to the pages speed, which every blogger wants to achieve.  I am still thinking of moving the source contents to Gitlab and host the output (built by CI) in Github.

## Tranquilpeak Theme
There are many [themes](https://hexo.io/themes/index.html) available for Hexo.  Most of the users are from China and the documentation are available in Chinese, which is not an issue until we have Google Translate.

Tranquilpeak theme is more responsive, modern and provide lot of options.  The theme should be build before building the website, which takes approximately 5 minutes whenever I initiate the CI to build the site. I want to avoid it.

I have gone through the documents and enabled cache for ```themes/tranquilpeak/node_modules``` folder, which reduced the site building time to 1+ minute.  Though I wanted the time to reduce it further; So, I download the themes folder instead of building, which saved more than 30 seconds.

The code to download and build the theme: 
{% codeblock build_theme.sh lang:bash https://github.com/anbuchelva/blog/blob/source/build_theme.sh build_theme.sh %}
if [ ! -d "themes/tranquilpeak" ]; then
	echo downloading theme
	wget https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak/releases/download/v2.0.0/hexo-theme-tranquilpeak-built-for-production-2.0.0.zip --quiet
	echo unzipping
	unzip -qo hexo-theme-tranquilpeak-built-for-production-2.0.0.zip -d themes/
	echo rename theme folder
	mv themes/hexo-theme-tranquilpeak-built-for-production-2.0.0 themes/tranquilpeak
	echo remove unnecessary files
	rm -rf themes/__MACOSX
	rm -rf hexo-theme-*.zip
	echo copy blog_tranquilpeak to tranquilpeak
	cp -rf themes/blog_tranquilpeak/* themes/tranquilpeak
	rm -rf themes/tranquilpeak/source/assets/images/*
	cd themes/tranquilpeak
	npm install
	cd ../../
fi
{% endcodeblock %}

the code for building the site: 
{% codeblock build_site.sh lang:bash https://github.com/anbuchelva/blog/blob/source/build_site.sh build_site.sh %}
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
fi
echo ${ci}
hexo deploy --silent
{% endcodeblock %}

I use the theme template as it is from the source, then I copy the files which needs to be customized from ```themes\blog_tranquilpeak\``` to ```themes\tranquilpeak\``` folder.  When there's a new release on the theme source, I don't need to worry in merging the latest commits.

## Continuous Integration
I tried using four platforms for CI.

1. [Travis-CI](https://travis-ci.org)
2. [Netlify](https://netlify.com)
3. [Circle-CI](https://circleci.com)
4. Gitlab-CI

Since, I have moved all the source contents to Github repo, Gitlab CI is no longer being used.
Circe-CI to be improved, as per my opinion.
Travis-CI is simple and build sites for free for all open source projects. But it is bit slow compared to other CI.

### Netlify
I tried Netlify for building site and hosting it there, with their CDN services, HTTPS encryption, CMS etc.,  But their CDNs are slow compared to Github.  So, I revert to Github Pages.  Still I use Netlify for building web pages and deploy back to Github repo; refer this [branch](https://github.com/anbuchelva/blog/commits/master).  There's no special command to build site in Netlify; I just use ```. build_theme.sh && . build_site.sh```. Netlify takes care of the docker to be used, caching, etc.

### Travis-CI
As mentioned Travis-CI is simple and trustable (_I'm bit paranoid_)  

The `yml` code that I use for configuring Travis-CI is here:
{% codeblock .travis.yml lang:yml https://github.com/anbuchelva/blog/blob/source/.travis.yml .travis.yml %}
language: node_js
node_js:
- 8.9.1
sudo: false
cache:
  directories:
  - node_modules
  - themes
before_install:
- npm install hexo-cli -g
install:
- npm install
branches:
  only:
  - source
script:
- . build_theme.sh
- . build_site.sh
{% endcodeblock %}

I use 3 environment variables to build the site
`ALGOLIA_ADMIN_API_KEY` - secret key for Algolia search
`GH_TOKEN` - secret key to write back the deployed site into git repository
`ci` - not a secret key, just to identify which CI built and deployed the site.

I may write a separate post for CI.

## Cloudflare
I should thank [Cloudflare](https://cloudflare.com) for their free service for ultrafast CDN and free encryption certificate, caching etc.  This increased the site speed from 60+ to 80-90 out of 100.

That's all folks!!