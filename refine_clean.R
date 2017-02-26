library(dplyr)

library(tidyr)

refine_original <- read.csv("C:/Users/mathe/Downloads/refine_original.csv")


refine_original$company <- tolower(refine_original$company)

str(refine_original)

refine1 <-
  mutate(refine_original, company = substr(refine_original$company, 1 , stop = 1))

refine1$company <- gsub("^[p|f]", "philips", refine1$company)

refine1$company <- gsub("^[a]", "akzo", refine1$company)

refine1$company <- gsub("^[u]", "unilever", refine1$company)

refine1$company <- gsub("^[v]", "van houten", refine1$company)

refine1 <- select(refine1, -Company) 

refine1 <- separate(refine1, Product.code...number, c("product_code", "product_number"),
           sep = "-")

refine1 <- mutate(refine1, product_category = product_code)

refine1$product_category <-
  gsub("^[p]", "Smartphone", refine1$product_category)

refine1$product_category <-
  gsub("^[v]", "TV", refine1$product_category)

refine1$product_category <-
  gsub("^[x]", "Laptop", refine1$product_category)

refine1$product_category <-
  gsub("^[q]", "Tablet", refine1$product_category)

refine1 <-
  unite(refine1,
        full_address,
        address:country,
        sep = ",",
        remove = TRUE)

refine1 <-
  mutate(refine1, company_philips = ifelse(Company == "philips", 1, 0))

refine1 <-
  mutate(refine1, company_akzo = ifelse(Company == "akzo", 1, 0))

refine1 <-
  mutate(refine1, company_unilever = ifelse(Company == "unilever", 1, 0))

refine1 <-
  mutate(refine1, company_van_houten = ifelse(Company == "van houten", 1, 0))

refine1 <-
  mutate(refine1,
         product_smartphone = ifelse(product_category == "Smartphone", 1, 0))

refine1 <-
  mutate(refine1, product_laptop = ifelse(product_category == "Laptop", 1, 0))

refine1 <-
  mutate(refine1, product_tv = ifelse(product_category == "TV", 1, 0))

refine1 <-
  mutate(refine1, product_tablet = ifelse(product_category == "Tablet", 1, 0))

select(refine1, company, everything())

refine_clean <- refine1

write.csv(refine_clean, file = "refine_clean.csv")

refine_clean

