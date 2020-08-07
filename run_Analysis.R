library(dplyr)

# reads train data
x_trn <- read.table("./train/X_train.txt")
y_trn <- read.table("./train/Y_train.txt")
sub_tn <- read.table("./subject_train.txt")

# reads test data
x_tst <- read.table("./test/X_test.txt")
y_tst <- read.table("./test/Y_test.txt")
sub_tst <- read.table("./subject_test.txt")

# reads data features
var_nam <- read.table("./features.txt")

# reads activity labels
act_lbl <- read.table("./activity_labels.txt")

# merges x_trn,x_tst 
x_merge <- rbind(x_trn, x_tst)
# merges y_trn,y_tst
x_merge <- rbind(y_trn, y_tst)
# merges sub_trn,sub_tst
sub_merge <- rbind(sub_trn, sub_tst)

# selects variable names containing either mean() or std()
var <- var_nam[grep("mean\\(\\)|std\\(\\)",var_nam[,2]),]
# extracts the data with selected variable names
x_merge <- x_merge[,var[,1]]

# makes a new column with factorised activity labels
y_merge$activitylabel <- factor(y_merge[,1],levels = act_lbl[,1], as.character(act_lbl[,2]))
# assigning the column to an object
activitylabels <- y_merge[,2]

# describing the attributes of x_merge dataset
colnames(x_merge) <- var_nam[var[,1],2]

# merging to form the total data
data1 <- cbind(x_merge, activitylabels, sub_merge)
data1_grp <-group_by(data1,activitylabel, sub_merge[,1]) 
tidy_data1 <- summarize_all(data1_grp,mean)
write.table(tidy_data1, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE)