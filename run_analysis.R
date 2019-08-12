

## PART 1  #######################################################
## Merging the training set and the test set to create one data set


## we first create data frame with combined train data_____________________________

## reading X_train data
Xtrain_df <- read.table(file='train/X_train.txt',header=F)

## check whether the data were correctly read
head(Xtrain_df[,1:6])
dim(Xtrain_df)

## reading y_train data
ytrain_df <- read.table(file='train/y_train.txt',header=F)

## check whether the data were correctly read
head(ytrain_df)
dim(ytrain_df)

## reading subjects data
subjtrain_df <- read.table('train/subject_train.txt', header=F)

## check if the data were correctly read
head(subjtrain_df)
dim(subjtrain_df)

## merging train data; as a first column, we take subject,
## followed by y_train (labels, i.e. the output of regression),
## followed by the 561 features (i.e X data)
train_df <- cbind(subjtrain_df, ytrain_df, Xtrain_df)

## check whether the data frame dftrain 
head(train_df[,1:6])

## reading features
feat = read.table(file='features.txt', header=F)

## checking whether features were read correctly
dim(feat)
head(feat)
str(feat[,2])

## assigning column names (subject, activity label and feature names)
names(train_df) <- c('subject','acty_label',as.character(feat[,2]))

## checking whether column names were correctly included
head(train_df[,1:6])
tail(train_df[,1:6])
dim(train_df)

## repeating the same thing but for test data_________________________________________

## reading X_test data
Xtest_df <- read.table(file='test/X_test.txt',header=F)

## check whether the data were correctly read
head(Xtest_df[,1:6])
dim(Xtest_df)

## reading y_test data
ytest_df <- read.table(file='test/y_test.txt',header=F)

## check whether the data were correctly read
head(ytest_df)
dim(ytest_df)

## reading subjects data
subjtest_df <- read.table('test/subject_test.txt', header=F)

## check if the data were correctly read
head(subjtest_df)
dim(subjtest_df)

## merging test data; as a first column, we take subject,
## followed by y_test (labels, i.e. the output of regression),
## followed by the 561 features (i.e X data)
test_df <- cbind(subjtest_df, ytest_df, Xtest_df)

## check whether the data frame dftest 
head(test_df[,1:6])

## reading features
feat = read.table(file='features.txt', header=F)

## checking whether features were read correctly
dim(feat)
head(feat)
str(feat[,2])

## assigning column names (subject, activity label and feature names)
names(test_df) <- c('subject','acty_label',as.character(feat[,2]))

## checking whether column names were correctly included
head(test_df[,1:6])
tail(test_df[,1:6])
dim(test_df)

## finally, we bind together train and test data into one data frame, called df

df <- rbind(train_df, test_df)
head(df[,1:6])
head(df[,560:dim(df)[2]])
str(df)


## PART 2 ########################################################################
## Extracting only mean and st. dev. measurements

library(plyr)

feat <- names(df)
str(feat)

whichcolumns <- c(1,2,grep("[Mm]ean|[Ss]td", feat))

newdf <- df[,whichcolumns]

dim(newdf)
head(newdf[,1:6])

## PART 3 ##################################################
## Naming the 5 activities into discriptive names:
## 1="walk", 2="walk_upstairs", 3="walk_downstairs", 4="sit", 5="stand", 6="lay"

library(plyr)  ##we use function revalue from 'plyr' for changing labels of activities
newdf$acty_label <- as.factor(newdf$acty_label)  ## converting acty_label into factors 
                                                 ## (needed for 'revalue' function to be applied)

newdf$acty_label <- revalue(newdf$acty_label, c("1"="walk", "2"="walk_upstairs", 
                                                "3"="walk_downstairs","4"="sit",
                                                "5"="stand","6"="lay"))
names(newdf)

## PART 4 ##################################################
## Labeling the data set with discriptive variable names

## This was already done in the lines 42-50 of this code 
## using the 'feat' vector (see above, lines 42-50); we can
## only change 'acty_label' to 'activity'

names(newdf)[2] <- 'activity'

## PART 5 ##################################################
## Creating tidy data set with means per subject per activity

library(dplyr)

newdf <- tbl_df(newdf)
tidydf <-  group_by(newdf, subject, activity) 

tidydf <- summarize_all(tidydf, mean)
head(tidydf[,1:7])
dim(tidydf)


## saving the data into 'tidy.csv' data set
write.table(tidydf, file="tidy.txt", row.names=FALSE)

