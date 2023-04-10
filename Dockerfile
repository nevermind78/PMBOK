FROM jupyter/datascience-notebook

ENV NB_PKGDIR=/home/work

USER root


RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx tesseract-ocr libpoppler-dev poppler-utils imagemagick && apt-get clean


# Switch to our non-root user
#USER ${USERNAME}
# add the default pip bin install location to the PATH
#ENV PATH="$PATH:/home/${USERNAME}/.local/bin"

RUN sudo -H pip install matplotlib numpy opencv-python pandas pytesseract pdf2image tabulate Wand pdfplumber
RUN sed -i 's#<policy domain="coder" rights="none" pattern="PDF" />#<policy domain="coder" rights="read|write" pattern="PDF" />#' /etc/ImageMagick-6/policy.xml


WORKDIR /home/work
COPY . .
RUN fix-permissions "${NB_PKGDIR}"
