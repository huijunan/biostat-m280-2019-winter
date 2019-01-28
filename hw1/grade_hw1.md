*Huijun An*


### Overall Grade: 100/110

### Quality of report: 10/10

-   Is the homework submitted (git tag time) before deadline?  

	Yes. `Jan 24, 2019, 10:21 PM PST`       

-   Is the final report in a human readable format html? 

    Yes. `html`.

-   Is the report prepared as a dynamic document (R markdown) for better reproducibility?

    Yes. `Rmd`.

-   Is the report clear (whole sentences, typos, grammar)? Do readers have a clear idea what's going on and how are results produced by just reading the report? 

	 Yes. 

### Correctness and efficiency of solution: 55/60

-   Q1 (10/10)

-   Q2 (18/20)

	\#5. (-2 pts) Note that the first two lines in `NYCHVS_1991.csv` are headers. Add `tail -n +3` to remove headers. For example, 
	
	```bash 
	tail -n +3 /home/m280data/NYCHVS/NYCHVS_1991.csv | 
		awk -F, '{print $2}' | sort | uniq -c
	```
	
-   Q3 (14/15)

	\#5. (-1 pt) Why do we need the first line of the shell script?

	
-  Q4 (13/15)

	\#3. (-2 pts) Table looks crude. You may use `kable` to print the table in the given format. For example, add the following lines to `Q4_3.R`:
	
	```
	library(knitr)
	kable(Table)
	```
  
 
### Usage of Git: 8/10

-   Are branches (`master` and `develop`) correctly set up? Is the hw submission put into the `master` branch?

    Yes.

-   Are there enough commits? Are commit messages clear? (-1 pt)

    11 commits for hw1 in `develop` branch. Make commit messages more informative. **Make sure** to start version control from the very beginning of a project. Make as many commits as possible during the process. 

                  
-   Is the hw1 submission tagged?  

    Yes. 

-   Are the folders (`hw1`, `hw2`, ...) created correctly? 

    Yes.
  
-   Do not put a lot auxiliary files into version control. (-1 pt) 

	Make sure to exclude auxiliary files such as `.Rproj` from version control. 
	
### Reproducibility: 8/10

-   Are the materials (files and instructions) submitted to the `master` branch sufficient for reproducing all the results? Just click the `knit` button will produce the final `html` on teaching server? (-2 pt)

	Clicking `knit` button does not produce the final html on teaching server. Make sure your collaborators can easily run your code. 
	
	- `middle.sh` is missing, but you are still running 
	
	````
	```{bash}
	chmod 777 middle.sh
	```
	````
	Either use the option `eval=FALSE` or include `middle.sh`.
	
	- `eval=FALSE` in the following code chunk 
  	
  	````
  	```{bash, eval=FALSE}
    curl https://www.gutenberg.org/files/1342/1342.txt > pride_and_prejudice.txt
    ```
  	````
  	does not allow downloading `pride_and_prejudice.txt`. Include all codes and files necessary for easier reproducibility. 
	
-   If necessary, are there clear instructions, either in report or in a separate file, how to reproduce the ressults?

    Yes.

### R code style: 19/20

-   [Rule 3.](https://google.github.io/styleguide/Rguide.xml#linelength) The maximum line length is 80 characters. 

	
-   [Rule 4.](https://google.github.io/styleguide/Rguide.xml#indentation) When indenting your code, use two spaces.

-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Place spaces around all binary operators (=, +, -, &lt;-, etc.).  (-1 pt)

	Some violations:
	- `runSim.R`: line 26
	
-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Do not place a space before a comma, but always place one after a comma. 
	
	
-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Place a space before left parenthesis, except in a function call.

-   [Rule 5.](https://google.github.io/styleguide/Rguide.xml#spacing) Do not place spaces around code in parentheses or square brackets.
