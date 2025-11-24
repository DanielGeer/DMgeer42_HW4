#include <stdio.h>
#include <string.h>
extern int addstr(char *a,char *b);
extern int is_palindromeASM(char *s);
extern int factstr(char *s);

int fact(int n){
    int fact_result = 1;
    while (n > 0){
        fact_result = fact_result * n;
        n--;
    }
    return fact_result;
}

extern void palindrome_check();
int is_palindromeC(char *s){
    int i, j;
    int length = strlen(s);
    for(i = 0, j = length-1; i < length/2 ; i++,j--){
        if(s[i] != s[j]){
            return 0;
        }
    }
    return 1;
}
int main(){
    char user_num1[10];
    char user_num2[10];
    char user_string[1024];
    int result;
    int add_result;
    int user_choice;
    printf("1. Add two numbers together\n");
    printf("2. Test if a string is a palindrome (C -> ASM)\n");
    printf("3. Print the factorial of a number\n");
    printf("4. Test if a string is a palindrome (ASM -> C)\n");
    printf("Enter a number between 1 and 4\n");
    scanf("%d",&user_choice);
    //Add 2 numbers
    if (user_choice == 1){
        printf("Enter a number\n");
        scanf("%s",&user_num1);
        printf("Enter another number\n");
        scanf("%s",&user_num2);
        add_result = addstr(user_num1,user_num2);
        printf("The result is %d\n",add_result);
    }
    //Check if palindrome C->ASM
    else if (user_choice == 2){
        printf("Insert a string\n");
        scanf("%s",&user_string);
        result = is_palindromeASM(user_string);
        if(result == 1){
            printf("It is a palindrome\n");
        } else{
            printf("It isn't a palindrome\n");
        }
    }
    //Print Factorial
    else if (user_choice == 3){
        printf("Enter a number\n");
        scanf("%s",&user_num1);
        result = factstr(user_num1);
        printf("The factorial is: %d\n",result);
    }
    //Print if palidrome ASM->C
    else if (user_choice == 4){
        palindrome_check();
    }
    return 0;
}