set -e

USEBRANCH=master
GITEMAIL="travis@travis-ci.org"
GITNAME="Travis CI"
GITSRC="github.com/icanhazbroccoli/latex-sandbox.git"

git checkout "${USEBRANCH}"
for src in $(ls -a *.tex); do
    docker run -ti -v $(pwd):/miktex/work -e MIKTEX_GID=$(id -g) -e MIKTEX_UID=$(id -u) miktex/miktex /bin/bash -c "mpm --update-db && pdflatex ${src}"
done
git config --global user.email "${GITEMAIL}"
git config --global user.name "${GITNAME}"
git add *.pdf
git commit -m "[skip travis] Automatic PDF build from ${TRAVIS_COMMIT}"
git pull --rebase
git remote set-url origin "https://${GITHUB_TOKEN}@${GITSRC}"
git push origin "${USEBRANCH}"
