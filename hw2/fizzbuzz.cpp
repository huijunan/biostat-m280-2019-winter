//RCPP_fizzbuzz.cpp
#include <Rcpp.h>
#include <iostream>
using namespace Rcpp;
using namespace std;

// [[Rcpp::export]]
void RCPP_fizzbuzz(vector<int>& input){
  for(unsigned i=0; i < input.size();i++){
    if(i % 15 == 0){
      cout << "FizzBuzz" << endl;
    }
    else if(i % 3 == 0){
      cout << "Fizz" << endl;
    }
    else if(i % 5 == 0){
      cout << "Buzz" << endl;
    }
    else{
      cout << (i) << endl;
    }
  }
}