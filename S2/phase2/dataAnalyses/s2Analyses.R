library(ggplot2) 
library(tidyverse)

data <- read.csv(file = "scarcitySt2Ratings.csv", header=TRUE)  %>% 
  mutate(subjID  = as.factor(subjID)) %>%
  filter(!grepl("Black", race))

sesRatings <- filter(data, stimCode == "ses")
hostileRatings <- filter(data, stimCode == "hostile")
otherRatings <- filter(data, stimCode == "other")
fillerRatings <- filter(data, stimCode == "filler")

#### analyseses ####

sesReformat <- sesRatings %>%
  group_by(subjID, stimCode) %>%
  summarise_at(vars(ratingCode), funs(mean(., na.rm=FALSE),std.error(.,na.rm=FALSE)))

hostReformat <- hostileRatings %>%
  group_by(subjID, stimCode) %>%
  summarise_at(vars(ratingCode), funs(mean(., na.rm=FALSE),std.error(.,na.rm=FALSE)))

otherReformat <- otherRatings %>%
  group_by(subjID, stimCode) %>%
  summarise_at(vars(ratingCode), funs(mean(., na.rm=FALSE),std.error(.,na.rm=FALSE)))

fillerReformat <- fillerRatings %>%
  group_by(subjID, stimCode) %>%
  summarise_at(vars(ratingCode), funs(mean(., na.rm=FALSE),std.error(.,na.rm=FALSE)))

t.test(x = sesReformat$mean) 
t.test(x = hostReformat$mean)  
t.test(x = otherReformat$mean) 
t.test(x = fillerReformat$mean)

t.test(x = sesReformat$mean)[1] 
t.test(x = sesReformat$mean)[2] 
t.test(x = sesReformat$mean)[3] 
t.test(x = hostReformat$mean)[1]  
t.test(x = hostReformat$mean)[2]  
t.test(x = hostReformat$mean)[3]  
t.test(x = otherReformat$mean)[1] 
t.test(x = otherReformat$mean)[2] 
t.test(x = otherReformat$mean)[3] 
t.test(x = fillerReformat$mean)[1]
t.test(x = fillerReformat$mean)[2]
t.test(x = fillerReformat$mean)[3]

dataReformat <- rbind(sesReformat,hostReformat,otherReformat,fillerReformat) %>%
  group_by(subjID, stimCode) %>%
  summarise_at(vars(mean), funs(mean(., na.rm=FALSE)))

stats <- dataReformat %>% group_by(stimCode) %>% 
  summarise(Mean = mean(mean), SD = sd(mean),
            CI_L = Mean - (SD * 1.96)/sqrt(111),
            CI_U = Mean + (SD * 1.96)/sqrt(111)) %>% 
  mutate(stimCode = dplyr::recode(stimCode,
                                  "ses" = "Low-SES Stereotype",
                                  "hostile" = "Hostile Stereotype",
                                  "filler" = "Non-Stereotype",
                                  "other" = "Other Stereotype"
                                  ))

dataReformat <- mutate(dataReformat, stimCode = dplyr::recode(stimCode,
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

wideDataReformat <-dataReformat %>% 
  select(-`Stereotype Rating`) %>% 
  spread(stimCode, mean)

t.test(wideDataReformat$`Low-SES Stereotype`,
       wideDataReformat$`Hostile Stereotype`,
       paired = TRUE, alternative = "two.sided")[3]

t.test(wideDataReformat$`Other Stereotype`,
       wideDataReformat$`Hostile Stereotype`,
       paired = TRUE, alternative = "two.sided")[3]

t.test(wideDataReformat$`Non-Stereotype`,
       wideDataReformat$`Hostile Stereotype`,
       paired = TRUE, alternative = "two.sided")[3]

t.test(wideDataReformat$`Low-SES Stereotype`,
       wideDataReformat$`Other Stereotype`,
       paired = TRUE, alternative = "two.sided")[1]

t.test(wideDataReformat$`Low-SES Stereotype`,
       wideDataReformat$`Non-Stereotype`,
       paired = TRUE, alternative = "two.sided")[3]

t.test(wideDataReformat$`Other Stereotype`,
       wideDataReformat$`Non-Stereotype`,
       paired = TRUE, alternative = "two.sided")[1]
