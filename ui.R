library(shiny)
library(shinydashboard)
library(httr)
library(jsonlite)
library(ggplot2)
library(plotly)
library(tidyquant)
library(scales)
library(dplyr)
library(waiter)
library(dashboardthemes)

ui <- dashboardPage(
    dashboardHeader(title = "SG Weather"),
    dashboardSidebar(collapsed = T,
                     menuItem("Temperature",tabName = "temp_tab",icon = icon("thermometer"))),
    dashboardBody()
)
