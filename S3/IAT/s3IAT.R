#### packages ####
library(tidyverse)
library(class)
library(ROCR)
library(summarytools)
library(lubridate)
library(psych)
library(Hmisc)
library(extrafont)
library(gridExtra)
library(lme4)
library(geepack)


#### munge ####

# load non-black participants data
iat_data <- read.csv("study3_iat.csv") %>% 
  select(iat_subj_id, condition, first_iat, host_d, ses_d, eval_d, race)%>% 
  mutate(condition = dplyr::recode(condition,
                            `0` = "scarcity",
                            `1` = "control")) %>% 
  mutate(iat_subj_id  = as.factor(iat_subj_id),
         condition = as.factor(condition)) %>%
  filter(first_iat > -1) %>% 
  filter(!grepl("Black", race))
  
names(iat_data)[1] <- "subjID"

data_long <- gather(iat_data, IAT, d_score, host_d:eval_d, factor_key=TRUE)

for (i in 1:nrow(data_long)) {
  if (data_long$first_iat[i] == .5)  {
    data_long$first_iat[i] <- "Low-SES" 
  }
}
for (i in 1:nrow(data_long)) {
  if (data_long$first_iat[i] == -.5)  {
    data_long$first_iat[i] <- "Hostile" 
  }
}
data_long$first_iat <- factor(data_long$first_iat)

ses_iat <- filter(iat_data, first_iat == .5) %>% 
  select(-host_d)
names(ses_iat)[4] <- "stereo_d"


host_iat <- filter(iat_data, first_iat == -.5) %>% 
  select(-ses_d)
names(host_iat)[4] <- "stereo_d"

both_iats <- rbind(ses_iat, host_iat)

scarcity.iat.gee <- geeglm(d_score ~ condition*IAT,
                           data = data_long,
                           id = subjID,
                           family = "gaussian",
                           corstr = "exchangeable")
summary(scarcity.iat.gee)

# converting Wald 
sprintf("%.4f",sqrt(as.numeric(sprintf("%.4f",
                                       as.numeric(summary(scarcity.iat.gee)[[6]][,'Wald'][2])))))

#-----#

eval_iat <- select(iat_data, -first_iat, -ses_d, -host_d)

eval.glm <- glm(eval_d ~ condition, data = eval_iat)
summary(eval.glm)

ses_iat <- filter(iat_data, first_iat == .5) %>% 
  select(-first_iat, -host_d, -race)

host_iat <- filter(iat_data, first_iat == -.5) %>% 
  select(-first_iat, -ses_d, -race)

#### eval t-test ####
t.test(eval_iat$eval_d ~ eval_iat$condition, var.equal = TRUE)[1]
t.test(eval_iat$eval_d ~ eval_iat$condition, var.equal = TRUE)[2]
t.test(eval_iat$eval_d ~ eval_iat$condition, var.equal = TRUE)[3]

eval_iat_anova <- aov(eval_iat$eval_d ~ eval_iat$condition)
summary(eval_iat_anova)

eval_reformat <- eval_iat %>%
  group_by(condition) %>%
  summarise_at(vars(eval_d), funs(mean(., na.rm=TRUE),sd(.,na.rm=TRUE)))

#### host t-test ####

t.test(host_iat$host_d ~ host_iat$condition, var.equal = TRUE)[1]
t.test(host_iat$host_d ~ host_iat$condition, var.equal = TRUE)[2]
t.test(host_iat$host_d ~ host_iat$condition, var.equal = TRUE)[3]

host_iat_anova <- aov(host_iat$host_d ~ host_iat$condition)
summary(host_iat_anova)

host_reformat <- host_iat %>%
  group_by(condition) %>%
  summarise_at(vars(host_d), funs(mean(., na.rm=TRUE),sd(.,na.rm=TRUE)))

#### ses t-test ####

t.test(ses_iat$ses_d ~ ses_iat$condition, var.equal = TRUE)[1]
t.test(ses_iat$ses_d ~ ses_iat$condition, var.equal = TRUE)[2]
t.test(ses_iat$ses_d ~ ses_iat$condition, var.equal = TRUE)[3]

ses_reformat <- ses_iat %>%
  group_by(condition) %>%
  summarise_at(vars(ses_d), funs(mean(., na.rm=TRUE),sd(.,na.rm=TRUE)))

ses_iat_anova <- aov(ses_iat$ses_d ~ ses_iat$condition)
summary(ses_iat_anova)
