
library(dplyr)
library(ggplot2)
library(stringr)
library(tidyverse)

book_df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# 5 Q's to Answer
# How many audiobooks were checked out in across the timespan the data was collected?

audio_books_tot <- book_df %>%
  filter(MaterialType == "AUDIOBOOK") %>%
  summarize(Totcheckouts = sum(Checkouts)) %>%
pull(Totcheckouts)

# How many of the checked out books were nonfiction?

nf_books <- book_df %>% 
  filter(Subjects == "Nonfiction") %>%
  summarize(nf_tot = sum(Checkouts)) %>%
pull(nf_tot)

# How many of the audiobooks were nonfiction?

audio_nf_books <- book_df %>%
  filter(MaterialType == "AUDIOBOOK") %>%
  filter(Subjects == "Nonfiction") %>%
  summarize(audio_tot = sum(Checkouts)) %>%
pull(audio_tot)

# What is the year with the most checkouts for nonfiction audiobooks?

max_audio_year <- book_df %>%
  filter(MaterialType == "AUDIOBOOK", str_detect(Subjects, "Nonfiction")) %>%
  group_by(CheckoutYear) %>%
  summarize(date_checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  filter(date_checkouts == max(date_checkouts, na.rm = TRUE)) %>%
pull(CheckoutYear)

# How many of the nonfiction books were also labeled philosophy books?

total_phil_books <- book_df %>%
  filter(str_detect(Subjects, "Nonfiction, Philosophy")) %>%
  summarise(tot_checkouts = sum(Checkouts, na.rm = TRUE)) %>%
pull(tot_checkouts)
  
  
  

