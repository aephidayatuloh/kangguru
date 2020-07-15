#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @importFrom shinyjs hide
#' @importFrom stats rnorm
#' @importFrom safer decrypt_string
#' @importFrom jsonlite fromJSON
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  
  expired <- decrypt_string(fromJSON(app_sys("app/assets/sid.json")))
  
  if(difftime(as.Date(expired), Sys.Date(), units = "days") <= 3){
    f7Notif(closeButton = TRUE, title = "Notifikasi", titleRightText = "Now",
            text = sprintf("Masa aktif %s hari", as.numeric(difftime(as.Date(expired), Sys.Date(), units = "days"))))
  }
  
  observe({
    if(Sys.Date() > as.Date(expired)){
      f7Dialog(title = "Notifikasi", text = "Lisensi kadaluarsa", type = "alert", session)
    } else {
      f7Dialog(title = "Login", inputId = "login", text = NULL, type = "login", session)
    }
  })
  
  observeEvent(input$login, {
    # req(input$login)
    if(input$login[1]== "" | input$login[2] == ""){
      return(NULL)
    } else {
      output$plot1 <- renderPlot({plot(rnorm(100), rnorm(100))})
    }
  })
  
  observeEvent(input$mulaiujian, {
    hide(id = "jadwal")
    output$uisoal <- renderUI({
      tagList(
        f7Swiper(id = "soal", slidePerView = 1, 
                 f7Slide(
                   f7Card(title = "Soal 1", 
                          "sfvdskbkdgkdfgjfbkdbdj", 
                          f7Radio(inputId = "jawaban1", label = NULL, choices = LETTERS[1:5])
                   )
                 ),
                 f7Slide(
                   f7Card(title = "Soal 2", 
                          "sfvdskbkdgkdfgjfbkdbdj", 
                          f7Radio(inputId = "jawaban2", label = NULL, choices = LETTERS[1:5])
                   )
                 )
        ),
        f7Segment(container = "segment", rounded = TRUE, 
                  f7Button(inputId = "prevs", label = f7Icon("backward_end_fill"), rounded = TRUE, color = "yellow"),
                  f7Button(inputId = "submits", label = "Submit"),
                  f7Button(inputId = "nexts", label = f7Icon("forward_end_fill"), rounded = TRUE, color = "green")
        )
      )
    })
  })
  
  observeEvent(input$submits, {
    f7Dialog(inputId = "confirm", title = "Yakin submit?", text = NULL, type = "confirm", session = session)
  })
  
  observeEvent(input$confirm, {
    if(input$confirm){
      f7Dialog(inputId = "finished", title = "Berhasil", text = input$confirm, #"Jawaban berhasil disimpan", 
               type = "alert", session = session)
      session$reload()
    }
  })
  
}
