library(tidyverse)
library(lme4)
library(lmerTest)

##Need to check/clean data
## Need to LMM for offspring growth; GLMM for offspring survival; and LM(?) for hatching
## success


###Tarsus measurments get log-transformed
## Offspring growth LMM
puk_last <- read_csv("Chick_measurements_2018_last_obs.csv")
puk2 <- na.omit(puk_last)
puk.subset <- puk2
puk.subset$ttar <- log10(puk.subset$Tarsus)
puk_gro <- lmer(Tarsus ~ Hatch_spread + age_day + Hatch_order + (1|Nest), 
                data = puk.subset)
summary(puk_gro)


### Offspring survival GLMM
survival <- read_csv("2018_chick_survival_v2.csv")

puksur <- glmer(first_sur ~ hatch_spread + (1|Nest), data = survival, 
                family = binomial(link = "logit"))
summary(puksur)

## Hatching Success
hatch.data <- read_csv("Hatch_synchrony_2018_data.csv")
puklm1 <- lm(Eggs_hatched ~ Hatch_spread + Total_clutch_size, data = hatch.data)



