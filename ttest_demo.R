dat_to_ttest <- out_list[[1]]$scores[, 1]
dat_ttest <- data_frame(x = dat_to_ttest, group = rep(c('HC', 'PAT'),
                                                      c(15, 10)))

p_val <- t.test(x~group, data = dat_ttest)
