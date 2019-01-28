
library(tidyverse)
puk <- read_csv("Chick_measurements_2018.csv")
puk2 <- na.omit(puk)
puk.var <- puk2[c("ChickID", "Nest", "Date", "age_day", "Final_age_seen", "Mass_net", "S_T", "Tar", "Treatment_Type")]
puk.subset <- puk.var %>% filter(puk.var$Final_age_seen >= 10)
ggplot(puk.subset, aes(x = age_day, y = Mass_net, colour=Treatment_Type)) + 
  geom_point() + labs(title = "Mass of pukeko nestlings re-caught at 10 days or later", x = "Age (days)", y = "Mass (grams)", color = "Treatment Type") +
  scale_fill_brewer() + theme_bw()
ggplot(puk.subset, aes(x = age_day, y = Mass_net, colour=Treatment_Type)) + 
  geom_line() + labs(title = "Nestling mass for each nest for re-captures at 10 days or later", x = "Age (days)", y = "Mass (grams)", color = "Treatment Type") + 
  scale_fill_brewer() + theme_bw() + facet_wrap(~Nest, scales = "free_y")
puk.chick <- puk.var %>% filter(ChickID == "AR1" | ChickID == "E1")
ggplot(puk.chick, aes(x = age_day, y = Mass_net, colour=Treatment_Type)) + 
  geom_line() + labs(title = "Mass of Two nestlings by Age", x = "Age (days)", y = "Mass (grams)", color = "Treatment Type") + 
  scale_fill_brewer() + theme_bw()
ggplot(puk.var, aes(x = age_day, colour=Treatment_Type)) + geom_histogram(binwidth = 5) + 
  xlab("Age (days)") + scale_fill_brewer() +
  theme_bw()
puk.subset2 <- puk.var %>% filter(puk.var$age_day == 0)
ggplot(aes(y = Mass_net, x = Treatment_Type), data = puk.subset2) + geom_boxplot() +
  scale_fill_brewer()+ xlab("Treatment Type") + ylab("Mass (grams)") + labs(title = "Mean mass of nestlings at 0 days of age")





