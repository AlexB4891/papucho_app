
# ------------------------------------------------------------------------- #
#          Aplicación para la presentación de informes por proceso          #
# ------------------------------------------------------------------------- #


# Librerias ---------------------------------------------------------------

library(tidyverse)
library(glue)
library(shiny)
library(readxl)
library(DT)

# Lectura -----------------------------------------------------------------

tabla <- read_excel("data/tabla_de_tablas.xlsx")


# Crear tags de HTML ------------------------------------------------------

tabla <- tabla |> 
  mutate(across(.cols = matches("Proceso"),
                .fns = ~glue('<a href = \"{x}\">{x}</a>',x = .x)))

# Función para la tabla en {gt} -------------------------------------------

ui <- fluidPage(
  DTOutput("tabla_links")  
)

server <- function(input, output, session) {
  
  output$tabla_links <- renderDT({
    
    tabla
    
  }, 
  filter = 'top',
  escape = FALSE,
  options = list(
    pageLength = 10, 
    autoWidth = TRUE))
  
}

shinyApp(ui, server)
