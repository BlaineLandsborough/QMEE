library(tidyverse)
library(lme4)
library(jtools)
library(ggstance)

## JD: Watch your case matching; code will not run on all computers unless 
## cases match

puk <- read_csv("chick_measurements_2018.csv")
puk2 <- na.omit(puk)
puk.var <- puk2[c("ChickID", "Hatch_spread", "Nest", "Date", "age_day", "Final_age_seen", "Tar", "Treatment_Type")]
puk.subset <- puk.var %>% filter(puk.var$Final_age_seen >= 10 & puk.var$age_day <= 60)
puk.subset1 <- puk.subset
puk.subset1$ttar <- log10(puk.subset1$Tar)

## JD Here are some rough suggestions how to do the same thing as above
## but "tidier"
chicks <- (read_csv("chick_measurements_2018.csv")
	%>% na.omit()
	%>% select(ChickID, Hatch_spread, Nest, Date
		, age_day, Final_age_seen, Tar, Treatment_Type
	)
	%>% filter(Final_age_seen >= 10 & age_day <= 60)
	%>% mutate(ttar <- log10(Tar))
)

puk_gro <- lm(ttar ~ Hatch_spread, data = puk.subset1)
puk_gro1 <- lm(ttar ~ age_day + Hatch_spread, data = puk.subset1)
par(mfrow=c(2,2),mar=c(2,3,1.5,1),mgp=c(2,1,0))
plot(puk_gro1,id.n = 4)

## JD: To be honest, this plot is a little deep for me. I dont' get the distributions, and it seems to based on a mixed model.
## It would have been nice to say clearly that you don't see the sign of the Hatch_spread effect clearly

puk_gro2 <- lmer(ttar ~ Hatch_spread + age_day + (1|Nest), data = puk.subset1)
plot_summs(puk_gro1, scale = TRUE, plot.distributions = TRUE, inner_ci_level = .95)

## Grade 2/3 (good)
