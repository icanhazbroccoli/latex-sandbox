set -e

USEBRANCH=master
BUILDSRC=sample.tex
BUILDRES=sample.pdf
GITEMAIL="travis@travis-ci.org"
GITNAME="Travis CI"
GITSRC="github.com/icanhazbroccoli/latex-sandbox.git"

git checkout "${USEBRANCH}"
docker run -ti -v $(pwd):/miktex/work -e MIKTEX_GID=$(id -g) -e MIKTEX_UID=$(id -u) miktex/miktex /bin/bash -c "mpm --update-db && pdflatex ${BUILDSRC}"
git config --global user.email "${GITEMAIL}"
git config --global user.name "${GITNAME}"
git add "${BUILDRES}"
git commit -m "[skip travis] Automatic PDF build from ${TRAVIS_COMMIT}"
git pull --rebase
git remote set-url origin "https://${GITHUB_TOKEN}@${GITSRC}"
git push origin "${USEBRANCH}"
