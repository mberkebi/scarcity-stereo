library(ggplot2) 
library(tidyverse)
library(lsr)
library(psych)

data <- read.csv(file = "s2Data.csv", header=TRUE)  %>% 
  mutate(subjID  = as.factor(subjID)) %>%
  group_by(subjID, stimCode) %>%
  summarise_at(vars(rating), funs(mean(., na.rm=FALSE)))

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
                                  "hostile" = "Threat Stereotype",
                                  "filler" = "Non-Stereotype",
                                  "other" = "Positive Stereotype"
                                  ))

dataReformat <- mutate(data, stimCode = dplyr::recode(stimCode,
                                                      "ses" = "Low-SES Stereotype",
                                                      "hostile" = "Threat Stereotype",
                                                      "filler" = "Non-Stereotype",
                                                      "other" = "Positive Stereotype"
))
dataReformat <- mutate(data, stimCode = dplyr::recode(stimCode,
                                                "ses" = "Low-SES Stereotype",
                                                "hostile" = "Threat Stereotype",
                                                "filler" = "Non-Stereotype",
                                                "other" = "Positive Stereotype"
))

names(dataReformat)[3] <- "Stereotype Rating"
names(stats)[2] <- "Stereotype Rating"
dataReformat$mean <- dataReformat$`Stereotype Rating`

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

#### raincloud plots ####

source("https://gist.githubusercontent.com/benmarwick/2a1bb0133ff568cbe28d/raw/fb53bd97121f7f9ce947837ef1a4c65a73bffb3f/geom_flat_violin.R")

line.pal <- c("#2166ac","#2166ac","#2166ac","#2166ac")
dataReformat$stims <- factor(dataReformat$stimCode,levels = c("Low-SES Stereotype", "Threat Stereotype", "Positive Stereotype", "Non-Stereotype"))
ggplot(dataReformat, aes(x=stims, y=mean, color=stims)) +
  geom_hline(yintercept=0, linetype = "dashed", color = "grey5") +
  geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .1) +
  geom_point(aes(y = mean, color = stims), 
             position = position_jitter(width = .15), 
             size = .5, alpha = 0.7) +
  stat_summary(fun=mean, geom='point', size=2, color="black") +  #including and formatting for the mean
  stat_summary(fun.data=mean_cl_boot, geom='errorbar', 
               fun.args=list(conf.int=.95), size=.5, 
               aes(width=.2), color="black") +  #including and formatting 95% CI
  coord_cartesian(ylim=c(-2.5,2.5)) + # restricting the y-axis so it's just 1-5
  labs(x="Trait", y= "Response Preference for Scarcity Faces \n Over Control Faces")+ 
  scale_color_manual(values = c(line.pal)) +
  theme_classic() +
  theme(legend.position="none")+
  theme(text = element_text(family = "Times New Roman"))

        