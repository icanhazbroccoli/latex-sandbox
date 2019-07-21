set -e

docker run -ti -v $(pwd):/miktex/work -e MIKTEX_GID=$(id -g) -e MIKTEX_UID=$(id -u) miktex/miktex /bin/bash -c "mpm --update-db && pdflatex sample.tex"
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git checkout master
git add sample.pdf
git commit -m "[skip travis] Automatic PDF build from ${TRAVIS_COMMIT}"
git pull --rebase
git remote set-url origin "https://${GITHUB_TOKEN}@github.com/icanhazbroccoli/latex-sandbox.git"
git push origin master
