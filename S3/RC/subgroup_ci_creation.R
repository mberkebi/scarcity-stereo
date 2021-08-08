library(tidyverse)
library(rcicr)

all_rc <- read.csv('clean_rc.csv')

cont_eval_high <- filter(all_rc, subject == "1930639" | subject == "4753126"
                         | subject == "9184851" | subject == "6839084"
                         | subject == "3708907" | subject == "4235827"
                         | subject == "6412820" | subject == "3644853"
                         | subject == "9524064" | subject == "4232194"
                         | subject == "2758078" | subject == "5812426"
                         | subject == "2172386" | subject == "5162026"
                         | subject == "9230895")

cont_eval_low <- filter(all_rc, subject == "4662679" | subject == "2791130"
                         | subject == "4000979" | subject == "5734753"
                         | subject == "7766313" | subject == "8258183"
                         | subject == "6744876" | subject == "4621818"
                         | subject == "5684595" | subject == "8298756"
                         | subject == "4417875" | subject == "5830295"
                         | subject == "1639863" | subject == "2636379"
                         | subject == "5177074")

scar_eval_low <- filter(all_rc, subject == "7777283" | subject == "1877666"
                         | subject == "5486373" | subject == "8525460"
                         | subject == "7855589" | subject == "7110932"
                         | subject == "4610791" | subject == "1804821"
                         | subject == "7330847" | subject == "828835"
                         | subject == "9224951" | subject == "883747"
                         | subject == "3778486" | subject == "9858435"
                         | subject == "1476038")

scar_eval_high <- filter(all_rc, subject == "1496712" | subject == "8667681"
                        | subject == "8451721" | subject == "3681948"
                        | subject == "8800147" | subject == "5713312"
                        | subject == "6165669" | subject == "8997510"
                        | subject == "125139" | subject == "9726097"
                        | subject == "1853332" | subject == "2985120"
                        | subject == "8652366" | subject == "1942624"
                        | subject == "4885021")
#####

cont_host_high <- filter(all_rc, subject == "3266480" | subject == "3578561"
                         | subject == "3702216" | subject == "4235827"
                         | subject == "4893326" | subject == "5310277"
                         | subject == "5830295" | subject == "6207437"
                         | subject == "7302569" | subject == "7307893"
                         | subject == "7374520" | subject == "7688055"
                         | subject == "8031885" | subject == "9300742"
                         | subject == "9846062")

cont_host_low <- filter(all_rc, subject == "1396883" | subject == "1639863"
                        | subject == "2636379" | subject == "2791130"
                        | subject == "3261766" | subject == "4621818"
                        | subject == "4662679" | subject == "5729095"
                        | subject == "5734753" | subject == "6119359"
                        | subject == "6622583" | subject == "7224460"
                        | subject == "8094462" | subject == "8298756"
                        | subject == "9095826")

cont_ses_high <- filter(all_rc, subject == "390767" | subject == "1930639"
                        | subject == "3644853" | subject == "4232194"
                        | subject == "5160015" | subject == "5219411"
                        | subject == "5812426" | subject == "6412820"
                        | subject == "6631302" | subject == "6839084"
                        | subject == "7051721" | subject == "8668972"
                        | subject == "9184851" | subject == "9409771" 
                        | subject == "9524064")

cont_ses_low <- filter(all_rc, subject == "1344708" | subject == "1688594"
                        | subject == "3565001" | subject == "3708907"
                        | subject == "4417875" | subject == "4753126"
                        | subject == "5162026" | subject == "5397229"
                        | subject == "5684595" | subject == "6700209"
                        | subject == "7634658" | subject == "7766313"
                        | subject == "7846195" | subject == "8258183" 
                        | subject == "9230895")

scar_host_high <- filter(all_rc, subject == "120693" | subject == "125139"
                        | subject == "786767" | subject == "1118150"
                        | subject == "1859753" | subject == "1942624"
                        | subject == "2667460" | subject == "4208680"
                        | subject == "4305848" | subject == "5535267"
                        | subject == "5750539" | subject == "7471528"
                        | subject == "8667681" | subject == "8997510"
                        | subject == "9726097")

scar_host_low <- filter(all_rc, subject == "1130598" | subject == "1202764"
                        | subject == "1274211" | subject == "1804821"
                        | subject == "1877666" | subject == "1888221"
                        | subject == "3032542" | subject == "3778486"
                        | subject == "5713312" | subject == "6165669"
                        | subject == "7071072" | subject == "7330847"
                        | subject == "7727328" | subject == "8525460"
                        | subject == "9224951")

scar_ses_high <- filter(all_rc, subject == "1223946" | subject == "1496712"
                        | subject == "1853332" | subject == "2985120"
                        | subject == "3219591" | subject == "4146909"
                        | subject == "4610791" | subject == "4819967"
                        | subject == "7119347" | subject == "7161035"
                        | subject == "7984248" | subject == "8451721"
                        | subject == "8521421" | subject == "8652366"
                        | subject == "9546704")

scar_ses_low <- filter(all_rc, subject == "883747" | subject == "1347675"
                        | subject == "1476038" | subject == "1608397"
                        | subject == "1710470" | subject == "3779150"
                        | subject == "5369343" | subject == "5486373"
                        | subject == "5496891" | subject == "7548834"
                        | subject == "7780541" | subject == "7855589"
                        | subject == "8084358" | subject == "8494457"
                        | subject == "9858435")

# Base image name used during stimulus generation
baseimage <- 'ambig_baseface'

# File containing the contrast parameters (this file was created during stimulus generation)
rdata <- 'rcic_seed.Rdata'

# Load response data

#responsedata <- all_rc

# Batch generate classification images by subject
c_h_h <- batchGenerateCI2IFC(cont_host_high, 'trait', 'stimulus', 'response', baseimage, rdata)
c_h_l <- batchGenerateCI2IFC(cont_host_low, 'trait', 'stimulus', 'response', baseimage, rdata)
c_s_h <- batchGenerateCI2IFC(cont_ses_high, 'trait', 'stimulus', 'response', baseimage, rdata)
c_s_l <- batchGenerateCI2IFC(cont_ses_low, 'trait', 'stimulus', 'response', baseimage, rdata)
c_e_l <- batchGenerateCI2IFC(cont_eval_low, 'trait', 'stimulus', 'response', baseimage, rdata)
c_e_h <- batchGenerateCI2IFC(cont_eval_high, 'trait', 'stimulus', 'response', baseimage, rdata)


s_h_h <- batchGenerateCI2IFC(scar_host_high, 'trait', 'stimulus', 'response', baseimage, rdata)
s_h_l <- batchGenerateCI2IFC(scar_host_low, 'trait', 'stimulus', 'response', baseimage, rdata)
s_s_h <- batchGenerateCI2IFC(scar_ses_high, 'trait', 'stimulus', 'response', baseimage, rdata)
s_s_l <- batchGenerateCI2IFC(scar_ses_low, 'trait', 'stimulus', 'response', baseimage, rdata)
s_e_l <- batchGenerateCI2IFC(scar_eval_low, 'trait', 'stimulus', 'response', baseimage, rdata)
s_e_h <- batchGenerateCI2IFC(scar_eval_high, 'trait', 'stimulus', 'response', baseimage, rdata)










