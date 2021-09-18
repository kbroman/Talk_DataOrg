library(broman)
library(here)

pdf(here("Figs/skipping_cells.pdf"), height=5, width=8, pointsize=16)
mat <- data.frame(id=101:107,
                  date=c("2015-06-14", "", "2015-06-18", "", "", "2015-06-20", ""),
                  glucose=myround(c(149.3, 95.3, 97.5, 117.0, 108.0, 149.0, 169.4), 1),
                  stringsAsFactors=FALSE)
excel_fig(mat, cellwidth=110)
dev.off()


pdf(here("Figs/skipping_cells_2.pdf"), height=5, width=8, pointsize=16)
mat$date[2] <- mat$date[1]
mat$date[4:5] <- mat$date[3]
mat$date[7] <- mat$date[6]
excel_fig(mat, cellwidth=110)
dev.off()
