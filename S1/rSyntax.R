library(tidyverse)
library(plotrix)
library(ggplot2)

#### munge ####

# load data
data <- read.csv("scrSt1Ratings.csv") %>% 
  mutate(subjID  = as.factor(subjID)) %>%
  mutate(Condition = condition) %>% 
  filter(include==1) %>% 
  dplyr::select(-cond_dummy, -include, -filter_var, -condition)

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

data_long$Stereotype <- NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$stim[i],8,11) == "neut")  {
    data_long$Stereotype[i] <- "Non-Stereotype"
  } else if (substr(data_long$stim[i],8,11) == "othe")  {
    data_long$Stereotype[i] <- "Other Stereotype"
  } else if (substr(data_long$stim[i],8,11) == "host")  {
    data_long$Stereotype[i] <- "Hostile Stereotype"
  } else if (substr(data_long$stim[i],8,10) == "ses")  {
    data_long$Stereotype[i] <- "Low-SES Stereotype"
  }
}
data_long$Stereotype <- factor(data_long$Stereotype,levels = c("Low-SES Stereotype", "Hostile Stereotype", "Other Stereotype", "Non-Stereotype"))

data_long$Level = NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$stim[i],3,6) == "comm")  {
    data_long$Level[i] <- "Common" 
  } else if (substr(data_long$stim[i],3,6) == "pers")  {
    data_long$Level[i] <- "Personal"
  }
}
data_long$Level <- as.factor(data_long$Level)

data_long$Condition <- factor(data_long$Condition, levels = c("Scarcity", "Control"))
names(data_long)[6] <- "Trait"

commonData <- filter(data_long, Level == "Common") %>% 
  dplyr::select(-stim, -Level)

####plots####

blackCommonMeans <- commonData %>%
  filter(Race == "Black") %>% 
  group_by(Condition, Trait) %>%
  summarise_at(vars(rating), funs(mean(., na.rm=FALSE),sd(.,na.rm=FALSE),std.error(.,na.rm=FALSE)))

blackCommonReformat <- commonData %>%
  filter(Race == "Black") %>% 
  group_by(subjID, Condition, Trait) %>%
  summarise_at(vars(rating), funs(mean(., na.rm=FALSE),sd(.,na.rm=FALSE),std.error(.,na.rm=FALSE)))

line.pal <- c("#b2182b","#2166ac")
fill.pal <- c("#EF7762","#d1e5f0")

ggplot(blackCommonMeans, aes(x = Trait, y=mean, color=Condition, fill = Condition)) +
  geom_bar(stat="identity", size = .7, position=position_dodge(.91)) +
  theme_classic() +
  scale_y_continuous(expand = expansion(mult = c(0, .1))) +
  ylab("Percentage of Black Americans \n Characterized by Trait (%)") +
  theme(text=element_text(size=12,  family="Times New Roman"),
        axis.text.x = element_text(size = 11, color = "black"),
        axis.text.y = element_text(size = 11, color = "black"),
        legend.position = c(.9, .9)) +
  geom_jitter(data = blackCommonReformat, aes(colour = Condition), shape = 20, alpha = .75,
              position = position_jitterdodge(jitter.height = 0, jitter.width = .4)) +
  geom_errorbar(aes(ymin=mean-(sd*1.96/sqrt(112)), ymax=mean+(sd*1.96/sqrt(112))),
                width=.3,position=position_dodge(.9), size = .9) +
  scale_color_manual(values = line.pal) +
  scale_fill_manual(values = c(fill.pal))  
