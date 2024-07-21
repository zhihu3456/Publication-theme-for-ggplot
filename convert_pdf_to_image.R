#################################################################
### simply convert pdf to png, jpeg, tiff
#################################################################
# convert pdf to png
ggsave_pdf2png <- function(object,name,width=10,height=10){
  ggsave(object,filename=paste0(name,'.pdf'),width=width,height=height)
  library(pdftools)
  library(png)
  bitmap <- pdf_render_page(paste0(name,'.pdf'),dpi=600)
  writePNG(bitmap, paste0(name,'.png'),dpi=600)
}
ggsave_pdf2png(p,'test',width=10,height=10)




# convert png to jpeg
png2jpeg <- function(name,width=10,height=10){
  library(png)
  library(grid)
  PNG <- png::readPNG(paste0(name,'.png'))
  raster_grob <- rasterGrob(PNG)
  jpeg(paste0(name,'.jpeg'), width = width, height = height, units = "in", res = 600)
  grid.newpage()
  pushViewport(viewport(x = 0.5, y = 0.5, width = 1, height = 1))
  grid.draw(raster_grob)
  dev.off()
}
png2jpeg('test',width=10,height=10)



# convert png to tiff
png2tiff <- function(name,width=10,height=10){
  library(png)
  library(grid)
  PNG <- png::readPNG(paste0(name,'.png'))
  raster_grob <- rasterGrob(PNG)
  tiff(paste0(name,'.tiff'), width = width, height = height, units = "in", res = 600)
  grid.newpage()
  pushViewport(viewport(x = 0.5, y = 0.5, width = 1, height = 1))
  grid.draw(raster_grob)
  dev.off()
}
png2tiff('test',width=10,height=10)

