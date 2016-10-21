CONTENTS = app.js COPYING.txt icon128.png icon512.png index.html manifest.webapp style.css

.PHONY: all
all: emoticons.zip emoticons.manifest.webapp github.manifest.webapp

.PHONY: clean
clean:
	find . -name '*~' -delete

.PHONY: icons
icons: icon128.png icon512.png

icon128.png: icon.svg
	rsvg-convert -w 128 icon.svg -o icon128.png
	optipng icon128.png

icon512.png: icon.svg
	rsvg-convert -w 512 icon.svg -o icon512.png
	optipng icon512.png

emoticons.zip: clean icons $(CONTENTS)
	rm -f emoticons.zip
	zip -r emoticons.zip $(CONTENTS)

emoticons.manifest.webapp: manifest.webapp
	sed manifest.webapp -e 's/"launch_path"\s*:\s*"[^"]*"/"package_path": "http:\/\/localhost:8080\/emoticons.zip"/' > emoticons.manifest.webapp

github.manifest.webapp: manifest.webapp
	sed manifest.webapp -e 's/"launch_path"\s*:\s*"[^"]*"/"package_path": "https:\/\/schnark.github.io\/emoticons\/emoticons.zip"/' > github.manifest.webapp
