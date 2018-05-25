---
title: A New Blog With Hexo
date: 2018-05-14 23:04:55
tags:
  - Hexo
  - Blog
category:
  - Learning
toc: true
---
I have been working and learning everyday in all Oracle Hyperion products.  I have learned things by doing trial and error method and referring the blogs and OTN posts for any clarification; the community has helped me a lot.  I wish to pay back to the community by documenting all my learnings in this blog.  The posts may have very basic information, but that is the purpose.  I wish people can use this blog, who starts from level 0, without any prior knowledge in Hyperion products.
<!---more--->
## Hyperion Blog
I decided to use this platform to write only about **Hyperion** products, that's the reason i have created a sub domain https://hyperion.anbuchelva.in.  This post is an exception to that, as I need to thank people who made this platform available for writing.  

## Static Blog
I wish to write blogs, however I do not want to use the traditional blogging systems such as Blogger or Wordpress and want to go with the static sites.  If you are familiar with static site generators there are variety options available.  

* Jekyll
* Hugo
* Hexo
* Ghost
* Gatsby etc.

I have tried all the platforms finally chosen Hexo to write blogs.  Still my primary domain page https://anbuchelva.in is running on Jekyll.  

## List of Products/Platforms Used
One of my primary requirement is not to spend money for hosting, CMS, etc., So I tried to stick with most of the free services and open source platforms in this blog as listed below:

1. [Hexo](https://hexo.io/) - The platform that generates static sites
2. [Markdown](https://en.wikipedia.org/wiki/Markdown) - The language is being used to write posts
3. [Gitlab](https://gitlab.com) - Hosting this site
4. [Hexo-pure-theme](https://github.com/cofess/hexo-theme-pure) - The Hexo theme used in this blog
5. [Github](https://github.com/) - The place where the theme is stored
6. [Cloudflare](https://www.cloudflare.com/) - for CDN and security purposes
8. [Disqus](https://disqus.com/) - For comments
7. [Google Domains](https://domains.google.com/) - for the https://anbuchelva.in domain<sup><a name="myfootnote1">1</a></sup> 

## Github vs. Gitlab
Github and Gitlab provides almost similar services.  However, I felt Gitlab provides more security compared to Github for hosting a site.  It has inbuilt <abbr title="Continuous Integration">CI</abbr> and End-to-end encryption with HTTPS certificate.

I have to depend on 3rd party CI such as Travis-CI or Circle-CI or Netlify, if I use Github.  Also the transactions between Github and Cloudflare is not secured.  Gitlab provides free private repository, which help me to secure my blog contents and avoid someone just fork all the contents/publish with his/her name.

I will keep a copy of this repository in my [Github Account](https://github.com/anbuchelva/hyperion), which is visible to everyone if somebody wants to see the bloging setup.

_That's all folks! Happy Writing!!_

---
<sup>[1](#myfootnote1)</sup> I pay $12 per year only for this is product.