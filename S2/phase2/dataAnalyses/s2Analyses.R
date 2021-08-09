library(ggplot2) 
library(tidyverse)
library(lsr)
library(psych)

data <- read.csv(file = "scarcitySt2Ratings.csv", header=TRUE)  %>% 
  mutate(subjID  = as.factor(subjID)) %>%
  filter(!grepl("Black", race)) %>% 
  group_by(subjID, stimCode) %>%
  summarise_at(vars(ratingCode), funs(mean(., na.rm=FALSE)))

names(data)[3] <- "mean"

sesReformat <- filter(data, stimCode == "ses")
hostReformat <- filter(data, stimCode == "hostile")
otherReformat <- filter(data, stimCode == "other")
fillerReformat <- filter(data, stimCode == "filler")

as_tibble(describe(hostReformat$mean))
t.test(x = hostReformat$mean)[2]  
t.test(x = hostReformat$mean)[1]  
t.test(x = hostReformat$mean)[3]
cohensD(hostReformat$mean, mu = 0)

as_tibble(describe(sesReformat$mean))
t.test(x = sesReformat$mean)[2] 
t.test(x = sesReformat$mean)[1] 
t.test(x = sesReformat$mean)[3] 
cohensD(sesReformat$mean, mu = 0)

as_tibble(describe(otherReformat$mean))
t.test(x = otherReformat$mean)[2] 
t.test(x = otherReformat$mean)[1] 
t.test(x = otherReformat$mean)[3] 
cohensD(otherReformat$mean, mu = 0)

as_tibble(describe(fillerReformat$mean))
t.test(x = fillerReformat$mean)[2]
t.test(x = fillerReformat$mean)[1]
t.test(x = fillerReformat$mean)[3]
cohensD(fillerReformat$mean, mu = 0)

stats <- data %>% group_by(stimCode) %>% 
  summarise(Mean = mean(mean), SD = sd(mean),
            CI_L = Mean - (SD * 1.96)/sqrt(111),
            CI_U = Mean + (SD * 1.96)/sqrt(111)) %>% 
  mutate(stimCode = dplyr::recode(stimCode,
                                  "ses" = "Low-SES Stereotype",
                                  "hostile" = "Hostile Stereotype",
                                  "filler" = "Non-Stereotype",
                                  "other" = "Other Stereotype"
                                  ))

dataReformat <- mutate(data, stimCode = dplyr::recode(stimCode,
                                                "ses" = "Low-SES Stereotype",
                                                "hostile" = "Hostile Stereotype",
                                                "filler" = "Non-Stereotype",
                                                "other" = "Other Stereotype"
))

names(dataReformat)[3] <- "Stereotype Rating"
names(stats)[2] <- "Stereotype Rating"
dataReformat$mean <- dataReformat$`Stereotype Rating`

ggplot(data= dataReformat, aes(x = reorder(stimCode, -mean), y = `Stereotype Rating`))+
  geom_violin(color = "#2166ac") + 
  geom_hline(yintercept=0, linetype = "dashed", color = "black") +
  geom_jitter(width = 0.15, color = "#67a9cf",shape = 20, size = 1.5) +
  stat_summary(fun=mean, geom="point", shape=19, size = 2, color = "black") +
  ylab("Response Preference for Scarcity Faces \n Over Control Faces") +
  xlab("Trait") +
  theme_classic() +
  geom_errorbar(mapping = aes(x = stimCode, ymin = CI_L, ymax = CI_U), data = stats, width = .15) +
  theme(text = element_text(size=12, family = "Times New Roman"),
        axis.text.x = element_text(size = 11, color = "black"),
        axis.text.y = element_text(size = 11, color = "black"))

### One way anova ###

oneWayAnova <- aov(`Stereotype Rating` ~ stimCode, data = dataReformat)
summary(oneWayAnova)

#### Pairwise comparisons ####

install.packages("lessR")
library(lessR)

wideDataReformat <-data %>% 
  spread(stimCode, mean)

lessR::ttest(data = wideDataReformat,
             x = hostile,
             y = ses,
             paired = TRUE, arg = "two_sided", digits.d = 4)

lessR::ttest(data = wideDataReformat,
             x = hostile,
             y = other,
             paired = TRUE, arg = "two_sided", digits.d = 4)

lessR::ttest(data = wideDataReformat,
             x = hostile,
             y = filler,
             paired = TRUE, arg = "two_sided", digits.d = 4)

lessR::ttest(data = wideDataReformat,
             x = ses,
             y = other,
             paired = TRUE, arg = "two_sided", digits.d = 4)

lessR::ttest(data = wideDataReformat,
             x = ses,
             y = filler,
             paired = TRUE, arg = "two_sided", digits.d = 4)

lessR::ttest(data = wideDataReformat,
             x = other,
             y = filler,
             paired = TRUE, arg = "two_sided", digits.d = 4)





