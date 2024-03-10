library(ggplot2)
library(ggpmisc)
library(patchwork)
library(ggrepel)
library(kableExtra)

p1 <- vt_data %>% 
  ggplot(aes(percent_ba_plus, Haley)) +
  geom_point(col = "darkgreen") +
  theme_classic() +
  labs(y = "Nikki haley vote share") +
  stat_poly_eq()
  
p2 <- vt_data %>% 
  ggplot(aes(percent_ba_plus, Trump)) +
  geom_point(col = "firebrick") +
  theme_classic() +
  labs(y = "Trump vote share") +
  stat_poly_eq()

p1 + p2 + 
  plot_annotation('GOP Primary Vote Share and Education Level,' ~bold('Vermont')~ 'Towns',theme=theme(plot.title=element_text(hjust=0.5)))
  

p3 <- nc_data %>% 
  ggplot(aes(percent_ba_plus, Haley)) +
  geom_point(col = "lightblue") +
  theme_classic() +
  labs(y = "Nikki haley vote share") +
  stat_poly_eq()

p4 <- nc_data %>% 
  ggplot(aes(percent_ba_plus, Trump)) +
  geom_point(col = "darkblue") +
  theme_classic() +
  labs(y = "Trump vote share") +
  stat_poly_eq()

p3 + p4 + 
  plot_annotation('GOP Primary Vote Share and Education Level,' ~bold('North Carolina')~ 'Counties',theme=theme(plot.title=element_text(hjust=0.5)))

sampled_nc <- sample_n(nc_data, size = 15)
names_plot <- nc_data %>% 
  ggplot(aes(percent_ba_plus, Haley)) +
  geom_point(col = "lightblue") +
  geom_text_repel(data = sampled_nc, aes(label = County)) +
  theme_classic() +
  labs(y = "Nikki haley vote share") +
  stat_poly_eq()

names_plot +
  plot_annotation('Nikki Haley Primary Vote Share and Education Level,' ~bold('North Carolina')~ 'Counties',theme=theme(plot.title=element_text(hjust=0.5)))
  

names_plot_ok <- ok_data %>% 
  ggplot(aes(percent_ba_plus, Haley)) +
  geom_point(col = "lightgreen") +
  geom_text_repel(aes(label = County)) +
  theme_classic() +
  labs(y = "Nikki haley vote share") +
  stat_poly_eq()
names_plot_ok + 
  plot_annotation('Nikki Haley Primary Vote Share and Education Level,' ~bold('Oklahoma')~ 'Counties',theme=theme(plot.title=element_text(hjust=0.5)))

cor(vt_data$Haley, vt_data$percent_ba_plus) # vermont
cor(nc_data$Haley, nc_data$percent_ba_plus) # nc
cor(ok_data$Haley, ok_data$percent_ba_plus) # ok

cors <- data.frame(State = c("Vermont (Towns)",
                             "North Carolina (Counties)",
                             "Oklahoma (Counties)"),
                   cor = c(.59, .88, .87))
cors %>% 
  kbl(caption = "Correlations Between Nikki Haley Vote Share on
      Super Tuesday and Percent 25 and Older with a Bachelor's Degree or Higher",
  format = 'html',
  col.names = c("State (Aggregation)", "r")) %>% 
  kable_classic(full_width = T, html_font = "helvetica")
  
