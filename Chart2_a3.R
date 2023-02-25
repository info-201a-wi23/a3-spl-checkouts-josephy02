# Line chart of different material types of books by checkout
library(tidyverse)
library(dplyr)
library(stringr)
library(scales)
library(ggplot2)
library(plotly)

book_df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

mat_type_hard <- book_df %>%
  group_by(CheckoutYear) %>%
  filter(MaterialType == "BOOK") %>%
  summarize(hard_checkouts = sum(Checkouts))

mat_type_aud <- book_df %>%
  group_by(CheckoutYear) %>%
  filter(MaterialType == "AUDIOBOOK") %>%
  summarize(aud_checkouts = sum(Checkouts))

checkoutyear2 <- mat_type_aud$CheckoutYear 
h_tot <- mat_type_hard$hard_checkouts
a_tot <- mat_type_aud$aud_checkouts

all_books_df <- data.frame(x = checkoutyear2, y1 = h_tot, y2 = a_tot)

ggplot(all_books_df, aes(x=checkoutyear2)) +
  geom_line(aes(y = y1, colour = "Book")) +
  geom_line(aes(y = y2, colour = "Audiobook")) +
  labs(title = "Books and Audiobooks Over The Years (2017-2023)", x = "Checkout Year", y = "Total Checkouts")+
  scale_color_manual("", breaks = c("Book","Audiobook"), values = c("blue", "yellow")) +
  guides(color = guide_legend(title = "Line Colors"))
#scale_color_brewer(palette = "Set3")
