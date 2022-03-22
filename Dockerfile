FROM jupyter/datascience-notebook

USER root

# 
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean 
RUN apt-get install -y libgl1-mesa-glx tesseract-ocr libpoppler-dev poppler-utils imagemagick && apt-get clean
RUN pip install matplotlib==3.3.4 numpy==1.19.5 opencv-python==4.5.5.62 pandas==1.2.3 pytesseract==0.3.8 pdf2image==1.16.0 tabulate==0.8.9 Wand==0.6.7 pdfplumber==0.6.0
RUN sed -i 's#<policy domain="coder" rights="none" pattern="PDF" />#<policy domain="coder" rights="read|write" pattern="PDF" />#' /etc/ImageMagick-6/policy.xml

USER main
