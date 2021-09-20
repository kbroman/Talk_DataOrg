# one thing per cell
library(broman)
library(here)

pdf(here("Figs/one_thing_per_cell.pdf"), height=5, width=9, pointsize=14)

mat <- data.frame(id=c(71, 72, 73, 74, 25, 26, 27, 28, 75, 76),
                  sex=c("M", "M", "M", "M", "F", "F", "F", "F", "M", "M"),
         Glu=c(216.9914, 242.0906, 109.4086, 147.1094, 199.8594,
               141.3293, 172.6252, 167.3137, 266.0442, 205.2229),
         Ins=c(0.17985, 3.5117, 0.06834, "0.85040", "0.4 (off curve lo)",
               0.64955, 0.61845, "0.037430", 0.15875, 0.26185),
         weight=paste(c(32.4, 58.8, 30.6, 34.4, 22.9, 29.4, 26.6, 24.6, 51.5, 33.3), "g"))

excel_fig(mat)
dev.off()


pdf(here("Figs/one_thing_per_cell_hilit1.pdf"), height=5, width=9, pointsize=14)
excel_fig(mat, hilitcells="D6")
dev.off()

pdf(here("Figs/one_thing_per_cell_hilit2.pdf"), height=5, width=9, pointsize=14)
excel_fig(mat, hilitcells=paste0("E", 2:11))
dev.off()



pdf(here("Figs/one_thing_per_cell_rev.pdf"), height=5, width=10, pointsize=14)

mat2 <- cbind(mat[,1:4], Ins_off_curve=rep("FALSE", nrow(mat)),
              weight=sub(" g$", "", mat[,5]))

mat2[grep("off", mat$Ins), "Ins_off_curve"] <- TRUE
mat2[grep("off", mat$Ins), "Ins"] <- 0.4
colnames(mat2)[ncol(mat2)] <- "weight_g"

excel_fig(mat2)

dev.off()
