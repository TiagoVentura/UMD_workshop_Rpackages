Writing your packages in R
========================================================
author: Tiago Ventura 
date: GVPT - UMD
font-import: http://fonts.googleapis.com/css?family=Garamond
font-family: 'Garamond'
autosize: true</code>

March 26

<style>

<style>

/* Altering the Title Slides */
.reveal body {
  background: #EDE0CF;
}

/* slide titles */
.reveal h3 { 
  font-size: 60px;
  color: #666699;
}

/* subheader titles */
.reveal h2 { 
  font-size: 100px;
}

/* starter-section */
.starter-section .reveal .state-background {
  background: #A3A5AD;
} 
.starter-section .reveal h3 {
    font-size: 100px;
    color: white;
}

/* Special Slide Type */
.exclaim .reveal .state-background {
  background: #ff8080;
} 
.exclaim .reveal h3 {
  font-size: 150px;
  color: black;
}
.exclaim .reveal p {
  color: white;
}

/* Reducing the Size of the Code*/
.small-code pre code {
  font-size: 1em;
}

</style>



Why writing R packages?
=========================================================

 + R packages are the best way to distribute R code and documentation

 + R packages help you to keep track of your own personal R functions

 + R packages are a great way to collaborate with other colleagues

 + R packages are also useful to build a reputation around your name. 

 + Despite what one can think, it is not difficult to do it!


What did I learn writing R packages?
=========================================================

 + I learn how to read and work with Github. 

 + I improved my skills writing functions. 

 + I wrote a package that make me seemed smarter with some faculty


Overview of the workshop 
========================================================

1. Writing functions in R. Why? When? and How?

2. Converting your functions to a package. 

3. A real example: GetIRdata


**Note**: This workshop is not about making a beautiful, perfect R package. It is about creating a bare-minimum R package. 


Functions
========================================================
type:section


Why should I learn how to write functions??
=========================================================


Avoid unnecessary repetitions in the same code

Avoid being always tweaking small components of your codes. 

Avoid to make mistakes with copy and pastes from one code to another

To share you knowledge with your colleagues. Build you name 

To save time for your theoretical questions instead  of speeding time repeating your code. 
       
=======================================================


## Hadley Wickham's rule of thumb:

      if you copy and paste the code more than twice, it is time to write your function! 




Let's Code
======================================================
type:section




Function Fundamentals
==========================================================


```r
my_func <- function(arg1, arg2) {
  out

}
```


### Our first function


```r
mean_bytiago  <- function(x){
  out <- sum(x)/length(x)
  out
}
```

===============

### Using our function


```r
mean_bytiago(rnorm(1000, 0, 1))
```

```
[1] 0.03996626
```

Functions Components. Ex. One
===================== 

The arguments

```r
formals(mean_bytiago)

library(BayesTwin) # Package for Bayesian stats

formals(HPD)
```


The body

```r
body(mean_bytiago)

body()
```

=====


Where the function is saved

```r
environment(mean_bytiago)
```

Functions Components. Ex. two
===================== 

The arguments

```r
library(BayesTwin) # Package for Bayesian stats

formals(HPD)
```

```
$sample


$cred_int
[1] 0.95
```

====

The body

```r
body(HPD)
```

```
{
    cred_int <- (1 - cred_int)/2
    lower <- round(length(sample) * cred_int, 0)
    upper <- round(length(sample) * (1 - cred_int), 0)
    diff.int <- upper - lower
    HPDo <- sample[order(sample)][1:lower]
    HPDb <- sample[order(sample)][(diff.int + 1):upper]
    HPDI <- round(c(HPDo[order(HPDb - HPDo)[1]], HPDb[order(HPDb - 
        HPDo)[1]]), 5)
    return(HPDI)
}
```

=====

Where the function is saved

```r
environment(HPD)
```

```
<environment: namespace:BayesTwin>
```

From your code to a function
=================================================

Simple Reescale function


```r
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
```

The workflow for writing functions
========================================

- Find the inputs

 + Only one: df$norm
 
-  Find the outputs

 + Only one: the scaled value
 
- Make it more efficient

 + max(df$norm, na.rm = TRUE) - min(df$norm, na.rm = TRUE) = range()

Write your function
============


```r
rescale_bytiago <- function(x){ # one input
  rng <- range(x) # More efficient
  (x - rng[1])/(rng[2] - rng[1])
}
```


Loops and Conditional Statements
==============

## If Statement

    if(condition){expr}

### Example

```r
x<-5
if(x>0){
  print("x is a positive number")
} 
```

```
[1] "x is a positive number"
```

=====

## Else  

The if conditional, but adding a default condition. 


    if(conditon){
      expr} else{  
            expr}

**The else must be in the same line of the bracket**


```r
x<-5
if(x<0){
  print("x is negative")
} else{ print("x is positive")}
```

```
[1] "x is positive"
```


=====
## Else if

      if(conditon){
      expr} else if (condition2) {  
        expr} else{expr default} 


```r
if(x>0){
  print("x is negative")
}else if(x==0) {
  print("x is zero")
} else{print("x is positive")}
```

```
[1] "x is negative"
```


For Loop
==================

      for(var in seq){
      exp}


```r
cities <- c("Belem", "Rio de janeiro", "Brasilia", "DC", "College Park" )

for(i in 1:length(cities)){
  print(cities[i])
}
```

```
[1] "Belem"
[1] "Rio de janeiro"
[1] "Brasilia"
[1] "DC"
[1] "College Park"
```


My workflow for For loops
===============


```r
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
```


Good Rules for Writing Functions
=============
incremental:true




```r
# What is this function doing? 

ci <- function(nums, y, boot) {
  out.1 <- sd(nums) / sqrt(length(nums))
  out.2 <- 1 - ly
  mean(nums) + out.1 * qnorm(c(out.2 / 2, 1 - out.2 / 2))
}
```


+ Bad name
+ Bad arguments
+ Terrible Body

Great Example
=============
incremental:true



```r
mean_ci <- function(x, level=0.95){ 
  se <- sd(x) / sqrt(length(x))    
  alpha <- 1 - level
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
}
```

+ Intuitive names.
+ Meaningful inputs 
+ Default values 
+ Clear components.


Robust Function
===========================

1. Identify the errors

    if(condition) {
    stop("Error", call. = FALSE)}

2. Avoid the apply family

  + It returns inconsistent objects
  
=======

3. Save the output in your global environment. 


```r
mean_ci <- function(x, level=0.95){ 
  se <- sd(x) / sqrt(length(x))    
  alpha <- 1 - level
  output <-mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
  output.df <- data.frame(mean = mean(x), upper= output[2], lower=output[1])
  assign("ci_df", output.df, .GlobalEnv) 
}
```

=====

4. Add a warning message


```r
mean_ci <- function(x, level=0.95){ 
  if(!is.numeric(x)){
    warning("x should be numeric", call. = FALSE)
  }
  se <- sd(x) / sqrt(length(x))    
  alpha <- 1 - level
  output <-mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
  output.df <- data.frame(mean = mean(x), upper= output[2], lower=output[1])
  assign("mean_ci", output.df, .GlobalEnv)
}

mean_ci("df")
```

Packages
=============
type:section




Calling some friends
===================


```r
#install.packages("devtools")
library(devtools)  # Creates the package

#install.packages("roxygen2")
library(roxygen2) # Documents the packages

#install.packages("testthat")

library(testthat) # test the package
```


Suggested Workflow
====================

**First Step** Go to github, and create a repository for your package

**Second Step** Create a new project, with version control in Rstudio, already integrated with your github repository

**Third Step** Create your packages using devtools::create()

**Fourth** Write the functions for your package

**Fifth** Document your packages with roxygeon::document()

**Fifth** Test and Share it with your colleagues!!


Creating your package
===============================

After you have create a Rproject and a Git Rep:

    devtools::create("Name of your package")

A new folder will be created in your directory

- R : Folder For your Codes

And others:

- Description: Description of your package

- Namespace: all the functions available in your package. Not suppose to change this directly. More important if you plan on submitting a package to CRAN.


Write your function
==================================

A package is just a set of functions one created and put together. 

Each function of your package is a .r file with a specific set of comments. 

The comments are what we call the documents of your package

      ?function or help(function) gives you the 
      documentation



Documenting your function using roxygen2
================================

#### To write the documentation you should use #'

@param: Parameter/argument name and description.

@import: Loads the entire package to use in your functions (Not recommended). 
 
@return: What is output from the function. In this case, a data frame.

@examples: Usually good to give an example of how your function is used.

@export: Whether to send this function to the NAMESPACE.The last line

=======

### It's a .md file. Then, you can embed tex code!! It makes our life easier

### But never change the .md directly. Show you a example latter. 


Converting the documentation
========

After you are done writing your functions,  saving them in the R folder, then call function below to create the folder "man" and the  .md files for documentation. 



    roxygen2::document(".//package_name") 
    

Importing other packages
=====================================

The way works the best for me:

- Imports: field of the DESCRIPTION file and call the function(s)
explicitly using ::

    devtools::use_package("package")

- @Importsfrom pkg function on your R code using roxygen

- Loading the entire package using @Import. It does not install the package
  just tell R you need it. Kind of useless. 

Final steps
================================

Write a Readme. It is a .md file explaining how your packages works. 

Do some tests and checks

    
    use_testthat(".//package_name") # to create a folder

    devtools::test(".//package_name")  # To apply your tests

    devtools::check(".//package_name") # Check if it is working


Installing
================


    From your computer
    devtools::install(".//package_name")
    library("package_name")

    From Github: After commit and push
    devtools::install_github("TiagoVentura/nameofrep")
    library(package_name)




Now, let's try!
===============
type:section 

Sources
====================


#### The excelent book from Hadley Wickham entirely avaiable online Rpackages

http://r-pkgs.had.co.nz/

#### The excellent tutorial from Hillary Park

https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

#### Datacamp course "Using Rstudio part II" and "Writing Functions"

https://datacamp.com

#### Karl Broman's Blog

http://kbroman.org/pkg_primer/




 


