############################
# Writing R packages
# Tiago Ventura
# GSA Methods Workshop
# March 26
#############################

#------------------------------------------------------------------------#
#
# Review of Functions in R
#
#
#------------------------------------------------------------------------#


### Why should I learn how to write functions??
#     
#     
#   Avoid unnecessary repetitions in the same code
#   
#   Avoid being always tweaking small components of your codes. 
#   
#   Avoid to make mistakes with copy and pastes from one code to another
#   
#   To share you knowledge with your colleagues. Build you name 
#   
#   To save time for your theoretical questions instead  of speeding time repeating your code. 
  

#Let's Code

library(tidyverse)



#Function Fundamentals
#==========================================================


my_func <- function(arg1, arg2) {
out



### Our first function


mean_bytiago  <- function(x){
out <- sum(x)/length(x)
out
}



### Using our function


mean_bytiago(rnorm(1000, 0, 1))


#The arguments

formals(mean_bytiago)


#The body

body(mean_bytiago)



#Where the function is saved

environment(mean_bytiago)

#Functions Components. Ex. two


library(BayesTwin) # Package for Bayesian stats

formals(HPD)

body(HPD)


environment(HPD)

#From your code to a function

#Simple Reescale function

# Creating a fake data

norm <- rnorm(1000, 0, 1); unif <- runif(1000, 0, 10)

df <- data.frame(cbind(norm, unif))

# Simple Reescale Function

df$norm_0_1 <- (df$norm - min(df$norm, na.rm = TRUE)) /  
(max(df$norm, na.rm = TRUE) - min(df$norm, na.rm = TRUE))

# Plot Norm
df %>% ggplot(., aes(x=norm)) + geom_density()

# PloT rescaled
df %>% ggplot(., aes(x=norm_0_1)) + geom_density()


# The workflow for writing functions
# ========================================
#   
# - Find the inputs
# 
#       + Only one: df$norm
# 
# -  Find the outputs
# 
#       + Only one: the scaled value
# 
# - Make it more efficient
# 
#       + max(df$norm, na.rm = TRUE) - min(df$norm, na.rm = TRUE) = range()
# 


rescale_bytiago <- function(x){ # one input
  rng <- range(x) # More efficient
  (x - rng[1])/(rng[2] - rng[1])
}


#------------------------------------------------------------#
#Loops and Conditional Statements
#------------------------------------------------------------#

## If Statement

  if(condition){expr}


x<-5
if(x>0){
  print("x is a positive number")
}

## Else

#The if conditional, but adding a default condition.


if(conditon){
  expr} else{
    expr}

##**The else must be in the same line of the bracket**##

x<-5
if(x<0){
  print("x is negative")
} else{ print("x is positive")}


#### Else if

  if(conditon){
    expr} else if (condition2) {
      expr} else{expr default}



if(x>0){
  print("x is negative")
}else if(x==0) {
  print("x is zero")
} else{print("x is positive")}


####For Loop

  for(var in seq){
    exp}

cities <- c("Belem", "Rio de janeiro", "Brasilia", "DC", "College Park" )

for(i in 1:length(cities)){
  print(cities[i])
}
```


#My workflow for For loops

## 1. Create a Container

rescaled.df <- c(NULL)

## 2. Make it iteratable

i <- ncol(df) # A check to see if it is working

## 3. Write the loop

for( i in 1:ncol(df)){
  out <- rescale(df[,i])
  rescaled.df <- cbind(rescaled.df, out)
  print(i)
}



#------------------------------------------------------------------------#
#
# Packages  in R
#
#
#------------------------------------------------------------------------#


######
# Let's Start
######

# Packages we will need

#install.packages("devtools")
library(devtools)
#install.packages("roxygen2")
library(roxygen2)
#install.packages("testthat")
library(testthat)


#######
# Suggested Workflow
#######

#**First Step** Go to github, and create a repository for your package

#**Second Step** Create a new project, with version control in Rstudio, already integrated with your github repository

#**Third Step** Create your packages using devtools::create()

#**Fourth** Write the functions for your package

#**Fifth** Document your packages with roxygeon::document()

#**Fifth** Test and Share it with your colleagues!!
  

#####
# Creating the Package
######

create("UMDWorkshop") # I Prefer to do it using point and click

# A New folder for your project has been created. Go there, and open the R.Project.

# One can also do the same using point and click => file ~ new project ~ new package

#####
# Creating the function
######


# Write a function and the documentation. Save it in the R folder

# These tags are called roxygen document tags.

# To write the documentation you should use #'

#' @param: Parameter/argument name and description.

#' @return: What is output from the function. In this case, a data frame.

#' @export: Whether to send this function to the NAMESPACE.

#' @examples: Usually good to give an example of how your function is used.


#############
# Writing the documentation
#############

# After you are done writing your functions,
# you should call the function below
# to create your .Rd file.

document() # or

ctrl+alt+shift+r # keyboard shortcut



###### How to call other packages to your functions?

#' @import or
#' @importFrom package:function


####
# Testing and Checking your package
#####

use_testthat(".\\UMDWorkshop") # to create a folder to perform tests on your package

#Then you can write tests in the new folder tests to check your package.

devtools::test(".\\UMDWorkshop")  # To apply your tests

# Finaly, before sharing one shoudl check if the package is working in a basic computer.

devtools::check(".\\UMDWorkshop")


######
#Installing and calling your package from your computer.
#######

#From your computer
devtools::install("./UMDWorkshop")
library("UMDWorkshop")

#From Github
devtools::install_github("TiagoVentura/UMDWorkshop")
library(UMDWorkshop)

# Of course, before you download from github, 
# you need to commit and push all your changes


# CONGRATS! You have just written your first R package!

