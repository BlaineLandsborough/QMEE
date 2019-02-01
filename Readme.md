Week 4:
 1) What is the probability that a randomly-selected person, who tested positive for the disease, actually has the disease?

The probability that this person has MMV is 0.17.

Work shown:
Pre-test probability: 0.01
Sensitivity: 1
Specificity: 0.95
LR+ = 1/(1-0.95) = 20
Pre-test odds: 0.01 / (1-0.01) = 0.0101
Post-test odds: 0.0101 x 20 = 0.202
Post-test probability: 0.202/(1 + 0.202) = 0.16806 

2) You learn that your friend has a positive rapid test for MMV. What do you tell them?

First, I need additional information before I can tell them anything informative. Specifically, I need to know whether my friend was tested randomly or selected for a certain reason (e.g. symptoms or exposure). Further, how prevalent is the disease in our population.
Assuming that my friend was both tested randomly and belongs to a population with a similarly low prevalence of the disease (1%), I would explain to him that, when a likelihood ratio is used to consider all of the available evidence (e.g. prevalence, specificity, and sensitivity), there is a substantial probability that he does not actually have the disease. Even though the test results were positive, the extremely low prevalence of the disease in the population along with the known probability of false-positive results will drastically lower the post-test probability of having the disease.


Week 3:

The first is a scatterplot of the mass of Pukeko nestlings that were caught both at 0-1 days and >=10 days of age. The plot shows the mass (grams) of nestlings on the y-axis and ages (days) on the x-axis. The plot is meant to give a simple visualization of the size of nestlings (using only mass) by age with the colour representing treatment type. However, this first plot has clusters of data points that make it difficult to interpret. The second plot is a series line graph of the same to visualize the mass of nestlings by age but separated by nest for easier comparison of change in mass between treatment types. This provides some insight into the difference in mass by age allowing to infer differences in growth rate between nests and treatment types. It also makes it easier to digest and interpret the data points while looking for outliers or abnormalities. Obviously, all these plots ignore a number of random and non-random effects (e.g. clutch size, hatch order, calendar date, etc.). I also plotted the change in mass over time for two chicks, one per treatment type. Both chicks selected were the most frequently captured for each treatment type. These plots should be the easiest method to interpret these data as it is comparing position along common scales. Scatterplots are one of the simplest plot methods and may be helpful in identifying clusters of data points and potential outliers.
The histogram shows the number of nestlings caught at each age. The colour proportion of each bar represents the treatment type (experimental or control) assigned to the nest that the nestling originated from. This plot simply is to visualize how many nestlings were caught at specific ages for each treatment type. For example, the majority of chicks were caught 0-5 days of age. This is not unexpected considering chick mortality and that chicks become mobile within a day of hatching.
The boxplot shows the mean mass of Pukeko nestlings by treatment at day of hatching as an easy and simple way to visualize nestling mass at 0-1 days of age for both treatment types. Both plots show standard deviation. Zero days of ages was selected because it is the first observation for most chicks, and it may help to inform whether there is a difference in mass at hatching between treatment types. 






Week 2:

These data are measurements of Pukeko nestlings from a number of nests of two treatment types (Experimental and control). Pukeko are precocial and able to leave the nest within a day. As a result, the number of observations for nestlings are variable in frequency and time between last observation. To test the prediction that more synchronous clutches should benefit from higher inclusive fitness, I manipulated joint-female nests, through cross-fostering of eggs, to create broods with exaggerated asynchronous hatching (Experimental treatment). I also manipulated nine joint-laid nests where I cross-fostered eggs between nests while maintaining a natural degree of hatching synchrony (Control treatment). I will use these measurements to compare nestling growth between treatments. 
Question:
Do nestlings produced by synchronous nests grow faster and survival better than nestlings from asynchronous nests?

-Need to determine how many chicks were caught and measured multiple times? How many days between first and last capture?
-Then separate out chicks that were recaught 10-60 days after the original capture date and move these observations into a new dataframe.
-
-Assess whether treatment type affects offspring growth within the first 60 days after hatching using Linear mixed-effects models.


**This is only a partial dataset, as I am still compiling observations from fieldbooks for the 2018 field season. Upon plotting out my variables using pairs(), I recognize that I need to add in more observations of nestlings when older.
