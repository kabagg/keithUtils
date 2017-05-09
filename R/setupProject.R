#' Autopopulates project folder with common directories
#'
#' I almost always start a project by creating subdirectories
#' for RawData, ProcessedData, and so on, so I decided to
#' script the process to improve consistency.
#'
#' @param folderStyle character string naming the person
#'     whose file structure I'm using as a template.
#'     Default is "KeithBaggerly"; other currently allowed
#'     variants are "JennyBryan", and "KarlBroman".
#' @param includeProjectDescription logical - should a
#'     skeleton project description file be included at
#'     the top level of the project hierarchy? Defaults
#'     to TRUE.
#' @return invisible if all of the folders were successfully
#'     created.
#' @examples
#' setupProject("KeithBaggerly")
#' @export
setUpProject <- function(folderStyle="KeithBaggerly",
                         includeProjectDescription=TRUE){

  ## identify project root directory

  tempFolder <-
    tryCatch(find_root(is_rstudio_project),
             error = function(e) e)
  if(length(grep("No root directory found", tempFolder) == 0)){
    cat(paste0("No rstudio project found\n",
               "Setting working directory as project root\n"))
    projectRoot <- getwd()
  }else{
    cat("Setting project root")
    projectRoot <- tempFolder
  }

  projectInfo <- vector("list", 6)
  names(projectInfo) <-
    c("folderStyle",
      "figureFolder",
      "reportsFolder",
      "rawDataFolder",
      "processedDataFolder",
      "outputFolder")

  if(folderStyle=="KeithBaggerly"){
    foldersToAdd <-
      c("Data", "ProcessedData", "Figures", "Reports", "Output")

    projectInfo$folderStyle <- folderStyle
    projectInfo$figureFolder <- "Figures"
    projectInfo$reportsFolder <- "Reports"
    projectInfo$rawDataFolder <- "Data"
    projectInfo$processedDataFolder <- "ProcessedData"
    projectInfo$outputFolder <- "Output"
  }

  if(folderStyle=="JennyBryan"){

    ## Taken from
    ## https://www.stat.ubc.ca/~jenny/
    ##   STAT545A/block19_codeFormattingOrganization.html

    foldersToAdd <-
      c("fromCollaborator", "data", "code", "figs",
        "results", "prose", "rmd", "web")

    projectInfo$folderStyle <- folderStyle
    projectInfo$figureFolder <- "figs"
    projectInfo$reportsFolder <- "rmd"
    projectInfo$rawDataFolder <- "data"
    projectInfo$processedDataFolder <- "data"
    projectInfo$outputFolder <- "results"

  }

  if(folderStyle=="KarlBroman"){

    ## Taken from
    ## http://kbroman.org/Tools4RR/assets/
    ##   lectures/06_org_eda_withnotes.pdf
    ## Slide 6 deals with projects; he organizes
    ## folders for Papers and Presentations differently

    foldersToAdd <-
      c("Data", "Notes", "R", "R/Figs", "R/Cache",
        "RawData", "Refs")

    projectInfo$folderStyle <- folderStyle
    projectInfo$figureFolder <- "R/Figs"
    projectInfo$reportsFolder <- "R"
    projectInfo$rawDataFolder <- "RawData"
    projectInfo$processedDataFolder <- "Data"
    projectInfo$outputFolder <- "R"

  }


  for(i1 in 1:length(foldersToAdd)){
    if(!dir.exists(foldersToAdd[i1])){
      dir.create(foldersToAdd[i1])
    }
  }

  if(includeProjectDescription){

    newProjectDescription()

  }

  save(projectInfo,
       file=file.path(projectRoot, "projectInfo.RData"))

}
