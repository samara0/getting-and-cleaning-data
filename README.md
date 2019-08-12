---
title: 'Human Activity Recognition - Tidy Summary Data'
output:
  html_document:
    keep_md: yes
  pdf_document: default
autor: samara0
---



## Acknowledgements

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

**This file describes what each part of the code does, gives the exact code, as well as the output of the code.**

## PART 1 
### Merging the training set and the test set to create one data set


```r
## We first create data frame with combined train data

## reading X_train data
Xtrain_df <- read.table(file='train/X_train.txt',header=F)

## check whether the data were correctly read
head(Xtrain_df[,1:6])
```

```
         V1          V2         V3         V4         V5         V6
1 0.2885845 -0.02029417 -0.1329051 -0.9952786 -0.9831106 -0.9135264
2 0.2784188 -0.01641057 -0.1235202 -0.9982453 -0.9753002 -0.9603220
3 0.2796531 -0.01946716 -0.1134617 -0.9953796 -0.9671870 -0.9789440
4 0.2791739 -0.02620065 -0.1232826 -0.9960915 -0.9834027 -0.9906751
5 0.2766288 -0.01656965 -0.1153619 -0.9981386 -0.9808173 -0.9904816
6 0.2771988 -0.01009785 -0.1051373 -0.9973350 -0.9904868 -0.9954200
```

```r
dim(Xtrain_df)
```

```
[1] 7352  561
```

```r
## reading y_train data
ytrain_df <- read.table(file='train/y_train.txt',header=F)

## check whether the data were correctly read
head(ytrain_df)
```

```
  V1
1  5
2  5
3  5
4  5
5  5
6  5
```

```r
dim(ytrain_df)
```

```
[1] 7352    1
```

```r
## reading subjects data
subjtrain_df <- read.table('train/subject_train.txt', header=F)

## check if the data were correctly read
head(subjtrain_df)
```

```
  V1
1  1
2  1
3  1
4  1
5  1
6  1
```

```r
dim(subjtrain_df)
```

```
[1] 7352    1
```

```r
## merging train data; as a first column, we take subject,
## followed by y_train (labels, i.e. the output of regression),
## followed by the 561 features (i.e X data)
train_df <- cbind(subjtrain_df, ytrain_df, Xtrain_df)

## check whether the data frame dftrain 
head(train_df[,1:6])
```

```
  V1 V1.1      V1.2          V2         V3         V4
1  1    5 0.2885845 -0.02029417 -0.1329051 -0.9952786
2  1    5 0.2784188 -0.01641057 -0.1235202 -0.9982453
3  1    5 0.2796531 -0.01946716 -0.1134617 -0.9953796
4  1    5 0.2791739 -0.02620065 -0.1232826 -0.9960915
5  1    5 0.2766288 -0.01656965 -0.1153619 -0.9981386
6  1    5 0.2771988 -0.01009785 -0.1051373 -0.9973350
```

```r
## reading features
feat = read.table(file='features.txt', header=F)

## checking whether features were read correctly
dim(feat)
```

```
[1] 561   2
```

```r
head(feat)
```

```
  V1                V2
1  1 tBodyAcc-mean()-X
2  2 tBodyAcc-mean()-Y
3  3 tBodyAcc-mean()-Z
4  4  tBodyAcc-std()-X
5  5  tBodyAcc-std()-Y
6  6  tBodyAcc-std()-Z
```

```r
str(feat[,2])
```

```
 Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...
```

```r
## assigning column names (subject, activity label and feature names)
names(train_df) <- c('subject','acty_label',as.character(feat[,2]))

## checking whether column names were correctly included
head(train_df[,1:6])
```

```
  subject acty_label tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1       1          5         0.2885845       -0.02029417        -0.1329051
2       1          5         0.2784188       -0.01641057        -0.1235202
3       1          5         0.2796531       -0.01946716        -0.1134617
4       1          5         0.2791739       -0.02620065        -0.1232826
5       1          5         0.2766288       -0.01656965        -0.1153619
6       1          5         0.2771988       -0.01009785        -0.1051373
  tBodyAcc-std()-X
1       -0.9952786
2       -0.9982453
3       -0.9953796
4       -0.9960915
5       -0.9981386
6       -0.9973350
```

```r
tail(train_df[,1:6])
```

```
     subject acty_label tBodyAcc-mean()-X tBodyAcc-mean()-Y
7347      30          2         0.2379665      -0.001087807
7348      30          2         0.2996653      -0.057193414
7349      30          2         0.2738527      -0.007749326
7350      30          2         0.2733874      -0.017010616
7351      30          2         0.2896542      -0.018843044
7352      30          2         0.3515035      -0.012423118
     tBodyAcc-mean()-Z tBodyAcc-std()-X
7347       -0.14832590       -0.2189488
7348       -0.18123302       -0.1953865
7349       -0.14746837       -0.2353085
7350       -0.04502183       -0.2182182
7351       -0.15828059       -0.2191394
7352       -0.20386717       -0.2692704
```

```r
dim(train_df)
```

```
[1] 7352  563
```

```r
## repeating the same thing but for test data_________________________________________

## reading X_test data
Xtest_df <- read.table(file='test/X_test.txt',header=F)

## check whether the data were correctly read
head(Xtest_df[,1:6])
```

```
         V1          V2          V3         V4         V5         V6
1 0.2571778 -0.02328523 -0.01465376 -0.9384040 -0.9200908 -0.6676833
2 0.2860267 -0.01316336 -0.11908252 -0.9754147 -0.9674579 -0.9449582
3 0.2754848 -0.02605042 -0.11815167 -0.9938190 -0.9699255 -0.9627480
4 0.2702982 -0.03261387 -0.11752018 -0.9947428 -0.9732676 -0.9670907
5 0.2748330 -0.02784779 -0.12952716 -0.9938525 -0.9674455 -0.9782950
6 0.2792199 -0.01862040 -0.11390197 -0.9944552 -0.9704169 -0.9653163
```

```r
dim(Xtest_df)
```

```
[1] 2947  561
```

```r
## reading y_test data
ytest_df <- read.table(file='test/y_test.txt',header=F)

## check whether the data were correctly read
head(ytest_df)
```

```
  V1
1  5
2  5
3  5
4  5
5  5
6  5
```

```r
dim(ytest_df)
```

```
[1] 2947    1
```

```r
## reading subjects data
subjtest_df <- read.table('test/subject_test.txt', header=F)

## check if the data were correctly read
head(subjtest_df)
```

```
  V1
1  2
2  2
3  2
4  2
5  2
6  2
```

```r
dim(subjtest_df)
```

```
[1] 2947    1
```

```r
## merging test data; as a first column, we take subject,
## followed by y_test (labels, i.e. the output of regression),
## followed by the 561 features (i.e X data)
test_df <- cbind(subjtest_df, ytest_df, Xtest_df)

## check whether the data frame dftest 
head(test_df[,1:6])
```

```
  V1 V1.1      V1.2          V2          V3         V4
1  2    5 0.2571778 -0.02328523 -0.01465376 -0.9384040
2  2    5 0.2860267 -0.01316336 -0.11908252 -0.9754147
3  2    5 0.2754848 -0.02605042 -0.11815167 -0.9938190
4  2    5 0.2702982 -0.03261387 -0.11752018 -0.9947428
5  2    5 0.2748330 -0.02784779 -0.12952716 -0.9938525
6  2    5 0.2792199 -0.01862040 -0.11390197 -0.9944552
```

```r
## reading features
feat = read.table(file='features.txt', header=F)

## checking whether features were read correctly
dim(feat)
```

```
[1] 561   2
```

```r
head(feat)
```

```
  V1                V2
1  1 tBodyAcc-mean()-X
2  2 tBodyAcc-mean()-Y
3  3 tBodyAcc-mean()-Z
4  4  tBodyAcc-std()-X
5  5  tBodyAcc-std()-Y
6  6  tBodyAcc-std()-Z
```

```r
str(feat[,2])
```

```
 Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...
```

```r
## assigning column names (subject, activity label and feature names)
names(test_df) <- c('subject','acty_label',as.character(feat[,2]))

## checking whether column names were correctly included
head(test_df[,1:6])
```

```
  subject acty_label tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1       2          5         0.2571778       -0.02328523       -0.01465376
2       2          5         0.2860267       -0.01316336       -0.11908252
3       2          5         0.2754848       -0.02605042       -0.11815167
4       2          5         0.2702982       -0.03261387       -0.11752018
5       2          5         0.2748330       -0.02784779       -0.12952716
6       2          5         0.2792199       -0.01862040       -0.11390197
  tBodyAcc-std()-X
1       -0.9384040
2       -0.9754147
3       -0.9938190
4       -0.9947428
5       -0.9938525
6       -0.9944552
```

```r
tail(test_df[,1:6])
```

```
     subject acty_label tBodyAcc-mean()-X tBodyAcc-mean()-Y
2942      24          2         0.1922746       -0.03364257
2943      24          2         0.3101546       -0.05339125
2944      24          2         0.3633846       -0.03921402
2945      24          2         0.3499661        0.03007744
2946      24          2         0.2375938        0.01846687
2947      24          2         0.1536272       -0.01843651
     tBodyAcc-mean()-Z tBodyAcc-std()-X
2942       -0.10594911       -0.3548408
2943       -0.09910872       -0.2878663
2944       -0.10591509       -0.3053880
2945       -0.11578796       -0.3296381
2946       -0.09649893       -0.3231143
2947       -0.13701846       -0.3300460
```

```r
dim(test_df)
```

```
[1] 2947  563
```

```r
## finally, we bind together train and test data into one data frame, called df

df <- rbind(train_df, test_df)
head(df[,1:6])
```

```
  subject acty_label tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1       1          5         0.2885845       -0.02029417        -0.1329051
2       1          5         0.2784188       -0.01641057        -0.1235202
3       1          5         0.2796531       -0.01946716        -0.1134617
4       1          5         0.2791739       -0.02620065        -0.1232826
5       1          5         0.2766288       -0.01656965        -0.1153619
6       1          5         0.2771988       -0.01009785        -0.1051373
  tBodyAcc-std()-X
1       -0.9952786
2       -0.9982453
3       -0.9953796
4       -0.9960915
5       -0.9981386
6       -0.9973350
```

```r
head(df[,560:dim(df)[2]])
```

```
  angle(tBodyGyroJerkMean,gravityMean) angle(X,gravityMean)
1                          -0.01844588           -0.8412468
2                           0.70351059           -0.8447876
3                           0.80852908           -0.8489335
4                          -0.48536645           -0.8486494
5                          -0.61597061           -0.8478653
6                          -0.36822404           -0.8496316
  angle(Y,gravityMean) angle(Z,gravityMean)
1            0.1799406          -0.05862692
2            0.1802889          -0.05431672
3            0.1806373          -0.04911782
4            0.1819348          -0.04766318
5            0.1851512          -0.04389225
6            0.1848225          -0.04212638
```

## PART 2 
### Extracting only mean and st. dev. measurements


```r
library(plyr)

feat <- names(df)
str(feat)
```

```
 chr [1:563] "subject" "acty_label" "tBodyAcc-mean()-X" ...
```

```r
whichcolumns <- c(1,2,grep("[Mm]ean|[Ss]td", feat))

newdf <- df[,whichcolumns]

dim(newdf)
```

```
[1] 10299    88
```

```r
head(newdf[,1:6])
```

```
  subject acty_label tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1       1          5         0.2885845       -0.02029417        -0.1329051
2       1          5         0.2784188       -0.01641057        -0.1235202
3       1          5         0.2796531       -0.01946716        -0.1134617
4       1          5         0.2791739       -0.02620065        -0.1232826
5       1          5         0.2766288       -0.01656965        -0.1153619
6       1          5         0.2771988       -0.01009785        -0.1051373
  tBodyAcc-std()-X
1       -0.9952786
2       -0.9982453
3       -0.9953796
4       -0.9960915
5       -0.9981386
6       -0.9973350
```

## PART 3 
### Naming the 5 activities into discriptive names:
 1="walk", 2="walk_upstairs", 3="walk_downstairs", 4="sit", 5="stand", 6="lay"


```r
library(plyr)  ##we use function revalue from 'plyr' for changing labels of activities
newdf$acty_label <- as.factor(newdf$acty_label)  ## converting acty_label into factors 
                                                 ## (needed for 'revalue' function to be applied)

newdf$acty_label <- revalue(newdf$acty_label, c("1"="walk", "2"="walk_upstairs", 
                                                "3"="walk_downstairs","4"="sit",
                                                "5"="stand","6"="lay"))
```
Checking whether everything is okay.

```r
names(newdf)
```

```
 [1] "subject"                             
 [2] "acty_label"                          
 [3] "tBodyAcc-mean()-X"                   
 [4] "tBodyAcc-mean()-Y"                   
 [5] "tBodyAcc-mean()-Z"                   
 [6] "tBodyAcc-std()-X"                    
 [7] "tBodyAcc-std()-Y"                    
 [8] "tBodyAcc-std()-Z"                    
 [9] "tGravityAcc-mean()-X"                
[10] "tGravityAcc-mean()-Y"                
[11] "tGravityAcc-mean()-Z"                
[12] "tGravityAcc-std()-X"                 
[13] "tGravityAcc-std()-Y"                 
[14] "tGravityAcc-std()-Z"                 
[15] "tBodyAccJerk-mean()-X"               
[16] "tBodyAccJerk-mean()-Y"               
[17] "tBodyAccJerk-mean()-Z"               
[18] "tBodyAccJerk-std()-X"                
[19] "tBodyAccJerk-std()-Y"                
[20] "tBodyAccJerk-std()-Z"                
[21] "tBodyGyro-mean()-X"                  
[22] "tBodyGyro-mean()-Y"                  
[23] "tBodyGyro-mean()-Z"                  
[24] "tBodyGyro-std()-X"                   
[25] "tBodyGyro-std()-Y"                   
[26] "tBodyGyro-std()-Z"                   
[27] "tBodyGyroJerk-mean()-X"              
[28] "tBodyGyroJerk-mean()-Y"              
[29] "tBodyGyroJerk-mean()-Z"              
[30] "tBodyGyroJerk-std()-X"               
[31] "tBodyGyroJerk-std()-Y"               
[32] "tBodyGyroJerk-std()-Z"               
[33] "tBodyAccMag-mean()"                  
[34] "tBodyAccMag-std()"                   
[35] "tGravityAccMag-mean()"               
[36] "tGravityAccMag-std()"                
[37] "tBodyAccJerkMag-mean()"              
[38] "tBodyAccJerkMag-std()"               
[39] "tBodyGyroMag-mean()"                 
[40] "tBodyGyroMag-std()"                  
[41] "tBodyGyroJerkMag-mean()"             
[42] "tBodyGyroJerkMag-std()"              
[43] "fBodyAcc-mean()-X"                   
[44] "fBodyAcc-mean()-Y"                   
[45] "fBodyAcc-mean()-Z"                   
[46] "fBodyAcc-std()-X"                    
[47] "fBodyAcc-std()-Y"                    
[48] "fBodyAcc-std()-Z"                    
[49] "fBodyAcc-meanFreq()-X"               
[50] "fBodyAcc-meanFreq()-Y"               
[51] "fBodyAcc-meanFreq()-Z"               
[52] "fBodyAccJerk-mean()-X"               
[53] "fBodyAccJerk-mean()-Y"               
[54] "fBodyAccJerk-mean()-Z"               
[55] "fBodyAccJerk-std()-X"                
[56] "fBodyAccJerk-std()-Y"                
[57] "fBodyAccJerk-std()-Z"                
[58] "fBodyAccJerk-meanFreq()-X"           
[59] "fBodyAccJerk-meanFreq()-Y"           
[60] "fBodyAccJerk-meanFreq()-Z"           
[61] "fBodyGyro-mean()-X"                  
[62] "fBodyGyro-mean()-Y"                  
[63] "fBodyGyro-mean()-Z"                  
[64] "fBodyGyro-std()-X"                   
[65] "fBodyGyro-std()-Y"                   
[66] "fBodyGyro-std()-Z"                   
[67] "fBodyGyro-meanFreq()-X"              
[68] "fBodyGyro-meanFreq()-Y"              
[69] "fBodyGyro-meanFreq()-Z"              
[70] "fBodyAccMag-mean()"                  
[71] "fBodyAccMag-std()"                   
[72] "fBodyAccMag-meanFreq()"              
[73] "fBodyBodyAccJerkMag-mean()"          
[74] "fBodyBodyAccJerkMag-std()"           
[75] "fBodyBodyAccJerkMag-meanFreq()"      
[76] "fBodyBodyGyroMag-mean()"             
[77] "fBodyBodyGyroMag-std()"              
[78] "fBodyBodyGyroMag-meanFreq()"         
[79] "fBodyBodyGyroJerkMag-mean()"         
[80] "fBodyBodyGyroJerkMag-std()"          
[81] "fBodyBodyGyroJerkMag-meanFreq()"     
[82] "angle(tBodyAccMean,gravity)"         
[83] "angle(tBodyAccJerkMean),gravityMean)"
[84] "angle(tBodyGyroMean,gravityMean)"    
[85] "angle(tBodyGyroJerkMean,gravityMean)"
[86] "angle(X,gravityMean)"                
[87] "angle(Y,gravityMean)"                
[88] "angle(Z,gravityMean)"                
```

## PART 4 
### Labeling the data set with discriptive variable names

 This was already done in the lines 42-50 of this code 
 using the 'feat' vector (see above, lines 42-50); we can
 only change 'acty_label' to 'activity'

```r
names(newdf)[2] <- 'activity'
```

## PART 5 
### Creating tidy data set with means per subject per activity


```r
library(dplyr)
```

```
Warning: package 'dplyr' was built under R version 3.5.3
```

```

Attaching package: 'dplyr'
```

```
The following objects are masked from 'package:plyr':

    arrange, count, desc, failwith, id, mutate, rename, summarise,
    summarize
```

```
The following objects are masked from 'package:stats':

    filter, lag
```

```
The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union
```

```r
newdf <- tbl_df(newdf)
tidydf <-  group_by(newdf, subject, activity) 

tidydf <- summarize_all(tidydf, mean)
head(tidydf[,1:7])
```

```
# A tibble: 6 x 7
# Groups:   subject [1]
  subject activity `tBodyAcc-mean(~ `tBodyAcc-mean(~ `tBodyAcc-mean(~
    <int> <fct>               <dbl>            <dbl>            <dbl>
1       1 walk                0.277         -0.0174           -0.111 
2       1 walk_up~            0.255         -0.0240           -0.0973
3       1 walk_do~            0.289         -0.00992          -0.108 
4       1 sit                 0.261         -0.00131          -0.105 
5       1 stand               0.279         -0.0161           -0.111 
6       1 lay                 0.222         -0.0405           -0.113 
# ... with 2 more variables: `tBodyAcc-std()-X` <dbl>,
#   `tBodyAcc-std()-Y` <dbl>
```

```r
dim(tidydf)
```

```
[1] 180  88
```

Finally, we save the data into 'tidy.csv' data set


```r
write.table(tidydf, file="tidy.txt", row.names=FALSE)
```


