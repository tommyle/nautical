build-web:
	/Users/tommyle/flutter/bin/flutter build web
	cp -R /Users/tommyle/repos/dashboard/build/web /Users/tommyle/repos/nautical_web
	cd /Users/tommyle/repos/nautical_web
	git add .
	git commit -m 'Deploy'
	git push