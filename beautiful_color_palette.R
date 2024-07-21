# rcolors -------------------------------------------
# https://github.com/rpkgs/rcolors?tab=readme-ov-file
install.packages('rcolors')
library(rcolors)
cols = rcolors$amwg_blueyellowred

show_cols(cols)

(cols_1 = get_color(rcolors$amwg_blueyellowred, n = 20))

print(names(colors_group))

show_cols(colors_group$rainbow, margin = 14)



# PNWcolors --------------------------------------------
devtools::install_github("jakelawlor/PNWColors") 
library(PNWColors)
names(pnw_palettes)
PNWColors::pnw_palette('Bay')


# MetBrewer ------------------------------------------
devtools::install_github("BlakeRMills/MetBrewer")
library(MetBrewer)
MetBrewer::display.all.met()
MetBrewer::colorblind_met_palettes


# NatParksPalettes -----------------------------------
devtools::install_github("kevinsblake/NatParksPalettes")
library(NatParksPalettes)
names(NatParksPalettes)
NatParksPalettes::scale_fill_natparks_c()



# rockthemes ------------------------------------------
devtools::install_github("johnmackintosh/rockthemes")
library(rockthemes)
show_col(californication_pal()(10))


# RColorBrewer ----------------------------------------
library(RColorBrewer)
display.brewer.all()


# paletter --------------------------------------------
library(paletteer)
paletteer::palettes_d_names
paletteer::palettes_c_names





