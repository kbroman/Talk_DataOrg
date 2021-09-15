# make figures showing the ugly and tidy Excel files for Activity 1

library(broman)
library(here)

# read data
ugly <- read.table(here("R/example_ugly.csv"), sep=",",
                 header=FALSE, stringsAsFactors=FALSE,
                 blank.lines.skip=FALSE,
                 colClasses=character())

# restore two blank lines
ugly <- rbind(rep("", ncol(ugly)),
              ugly[1:5,],
              rep("", ncol(ugly)),
              ugly[-(1:5),])


pdf(here("Figs/spreadsheet_ugly.pdf"), height=5, width=10, pointsize=14)
excel_fig(ugly, col_names=FALSE)
dev.off()

tidy <- read.csv(here("R/example_tidy.csv"),
                 header=TRUE, stringsAsFactors=FALSE,
                 colClasses=character())

pdf(here("Figs/spreadsheet_tidy.pdf"), height=5, width=10, pointsize=12)
excel_fig(tidy[1:9,])
dev.off()
