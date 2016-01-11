library(qdapRegex)
data <- read.csv("product.csv")
uncatdata <- data[data$cat=="[\"uncategorised\"]",]
catdata <- data[data$cat!="[\"uncategorised\"]",]
categories <- rm_between(catdata$cat,extract = TRUE,"\"", "\"")
categories <- unique(unlist(categories))
cat.list <- as.list(categories)


