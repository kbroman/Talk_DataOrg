# spreadsheet with highlighted cell

library(broman)
library(here)

pdf(here("Figs/no_highlighting.pdf"), height=5, width=8, pointsize=14)

mat <- data.frame(id=101:107,
                  date=c("2015-06-14", "", "2015-06-18", "", "", "2015-06-20", ""),
                  glucose=myround(c(149.3, 95.3, 97.5, 1.08, 108.0, 149.0, 169.4), 1),
                  stringsAsFactors=FALSE)
mat$date[2] <- mat$date[1]
mat$date[4:5] <- mat$date[3]
mat$date[7] <- mat$date[6]

hilitcells <- "C5"

excel_fig(mat, hilitcells=hilitcells, cellwidth=100)
dev.off()




# outlier column
pdf(here("Figs/no_highlighting_2.pdf"), height=5, width=10, pointsize=14)
mat$outlier <- c(FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE)
excel_fig(mat, cellwidth=100)
dev.off()
