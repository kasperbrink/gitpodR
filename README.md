# gitpodR
A package for adding a gitpod setup to a R package. This lets you add a complete
gitpod Rstudio image to your package, with all dependencies.

Try it out here

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/kasperbrink/gitpodR)

To learn more about gitpod visit [gitpod](https://www.gitpod.io). 

Install from github:

```r
remotes::install_github(repo = "kasperbrink/gitpodR")
```

This package has one main function `create_gp_files` that takes three arguments,
`FROM`, `AS`, and `rstudio`.

Example usage
```r
create_gp_files(FROM = "rocker/tidyverse:latest", AS = NULL, rstudio = TRUE)
```

This adds a .gitpod.Dockerfile and .gitpod.yml to your package
which will enable you to start it as a gitpod workspace.