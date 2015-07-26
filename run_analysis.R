setwd("/Users/albertorivera/Downloads/R_stuff/")
library(reshape2)
projUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(projUrl,destfile="projfiles.zip",method="curl")
unzip("projfiles.zip")
setwd("UCI Har Dataset")
wanted_cols<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:272,345:350,424:429,503:504,516:517,529:530,542:543,556:561)


xtrain<-read.table("train/X_train.txt")

ytrain<-read.table("train/Y_train.txt")
subtrain<-read.table("train/subject_train.txt")

xtest<-read.table("test/X_test.txt")

ytest<-read.table("test/Y_test.txt")
subtest<-read.table("test/subject_test.txt")
names(subtrain)<-names(subtest)<-"Subject"
names(ytrain)<-names(ytest)<-"Activity"
features<-read.table("features.txt")
colnames(xtest)<-colnames(xtrain)<-features[,2]

xtrain<-xtrain[,wanted_cols]
xtest<-xtest[,wanted_cols]

Utrain<-cbind(xtrain,ytrain,subtrain)
Utest<-cbind(xtest,ytest,subtest)


Utrain<-split(Utrain,ytrain)
names(Utrain)<-c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying")

NUTrain<-data.frame()
for(i in seq_along(Utrain)){
  Utrain[[i]]$Activity<-names(Utrain[i])
  NUTrain<-rbind(NUTrain,Utrain[[i]])
}

Utest<-split(Utest,ytest)
names(Utest)<-c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying")

NUTest<-data.frame()
for(j in seq_along(Utest)){
  Utest[[j]]$Activity<-names(Utest[j])
  NUTest<-rbind(NUTest,Utest[[j]])
}

together<-rbind(NUTrain,NUTest)
together<-together[order(together$Subject),] #This is the data set as of step 4.

split1<-split(together,together$Subject)
split2<-sapply(split1,function(x){split(x,x$Activity)})
tidy<-data.frame()
for(k in seq_along(split2)){
  use<-colMeans(split2[[k]][,1:73])
  tidy<-rbind(tidy,use)
  names(tidy)<-names(split2[[k]])[1:73]
}
end_tidy<-data.frame()
for(p in seq_along(split2)){
  take<-split2[[p]][1,74:75]
  end_tidy<-rbind(end_tidy,take)
}

tidy<-cbind(tidy,end_tidy)  #Final Tidy Dataset

write.table(tidy,"tidy_proj.txt",row.names=FALSE)


