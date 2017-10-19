df <- dat_show
df_hc <- filter(df, group == 'HC')
sum_data <- df_hc %>%
  group_by(volInd) %>%
  summarise(meanVal = mean(Val))
ord <- order(order(sum_data$meanVal)) #reorder the data according to the healthy data
df$new_order <- rep(ord, nrow(df)/max(ord))
df <- df%>% arrange(group, subInd, voxInd, new_order)

bs_basis <- create.bspline.basis(breaks = seq(1, 64, length.out = 25))

y <- matrix(df$Val, nrow = max(df$new_order))
fdobj <- smooth.basis(y = y, fdParobj = bs_basis)$fd

dat_fd_pca <- pca.fd(fdobj, nharm = 10)

fdmat <- eval.fd(seq(1, 64, length.out = 128), dat_fd_pca[[1]])
pc1_mat <- matrix(rep(fdmat[, 1], each = 23), nrow = 128, byrow = T)
score_pc1 <- matrix(rep(dat_fd_pca$scores[, 1], each = 128),
                    nrow = 128)
sub_pc1 <- pc1_mat*score_pc1

df_pc1 <- data_frame(value = as.vector(sub_pc1), 
                     subInd = rep(unique(df$subInd), each = 128), 
                     group = rep(c('HC', 'PAT'), times = c(13*128, 10*128)))




df_pc1$group <- factor(df_pc1$group)
df_pc1$inx <- rep(c(1:128), 23)
p <- ggplot(df_pc1, aes(x = inx, y = value))
p <- p + geom_line(aes(color = group, group = subInd))