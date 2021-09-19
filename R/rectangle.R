library(broman)
library(here)

# good example
pdf(here("Figs/rectangle.pdf"), height=5, width=10, pointsize=14)
set.seed(20150803)
mat <- data.frame(id=101:105,
                  sex=sample(c("Male", "Female"), 5, replace=TRUE),
                  glucose=myround(runif(5, 70, 150), 1),
                  insulin=myround(runif(5, 0.5, 1.5), 2),
                  triglyc=myround(runif(5, 70, 300), 1),
                  stringsAsFactors=FALSE)

excel_fig(mat)
dev.off()


# bad example 1
pdf(here("Figs/not_rectangle_1.pdf"), height=5, width=10, pointsize=14)
mat2 <- t(mat)

mat2 <- cbind(rownames(mat2), mat2)
mat2 <- rbind(rep("", 6),
              mat2[1:2,],
              rep("", 6),
              mat2[c(1,3),],
              rep("", 6),
              mat2[c(1,4),])
mat2[c(2,5,8),1] <- ""

excel_fig(mat2, col_names=FALSE)
dev.off()


# bad example 2
pdf(here("Figs/not_rectangle_2.pdf"), height=5, width=10, pointsize=14)
mat4 <- rbind(rep("", 7),
              c("Date", "11/3/14", rep("", 5)),
              c("Days on diet", "126", rep("", 5)),
              c("Mouse #", "43", rep("", 5)),
              c("sex", "f", rep("", 5)),
              c("experiment", "", "values", "", "", "mean", "SD"),
              c("control", "", 0.186, 0.191, 1.081, "", ""),
              c("treatment A", "", 7.414, 1.468, 2.254, "", ""),
              c("treatment B", "", 9.811, 9.259, 11.296, "", ""),
              rep("", 7),
              c("fold change", "", "values", "", "", "mean", "SD"),
              c("treatment A", "", 7.414, 1.468, 2.254, "", ""),
              c("treatment B", "", 9.811, 9.259, 11.296, "", ""))

for(i in 7:9) {
    # calc mean and SD
    x <- as.numeric(mat4[i, 3:5])
    mat4[i,6] <- round(mean(x), 2)
    mat4[i,7] <- round(sd(x), 2)

    if(i > 7) {
      # fold change
      y <- as.numeric(mat4[7, 3:5])
      z <- x/mean(y)
      mat4[i+4,3:5] <- round(z, 2)
      mat4[i+4,6] <- round(mean(z), 2)
      mat4[i+4,7] <- round(sd(z), 2)
    }
}
excel_fig(mat4, cellwidth=c(90, 105, 95, rep(90, 5)),
          fig_width=680, fig_height=330)
dev.off()


# bad example 3
pdf(here("Figs/not_rectangle_3.pdf"), height=5, width=10, pointsize=12)
mat5 <- rbind(c("", "GTT date", "GTT weight", "time", "glucose mg/dl", "insulin ng/ml"),
              c("321", "2/9/15", "24.5",  0,  99.2, "lo off curve"),
              c("", "", "",               5, 349.3, 0.205),
              c("", "", "",              15, 286.1, 0.129),
              c("", "", "",              30, 312.0, 0.175),
              c("", "", "",              60,  99.9, 0.122),
              c("", "", "",             120, 217.9, "lo off curve"),
              c("322", "2/9/15", "18.9",  0, 185.8, 0.251),
              c("", "", "",               5, 297.4, 2.228),
              c("", "", "",              15, 439.0, 2.078),
              c("", "", "",              30, 362.3, 0.775),
              c("", "", "",              60, 232.7, 0.500),
              c("", "", "",             120, 260.7, 0.523),
              c("323", "2/9/15", "24.7",  0, 198.5, 0.151),
              c("", "", "",               5, 530.6, "off curve lo"))

excel_fig(mat5, col_names=FALSE, cellwidth=c(85, 85, 105, 105, 85, 110, 110))
dev.off()


# that one filled in
pdf(here("Figs/not_rectangle_3_corr1.pdf"), height=5, width=10, pointsize=12)
mat5[1,1] <- "id"
for(i in 1:3) {
    mat5[3:7, i] <- mat5[2,i]
    mat5[(3:7)+6, i] <- mat5[8,i]
    mat5[15, i] <- mat5[14,i]
}

excel_fig(mat5, col_names=FALSE, cellwidth=c(85, 85, 105, 105, 85, 110, 110))
dev.off()


# split into two
pdf(here("Figs/not_rectangle_3_corr2.pdf"), height=5, width=10, pointsize=12)
par(mfrow=c(1,2))
#### weights
mat5wt <- mat5[c(1,2,8,14), 1:3]
excel_fig(mat5wt, col_names=FALSE, cellwidth=c(85, 85, 105, 105))

#### gtt
mat5gtt <- mat5[,c(1, 4:6)]
mat5gtt[1,2] <- "GTT time"
excel_fig(mat5gtt, col_names=FALSE, cellwidth=c(85, 85, 85, 110, 110))
dev.off()

pdf(here("Figs/not_rectangle_3_corr3.pdf"), height=5, width=10, pointsize=12)
par(mfrow=c(1,2))
#### weights
mat5wt <- mat5[c(1,2,8,14), 1:3]
excel_fig(mat5wt, col_names=FALSE, cellwidth=c(85, 85, 105, 105))

# and fix those notes
mat5gtt[c(2,7,15),4] <- "NA"
mat5gtt <- cbind(mat5gtt, c("note", rep("", 14)))
mat5gtt[c(2,7,15),5] <- "insulin below curve"
excel_fig(mat5gtt, col_names=FALSE, cellwidth=c(85, 85, 85, 110, 110, 160))
dev.off()



# bad example with two header rows
pdf(here("Figs/not_rectangle_4.pdf"), height=5, width=10, pointsize=12)
mat6 <- rbind(c("", "", "week 4", "", "", "week 6", "", "", "week 8", "", ""),
              c("Mouse ID", "SEX", rep(c("date", "weight", "glucose"), 3)),
              c("3005", "M", "3/30/2007",  19.3, 635.0, "4/11/2007",  31,   460.7, "4/27/2007",  39.6, 530.2),
              c("3017", "M", "10/6/2006",  25.9, 202.4, "10/19/2006", 45.1, 384.7, "11/3/2006",  57.2, 458.7),
              c("3434", "F", "11/22/2006", 26.6, 238.9, "12/6/2006",  45.9, 378.0, "12/22/2006", 56.2, 409.8),
              c("3449", "M", "1/5/2007",   27.5, 121.0, "1/19/2007",  42.9, 191.3, "2/2/2007",   56.7, 182.5),
              c("3499", "F", "1/5/2007",   19.8, 220.2, "1/19/2007",  36.6, 556.9, "2/2/2007",   43.6, 446.0))

excel_fig(mat6, cellwidth=c(85, 85, 85, 105, 85, 95, 105, 85, 95, 105, 85, 95),
          fig_width=780, fig_height=150, col_names=FALSE)
dev.off()

# week in variable name
pdf(here("Figs/not_rectangle_4_corr1.pdf"), height=5, width=10, pointsize=12)
mat6 <- mat6[-1,]
wk <- c(4, 6, 8)
firstcol <- c(3,6,9)
for(i in seq(along=firstcol))
    mat6[1,firstcol[i]+0:2] <- paste0(mat6[1,firstcol[i]+0:2], "_", wk[i])

excel_fig(mat6, cellwidth=c(85, 85, 85, 105, 85, 95, 105, 85, 95, 105, 85, 95),
          fig_width=780, fig_height=150, col_names=FALSE)
dev.off()

# tidy version
pdf(here("Figs/not_rectangle_4_corr2.pdf"), height=5, width=10, pointsize=12)
mat6b <- rbind(cbind(mat6[,1:2], week=rep(4,6), mat6[,3:5]),
               cbind(mat6[-1,1:2], week=rep(6,5), mat6[-1,6:8]),
               cbind(mat6[-1,1:2], week=rep(8,5), mat6[-1,9:11]))
colnames(mat6b) <- c("mouse_id", "sex", "week", "date", "glucose", "weight")
mat6b <- mat6b[-1,]
mat6b <- mat6b[order(as.numeric(mat6b[,1]), mat6b[,3]),]

excel_fig(mat6b, cellwidth=c(85, 85, 85, 85, 100, 85, 85))
dev.off()
