library(readxl)
library(writexl)
library(stringr)
library(tidytext)
library(dplyr)
library(xlsx)

good_reads <- read_excel("/Users/johnaugusterferiii/Documents/VCU Grad School/DAPT 2019-2020/Fall Semester/Text Mining/group project/all_data.xlsx")
good_reads_clean <- good_reads[,c("book_title", "Book_series", "book_rating", "book_author", "genre", "reviewer_name", "review", "ID")]
good_reads_copy <- good_reads_clean

good_reads_copy$review <- gsub("â€™", "'", good_reads_copy$review, fixed = FALSE)

test_matrix <- str_split_fixed(good_reads_copy$genre, ", ", 2)

good_reads_copy$genre <- test_matrix[ ,1]
good_reads_copy$genre2 <- test_matrix[,2]

good_reads_copy$genre2 <- gsub(",.*","",good_reads_copy$genre2)
good_reads_copy <- good_reads_copy[,c(1:5, 9, 6:8)]

good_reads_test <- good_reads_copy[!(is.na(good_reads_copy$review)),]

write_xlsx(good_reads_test, "/Users/johnaugusterferiii/Documents/VCU Grad School/DAPT 2019-2020/Fall Semester/Text Mining/group project/good_reads_write_underscore.xlsx", col_names = TRUE)
write.xlsx(good_reads_test, "/Users/johnaugusterferiii/Documents/VCU Grad School/DAPT 2019-2020/Fall Semester/Text Mining/group project/good_reads_write_period.xlsx", col.names = TRUE)

good_reads_copy %>%
  unnest_tokens(word, good_reads_copy$review)

text_df <- tibble(line = 1:4, text = good_reads_copy$review)

text_df
