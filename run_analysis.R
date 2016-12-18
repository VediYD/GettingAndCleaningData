library(dplyr)
filename <- "getdata%2Fprojectfiles%2FUCI HAR Dataset.zip"
#Downloading the data-set if its absent from the working directory.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}
#Merging the data
x_dat<-data.frame()
y_dat<-data.frame()
subject_dat<-data.frame()
a=c("test","train")
for (j in a){
        FileNames<-list.files(paste("UCI HAR Dataset",j,sep="/"),pattern="*.txt",full.names=TRUE)
        FeatureDat<-read.table(paste("UCI HAR Dataset","features.txt",sep="/"))
        LabelDat<-read.table(paste("UCI HAR Dataset","activity_labels.txt",sep="/"),
                                   col.names=c("ActivityNumber","ActivityName"))
        for(i in FileNames[grepl("X",FileNames)]){
                tmp<-read.table(i,col.names=FeatureDat[,2])
                x_dat<-rbind(x_dat,tmp)
        }
        for(i in FileNames[grepl("y",FileNames)]){
                tmp<-read.table(i,col.names="ActivityNumber")
                y_dat<-rbind(y_dat,tmp)
        }
        for(i in FileNames[grepl("subject",FileNames)]){
                tmp<-read.table(i,col.names="SubjectNumber")
                subject_dat<-rbind(subject_dat,tmp)
        }
}
MergedData<-cbind(x_dat,y_dat,subject_dat)
#Using activity names to name the activities in the data set.
MergedDataAct<-merge(MergedData,LabelDat,by="ActivityNumber")
#Extracting only mean and standard deviation data from the data set.
MeanStdMergedDat<-select(MergedDataAct,grep("mean|std|ActivityName|SubjectNumber",colnames(MergedDataAct)))
#Creating a tidy data set with average values of each variable for each activity and each subject
AvgByActAndSub<-aggregate(x=MeanStdMergedDat,
                          FUN=mean,
                          by=list(ActivityName=MeanStdMergedDat$ActivityName,
                                  SubjectNumber=MeanStdMergedDat$SubjectNumber))[,1:80]
#writing a data into an independent file
write.table(AvgByActAndSub,file="Tidy.txt",row.name=FALSE)