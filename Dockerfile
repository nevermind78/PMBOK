FROM jupyter/datascience-notebook

ENV NB_PKGDIR=/home/work

USER root


RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx tesseract-ocr libpoppler-dev poppler-utils imagemagick && apt-get clean

# (fyi) You can pass args from docker-compose.yml, just remove the "=myuser" from here
ARG USERNAME=myuser

# for whatever reason the /home/username directory is not created with useradd  for me :/
# RUN useradd -u ${USER_UID} --gid ${USER_GID} ${USERNAME}
RUN adduser --uid 1000 --disabled-password ${USERNAME}

# Switch to our non-root user
USER ${USERNAME}
# add the default pip bin install location to the PATH
ENV PATH="$PATH:/home/${USERNAME}/.local/bin"

RUN pip install matplotlib==3.3.4 numpy==1.19.5 opencv-python==4.5.5.62 pandas==1.2.3 pytesseract==0.3.8 pdf2image==1.16.0 tabulate==0.8.9 Wand==0.6.7 pdfplumber==0.6.0
RUN sed -i 's#<policy domain="coder" rights="none" pattern="PDF" />#<policy domain="coder" rights="read|write" pattern="PDF" />#' /etc/ImageMagick-6/policy.xml


WORKDIR /home/work
COPY . .
RUN fix-permissions "${NB_PKGDIR}"
