FROM rocker/shiny-verse:latest

ARG WHEN

# Installing general-use libraries
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 

# Download and install shiny server
#RUN sudo apt-get install gdebi-core
#RUN wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.13.944-amd64.deb
#RUN sudo gdebi shiny-server-1.5.13.944-amd64.deb

    
# Package install 
#Devtools - required for installing speedyseq
RUN R -e "install.packages('devtools')"

#R Markdown
RUN R -e "install.packages('knitr')"

#Plot generation/visualization packages
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('heatmaply')"
RUN R -e "install.packages('ggpubr')"
RUN R -e "install.packages('hrbrthemes')"

#Other required libraries
RUN R -e "install.packages('vegan')"
RUN R -e "install.packages('DT')"

#BiocManager, phyloseq and extensions
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('phyloseq')" 
RUN R -e "BiocManager::install('microbiome')"
RUN R -e "devtools::install_github('mikemc/speedyseq')"

#Shiny and Shiny extensions
RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('shinydashboard')"
RUN R -e "install.packages('shinyBS')"

# Copy configuration files into the Docker image
COPY ./app/  /srv/shiny-server/app/
COPY ./shiny-server.sh /srv/shiny-server/
COPY ./shiny-server.conf  /etc/shiny-server/shiny-server.conf

RUN chmod -R 755 /srv/shiny-server/

WORKDIR /srv/shiny-server/

# Expose port 3838
EXPOSE 3838

# Run the app
CMD R -e "options(shiny.port=3838, shiny.host='0.0.0.0'); shiny::runApp('./app')"
#CMD ["R", "-e", "shiny::runApp(port = 3838)"]
#CMD ["/srv/shiny-server/shiny-server.sh"]


