if [ ! -d "themes/tranquilpeak" ]; then
	git config --global user.email "anbuchelva@gmail.com"
	git config --global user.name "anbuchelva"
	cd ../
	echo installing zip
	apt-get update
	apt-get install zip unzip
	echo downloading theme
	wget https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak/releases/download/v2.0.0/hexo-theme-tranquilpeak-built-for-production-2.0.0.zip
	echo unzipping
	unzip hexo-theme-tranquilpeak-built-for-production-2.0.0.zip -d themes/
	echo rename theme folder
	mv themes/hexo-theme-tranquilpeak-built-for-production-2.0.0 themes/tranquilpeak
	echo remove unnecessary files
	rm -rf themes/__MACOSX
	rm -rf hexo-theme-*.zip
	echo copy blog_tranquilpeak to tranquilpeak
	cp -rf themes/blog_tranquilpeak/* themes/tranquilpeak
fi