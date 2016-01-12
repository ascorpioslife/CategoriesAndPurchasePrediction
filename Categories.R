library(qdapRegex)
data <- read.csv("product.csv")
uncatdata <- data[data$cat=="[\"uncategorised\"]",]
catdata <- data[data$cat!="[\"uncategorised\"]",]
categories <- rm_between(catdata$cat,extract = TRUE,"\"", "\"")
categories <- unique(unlist(categories))
cat.list <- as.list(categories)

for(i in 1:length(categories))
{
    word <- categories[i]
    for(j in 1:nrow(catdata))
    { 
      if(length(grep(word,catdata[j,4])))
      {
        cat.list[word]=paste(cat.list[word],catdata[j,2])
      }
      
    }
}



