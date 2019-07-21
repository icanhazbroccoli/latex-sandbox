This repo is an example of a LaTeX build pipeline.
In essence: the build pipeline triggers a pdf build from the source tex file on every commit.
The build pipeline is powered by Travis CI and uses miktex/miktex docker image.
The result pdf file is being uploaded to the same repo once the pipeline succeeds (this operaion creates a new commit authored by Travis CI).
