# This file will is the code for a bar graph of audiobooks across each checkout year

library(tidyverse)
library(dplyr)
library(stringr)
library(scales)
library(ggplot2)

book_df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

max_audio_years <- book_df %>%
  group_by(CheckoutYear) %>%
  filter(MaterialType == "AUDIOBOOK", str_detect(Subjects, "Nonfiction")) %>%
  summarize(all_checkouts = sum(Checkouts, na.rm = TRUE))

ggplot(data = max_audio_years) +
  geom_col(mapping = aes(x = CheckoutYear, y = all_checkouts, fill = CheckoutYear))+
  labs(title = "Nonfiction Audiobooks Over The Years (2017-2023)", x = "Checkout Year", y = "Total Checkouts")+
  theme_classic()+
  scale_color_brewer(palette = "Accent")           
