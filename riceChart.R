require(tidyverse)

sportsData <- read_csv('rice.csv')
chart <- sportsData %>%
  
  #basic ggplot stuff. Setting out x and y values, coloring by sport
  ggplot(aes(x = season, y = SRS, group=sport, color = sport)) +
  
  # adding a horizontal line at 0 that's darker
  geom_hline(yintercept = 0, color='#333333',size=0.2) +
  
  # adding our points, but giving them some opacity
  geom_point(alpha = 0.55, stroke=0, size=2) +
  
  # adding our trend lines, and making them a little thick
  geom_smooth(method = 'lm', se=FALSE, size=1.2) +
  
  # setting our x-axis breaks
  scale_x_continuous(breaks=c(1949, seq(1960, 2020, 10))) +
  
  #setting our y-axis breaks, and making a custom label to add "SRS" to the top label
  scale_y_continuous(breaks=seq(-20,20,5), labels=c(seq(-20,15,5),'20 SRS')) +
  
  # defining the colors for the two spots
  scale_color_manual(values=c('#666666', '#e7298a')) +
  
  # adding custom annotations for Football and Basketball, including their find and size
  # we're just eyeballing the y position
  # x position is to have it fall off the end of the chart, wiht a little padding
  annotate(geom='text',x = 2021, y = -13, label = 'Football', color = '#e7298a', hjust=0, family = 'Gill Sans SemiBold', size = 4.5) +
  annotate(geom='text',x = 2021, y = -2.4, label = 'Basketball', color = '#666666', hjust=0, family = 'Gill Sans SemiBold', size = 4.5) +
  
  # adding out two smaller custom annotations
  # eyeballing both the x and y position
  annotate(geom='text',x = 1962, y = 17.5, label = 'Rice was a powerhouse\nin the 50s and early 60s', hjust=0, family = 'Gill Sans Light', size=3.3) +
  annotate(geom='text',x = 1998, y = -19, label = '2017 and 2018 were Rice’s\nworst football seasons ever', hjust=0, family = 'Gill Sans Light', size=3.3) +
  
  # this will stop the Basketball and Football labels form getting cut off since they fall off the chart
  coord_cartesian(clip = 'off') +
  
  # setting out title/subtitle/caption and deleting our x and y labels
  labs(
    title= 'Rice football has gotten worse, basketball has stayed mediocre',
    subtitle = 'Simple Rating System score for each team by season, 1949 to 2020',
    x = '',
    y = '',
    caption = 'Source: sports-reference.com'
  ) +
  
  # this is a handy theme function that wipes out the defaul axis ticks and gray background
  theme_minimal() +
  
  # setting some more precise elements of our theme
  theme(
    
    # making Gill Sans Light our default font
    text = element_text(family = 'Gill Sans Light',  size = 12),
    
    # making the title bold and larger, plus adding some margin between the title and subtitle
    plot.title = element_text(family = 'Gill Sans SemiBold', size = 17, margin=margin(b=5)),
    
    # adding some margin between the subtitle and the start of the chart
    plot.subtitle = element_text(margin=margin(b=10)),
    
    # deleting the key since we're direct labeling
    legend.position = 'none',
    
    # removing minor gridlines
    panel.grid.minor = element_blank(),
    
    # making our major gridlines lighter and thinner
    panel.grid.major = element_line(colour = "#d9d9d9", size=0.2),
    
    # making our axis text a little lighter
    axis.text = element_text(color = '#262626'),
    
    # setting a bunch of margin to the right of the chart, so there's space for the basketball and football labels
    plot.margin = margin(5, 50, 5, 0)
  )

# exporting
ggsave(
  'riceChart.png',
  width = 550/72,
  height = 400/72,
  dpi = 300,
  units = 'in'
)