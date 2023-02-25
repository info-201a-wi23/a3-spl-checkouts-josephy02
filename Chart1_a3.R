# Line graph of fiction vs nonfiction checkouts across the timespan of the collection period
library(tidyverse)
library(dplyr)
library(stringr)
library(scales)
library(ggplot2)
library(plotly)

book_df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

nf_books_graph <- book_df %>%
  group_by(CheckoutYear) %>%
  filter(Subjects == "Nonfiction") %>%
  summarize(nf_tot = sum(Checkouts)) %>%
  mutate(nf_tot)

f_books_graph <- book_df %>%
  group_by(CheckoutYear) %>%
  filter(Subjects == "Fiction") %>%
  summarize(f_tot = sum(Checkouts)) %>%
  mutate(f_tot)

checkoutyear <- nf_books_graph$CheckoutYear 
nf_tot2 <- nf_books_graph$nf_tot
f_tot2 <- f_books_graph$f_tot

all_book_df <- data.frame(x = checkoutyear, y1 = nf_tot2, y2 = f_tot2)

ggplot(all_book_df, aes(x=checkoutyear)) +
  geom_line(aes(y = y1, color = "Nonfiction")) +
  geom_line(aes(y = y2, color = "Fiction")) +
  labs(title = "Fiction and Nonfiction Books Over The Years (2017-2023)", x = "Checkout Year", y = "Total Checkouts")+
  scale_color_manual("", breaks = c("Nonfiction","Fiction"), values = c("red", "green")) +
  guides(color = guide_legend(title = "Line Colors"))
#scale_color_brewer(palette = "Set3")
