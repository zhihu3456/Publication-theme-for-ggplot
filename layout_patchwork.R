library(ggplot2)
library(patchwork)

p1 <- ggplot(mtcars) + 
  geom_point(aes(mpg, disp)) + 
  ggtitle('Plot 1')

p2 <- ggplot(mtcars) + 
  geom_boxplot(aes(gear, disp, group = gear)) + 
  ggtitle('Plot 2')

p3 <- ggplot(mtcars) + 
  geom_point(aes(hp, wt, colour = mpg)) + 
  ggtitle('Plot 3')

p4 <- ggplot(mtcars) + 
  geom_bar(aes(gear)) + 
  facet_wrap(~cyl) + 
  ggtitle('Plot 4')


# ggplot objects can be added together using the + operator, be active to last plot
p1 + p2 + labs(subtitle = 'This will appear in the last plot')

# control layout
p1 + p2 + p3 + p4 + plot_layout(nrow = 3, byrow = FALSE)

# total title/caption 
(p1 | (p2 / p3)) + 
  plot_annotation(title = 'The surprising story about mtcars',
                  theme = theme(plot.title = element_text(hjust = 0.5))) 

# add tag
p1 + p2 + p3 + 
  plot_annotation(tag_levels = 'I')


# add non-ggplot content
p1 + grid::textGrob('Some really important text')

# add table 
p1 + gridExtra::tableGrob(mtcars[1:10, c('mpg', 'disp')])

# add base plot
p1 + ~plot(mtcars$mpg, mtcars$disp, main = 'Plot 2')


# change one theme of plots
patchwork <- p1 + p2
patchwork[[1]] <- patchwork[[1]] + theme_minimal()
patchwork

# change all
patchwork <- p3 / (p1 | p2)
patchwork & theme_minimal()

# patchwork * theme_minimal()



###### layout ------------------------------------------------------------------
p1 + plot_spacer() + p2 + plot_spacer() + p3 + plot_spacer()

(p1 + plot_spacer() + p2) / (plot_spacer() + p3 + plot_spacer())

p1 + p2 + p3 + p4 + 
  plot_layout(ncol = 3)

p1 + p2 + p3 + p4 + 
  plot_layout(widths = c(2, 1))

p1 + p2 + p3 + p4 + 
  plot_layout(widths = c(2, 1), heights = unit(c(5, 1), c('cm', 'null')))

layout <- "
##BBBB
AACCDD
##CCDD
"
p1 + p2 + p3 + p4 + 
  plot_layout(design = layout)

layout <- c(
  area(t = 2, l = 1, b = 5, r = 4),
  area(t = 1, l = 3, b = 3, r = 5)
)
p1 + p2 + 
  plot_layout(design = layout)


layout <- '
A#B
#C#
D#E
'
wrap_plots(D = p1, C = p2, B = p3, design = layout)


p2mod <- p2 + labs(x = "This is such a long\nand important label that\nit has to span many lines")
p1 | p2mod
free(p1) | p2mod

design <- "#AAAA#
           #AAAA#
           BBCCDD
           EEFFGG"
p3 + p2 + p1 + p4 + p4 + p1 + p2 +
  plot_layout(design = design)
free(p3) + p2 + p1 + p4 + p4 + p1 + p2 +
  plot_layout(design = design) # keep the prop right



# inset plot
p1 + inset_element(p2, left = 0.6, bottom = 0.6, right = 1, top = 1)
p1 + inset_element(p2, left = 0, bottom = 0.6, right = 0.4, top = 1, align_to = 'full')
p1 + inset_element(
  p2, 
  left = 0.5, 
  bottom = 0.5, 
  right = unit(1, 'npc') - unit(1, 'cm'), 
  top = unit(1, 'npc') - unit(1, 'cm')
)


# share legend
p1 + p2 + p3 + p4 +
  plot_layout(guides = 'collect')

((p2 / p3 + plot_layout(guides = 'auto')) | p1) + plot_layout(guides = 'collect')
((p2 / p3 + plot_layout(guides = 'keep')) | p1) + plot_layout(guides = 'collect')

p1a <- ggplot(mtcars) + 
  geom_point(aes(mpg, disp, colour = mpg, size = wt)) + 
  ggtitle('Plot 1a')
p1a | (p2 / p3)
(p1a | (p2 / p3)) + plot_layout(guides = 'collect')
p1 + p2 + p3 + guide_area() + 
  plot_layout(guides = 'collect')


# share axes
p1 + p2 + plot_layout(axes = "collect")
p1 + p2 + plot_layout(axis_titles = "collect")
p1 / p2 + plot_layout(axis_titles = "collect")


# annotation
patchwork <- (p1 + p2) / p3
patchwork + plot_annotation(
  title = 'The surprising truth about mtcars',
  subtitle = 'These 3 plots will reveal yet-untold secrets about our beloved data-set',
  caption = 'Disclaimer: None of these plots are insightful'
)

# tagging
patchwork + plot_annotation(tag_levels = 'A')
patchwork + 
  plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(face='bold'))

patchwork[[1]] <- patchwork[[1]] + plot_layout(tag_level = 'new')
patchwork + plot_annotation(tag_levels = c('A', '1'))

patchwork + plot_annotation(tag_levels = c('A', '1'), tag_prefix = 'Fig. ',
                            tag_sep = '.', tag_suffix = ':')

patchwork + 
  plot_annotation(tag_levels = c('A', '1'), tag_prefix = 'Fig. ', tag_sep = '.', 
                  tag_suffix = ':') & 
  theme(plot.tag.position = c(0, 1),
        plot.tag = element_text(size = 8, hjust = 0, vjust = 0))

patchwork + 
  plot_annotation(tag_levels = list(c('#', '&'), '1'))


# theme
patchwork + 
  plot_annotation(title = 'The surprising truth about mtcars') & 
  theme(text = element_text('mono'))
