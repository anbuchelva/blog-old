if [ ! -d "themes/tranquilpeak" ]; then
	# cd ../
	# echo installing zip
	# apt-get update
	# apt-get install zip unzip
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