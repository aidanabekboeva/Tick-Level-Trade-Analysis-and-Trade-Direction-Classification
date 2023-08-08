library(xts)
library(highfrequency)

#   load data set
options(digits.secs=3)

load("sampleTQdata.RData")

# loads a file called tqdata

Sys.setenv(TZ='GMT') # added to remove warnings about time zone mismatch

head(tqdata)
tail(tqdata)

n.trades <- length(tqdata$PRICE) 
n.trades

plot(as.numeric(tqdata$PRICE), main="Prices pt", ylab = "Pt")
plot(as.numeric(tqdata$BID), main="Best-bid", ylab = "Bt")
plot(as.numeric(tqdata$OFR), main="Best-ask", ylab = "At")

newdata <- (subset(tqdata[100:200, ]))
plot(as.numeric(newdata$PRICE), main="Prices pt 100:200", ylab = "Prices")
plot(as.numeric(newdata$BID), main="Best-bids bt 100:200", ylab = "Bt")
plot(as.numeric(newdata$OFR), main="Best-asks at 100:200", ylab = "At")

#####################################################

# 2. Count how many trades take place: i) within the spread, ii) at bid, iii) at ask

results = list("p_within" = 0, "b" = 0, "a" = 0, "p_outside" = 0)
b = tqdata[ , 3]
a = tqdata[ , 5]
p = tqdata[ , 8]

for (i in 1:8153){
    if(p[i]>b[i] & p[i]<a[i]){
      results$p_within <- results$p_within + 1 
    } else if(p[i]==b[i]){
      results$b <- results$b + 1
    } else if (p[i]==a[i]){
      results$a <- results$a + 1
    } else {
      results$p_outside <- results$p_outside + 1
    }
}

results
results$p_within + results$b + results$a + results$p_outside

#3. Trade directions  
#i) Tick test.
data <- tqdata[ , 8]
summary(data)
data$PREVIOUS <- c(NA, data[1:8152])

tk <- c("-1", NA, "+1")[sign(as.numeric(data$PRICE)-as.numeric(data$PREVIOUS))+2]
for(i in 2:length(tk)) if (is.na(tk[i])) tk[i] <- tk[i-1]

data$TICK <- tk
head(data)

#3. ii) Lee-Ready test.library(highfrequency)
#First method

data1 <- tqdata[ , 8]
summary(data1)
data1$PREVIOUS <- c(NA, data1[1:8152])
data1$MIDPOINTS <- (as.numeric(tqdata$BID) + as.numeric(tqdata$OFR))/2

d <- list()

for (i in 1:8153){
  if(data1$PRICE[i] > data1$MIDPOINTS[i]){
    d <- append(d, "1")  
  } else if(data1$PRICE[i] < data1$MIDPOINTS[i]){
    d <- append(d, "-1") 
  } else if (data1$PRICE[i] == data1$MIDPOINTS[i]){
    d <- append(d, data$TICK[i])
  } 
}

data1$TICK <- d

head(data1)

#Second method
directions <- getTradeDirection(tqdata)
View(directions)

comparing <- as.data.frame(directions)
comparing$d <- d

ifelse(comparing$directions == comparing$d, comparing$RESULT <- TRUE, comparing$RESULT <- FALSE)
head(comparing)
sum(comparing$RESULT)

