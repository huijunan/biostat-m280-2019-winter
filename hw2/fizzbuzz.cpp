//RCPP_fizzbuzz.cpp
#include <Rcpp.h>
#include <iostream>
using namespace Rcpp;
using namespace std;
int main()
{
}

// [[Rcpp::export]]
void RCPP_fizzbuzz(vector<double> & input){
  for(unsigned i = 0; i < input.size(); i++){
    if(input[i] != floor(input[i])){
      Rcout << "not valid input, please try again" << endl;
      return;
    }
    int iter = int(input[i]);
    if(iter % 15 == 0){
      Rcout << "FizzBuzz" << endl;
    }
    else if(iter  % 3 == 0){
      Rcout << "Fizz" << endl;
    }
    else if(iter  % 5 == 0){
      Rcout << "Buzz" << endl;
    }
    else{
      Rcout << iter  << endl;
    }
  }
}