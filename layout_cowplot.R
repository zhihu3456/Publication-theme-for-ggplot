# cowplot -------------------------------------------------------
library(cowplot)
mtcars$am <- factor(mtcars$am)
p <- ggplot(mtcars, aes(mpg, wt, color=am)) + geom_point(show.legend = F) 
# simple grid
plot_grid(p,p,p,p,
          ncol=2,
          labels=c('A','B','C','D'),
          label_size=10,
          label_colour = 'red',
          label_fontfamily = 'mono',
          rel_widths = c(1,2),
          rel_heights = c(2,1),
          align = 'hv'
          )
# nested grid
plot_grid(NULL,p,NULL,
          ncol=3,
          nrow=1,
          labels=c('','A',''),
          label_size=10,
          label_colour = 'red',
          label_fontfamily = 'mono',
          rel_widths = c(1,2,1)
) -> up 
plot_grid(p,p,
          labels=c('B','C'),
          label_size=10,
          label_colour = 'red',
          label_fontfamily = 'mono',
          rel_widths = c(2,2)
) -> bottom
plot_grid(up,bottom,
          ncol=1,
          nrow=2,
          labels=c('',''),
          label_size=10,
          label_colour = 'red',
          label_fontfamily = 'mono',
          rel_heights = c(1,1)
) -> complex
complex

# joint title 
title <- ggdraw() + 
  draw_label(
    "Miles per gallon decline with displacement and horsepower",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme(
    # add margin on the left of the drawing canvas,
    # so title is aligned with left edge of first plot
    plot.margin = margin(0, 0, 0, 7)
  )
plot_grid(title, complex,
          ncol=1,rel_heights = c(0.1,1))


# shared legend
# right
# extract the legend from one of the plots
legend <- get_legend(
  # create some space to the left of the legend
  p + theme(legend.box.margin = margin(0, 0, 0, 12))
)
# add the legend to the row we made earlier. Give it one-third of 
# the width of one plot (via rel_widths).
plot_grid(complex, legend, rel_widths = c(3, .1), nrow=1)

# bottom
# extract a legend that is laid out horizontally
p1 + 
  guides(color = guide_legend(nrow = 1)) +
  theme(legend.position = "bottom") -> p2
grobs <- ggplotGrob(p2)$grobs
legend <- grobs[[which(sapply(grobs, function(x) x$name) == "guide-box")]]
# add the legend underneath the row we made earlier. Give it 10%
# of the height of one plot (via rel_heights).
plot_grid(p1,p1, legend, 
          ncol = 1,
          rel_heights = c(1,1, .1))

# inset plots
inset <- ggplot(mpg, aes(drv)) + 
  geom_bar(fill = "skyblue2", alpha = 0.7) + 
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_hgrid(11)

ggdraw(p + theme_half_open(12)) +
  draw_plot(inset, .45, .45, .5, .5) +
  draw_plot_label(
    c("A", "B"),
    c(0, 0.45),
    c(1, 0.95),
    size = 12
  )

