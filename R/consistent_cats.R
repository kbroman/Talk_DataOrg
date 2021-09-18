# consistent categories, missing values, and subject IDs

library(broman)
library(here)


mat <- data.frame(id=95:107,
                  sex=c("Male", "F", "F", "female", "Female",
                        "F","F","M","F","F",
                        "F","F","male"),
                  weight=c(50.1,22.6,23.5,24.6,20.8,
                           16.9,23.6, "", 27.2,20.5,
                           23.1,19.3,32.6),
                  heart=c(0.171,0.191,0.128,0.104,0.116,
                          0.107,0.114,0.131,0.131,"-",
                          0.115,0.103,0.126),
                  "L liver lobe"=c(0.515,0.441,"0.330",0.277,0.311,
                                   "NA",0.329,0.277,0.374,0.297,
                                   0.313,0.276,"0.210"))

mat[1:2,1] <- paste0("DO", mat[1:2,1])
mat[3:5,1] <- paste0("DO0", mat[3:5,1])
mat[6:7,1] <- paste0("DO", mat[6:7,1])
mat[8:11,1] <- paste0("DO-", mat[8:11,1])


pdf(here("Figs/consistent_cats.pdf"), height=5, width=10, pointsize=14)

excel_fig(mat, hilitcells=c("B2", "B9", "B14"))

dev.off()


pdf(here("Figs/consistent_nas.pdf"), height=5, width=10, pointsize=14)

excel_fig(mat, hilitcells=c("C9", "D11", "E7"))

dev.off()


pdf(here("Figs/consistent_ids.pdf"), height=5, width=10, pointsize=14)

excel_fig(mat, hilitcells=c("A2", "A4", "A9", "A13"))

dev.off()
