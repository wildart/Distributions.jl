# Writing a Better Multinomial Sampler

# Sequential Binomial Sampling
Linear

# Condensed Table

# Alias Table

# Mixed Sequential Binomial Sampling + Alias Table


Graph of R's performance
Graph of our performance

b <- Sys.time(); s <- rmultinom(1000000 / 2, 1, rep(1 / 10, 10)); e <- Sys.time(); e - b
b <- Sys.time(); s <- rmultinom(1000000, 1, rep(1 / 10, 10)); e <- Sys.time(); e - b
b <- Sys.time(); s <- rmultinom(1000000 * 2, 1, rep(1 / 10, 10)); e <- Sys.time(); e - b

rand(Multinomial(1, 10), 1000000)
rand(Multinomial(1000000, 10), 1)

b <- Sys.time(); s <- rmultinom(10000 / 2, 1, rep(1 / 1000, 1000)); e <- Sys.time(); e - b
b <- Sys.time(); s <- rmultinom(10000, 1, rep(1 / 1000, 1000)); e <- Sys.time(); e - b
b <- Sys.time(); s <- rmultinom(10000 * 2, 1, rep(1 / 1000, 1000)); e <- Sys.time(); e - b

b <- Sys.time(); s <- rmultinom(100 / 2, 1, rep(1 / 100000, 100000)); e <- Sys.time(); e - b
b <- Sys.time(); s <- rmultinom(100, 1, rep(1 / 100000, 100000)); e <- Sys.time(); e - b
b <- Sys.time(); s <- rmultinom(100 * 2, 1, rep(1 / 100000, 100000)); e <- Sys.time(); e - b
