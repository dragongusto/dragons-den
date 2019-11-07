library(readxl)
library(writexl)
library(stringr)
library(tidytext)
library(dplyr)
library(xlsx)
library(ggplot2)

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

#write_xlsx(good_reads_test, "/Users/johnaugusterferiii/Documents/VCU Grad School/DAPT 2019-2020/Fall Semester/Text Mining/group project/good_reads_write_underscore.xlsx", col_names = TRUE)
#write.xlsx(good_reads_test, "/Users/johnaugusterferiii/Documents/VCU Grad School/DAPT 2019-2020/Fall Semester/Text Mining/group project/good_reads_write_period.xlsx", col.names = TRUE)

good_reads_copy %>%
  unnest_tokens(word, good_reads_copy$review)

text_df <- tibble(text = good_reads_copy$review)

text_df

review_words <- text_df %>%
  unnest_tokens(word, text)

data(stop_words)

review_words <- review_words %>%
  anti_join(stop_words)

review_words %>%
  count(word, sort = TRUE)


#Graphs the frequency of words.
#the filter(n > 8000) means only the words that appear more than 8,000 times.
review_words %>%
  count(word, sort = TRUE) %>%
  filter(n > 8000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()








