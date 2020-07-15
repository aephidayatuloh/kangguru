#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @import RPostgreSQL
#' @noRd
app_ui <- function(request) {
  items <- tagList(
    f7TimelineItem(NULL,
                   date = "01 Des",
                   card = FALSE,
                   time = "12:30 - 14:00",
                   title = "Matematika",
                   side = "left"
    ),
    f7TimelineItem(
      f7Button("mulaiujian", "Mulai Ujian"),
      date = "02 Dec",
      card = TRUE,
      time = "13:00 - 14:30",
      title = "Bahasa Indonesia"
    ),
    f7TimelineItem(NULL,
                   date = "02 Dec",
                   card = TRUE,
                   time = "15:00 - 16:30",
                   title = "Farmakognosi"
    ),
    f7TimelineItem(NULL,
                   date = "03 Dec",
                   card = FALSE,
                   time = "13:00 - 15:45",
                   title = "Kimia"
    )
  )
  
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
                 f7Timeline(calendar = FALSE, items)
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
    useShinyjs()
  )
}

