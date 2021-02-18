library(topicmodels)

##########################################
install.packages("lda")
library(lda)
library(topicmodels)
library(tidytext)
# lda

ap_lda <- LDA(m, k = 6, control = list(seed = 1234))
terms <- Terms(m)

tidy_terms <- tidy(tf_dtm)

m <- as.matrix(tf_dtm)
m[m==0] <- 0.001

doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(corpus)))
dtm <- DocumentTermMatrix(corpus[doc.lengths > 0])

#########################################################################################################


doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(ctweets)))
dtm <- DocumentTermMatrix(ctweets[doc.lengths > 0])
SEED = sample(1:1000000, 1)

LDA_employ <- LDA(dtm, k =5,method = "VEM", cotrol = list(seed=1234))
employ_topics <- tidy(LDA_employ, matrix ="beta")

ap_top_terms <- employ_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  scale_x_reordered()

library(tidyr)

beta_spread <- employ_topics %>%
  mutate(topic = paste0("topic", topic)) %>%
  spread(topic, beta) %>%
  filter(topic1 > .001 | topic2 > .001) %>%
  mutate(log_ratio = log2(topic2 / topic1))


ap_documents <- tidy(LDA_employ, matrix = "gamma")
ap_documents

tidy(dtm) %>%
  filter(document == 5) %>%
  arrange(desc(count))

#########################################################################################################

# Generate the document-term matrix
dtm <- ctweets %>%
  unnest_tokens(input=text, output=word) %>%
  count(id, word) %>%
  cast_dtm(document=id, term=word, value=n)

# Run the LDA for two topics
mod <- LDA(x=dtm, k=2, method="Gibbs",control=list(alpha=1, delta=0.1, seed=10005))

# Retrieve the probabilities of word `will` belonging to topics 1 and 2
tidy(mod, matrix="beta") %>%
  filter(term == "will")

# Make a stacked column chart showing the probabilities of documents belonging to topics
tidy(mod, matrix="gamma") %>%
  mutate(topic = as.factor(topic)) %>%
  ggplot(aes(x=document, y=gamma)) +
  geom_col(aes(fill=topic))

