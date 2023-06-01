# Fungsi dashboardPage() diperuntuhkan untuk membuat ketiga bagian pada Shiny
dashboardPage(skin = "black",
              
              # ------ HEADER -------
              # Fungsi dashboardHeader() adalah bagian untuk membuat header
              dashboardHeader(title = "Youtube Analysis"), 
              # ------ SIDE BAR -------
              # Fungsi dashboardSidebar() adalah bagian untuk membuat sidebar
              dashboardSidebar(
                sidebarMenu(
                  menuItem(text = "Overview",
                           tabName = "page1",
                           icon = icon("video")),
                  menuItem(text = "Channels",
                           icon = icon("youtube"),
                           tabName = "page2",
                           badgeLabel = "new",
                           badgeColor = "green"),
                  menuItem(text = "Data Table",
                           tabName = "page3",
                           icon = icon("table-list")),
                  menuItem(
                    text = "Source", 
                    icon = icon("code"),
                    href = "https://github.com/ahmaddfauzi24/LBB_IP"),
                  selectInput(inputId = "input_year", 
                              label = "Choose year", 
                              choices = levels(youtube_clean$publish_year))
                  
                  
                )
              ),
              
              # ------ BODY -------
              # Fungsi dashboardBody() adalah bagian untuk membuat isi body
              dashboardBody(
                tabItems(
                  # --- PAGE 1 (Dashboard) --- 
                  tabItem(tabName = "page1",
                          fluidRow(
                            # A static infoBox
                            infoBox(title = "TOTAL DATA", 
                                    value = nrow(youtube_clean), 
                                    icon = icon("credit-card"),
                                    color = "purple"),
                            infoBox(title = "TOTAL UNIQUE VIDEOS",
                                    value = length(unique(youtube_clean$title)), 
                                    icon = icon("video"),
                                    color = "navy"),
                            infoBox(title = "TOTAL UNIQUE CHANNELS", 
                                    value = length(unique(youtube_clean$channel_title)), 
                                    icon = icon("headphones"),
                                    color = "light-blue")
                          ),
                          # Row 2 (PLOT 1)
                          fluidRow(  # Kotak bayangan untuk menaruh kertas/box
                            box(width = 12,
                                # plotoutput -> untuk statis -> ubah menjadi plotlyoutput
                                # outputId sama dengan tabname ->  unik untuk setiap plot yang ada
                                plotlyOutput(outputId = "plot_categories",
                                             height = 500)
                            )
                          )
                  ),
                  
                  # --- PAGE 2 (Scatter Plot) --- 
                  tabItem(tabName = "page2",
                          fluidRow(
                            box(width = 12,
                                solidHeader = TRUE,
                                status = "warning",
                                title = "Choose Video Category" ,
                                selectInput(inputId = "select",
                                            label = NULL,
                                            choices = levels(youtube_clean$category_id)))
                            
                                
                            ),
                          # Row 2 (PLOT 1)
                          fluidRow(  # Kotak bayangan untuk menaruh kertas/box
                            box(width = 12,
                                # plotoutput -> untuk statis -> ubah menjadi plotlyoutput
                                # outputId sama dengan tabname ->  unik untuk setiap plot yang ada
                                plotlyOutput(outputId = "plot_trend",
                                             height = 500)
                            )
                          ),
                          # Row 2 (PLOT 2)
                          fluidRow(  # Kotak bayangan untuk menaruh kertas/box
                            box(width = 12,
                                # plotoutput -> untuk statis -> ubah menjadi plotlyoutput
                                # outputId sama dengan tabname ->  unik untuk setiap plot yang ada
                                plotlyOutput(outputId = "plot_likes",
                                             height = 500)
                            )
                          )
                          
                          
                          
                  ),
                  
                
                  # --- PAGE 3 (Data Table) --- perlu install library tambahan (DT)
                  tabItem(tabName = "page3",
                          fluidRow(
                            box(width = 12,
                                # title = "Dataset US YouTube Trending 2017-2018",
                                dataTableOutput(outputId = "table_data"))  
                          )
                  )
                )
              )
)