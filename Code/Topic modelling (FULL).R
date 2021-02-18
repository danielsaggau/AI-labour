



doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(ctweets)))
dtm <- DocumentTermMatrix(ctweets[doc.lengths > 0])
SEED = sample(1:1000000, 1)
k = 3

models <- list(
  CTM       = CTM(dtm, k = k, control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3))),
  VEM       = LDA(dtm, k = k, control = list(seed = SEED)),
  VEM_Fixed = LDA(dtm, k = k, control = list(estimate.alpha = FALSE, seed = SEED)),
  Gibbs     = LDA(dtm, k = k, method = "Gibbs", control = list(seed = SEED, burnin = 1000,
                                                               thin = 100,    iter = 1000))
)

lapply(models, terms, 10)


