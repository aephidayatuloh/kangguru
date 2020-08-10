#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @importFrom shinyjs hide
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  
  f7Dialog(title = "Login", inputId = "login", text = NULL, type = "login", session)
  
  
  observeEvent(input$mulaiujian, {
    hide(id = "jadwal")
    output$uisoal <- renderUI({
      tagList(
        f7Swiper(id = "soal", slidePerView = 1, 
                 f7Slide(
                   col_12(
                          h5("Soal 1", style="margin-bottom: 0;padding-left: 5px;padding-right: 5px;"),
                          withMathJax(helpText(
                            "Quiz your audience with this easy-to-use quiz template by 123FormBuilder. Customize it with simple the simple drag-and-drop interface, type in your questions, provide multiple choice answers with images, and many more. Show the quiz score on completion, trigger partial answers, and send auto-replies by email. With 123FormBuilder, quizzing online is as easy as 1-2-3!"
                            )),
                          f7Radio(inputId = "jawaban1", label = NULL, choices = LETTERS[1:5])
                   ), 
                   br()
                 ),
                 f7Slide(
                   col_12(
                     h5("Soal 2", style="margin-bottom: 0;padding-left: 5px;padding-right: 5px;"),
                     withMathJax(helpText(
                       "Quiz your audience with this easy-to-use quiz template by \\(f(x) = x^2 + 2x + 1\\). Customize it with simple the simple drag-and-drop interface, type in your questions, provide multiple choice answers with images, and many more. Show the quiz score on completion, trigger partial answers, and send auto-replies by email. With 123FormBuilder, quizzing online is as easy as 1-2-3!")),
                     f7Radio(inputId = "jawaban2", label = NULL, choices = LETTERS[1:5])
                     ), 
                   br()
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
