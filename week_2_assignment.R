library(tidyverse)
puk <- read_csv("chick_measurements_2018.csv")
str(puk)
summary(puk)
puk2 <- na.omit(puk)
print(puk2
      %>% group_by(Treatment_Type)
      %>% summarize(count=n()))
hist(puk2[["Mass_net"]])
hist(puk2[["Tar"]])
puk.var <- puk2[!names(puk2) %in% c("Nest", "ToeNail", "mass_bag", "Mass_total", 
                                    "Treatment_Type")]
pairs(puk.var[,-1])