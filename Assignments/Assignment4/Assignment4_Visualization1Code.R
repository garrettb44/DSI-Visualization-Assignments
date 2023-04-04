# load libraries
library(tidyverse)
library(ggplot2)

# load into dataset
apartment_building_evaluation <- read_csv('ApartmentBuildingEvaluation.csv')

# view dataset
apartment_building_evaluation

# manipulate dataset
apartment_building_evaluation <-  apartment_building_evaluation %>% 
  rename("Property_Type" = "Property Type")

# generate our ggplot with building score against year built
# colour the plot according to housing type
set.seed(123)
apartment_building_plot <- ggplot(data = apartment_building_evaluation, 
                             mapping = aes(x = YEAR_BUILT, y = SCORE, 
                                           colour = Property_Type)
) 

# plot our ggplot using geom_point with jitter and added a trend line with geom_smooth
# add custom labels
# use virdis colour package and a minimal theme
apartment_building_plot + geom_point(alpha = 0.4, position=position_jitter(h=0.15,w=0.15)) + 
  geom_smooth(method = "lm") +
  labs(x = "Year Apartment Built", y = "Apartment Building Evaluation Score", 
  title = "Apartment Building Evaluation Score by Year Built", 
  subtitle = "Alt text: A scatter plot displaying the apartment building evaluation score for apartment buildings 
  in Toronto that are registered with RentSafeTO. The score is plotte against the year 
  the bulding was built. A linear regression model line shows us that the score tends to
  increase in buildings built more recently.", color = "Housing Type\n") +
  scale_color_viridis_d(labels = c("Private", "Social Housing", "Toronto Community Housing")) +
  theme_minimal()
     
