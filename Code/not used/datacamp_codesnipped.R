install.packages("magrittr")
library(magrittr)
devtools::install_github(trinker.github.com/qdap/)
library(qdap)
tweets_migration %$% polarity(text)
library(tm)
install.packages("metricsgraphics")
library(metricsgraphics)



clean_corpus <- function(corpus){
  corpus <- tm_map(corpus, content_transformer(replace_abbreviation))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removeWords, c(stopwords("en"), "coffee"))
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, stripWhitespace)
  return(corpus)
}

(datacamp_conversation <- tweets_migration %$% polarity(text, screenName))

positive <- tweets_migration %$% polarity(text, screenName)
pos_score <- counts(positive)


# Counts table from datacamp_conversation
counts(datacamp_conversation)

migrationCorpus <-VectorSource(tweets_migration)
tm_corpus <- VCorpus(migrationCorpus)
tm_clean <- clean_corpus(tm_corpus)

tf_dtm <- DocumentTermMatrix(tm_clean)

tf_dtm_m <- as.matrix(tf_dtm)

# Dimensions of DTM matrix
dim(tf_dtm_m)

## ccraete expectations


#########################################################################################################
# here data camps uses sb words but we dont have rank or freqency hence one would need to compute those to make this
# Examine sb_words
head(sb_words)

# Create expectations
sb_words$expectations <- sb_words %$%
  {freq[1] / rank}

# Create metrics plot
sb_plot <- mjs_plot(sb_words, x = rank, y = freq, show_rollover_text = FALSE)

# Add 1st line
sb_plot <- mjs_line(sb_plot)

# Add 2nd line
sb_plot <- mjs_add_line(sb_plot, expectations)

# Add legend
sb_plot <- mjs_add_legend(sb_plot, legend = c("Frequency", "Expectation"))

# Display plot
sb_plot

#########################################################################################################


#################################################################
## notes
library(tm)

# Import text data from CSV, no factors
tweets <- read.csv(coffee_data_file)
stringAsFactor = FALSE,
# View the structure of tweets
str(tweets)

# Isolate text from tweets
coffee_tweets <- tweets$text

# Make lowercase
tolower(text)

# Remove punctuation
removePunctuation(text)

# Remove numbers
removeNumbers(text)

# Remove whitespace
stripWhitespace(text)

#################################################################
## text is still loaded in your workspace

# Remove text within brackets
bracketX(text)

# Replace numbers with words
replace_number(text)

# Replace abbreviations
replace_abbreviation(text)

# Replace contractions
replace_contraction(text)

# Replace symbols with words
replace_symbol(text)

#################################################################
# Create complicate
complicate <- c("complicated", "complication", "complicatedly")

# Perform word stemming: stem_doc
stem_doc <- stemDocument(complicate)

# Create the completion dictionary: comp_dict
comp_dict <- "complicate"

# Perform stem completion: complete_text
complete_text <- stemCompletion(stem_doc, comp_dict)

# Print complete_text
complete_text

# Remove punctuation: rm_punc
rm_punc <- removePunctuation(text_data)

# Create character vector: n_char_vec
n_char_vec <- unlist(strsplit(rm_punc, split = " "))

# Perform word stemming: stem_doc
stem_doc <- stemDocument(n_char_vec)

# Print stem_doc
stem_doc

# Re-complete stemmed document: complete_doc
complete_doc <- stemCompletion(stem_doc, comp_dict)

# Print complete_doc
complete_doc

# Create frequency
frequency <- freq_terms(
  doc$terms,
  top = 50,
  at.least = 3,
  stopwords("english"))

plot(frequency)

plot(index)
# Make a frequency barchart

associations <- findAssocs(tweets_tdm, "venti", 0.2)

# View the venti associations
associations

# Create associations_df
associations_df <- list_vect2df(associations, col2 = "word", col3 = "score")

# Plot the associations_df values
ggplot(associations_df, aes(score, word)) +
  geom_point(size = 3) +
  theme_gdocs()


#################################################################
# Make tokenizer function
tokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

# Create unigram_dtm
unigram_dtm <- DocumentTermMatrix(text_corp)

# Create bigram_dtm
bigram_dtm <- DocumentTermMatrix(
  text_corp,
  control = list(tokenize = tokenizer)
)

# Print unigram_dtm
unigram_dtm

# Print bigram_dtm
bigram_dtm


# Rename columns
names(tweets)[1] <- "doc_id"

# Set the schema: docs
docs <- DataframeSource(tweets)

# Make a clean volatile corpus: text_corpus
text_corpus <- clean_corpus(VCorpus(docs))

# Examine the first doc content
content(text_corpus[[1]])

# Access the first doc metadata
meta(text_corpus[1])

#################################################################
### use case

# Print the structure of amzn
str(amzn)

# Create amzn_pros
amzn_pros <- amzn$pros

# Create amzn_cons
amzn_cons <- amzn$cons

# Print the structure of goog
str(goog)

# Create goog_pros
goog_pros <- goog$pros

# Create goog_cons
goog_cons <- goog$cons


#################################################################
# cleaning your corpora

# qdap_clean the text
qdap_cleaned_amzn_cons <- qdap_clean(amzn_cons)

# Source and create the corpus
amzn_c_corp <- VCorpus(VectorSource(qdap_cleaned_amzn_cons))

# tm_clean the corpus
amzn_cons_corp <- tm_clean(amzn_c_corp)

# qdap_clean the text
qdap_cleaned_goog_pros <- qdap_clean(goog_pros)

# Source and create the corpus
goog_p_corp <- VCorpus(VectorSource(qdap_cleaned_goog_pros))

# tm_clean the corpus
goog_pros_corp <- tm_clean(goog_p_corp)



# Create amzn_p_tdm
amzn_p_tdm <- TermDocumentMatrix(
  amzn_pros_corp,
  control = list(tokenize = tokenizer)
)

#################################################################
# index
library(qdap)

index <- final_df_out$index
cindex <- VCorpus(VectorSource(index))
cindex <- tm_map(cindex, removeWords, stopwords("english"))
doc <- TermDocumentMatrix(
  cindex
)

doc_m <- as.matrix(doc)
doc_f <- rowSums(doc_m)
wordcloud(names(doc_f), doc_f,max.words = 100, random.order=FALSE, rot.per=0.35,  colors=brewer.pal(8, "Dark2"))


# Create amzn_p_freq
amzn_p_freq <- rowSums(amzn_p_tdm_m)

# Plot a wordcloud using amzn_p_freq values
wordcloud(names(amzn_p_freq), amzn_p_freq, max.words = 25, color = "blue")


# Create amzn_c_tdm
amzn_c_tdm <- TermDocumentMatrix(
  amzn_cons_corp,
  control = list(tokenize = tokenizer)
)

# Create amzn_p_tdm_m
amzn_c_tdm_m <- as.matrix(amzn_c_tdm)

# Create amzn_p_freq
amzn_c_freq <- rowSums(amzn_c_tdm_m)

# Plot a wordcloud using amzn_p_freq values
wordcloud(names(amzn_c_freq), amzn_c_freq, max.words = 100,  colors=brewer.pal(8, "Dark2")))


#################################################################

# Create amzn_c_tdm
amzn_c_tdm <- TermDocumentMatrix(
  amzn_cons_corp,
  control = list(tokenize = tokenizer)
)

# Print amzn_c_tdm to the console
amzn_c_tdm

# Create amzn_c_tdm2 by removing sparse terms
amzn_c_tdm2 <- removeSparseTerms(amzn_c_tdm, sparse = .993)

# Create hc as a cluster of distance values
hc <-  hclust(dist(amzn_c_tdm2),
              method = "complete")

# Produce a plot of hc
plot(hc)


# Create amzn_p_tdm
amzn_p_tdm <- TermDocumentMatrix(
  amzn_pros_corp,
  control = list(tokenize = tokenizer)
)
#################################################################
# Create amzn_p_m
amzn_p_m <- as.matrix(amzn_p_tdm)

# Create amzn_p_freq
amzn_p_freq <- rowSums(amzn_p_m)

# Create term_frequency
term_frequency <- sort(amzn_p_freq, decreasing = TRUE)

# Print the 5 most common terms
term_frequency[1:5]

#################################################################
# Find associations with fast paced
findAssocs(amzn_p_tdm, "fast paced", 0.2)

# Create all_goog_corp
all_goog_corpus <- tm_clean(all_goog_corpus)

# Create all_tdm
all_tdm <- TermDocumentMatrix(all_goog_corpus)

# Create all_m
all_m <- as.matrix(all_tdm)

# Build a comparison cloud
comparison.cloud(all_m,
                 max.words = 100,
                 colors = c("#F44336", "#2196f3"))

# Extract top 5 common bigrams
(top5_df <- top_n(common_words, 5, diff))

# Create a pyramid plot
pyramid.plot(
  # Amazon on the left
  top5_df$AmazonNeg,
  # Google on the right
  top5_df$GoogleNeg,
  # Use terms for labels
  labels = top5_df$terms,
  # Set the gap to 12
  gap = 12,
  # Set top.labels to "Amzn", "Neg Words" & "Goog"
  top.labels = c("Amzn", "Neg Words", "Goog"),
  main = "Words in Common",
  unit = NULL
)

#################################################################
## Intro to NLP

# Tokenize animal farm's text_column column
tidy_animal_farm <- animal_farm %>%
  unnest_tokens(word, text_column)

# Print the word frequencies
tidy_animal_farm %>%
  count(word, sort = TRUE)

# Remove stop words, using stop_words from tidytext
tidy_animal_farm %>%
  anti_join(stop_words)

# Perform stemming on tidy_animal_farm
stemmed_animal_farm <- tidy_animal_farm %>%
  mutate(word = wordStem(word))

# Print the old word frequencies
tidy_animal_farm %>%›
count(word, sort = TRUE)

# Print the new word frequencies
stemmed_animal_farm %>%
  count(word, sort = TRUE)

plot(plot_AI)

#################################################################

sentiment_contributions %>%
  # Filter for Hamlet
  filter(title == "Hamlet, Prince of Denmark") %>%
  # Arrange to see the most negative words
  arrange(contribution)

sentiment_contributions %>%
  # Filter for The Merchant of Venice
  filter(title == "The Merchant of Venice") %>%
  # Arrange to see the most positive words
  arrange(desc(contribution))


#################################################################

tidy_shakespeare %>%
  # Implement sentiment analysis using "bing" lexicon
  inner_join(get_sentiments("bing")) %>%
  # Count using four arguments
  count(title, type, index = linenumber %/% 70, sentiment)


#################################################################

# calc net sentiments

# Load the tidyr package
library(tidyr)

tidy_shakespeare %>%
  inner_join(get_sentiments("bing")) %>%
  count(title, type, index = linenumber %/% 70, sentiment) %>%
  # Spread sentiment and n across multiple columns
  spread(sentiment, n, fill = 0) %>%
  # Use mutate to find net sentiment
  mutate(sentiment = positive-negative)


#################################################################

# Extract tweets on "Apple iphone" in French
tweets_french <- search_tweets("Apple iphone", lang = "fr")

# Display the tweets
head(tweets_french$text)

# Display the tweet metadata showing the language
head(tweets_french$lang)


#################################################################
# Calculate and store the golden ratio
counts_df$ratio <- counts_df$follower/counts_df$friend

# Sort the data frame in decreasing order of follower count
counts_sort <- arrange(counts_df, desc(follower))


# View the first few rows
head(counts_sort)

# Select rows where the follower count is greater than 50000
counts_sort[counts_sort$follower>50000,]

# Select rows where the follower count is less than 1000
counts_sort[counts_sort$follower<1000,]


#################################################################
# Examine the text data
# Examine the text data
text_df

# Calc overall polarity score
text_df %$% polarity(text)

# Calc polarity score by person
(datacamp_conversation <- text_df %$% polarity(text, person))

# Counts table from datacamp_conversation
counts(datacamp_conversation)

# Plot the conversation polarity
plot(datacamp_conversation)


#################################################################

# clean_corpus(), tm_define are pre-defined
clean_corpus
tm_define

# Create a VectorSource
tm_vector <- VectorSource(tm_define)

# Apply VCorpus
tm_corpus <- VCorpus(tm_vector)

# Examine the first document's contents
content(tm_corpus[[1]])

# Clean the text
tm_clean <- clean_corpus(tm_corpus)

# Reexamine the contents of the first doc
content(tm_clean[[1]])

#################################################################

# clean_corpus(), tm_define are pre-defined
clean_corpus
tm_define

# Create a VectorSource
tm_vector <- VectorSource(tm_define)

# Apply VCorpus
tm_corpus <- VCorpus(tm_vector)

# Examine the first document's contents
content(tm_corpus[[1]])

# Clean the text
tm_clean <- clean_corpus(tm_corpus)

# Reexamine the contents of the first doc
content(tm_clean[[1]])

#################################################################

# Common words comparison

library(tidyr)

text_df %>%
  unnest_tokens(word, `text$text`)

ggplot(Sentimentscores_twitter, aes(sentiment, Score)) +
  geom_col(show.legend = FALSE)
#

pride_prejudice <- tidy_books %>%
  filter(book == "Pride & Prejudice")

pride_prejudice

afinn <- pride_prejudice %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(index = linenumber %/% 80) %>%
  summarise(sentiment = sum(value)) %>%
  mutate(method = "AFINN")

bing_and_nrc <- bind_rows(pride_prejudice %>%
                            inner_join(get_sentiments("bing")) %>%
                            mutate(method = "Bing et al."),
                          pride_prejudice %>%
                            inner_join(get_sentiments("nrc") %>%
                                         filter(sentiment %in% c("positive",
                                                                 "negative"))) %>%
                            mutate(method = "NRC")) %>%
  count(method, index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

bind_rows(afinn,
          bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")

bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

bing_word_counts %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +


