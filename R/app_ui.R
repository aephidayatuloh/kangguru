#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @import RPostgreSQL
#' @noRd
app_ui <- function(request) {
  jadwal_dt <- data.frame(tanggal = c("2020-08-10", "2020-08-11", "2020-08-11", "2020-08-12"),
                          waktu_mulai = c("12:30", "03:00", "03:30", "08:00"),
                          waktu_selesai = c("14:00", "03:30", "05:00", "09:00"),
                          mapel = c("bindo", "math", "fis", "kim"))
  
  
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    # List the first level UI elements here 
    f7Page(favicon = "favicon.ico", 
           useShinyjs(),
           # useShinyalert(),
           init = f7Init(skin = "ios", theme = "light"),
           f7SingleLayout(
             navbar = f7Navbar(
               title = "Kangguru",
               hairline = FALSE,
               shadow = TRUE,
               left_panel = FALSE,
               right_panel = FALSE
             ),
             div(id = "jadwal", 
                 h1("Jadwal Ujian", style="text-align: center;"),
                 f7Timeline(calendar = FALSE, list_to_jadwal(jadwal_dt))
             ),
             uiOutput("uisoal")
           )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @import shinyMobile
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @importFrom shinyjs useShinyjs
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'Kangguru'
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
    withMathJax(),
    useShinyjs()
  )
}

