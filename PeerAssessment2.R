library("plyr")
library("dplyr")
library("tm")
library("knitr")

data = read.csv("repdata-data-StormData.csv.bz2")
pdf <- readPDF(control = list(c(text = "-layout")))
pdf <- pdf(elem=list(uri="nws_i10_1605.pdf"),language="en")
keep = c(pdf$content[seq(397, 420)], pdf$content[seq(425, 448)])


freq  = count(data, 'EVTYPE')
freq = arrange(freq, desc(freq))
freq = freq[1:50,]
df = merge(data, freq, by = "EVTYPE")
df = filter(df, FATALITIES != 0 | PROPDMG != 0 | CROPDMG != 0)
grouping <- group_by(df, EVTYPE)
sumHealth = summarize(grouping,sumFat = sum(FATALITIES),
                      sumInj =  sum(INJURIES))
arrange(sumHealth, desc(sumFat))
knit("PeerAssessment2.rmd")
