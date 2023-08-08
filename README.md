# Tick-Level-Trade-Analysis-and-Trade-Direction-Classification
In this completed project, tick-level trading data was analyzed using R programming. The provided dataset, "sampleTQdata.RData," containing trading data for a single day from 09:30 am to 4:00 pm, was used to accomplish the following:

1. The dataset was loaded and explored, leading to the following outcomes:

i) The total number of trades in the dataset was determined.

ii) Trade prices (pt), best-bid (bt), and best-ask (at) prices were plotted for the entire dataset.

iii) Similar plots were generated for trades with counts falling within the range of 100 to 200.

2. The number of trades within the spread (pt ∈ (bt, at)) and at the touch (pt = bt or pt = at) were counted separately. The sum of these counts was compared to the total trade count from task 1.i to validate the accuracy.

3. Two methods were used to determine the "trade direction" (dt) of each trade (buy or sell):

i) Tick test: Utilizing trade prices (pt) only to identify upticks, downticks, and zero-upticks/downticks.

ii) Lee-Ready rule: Incorporating both trade prices (pt) and quotes (at, bt), and comparing them to the mid-price (mt).

The implementation of the Lee-Ready rule was verified against the provided "getTradeDirection" function. Furthermore, the results obtained from both methods for determining trade direction were compared, and the fraction of trades classified identically under both tests was calculated.

This project offers a practical understanding of working with tick-level trading data and applying diverse methods to ascertain trade direction, encompassing tick tests and the Lee-Ready rule.
