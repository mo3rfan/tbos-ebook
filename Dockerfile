FROM debian:bullseye
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install texlive-xetex pandoc python2.7 git-core wget -y
RUN wget 'https://github.com/patriciogonzalezvivo/glslViewer/releases/download/1.6.0/glslviewer_1.6_amd64.deb'
RUN yes | dpkg -i "glslviewer_1.6_amd64.deb"
RUN apt-get install -y calibre
RUN git clone https://github.com/patriciogonzalezvivo/thebookofshaders.git
WORKDIR thebookofshaders
RUN mkdir /out
VOLUME /out
RUN apt-get install -y make
RUN make clean epub pdf
RUN ebook-convert book.epub book.mobi
ENTRYPOINT cp book.* /out/
