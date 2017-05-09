#' Build a new Project Description from a Template
#'
#' This pulls in a template description skeleton from
#' the package. There should just be one project description,
#' and it should reside at the top level of the project.
#' It should describe why we're undertaking this in broad
#' terms.
#' This is largely a wrapper for
#' rmarkdown::draft() with some prespecified arguments.
#'
#' @return invisible if the report subfolder and skeleton
#'     are successfully built.
#' @examples
#' newProjectDescription()
#' @export
newProjectDescription <- function(){

  rmarkdown::draft(file = "projectDescription.Rmd",
                   template = "projectDescription",
                   package = "keithUtils",
                   create_dir = FALSE,
                   edit = FALSE)

}
