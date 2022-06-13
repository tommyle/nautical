deploy:
	/Users/tommyle/flutter/bin/flutter build web
	rm -r /Users/tommyle/repos/nautical_web/docs && \
	cp -R /Users/tommyle/repos/dashboard/build/web /Users/tommyle/repos/nautical_web/docs
	cd /Users/tommyle/repos/nautical_web && git add . && \
	git commit -m 'Deploy' && \
	git push