FROM debian:latest

RUN set -x && adduser \
  --home /home/latex \
  --gecos LaTeX \
  --uid 1000 \
  --disabled-password \
  latex

RUN apt-get update && apt-get install -y \
  texlive-full \
  # some auxiliary tools
  wget git openssh-client make \
  # markup format conversion tool
  pandoc pandoc-citeproc \
  # XFig utilities
  fig2dev \
  # syntax highlighting package
  python3-pygments python3-pip python3-virtualenv python3-dateutil \
  # Java runtime environment (e.g. for arara)
  default-jre-headless && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y
