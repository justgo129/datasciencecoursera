# Peer-graded Assignment: Getting and Cleaning Data Course Project
# Filename: run_analysis.R 

  ## Load libraries:
  library(stringr)

  ## read files into R

  X_train<-read.table("X_train.txt", sep="")
  X_test<-read.table("X_test.txt", sep="")
  Y_train<-read.table("y_train.txt", sep="")
  Y_test<-read.table("y_test.txt", sep="")

  #Step 1: combine train and test data
  X<-rbind(X_train, X_test)
  Y<-rbind(Y_train, Y_test)
  
  ## Step 3 : Prep for Step #2
  ## tidy and read column headings into R:  (Assignments Steps 3 and 4 as 
   ## Intermediate Steps)
  features<-read.table("features.txt", sep="")
  features<-features[,2]
  features<-gsub("mean()", "Mean", features)
  features<-gsub("std()", "StandardDeviation", features)
  features<-gsub("mad()", "MedianAbsoluteDerivation", features)
  features<-gsub("max()", "Maximum", features)
  features<-gsub("min()", "Minimum", features)
  features<-gsub("sma()", "SignalMagnitudeArea", features)
  features<-gsub("energy()", "EnergyMeasure", features)
  features<-gsub("iqr()", "InterquartileRange", features)
  features<-gsub("entropy()", "SignalEntropy", features)
  features<-gsub("arCoeff()", "AutoregressionCoefficients", features)
  features<-gsub("correlation()", "Correlation", features)
  features<-gsub("maxInds()", "IndexofFrequencyComponentwithLargestMagnitude", features)
  features<-gsub("meanFreq()", "WeightedAverageofFrequencyComponents", features)
  features<-gsub("skewness()", "FrequencyDomainSignalSkewness", features) 
  features<-gsub("kurtosis()", "FrequencyDomainSignalKurtosis", features) 
  features<-gsub("bandsEnergy()", "EnergyofFrequencyIntervalWithin64FastFourierTransformBins", features)
  features<-gsub("angle()","AngleBetweenTwoVectors", features)
  features<-gsub("^f", "FastFourierTransform", features)
  features<-gsub("^t", "Time", features)
  features<-gsub("$-XYZ", "ThreeDimensions", features)
  features<-gsub("BodyAcc", "BodyAcceleration", features)
  features<-gsub("GravityAcc", "GravityAccelerationSignal", features)
  features<-gsub("BodyAccJerk", "JerkSignalsfromBodyLinearAcceleration", features)
  features<-gsub("gravityMean", "MeanGravity", features)
  features<-gsub("$()-X", "X-direction", features)
  features<-gsub("$()-Y", "Y-direction", features)
  features<-gsub("$()-Z", "Z-Direction", features)
  features<-gsub("tBodyAccJerk-XYZ", "DurationofJerkSignalsBodyLinearAcceleration", features)
  features<-gsub("tBodyGyroJerk-XYZ", "DurationofJerkSignalsAngularVelocity", features)
  features<-gsub("$XYZ", "inXYandZDimensions", features)  
  features<-gsub("\\()", "", features)
  features<-gsub("\\,", "", features) 
  features<-gsub("\\(*)","*" ,features)
  features<-gsub("\\-", "", features)
  features<-gsub("\\.", "", features)
  features<-gsub("_", "", features)
  
  features<-str_trim(features, side = c("left"))
  features<-str_trim(features, side = c("right"))
  colnames(X)<-features
  
  ## tidy and read row headings into R: X data frame (rows)
  
  subject_train<-read.table("subject_train.txt", sep="\n")
  subject_test<-read.table("subject_test.txt", sep="\n")
  subjects<-rbind(subject_train, subject_test)
  subjects<-c("Subject", rownames(X))
  
  colnames(Y, "Number")
  rownames(Y, "Subject")
  
  ## Step #2: Compute Statistics for X and Y: Per Activity

  XmeanperActivity<-apply(X, 2, mean)
  XstandardDeviationperActivity<-apply(X,2, sd)
  YMeanperActivity<-apply(Y, 2, mean)
  YstandardDeviationperActivity<-apply(Y,2,sd)
  
  ## Step #4: Compute Mean for X and Y: Per Subject
  
  XMeanperSubject<-apply(X, 1, mean)
  YMeanperSubject<-apply(Y, 1, mean)
  
  Means<-c(XmeanperActivity, XMeanperSubject, YMeanperActivity, YMeanperSubject)
  write.table(Means, file = "Means.csv", sep=",", col.names = 1)
