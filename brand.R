library(tidyr)
library(dplyr)
library(readr)

fashion <- read_delim("fashion_utter.txt", "\t", col_names = c("freq", "lemma"))
tech <- read_delim("tech_utter.txt", "\t", col_names = c("freq", "lemma"))

brands <- full_join(fashion, tech, by = "lemma") %>%
  select(lemma, fashion = freq.x, tech = freq.y)
brands

brands[is.na(brands)] <- 0

brands <- brands %>%
  mutate(rel_fash = fashion / sum(fashion), rel_tech = tech / sum(tech)) %>%
  mutate(diff = rel_fash - rel_tech) %>%
  arrange(desc(diff))
print(brands, n = 100)
tail(brands)
