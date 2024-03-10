library(readxl)
library(tidyr)
library(stringr)

# setwd("Downloads")
dat <- read_excel("college_town_analysis.xlsx", sheet = "vt")
dat[paste0("town", 1:4)] <- str_split_fixed(dat$town, ' town', 4)

vt_college <- dat %>% 
  mutate(percent_ba_plus = as.numeric(percent_ba_plus)) %>%
  mutate(percent_ba_plus = percent_ba_plus/100) %>% 
  rename(Town = town1) %>% 
  select(Town, percent_ba_plus)

vt_data <- right_join(vt, vt_college, by = "Town") %>% 
  filter(!is.na(Haley))

# NOTE 
# the data for NC and OK are by county, not town
# oklahoma only has education data for 12 counties in 2022

dat <- read_excel("college_town_analysis.xlsx", sheet = "nc")
dat[paste0("County", 1:2)] <- str_split_fixed(dat$county, ' County', 2)
nc_college <- dat %>% 
  rename(percent_ba_plus = `percent _ba_plus`) %>% 
  mutate(percent_ba_plus = as.numeric(percent_ba_plus)) %>%
  mutate(percent_ba_plus = percent_ba_plus/100) %>% 
  rename(County = County1) %>% 
  select(County, percent_ba_plus)

nc_data <- right_join(nc, nc_college, by = "County") %>% 
  filter(!is.na(Haley))

dat <- read_excel("college_town_analysis.xlsx", sheet = "ok")
dat %>% 
  View()
dat[paste0("County", 1:2)] <- str_split_fixed(dat$County, ' County', 2)
ok_college <- dat %>%
  mutate(percent_ba_plus = as.numeric(percent_ba_plus)) %>%
  mutate(percent_ba_plus = percent_ba_plus/100) %>% 
  select(County1, percent_ba_plus) %>% 
  rename(County = County1)

ok_data <- right_join(ok, ok_college, by = "County") %>% 
  filter(!is.na(Haley))


