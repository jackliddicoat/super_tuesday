library(dplyr)
library(rvest)

url_vt <- "https://www.nytimes.com/interactive/2024/03/05/us/elections/results-vermont-republican-presidential-primary.html"
vt <- url_vt %>% 
  read_html()
vt <- vt %>% 
  html_elements("table") %>% 
  html_table()
vt <- vt[[2]]

url_ok <- "https://www.nytimes.com/interactive/2024/03/05/us/elections/results-oklahoma-republican-presidential-primary.html"
ok <- url_ok %>% 
  read_html()
ok <- ok %>% 
  html_elements("table") %>% 
  html_table()
ok <- ok[[3]]

url_nc <- "https://www.nytimes.com/interactive/2024/03/05/us/elections/results-north-carolina-republican-presidential-primary.html"
nc <- url_nc %>% 
  read_html()
nc <- nc %>% 
  html_elements("table") %>% 
  html_table()
nc %>% 
  View()
nc <- nc[[3]]

vt %>% head(); ok %>% head(); nc %>% head()

vt <- vt %>% 
  select(Town, Haley, Trump) %>% 
  mutate(Haley = gsub("%", "", Haley),
         Trump = gsub("%", "", Trump)) %>% 
  mutate(Haley = as.numeric(Haley),
         Trump = as.numeric(Trump)) %>% 
  mutate(Haley = Haley/100,
         Trump = Trump/100) %>% 
  filter(!is.na(Haley))

ok <- ok %>% 
  select(County, Haley, Trump) %>% 
  mutate(Haley = gsub("%", "", Haley),
         Trump = gsub("%", "", Trump)) %>% 
  mutate(Haley = as.numeric(Haley)/100,
         Trump = as.numeric(Trump)/100) %>% 
  filter(!is.na(Haley))

nc <- nc %>% 
  select(County, Haley, Trump) %>% 
  mutate(Haley = gsub("%", "", Haley),
         Trump = gsub("%", "", Trump)) %>% 
  mutate(Haley = as.numeric(Haley)/100,
         Trump = as.numeric(Trump)/100) %>% 
  filter(!is.na(Haley))



