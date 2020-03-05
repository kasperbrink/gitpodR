FROM rocker/tidyverse:latest
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "6c8fdaa")'
RUN R -e 'remotes::install_cran("attempt")'
RUN R -e 'remotes::install_cran("remotes")'
RUN R -e 'remotes::install_cran("dockerfiler")'
RUN R -e 'remotes::install_cran("devtools")'
EXPOSE 8787
ENV "PASSWORD"="password"
