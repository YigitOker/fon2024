# fon2024
2024 yılının ilk yarısında fon performanslarının incelenmesi
---
title: "Fon_Raporu"
author: "Volkan Yiğit Oker"
date: "2024-06-14"
output: html_document
---
# Projenin amacı ve uygulanışı
Proje fon sepetlerini dört farklı ölçekte ele alacaktır: 
 
 * Haftalık Getiri
 * 1 Aylık getiri
 * 3 Aylık getiri
 * 6 Aylık getiri
 
 Bu ölçeklerde yapılan çalışmaların fon başına standart sapma değerleri hesaplanacak ve her dört ölçekte de ortalamanın üzerinde en yüksek getiriyi sağlayan şirketler analiz edilecektir.
 
## R ile kod çalışması
Öncelikle verinin temizlenip işlenmesi yani format hatalarının giderilmesi gerekmektedir:

```{r}
fonlar2 <- read.csv("~/r/fonlar2.csv", header=FALSE)
fonlar2 <- fonlar2 %>% row_to_names(row_number = 1)
colnames(fonlar2)[colnames(fonlar2) == "3AY"] <- "AYLIK3"
colnames(fonlar2)[colnames(fonlar2) == "6AY"] <- "AYLIK6"
fonlar2 <- fonlar2 %>% mutate(HAFTALIK = as.numeric(HAFTALIK))
fonlar2 <- fonlar2 %>% mutate(AYLIK = as.numeric(AYLIK))
fonlar2 <- fonlar2 %>% mutate(AYLIK3 = as.numeric(AYLIK3))
fonlar2 <- fonlar2 %>% mutate(AYLIK6 = as.numeric(AYLIK6))
```

Verinin temizlenmesi ve formatlandırılmasının ardından her bir fonun her bir ölçek için standart sapmasını hesaplamamız gerekiyor:

```{r}
fonlar2 <- fonlar2 %>% mutate(weeklysd = pnorm(HAFTALIK, mean=mean(HAFTALIK), sd=sd(HAFTALIK)))
fonlar2 <- fonlar2 %>% mutate(ayliksd = pnorm(AYLIK, mean=mean(AYLIK), sd=sd(AYLIK)))
fonlar2 <- fonlar2 %>% mutate(aylik3sd = pnorm(AYLIK3, mean=mean(AYLIK3), sd=sd(AYLIK3)))
fonlar2 <- fonlar2 %>% mutate(aylik6sd = pnorm(AYLIK6, mean=mean(AYLIK6), sd=sd(AYLIK6)))
```

İşlem sonucunda ölçek başı ortalamalar hesaplanıp standart sapmalara göre bölündükten sonra her bir fonun her bir ölçek için kaçıncı sapma da yani % kaçlık dilimde olduğu hesaplanıp sırasıyla yeni sütunlara yerleştirildi.

Her ölçekte ortalamanın üstünde getiri sağlayan fonları bulmak için tüm bu standart sapmaları her bir fon için toplayıp yeni değerler içerisindeki fonların yüzdelik olarak bulundukları noktalar incelenmeli:

```{r}
fonlar2 <- fonlar2 %>% mutate(sumsd = rowSums(across(c(weeklysd, ayliksd, aylik3sd, aylik6sd))))
fonlar2 <- fonlar2 %>% mutate(sdsumsd = pnorm(sumsd, mean=mean(sumsd), sd=sd(sumsd)))
```

## İşlem sonucu
