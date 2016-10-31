library(ggplot2)
filename <- file.choose()

dat <- read.table(filename, sep = ',', header = T)

dat$ratio <- seq(0.1, 0.9, 0.1)[-5]

p <- ggplot(aes(x = ratio, y = tt), data = dat)
p <- p + geom_line(colour= 'blue', linetype = 1, size = 1.2) + 
  geom_point(shape = 1, size = 4, colour = 2) + 
  scale_x_continuous(breaks = seq(0.1, 0.9, 0.1)) + 
  labs(x = 'partial volume', y = 'T2 value')