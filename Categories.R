# ©Nikunj
library(qdapRegex)
data <- read.csv("product.csv")
uncatdata <- data[data$cat=="[\"uncategorised\"]",]
catdata <- data[data$cat!="[\"uncategorised\"]",]
categories <- rm_between(catdata$cat,extract = TRUE,"\"", "\"")
categories <- unique(unlist(categories))
cat.list <- as.list(categories)
missing <- which(data$cat=="[\"uncategorised\"]")

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

for(i in 1:length(cat.list))
  cat.list[i] <- strsplit(cat.list[[i]]," ")

for(i in 1: length(categories))
  cat.list[[categories[i]]]<- unique(cat.list[[categories[i]]])

for(i in 1: length(categories))
  cat.list[[categories[i]]]<- (cat.list[[categories[i]]][-1])


uncattitles.list <-list()
uncattitles <- as.character(uncatdata$name)
for(i in 1:length(uncattitles))
{
  uncattitles.list[i] <- strsplit(uncattitles[i]," ")
  
}



uncatpredindex <- list(length = length(uncattitles.list))
for(i in 1:length(uncattitles.list))
{   temp <- vector(length =length(cat.list))
for(j in 1:length(cat.list))
{
  temp[j] <-sum(uncattitles.list[[i]] %in% cat.list[[categories[j]]])
}
uncatpredindex[[i]] <- order(temp)[length(temp):(length(temp)-2)]
}

uncatfinal.list <- list(length = length(uncatpredindex))
for(i in 1:length(uncatpredindex)){
  uncatfinal.list[i] <- paste("*",paste(categories[uncatpredindex[[i]]],collapse = ","),"*")
  
}
data$cat <- as.character(data$cat)
for(i in 1:length(missing)){
  data$cat[missing[i]] <- as.character(uncatfinal.list[i])
}
data$cat <- as.factor(data$cat)
write.csv(data,"productV1.csv")

#this change is to check 'rpostback-askpass' github solution


