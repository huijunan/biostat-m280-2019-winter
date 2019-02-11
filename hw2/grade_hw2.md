*Huijun An* 

### Overall Grade: 98/100

### Quality of report: 10/10

* Is the homework submitted (git tag time) before deadline?  

	Yes. `Feb 8, 2019, 5:05 PM PST`.

* Is the final report in a human readable format html? 

	Yes. `html`.

* Is the report prepared as a dynamic document (R markdown) for better reproducibility? 

	Yes. `Rmd`.

* Is the report clear (whole sentences, typos, grammar)? Do readers have a clear idea what's going on and how are results produced by just reading the report? 

	Yes. 

 
### Correctness and efficiency of solution: 48/50 

* Q1 (16/16)



* Q2  (15/16)


	- 	(-1 pt) Your `fizzbuzz` function prints `NULL` at the end. If you want to stop execution given invalid input, then use `if-else`. For example, 
	
	```r
	fizzbuzz <- function(x) {
	  if (is.numeric(x) == FALSE) {
	    print("not valid input, please try again")
	     # return(NULL)
	  }
	  else {
		  for (i in 1:length(x)) {
		    if (x[i] %% 1 != 0){
		      print ("not valid input, please try again")
		      # return(NULL)
		    }
		    else if (x[i] %% 15 == 0) {print("FizzBuzz")}
		    else if (x[i] %% 3 == 0) {print("Fizz")}
		    else if (x[i] %% 5 == 0) {print("Buzz")}
		    else print(x[i])
	  	  }
	  }
	}
	```


* Q3 (17/18)

	- (-1 pt) Use `if-else` statement to prevent returning `NULL` value at the end. 


	
### Usage of Git: 10/10

* Are branches (`master` and `develop`) correctly set up? Is the hw submission put into the `master` branch?

	Yes.

* Are there enough commits? Are commit messages clear? 

	Yes. 29 commits for hw2. 

* Is the hw2 submission tagged? 

	Yes. 

* Are the folders (`hw1`, `hw2`, ...) created correctly? 

	Yes.


* Do not put a lot auxillary files into version control.  

	Yes. 
		
### Reproducibility: 10/10

-   Are the materials (files and instructions) submitted to the `master` branch sufficient for reproducing all the results? Just click the `knit` button will produce the final `html` on teaching server? 

    Yes. 

-   If necessary, are there clear instructions, either in report or in a separate file, how to reproduce the results?

    Yes.

### R code style: 20/20

-   [Rule 3.](https://google.github.io/styleguide/Rguide.xml#linelength) The maximum line length is 80 characters. 


-   [Rule 4.](https://google.github.io/styleguide/Rguide.xml#indentation) When indenting your code, use two spaces.

-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Place spaces around all binary operators (=, +, -, &lt;-, etc.).

-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Do not place a space before a comma, but always place one after a comma. 

-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Place a space before left parenthesis, except in a function call.

-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Do not place spaces around code in parentheses or square brackets.
