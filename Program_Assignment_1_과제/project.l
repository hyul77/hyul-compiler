%{
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <stack>
#include <vector>
using namespace std;

vector<string> answer;
stack<char> operstack;
int consec = 0;
int AB = 0;
int checkoper(char oper){
	if(oper == '+'|| oper == '-'){
		return 1;
	}
	else{
		return -1;
	}
}

void checkpush(char oper){
	if (checkoper(oper) == 1 && !operstack.empty() && consec == 1){
		cout<<"error\n";
		exit(1);
	}
	else if (AB==0){
		cout<<"error\n";
		exit(1);
	}
	else if(operstack.empty()){
		operstack.push(oper);
	}
	else{
		char ch[2];
		ch[0] = operstack.top();
		ch[1] = ' ';
		string str(ch);
		answer.push_back(str);
		operstack.pop();
		operstack.push(oper);
	}
}
void changeconsec(int _x){
	consec = _x;
}
void plusAB(){
	AB++;
}

%}
%option noyywrap
%%
[1-9][0-9]*|0[^0-9]		{ answer.push_back(yytext);
		  answer.push_back(" ");
		  changeconsec(0);
		  plusAB();
		}
[+-]		{ checkpush(*yytext);
		  changeconsec(1);
		}
[ \t]		;

\n		{ for(int i = 0; i<answer.size(); i++){
			cout<<answer[i];
		  }
		  cout<<operstack.top()<<"\n";
		  exit(1);
		}
.		{ cout<<"error\n";
		  exit(1);
		}
%%
int main(){
	cout<<"Enter infix : ";
	yylex();

	return 0;
}


