# clearing environment
rm(list = ls())

# attach packages
library(tidyverse)
library(palmerpenguins)
library(lubridate) # help us work with dates

head(penguins)
# data wrangling refresher
penguin_tidy <- penguins %>%
  filter(island == c("Biscoe", "Dream")) %>% # only include penguins at Biscoe and Dream islands
  select(-sex, -year) %>% # remove year and sex variables
  mutate(body_mass_kg = body_mass_g / 1000) %>% # add new column converting body mass from grams to kg
  rename(location = island)# rename island variable to location

penguin_analysis <- penguins %>%
  filter(species == "Adelie") %>% # keep only Adelie species
  drop_na(flipper_length_mm, sex) %>% # remove NAs from flipper length
  group_by(sex) %>% # group data by sex
  summarise(mean_flipper_length = mean(flipper_length_mm), # calculate mean, standard deviation, and sample size of flipper lengths for male and female
            sd_flipper_length = sd(flipper_length_mm),
            n = n())




