function(input, output) { 
  # output$idplot <- renderapa({})
  
  # -------------------------- PLOT 1 --------------------------------------
  # Plot 1: Rangking -> Gap Earnings on Female and Male {Year}
  output$plot_categories <- renderPlotly({
    # Data Prep Plot 1
    top_categories2 <- youtube_clean %>% 
      filter(publish_year == input$input_year) %>% 
      group_by(category_id)
    
    top_categories2 <- as.data.frame(table(top_categories2$category_id)) 
    colnames(top_categories2) <- c("Title", "Freq")
    top_categories2 <- top_categories2 %>% 
      arrange(desc(Freq))
    
    top_categories2 <-  top_categories2 %>% 
      mutate(label=glue("Category : {Title}
     Video Count : {Freq}"))
    
    
    # Plot Rangking Statis
    plot_categories <- top_categories2 %>% 
      ggplot(mapping=aes(x = Freq,
                         y = reorder(Title, Freq),
                         text = label)) + # menambahkan kustomisasi hover pada plot dinamis
      geom_col(aes(fill = Freq)) +
      scale_fill_gradient(high = "#000000", low = "#E60E04") +
      labs(title = glue("Trending Categories of Youtube US in {input$input_year}"),
           x = "Video Count",
           y = NULL,
           caption = "Source: Youtube US Trending") +
      scale_y_discrete(labels = wrap_format(width = 30)) + theme(legend.position = "none") +
      theme_algoritma
    
    # Plot Rangking Interaktif
    ggplotly(plot_categories, tooltip = "text")
  })
  
  # Plot 1 Pages 2
  output$plot_trend <- renderPlotly({
    # Data Prep
    plot_agg_2 <- youtube_clean %>% 
      filter(category_id == input$select) %>% 
      group_by(channel_title) %>% 
      summarise(avg_views = mean(views)) %>% 
      arrange(desc(avg_views))
    
    plot_agg_2 <- head(plot_agg_2[order(plot_agg_2$avg_views, decreasing=T), ], 10)%>%
      mutate(label=glue("Channel : {channel_title}
     Average Views : {round(avg_views, 2)}"))
    
    # Plot Trend
    plot_trend <- plot_agg_2 %>% 
      ggplot(mapping=aes(x = avg_views,
                         y = reorder(
                           channel_title, avg_views),
                         text = label)) + # menambahkan kustomisasi hover pada plot dinamis
      geom_col(aes(fill = avg_views)) +
      scale_fill_gradient(high = "#000000", low = "#E60E04") +
      labs(title = glue("Top 10 Channel on {input$select}"),
           x = "Average Views",
           y = NULL,
           caption = "Source: Youtube US Trending") +
      scale_y_discrete(labels = wrap_format(width = 30)) + theme(legend.position = "none") +
      theme_algoritma
    
    # Plot Trend Interaktif
    ggplotly(plot_trend, tooltip = "text")
    
    
  })
  
  # Plot 2 Pages 2
  output$plot_likes <- renderPlotly({
    # Data Prep
    plot_agg_3 <-  youtube_clean %>% 
      filter(category_id == input$select) %>% 
      group_by(channel_title) %>% 
      summarise(avg_likes = mean(likes)) %>% 
      arrange(desc(avg_likes))
    
    plot_agg_3 <- head(plot_agg_3[order(plot_agg_3$avg_likes, decreasing=T), ], 10)%>%
      mutate(label=glue("Channel : {channel_title}
     Average Likes : {round(avg_likes, 2)}"))
    
    
    # Plot Trend
    plot_likes <- plot_agg_3 %>% 
      ggplot(mapping=aes(x = avg_likes,
                         y = reorder(
                           channel_title, avg_likes),
                         text = label)) + # menambahkan kustomisasi hover pada plot dinamis
      geom_col(aes(fill = avg_likes)) +
      scale_fill_gradient(high = "#000000", low = "#E60E04") +
      labs(title = glue("Top 10 Most Liked Channels in {input$select}"),
           x = "Average Likes",
           y = NULL) +
      scale_y_discrete(labels = wrap_format(width = 30)) + theme(legend.position = "none") +
      theme_algoritma
    
    # Plot Trend Interaktif
    ggplotly(plot_likes, tooltip = "text")
    
  })
  
  # ----- DATA TABEL -----
  output$table_data <- renderDataTable({
    datatable(data = youtube_clean,
              options = list(scrollX = TRUE)
    )
  })
  
  
  
  
}