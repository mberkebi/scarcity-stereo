library(tidyverse)
library(plotrix)
library(geepack)
library(lmSupport)
library(lme4)

#### munge ####

# load data
data <- read.csv("ratingsData.csv") %>% 
  dplyr::select(-qual_id, -implausible, -purpose, -unclear) %>% 
  mutate(subj_id  = as.factor(subj_id)) %>%
  filter(!grepl("Black", race))
  
# convert to long form
data_long <- gather(data, condition, rating, practice1:SHL_aggressive, factor_key=TRUE)
data_long <- data_long[order(data_long$subj_id),] %>% 
  select(subj_id, condition, rating)

# making scarcity conditions

data_long$group <- NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$condition[i],1,1) == "S")  {
    data_long$group[i] <- "scarcity" # setting scarcity group to 1
  } else if (substr(data_long$condition[i],1,1) == "C")  {
    data_long$group[i] <- "control" # setting control group to 0
  }
}
data_long$group <- as.factor(data_long$group)

data_long$stereotype <- NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$condition[i],2,2) == "E")  {
    data_long$stereotype[i] <- "eval" # eval faces to eval
  } else if (substr(data_long$condition[i],2,2) == "S")  {
    data_long$stereotype[i] <- "ses" # ses faces to ses
  } else if (substr(data_long$condition[i],2,2) == "H")  {
    data_long$stereotype[i] <- "host" # host faces to host
  }
}

data_long$level = NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$condition[i],3,3) == "H")  {
    data_long$level[i] <- "high" # setting scarcity group to 1
  } else if (substr(data_long$condition[i],3,3) == "L")  {
    data_long$level[i] <- "low" # setting control group to 0
  }
}
data_long$level <- as.factor(data_long$level)


data_long$outcome <- NA
for (i in 1:nrow(data_long)) {
  if (substr(data_long$condition[i],5,14) == "aggressive")  {
    data_long$outcome[i] <- "hostile" 
  } else if (substr(data_long$condition[i],5,8) == "like")  {
    data_long$outcome[i] <- "evaluative" 
  } else if (substr(data_long$condition[i],5,12) == "positive")  {
    data_long$outcome[i] <- "evaluative" 
  } else if (substr(data_long$condition[i],5,12) == "educated")  {
    data_long$outcome[i] <- "ses" 
  } else if (substr(data_long$condition[i],5,11) == "hostile")  {
    data_long$outcome[i] <- "hostile" 
  } else if (substr(data_long$condition[i],5,11) == "wealthy")  {
    data_long$outcome[i] <- "ses" 
  } 
}

eval_data <- filter(data_long, outcome == "evaluative", stereotype == "eval")
ses_data <- filter(data_long, outcome == "ses", stereotype == "ses")
host_data <- filter(data_long, outcome == "hostile", stereotype == "host")

# rescaling values to be in correct direction
ses_data <- mutate(ses_data, rating = dplyr::recode(rating,
                                                "10" = 1,
                                                "9" = 2,
                                                "8" = 3,
                                                "7" = 4,
                                                "6" = 5,
                                                "5" = 6,
                                                "4" = 7,
                                                "3" = 8,
                                                "2" = 9,
                                                "1" = 10))

ses_data$rating <- as.integer(ses_data$rating)

eval_data <- mutate(eval_data, rating = dplyr::recode(rating,
                                                    "10" = 1,
                                                    "9" = 2,
                                                    "8" = 3,
                                                    "7" = 4,
                                                    "6" = 5,
                                                    "5" = 6,
                                                    "4" = 7,
                                                    "3" = 8,
                                                    "2" = 9,
                                                    "1" = 10))

eval_data$rating <- as.integer(eval_data$rating)

stereo_data <- rbind(ses_data, host_data) 
stereo_data <- arrange(stereo_data, subj_id, condition) 
eval_data <- arrange(eval_data, subj_id, condition)

stereo_data <- stereo_data %>%
  group_by(subj_id, group, stereotype, level) %>%
  summarise_at(vars(rating), funs(mean(., na.rm=FALSE)))

stereo_data$stereo.rating <- stereo_data$rating
stereo_data$eval.rating <- eval_data$rating
eval_data$eval.rating <- eval_data$rating

#### gee analysis ####
stereo_data$group.f <- str_to_title(stereo_data$group)
stereo_data$level.f <- str_to_title(stereo_data$level)
stereo_data$stereotype.f <- str_to_title(stereo_data$stereotype)

stereo_data$group.f <- factor(stereo_data$group.f, levels = c("Control", "Scarcity"))
stereo_data$level.f <- factor(stereo_data$level.f, levels = c("Low", "High"))
stereo_data$stereotype.f <- factor(stereo_data$stereotype.f, levels = c("Ses", "Host"))

stereo.gee <- geeglm(stereo.rating ~ group.f + stereotype.f + level.f +
                                group.f*stereotype.f + group.f*level.f + stereotype.f*level.f +
                                group.f*stereotype.f*level.f,
                              data = stereo_data,
                              id = subj_id,
                              family = "gaussian",
                              corstr = "exchangeable")
summary(stereo.gee)


eval_data$group.f <- str_to_title(eval_data$group)
eval_data$level.f <- str_to_title(eval_data$level)
eval_data$stereotype.f <- str_to_title(eval_data$stereotype)

eval_data$group.f <- factor(eval_data$group.f, levels = c("Control", "Scarcity"))
eval_data$level.f <- factor(eval_data$level.f, levels = c("Low", "High"))
eval_data$stereotype.f <- factor(eval_data$stereotype.f, levels = c("Ses", "Host"))


eval.gee <- geeglm(eval.rating ~ group.f + level.f +
                     group.f*level.f,
                   data = eval_data,
                   id = subj_id,
                   family = "gaussian",
                   corstr = "exchangeable")
summary(eval.gee)


stereo.eval.gee <- geeglm(stereo.rating ~ group.f + stereotype.f + level.f + eval.rating +
                       group.f*stereotype.f + group.f*level.f + stereotype.f*level.f +
                       group.f*stereotype.f*level.f,
                     data = stereo_data,
                     id = subj_id,
                     family = "gaussian",
                     corstr = "exchangeable")
summary(stereo.eval.gee)

#### plots ####
stereo_means <- stereo_data %>%
   group_by(group.f, level.f) %>%
   summarise_at(vars(stereo.rating), funs(mean(., na.rm=FALSE),std.error(., na.rm=FALSE)))
 
stereo_reformat <- stereo_data %>%
  group_by(subj_id, group.f, level.f) %>%
  summarise_at(vars(stereo.rating), funs(mean(., na.rm=FALSE),std.error(., na.rm=FALSE)))

names(stereo_data)[8] <- "Group"
names(stereo_data)[9] <- "IAT Bias Level"
names(stereo_means)[1] <- "Group"
names(stereo_reformat)[2] <- "Group"

line.pal <- c("#b2182b","#2166ac")
fill.pal <- c("#EF7762","#d1e5f0")

ggplot(stereo_means, aes(x = level.f, y=mean, color=Group, fill = Group)) +
  geom_bar(stat="identity", size = .7, position=position_dodge(.91)) +
  theme_classic() +
  scale_y_continuous(expand = expansion(mult = c(0, .1))) +
  ylab("Stereotype Face Rating") +
  xlab("Stereotype IAT Bias Level") +
  theme(text=element_text(size=12,  family="Times New Roman"),
        axis.text.x = element_text(size = 11, color = "black"),
        axis.text.y = element_text(size = 11, color = "black"),
        legend.position = c(.9, .9)) +
  geom_jitter(data = stereo_reformat, aes(colour = Group), shape = 20, alpha = .75,
              position = position_jitterdodge(jitter.height = 0, jitter.width = .45)) +
  geom_errorbar(aes(ymin=mean-(std.error*1.96), ymax=mean+(std.error*1.96)),
                width=.3,position=position_dodge(.9), size = 1, alpha = 1) +
  scale_color_manual(values = line.pal) +
  scale_fill_manual(values = c(fill.pal)) +
  theme(legend.position = "right")

#### t-tests ####
stereo_high <- filter(stereo_data, level.f == "High")
stereo_low <- filter(stereo_data, level.f == "Low")
stereo_high_scarcity <- filter(stereo_high, group.f == "Scarcity")
stereo_high_control <- filter(stereo_high, group.f == "Control")
stereo_low_scarcity <- filter(stereo_low, group.f == "Scarcity")
stereo_low_control <- filter(stereo_low, group.f == "Control")

describe(stereo_high_control$stereo.rating)

t.test(stereo_low_scarcity$rating, stereo_high_scarcity$rating)

t.test(stereo_high$stereo.rating ~ stereo_high$group.f)[1]
t.test(stereo_high$stereo.rating ~ stereo_high$group.f)[2]
t.test(stereo_high$stereo.rating ~ stereo_high$group.f)[3]
t.test(stereo_low$stereo.rating ~ stereo_high$group.f)[1]
t.test(stereo_low$stereo.rating ~ stereo_low$group.f)[2]
t.test(stereo_low$stereo.rating ~ stereo_low$group.f)[3]

stereo_control <- filter(stereo_data, group.f == "Control")
stereo_scarcity <- filter(stereo_data, group.f == "Scarcity")
t.test(stereo_control$stereo.rating ~ stereo_control$level.f)[1]
t.test(stereo_scarcity$stereo.rating ~ stereo_scarcity$level.f)


#### lessR t.tests ####
install.packages("lessR")
library(lessR)

a <- 1:172
stereo_means <- tibble(a)
stereo_means$c.l <- stereo_low_control$stereo.rating
stereo_means$c.h <- stereo_high_control$stereo.rating
stereo_means$s.l <- stereo_low_scarcity$stereo.rating
stereo_means$s.h <- stereo_high_scarcity$stereo.rating
stereo_means <- stereo_means %>% 
  select(-a)

describe(stereo_means$c.l)
describe(stereo_means$c.h)
describe(stereo_means$s.l)
describe(stereo_means$s.h)

lessR::ttest(data = stereo_means,
             x = c.h,
             y = s.h,
             paired = FALSE, arg = "two_sided", digits.d = 4)

lessR::ttest(data = stereo_means,
             x = c.l,
             y = s.l,
             paired = FALSE, arg = "two_sided", digits.d = 5)

lessR::ttest(data = stereo_means,
             x = s.l,
             y = s.h,
             paired = FALSE, arg = "two_sided", digits.d = 5)






