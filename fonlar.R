library(tidyverse)
library(janitor)

fonlar2 <- read.csv("~/r/fonlar2.csv", header=FALSE)
fonlar2 <- fonlar2 %>% row_to_names(row_number = 1)

colnames(fonlar2)[colnames(fonlar2) == "6AY"] <- "AYLIK6"
colnames(fonlar2)[colnames(fonlar2) == "3AY"] <- "AYLIK3"

fonlar2 <- fonlar2 %>% mutate(HAFTALIK = as.numeric(HAFTALIK))
fonlar2 <- fonlar2 %>% mutate(AYLIK = as.numeric(AYLIK))
fonlar2 <- fonlar2 %>% mutate(AYLIK3 = as.numeric(AYLIK3))
fonlar2 <- fonlar2 %>% mutate(AYLIK6 = as.numeric(AYLIK6))                              

fonlar2 <- fonlar2 %>% mutate(weeklysd = pnorm(HAFTALIK, mean=mean(HAFTALIK), sd=sd(HAFTALIK)))
fonlar2 <- fonlar2 %>% mutate(ayliksd = pnorm(AYLIK, mean=mean(AYLIK), sd=sd(AYLIK)))
fonlar2 <- fonlar2 %>% mutate(aylik3sd = pnorm(AYLIK3, mean=mean(AYLIK3), sd=sd(AYLIK3)))
fonlar2 <- fonlar2 %>% mutate(aylik6sd = pnorm(AYLIK6, mean=mean(AYLIK6), sd=sd(AYLIK6)))

fonlar2 <- fonlar2 %>% mutate(sumsd = rowSums(across(c(weeklysd, ayliksd, aylik3sd, aylik6sd))))
fonlar2 <- fonlar2 %>% mutate(sdsumsd = pnorm(sumsd, mean=mean(sumsd), sd=sd(sumsd)))
fonlar2 <- fonlar2 %>% mutate(ybbsd = pnorm(YBB, mean=mean(YBB), sd=sd(YBB)))

