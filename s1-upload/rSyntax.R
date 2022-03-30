library(tidyverse)
library(plotrix)
library(ggplot2)
library(sjPlot)
library(geepack)
library(lmSupport)
library(lme4)
library(car)
library(lmerTest)
library(foreign)

# load data
data <- read.csv("s1Data.csv") %>% 
    mutate(subjID  = as.factor(subjID))

# convert to long form
data_long <- gather(data, stim, rating, b_comm_neutral:w_pers_other, factor_key=TRUE)
data_long <- data_long[order(data_long$subjID),]

# making scarcity conditions
data_long$Race <- NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$stim[i],1,1) == "w")  {
    data_long$Race[i] <- "White" 
  } else if (substr(data_long$stim[i],1,1) == "b")  {
    data_long$Race[i] <- "Black"
  }
}
data_long$Race <- as.factor(data_long$Race)

data_long$Trait <- NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$stim[i],8,8) == "n")  {
    data_long$Trait[i] <- "Non-Stereotype"
  } else if (substr(data_long$stim[i],8,8) == "s")  {
    data_long$Trait[i] <- "Low-SES Stereotype"
  } else if (substr(data_long$stim[i],8,8) == "h")  {
    data_long$Trait[i] <- "Threat Stereotype"
  } else if (substr(data_long$stim[i],8,8) == "o")  {
    data_long$Trait[i] <- "Positive Stereotype"
  } 
}
data_long$Trait <- factor(data_long$Trait,levels = c("Low-SES Stereotype", "Threat Stereotype", "Positive Stereotype", "Non-Stereotype"))

data_long$Level = NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$stim[i],3,6) == "comm")  {
    data_long$Level[i] <- "Common" 
  } else if (substr(data_long$stim[i],3,6) == "pers")  {
    data_long$Level[i] <- "Personal"
  }
}
data_long$Level <- as.factor(data_long$Level)

data_long$Condition <- factor(data_long$condition, levels = c("Scarcity", "Control"))

data_long <- data_long %>% 
  select(-condition, -stim)

commonData <- filter(data_long, Level == "Common")
personalData <- filter(data_long, Level == "Personal")

levels(personalData$Trait)
personalData$Trait <- relevel(personalData$Trait, ref = "Non-Stereotype")

levels(commonData$Trait)
commonData$Trait <- relevel(commonData$Trait, ref = "Non-Stereotype")

#lmer
library(lmerTest)
library(konfound)
library(car)

model.s1 <- lmer(rating ~ Condition*Race*Trait + (1 + Trait|subjID), data = commonData)
summary(model.s1)
confint(model.s1)

commonBlackData <- filter(commonData, Race == "Black")
commonWhiteData <- filter(commonData, Race == "White")

blackModelFit <- lmer(rating ~ Condition*Trait + (1|subjID), 
                      data = commonBlackData)
summary(blackModelFit)
confint(blackModelFit)

# Sig 2-way interaction, following up with T-tests

#### lessR t.tests ####
library(lessR)

scar.common.black.ses <- commonBlackData %>% 
  filter(Condition == "Scarcity") %>% 
  filter (Trait == "Low-SES Stereotype") %>% 
  select(rating)
con.common.black.ses <- commonBlackData %>% 
  filter(Condition == "Control") %>% 
  filter (Trait == "Low-SES Stereotype") %>% 
  select(rating)

scar.common.black.ses <- scar.common.black.ses$rating
con.common.black.ses <- con.common.black.ses$rating

lessR::ttest(x = scar.common.black.ses, y = con.common.black.ses, 
             paired = FALSE, arg = "two_sided", digits.d = 4)

scar.common.black.host <- commonBlackData %>% 
  filter(Condition == "Scarcity") %>% 
  filter (Trait == "Threat Stereotype") %>% 
  select(rating)
con.common.black.host <- commonBlackData %>% 
  filter(Condition == "Control") %>% 
  filter (Trait == "Threat Stereotype") %>% 
  select(rating)

scar.common.black.host <- scar.common.black.host$rating
con.common.black.host <- con.common.black.host$rating

lessR::ttest(x = scar.common.black.host, y = con.common.black.host, 
             paired = FALSE, arg = "two_sided", digits.d = 4)

scar.common.black.pos <- commonBlackData %>% 
  filter(Condition == "Scarcity") %>% 
  filter (Trait == "Positive Stereotype") %>% 
  select(rating)
con.common.black.pos <- commonBlackData %>% 
  filter(Condition == "Control") %>% 
  filter (Trait == "Positive Stereotype") %>% 
  select(rating)

scar.common.black.pos <- scar.common.black.pos$rating
con.common.black.pos <- con.common.black.pos$rating

lessR::ttest(x = scar.common.black.pos, y = con.common.black.pos, 
             paired = FALSE, arg = "two_sided", digits.d = 4)

scar.common.black.non <- commonBlackData %>% 
  filter(Condition == "Scarcity") %>% 
  filter (Trait == "Non-Stereotype") %>% 
  select(rating)
con.common.black.non <- commonBlackData %>% 
  filter(Condition == "Control") %>% 
  filter (Trait == "Non-Stereotype") %>% 
  select(rating)

scar.common.black.non <- scar.common.black.non$rating
con.common.black.non <- con.common.black.non$rating

lessR::ttest(x = scar.common.black.non, y = con.common.black.non, 
             paired = FALSE, arg = "two_sided", digits.d = 4)

#### LMER for White ratings
whiteModelFit <- lmer(rating ~ Condition*Trait + (1|subjID), 
                      data = commonWhiteData)
summary(whiteModelFit)
confint(whiteModelFit)
# marginal 2-way interaction so following up

scar.common.white.ses <- commonWhiteData %>% 
  filter(Condition == "Scarcity") %>% 
  filter (Trait == "Low-SES Stereotype") %>% 
  select(rating)
con.common.white.ses <- commonWhiteData %>% 
  filter(Condition == "Control") %>% 
  filter (Trait == "Low-SES Stereotype") %>% 
  select(rating)

scar.common.white.ses <- scar.common.white.ses$rating
con.common.white.ses <- con.common.white.ses$rating

lessR::ttest(x = scar.common.white.ses, y = con.common.white.ses, 
             paired = FALSE, arg = "two_sided", digits.d = 4)

scar.common.white.non <- commonWhiteData %>% 
  filter(Condition == "Scarcity") %>% 
  filter (Trait == "Non-Stereotype") %>% 
  select(rating)
con.common.white.non <- commonWhiteData %>% 
  filter(Condition == "Control") %>% 
  filter (Trait == "Non-Stereotype") %>% 
  select(rating)

scar.common.white.non <- scar.common.white.non$rating
con.common.white.non <- con.common.white.non$rating

lessR::ttest(x = scar.common.white.non, y = con.common.white.non, 
             paired = FALSE, arg = "two_sided", digits.d = 4)


#### Checking personal ratings
personalFit <- lmer(rating ~ Condition*Race*Trait + (1 + Trait|subjID), 
            data = personalData)
summary(personalFit)

personalBlackData <- filter(personalData, Race == "Black")
personalWhiteData <- filter(personalData, Race == "White")

blackPersonalFit <- lmer(rating ~ Condition*Trait + (1|subjID), 
                         data = personalBlackData)
summary(blackPersonalFit)

whitePersonalFit <- lmer(rating ~ Condition*Trait + (1|subjID), 
                         data = personalWhiteData)
summary(whitePersonalFit)

####plots####

blackCommonMeans <- commonData %>%
  filter(Race == "Black") %>% 
  group_by(Trait,Condition) %>%
  summarise_at(vars(rating), funs(mean(., na.rm=FALSE),sd(.,na.rm=FALSE),std.error(.,na.rm=FALSE)))

blackCommonReformat <- commonData %>%
  filter(Race == "Black") %>% 
  group_by(subjID, Condition, Trait) %>%
  summarise_at(vars(rating), funs(mean(., na.rm=FALSE),sd(.,na.rm=FALSE),std.error(.,na.rm=FALSE)))

line.pal <- c("#b2182b","#2166ac")
fill.pal <- c("#EF7762","#d1e5f0")

blackCommonMeans %>%
  mutate(Trait = factor(Trait, levels=c("Low-SES Stereotype",
                                        "Threat Stereotype",
                                        "Positive Stereotype",
                                        "Non-Stereotype"))) %>%
ggplot(aes(x = Trait, y=mean, color=Condition, fill = Condition)) +
  geom_bar(stat="identity", position=position_dodge(.91)) +
  theme_classic() +
  scale_y_continuous(expand = expansion(mult = c(0, .1))) +
  ylab("Percentage of Black Americans \n Characterized by Trait (%)") +
  theme(text=element_text(size=12,  family="Times New Roman"),
        axis.text.x = element_text(size = 11, color = "black"),
        axis.text.y = element_text(size = 11, color = "black"),
        legend.position = c(.9, .9)) +
  geom_jitter(data = blackCommonReformat, aes(colour = Condition), shape = 20, alpha = .5,
              position = position_jitterdodge(jitter.width = .3, dodge.width = .91)) +
  geom_errorbar(aes(ymin=mean-(sd*1.96/sqrt(112)), ymax=mean+(sd*1.96/sqrt(112))),
                width=.3,position=position_dodge(.91), size = .9) +
  scale_color_manual(values = line.pal) +
  scale_fill_manual(values = c(fill.pal))  
