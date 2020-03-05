#' Create a gitpod ready dockerfile from a R description file
#'
#' @param FROM \code{character} FROM of the Dockerfile
#' @param AS \code{character} AS of the Dockerfile
#' @param rstudio \code{logical} if using a rstudio server image open ports
#'
#' @return A Dockerfile Object.
#' @export
create_gp_dockerfile <- function(FROM, AS, rstudio){
  # create a dockerfile
  dfile <- dockerfiler::dock_from_desc(FROM = FROM, AS = AS)
  # remove the final two lines inserted by dock_from_desc
  ldf <- length(dfile$Dockerfile)
  dfile$remove_cmd((ldf-1):ldf)
  dfile$add_after(
    cmd = "RUN R -e 'remotes::install_cran(\"attempt\")'",
    after = 3
  )
  dfile$add_after(
    cmd = "RUN R -e 'remotes::install_cran(\"remotes\")'",
    after = 4
  )
  # if using a rstudio image open port 8787 and set password
  if(rstudio){
    dfile$EXPOSE(8787)
    dfile$ENV("PASSWORD", "password")
  }
  # write file
  dfile$write(as = ".gitpod.Dockerfile")
}


#' Create  a .gitpd.yml file for R(studio)
#'
#' @return A yml file wrtitten to .gitpod.yml
#' @export
create_gp_yml <- function(rstudio){
  # write yml with rstudio settings
  if(rstudio){
    writeLines(c("image:",
                 "  file: .gitpod.Dockerfile",
                 "ports:",
                 "  - port: 8787",
                 "    onOpen: open-preview",
                 "tasks:",
                 "  - command: /usr/lib/rstudio-server/bin/rstudio-server start",
                 "vscode:",
                 "  extensions:",
                 "  - Ikuyadeu.r@1.2.1:z5vr1v1bfS++U/aHLSXQ6Q=="),
               ".gitpod.yml")
  }else{
    # write yml without rstudio settings
    writeLines(c("image:",
                 "  file: .gitpod.Dockerfile",
                 "vscode:",
                 "  extensions:",
                 "  - Ikuyadeu.r@1.2.1:z5vr1v1bfS++U/aHLSXQ6Q=="),
               ".gitpod.yml")
  }
}

#' Creates a docker- and .yml file from
#' the current R project to run in a gitpod instance
#' with relevant dependencies installed.
#'
#' @param FROM \code{character} FROM of the Dockerfile
#' @param AS \code{character} AS of the Dockerfile
#' @param rstudio \code{logical} if using a rstudio server image open ports
#'
#' @return a docker- and .yml file
#' @export
create_gp_files <- function(FROM, AS = NULL, rstudio = TRUE){
  # create docker file
  create_gp_dockerfile(FROM = FROM, AS = AS, rstudio = rstudio)
  # create .yml file
  create_gp_yml(rstudio = rstudio)
}
