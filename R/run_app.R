#' Run the Shiny Application
#'
#' @param port Application port.
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(port, 
  ...
) {
  if(missing(port)){
    stop('\nargument "port" is missing, with no default')
  }
  
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server, options = list(host = "0.0.0.0", port = port)
    ), 
    golem_opts = list(...)
  )
}
