library(broman)

mat <- data.frame(Date=c("", "", "12/6/2005", rep("", 4)),
                  "Assay date"=c("12/9/05", "12/9/05", "e", "e", "e", "1/11/2006", "1/11/2006"),
                  "Weight"=c(54.9, 45.3, 47, 45.7, 52.9, 46.1, 38.6),
                  stringsAsFactors=FALSE, check.names=FALSE)
excel_fig(mat, cellwidth=90)
