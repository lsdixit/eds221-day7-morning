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

# paste data frame using datapasta
animals <- data.frame(
  stringsAsFactors = FALSE,
          location = c("lagoon", "bluff", "creek", "oaks", "bluff"),
           species = c("bobcat", "coyote", "fox", "squirrel", "bobcat"),
          maturity = c("adult", "juvenile", "adult", "juvenile", "adult")
)

sites <- data.frame(
  stringsAsFactors = FALSE,
          location = c("beach", "lagoon", "bluff", "oaks"),
    full_site_name = c("Goleta Beach","UCSB Lagoon",
                       "Ellwood Mesa","Fremont Campground"),
      jurisdiction = c("SB City", "UCSB", "SB City", "USFS")
)

# mutating joins

# full_join()
# keeps all rows and adds all columns
full_join(animals, sites)

# left_join()
left_join(animals, sites)

# right_join()
right_join(animals, sites)

# inner_join()
inner_join(animals, sites)

# filtering joins

# semi_join()
semi_join(animals, sites)
# same as:
animals %>%
  filter(location %in% sites$location)

# anti_join()
anti_join(animals, sites)
# same as:
animals %>%
  filter(!location %in% sites$location)

# practice with lubridate
my_date <- "03-13-1998"
lubridate::mdy(my_date) # fixed date to ISO 8601

my_date <- "08-Jun-1974"
lubridate::dmy(my_date)

my_date <- "19160518"
lubridate::ymd(my_date)

# what if we give lubridate a date that doesn't exist
lubridate::mdy("1942-08-30")

lubridate::dmy("09/12/84")

# working with date-times
time <- "2020-08-12 11:18"
time <- ymd_hm(time, tz = "America/Los_Angeles") # returns as POSIXct POSIXt class
# convert to pdt
with_tz(time, "America/Los_Angeles") # didn't add time zone, changed time from UTC to PDT
# extract info from dates
week(time)
year(time)
day(time)

start_time <- Sys.time()
end_time <- Sys.time()

end_time - start_time
