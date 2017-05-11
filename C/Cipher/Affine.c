/*
 * By: Daniel Laden @dthomasladen@gmail.com
 * Simple Affine Cipher
 * Started:  5/11/2017
 * Finished: 5//2017
 */

//Optional TODO remove punctuation

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define M 26
int coprime[12] = {1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25};
//Menu that prints till quit is selected

int cipherMenu(int in_message)
{
  int user_choice = -1;

  while (user_choice == -1)
  {
    printf("TYPE THE RESPECTED NUMBERS FOR WHICH OPTION YOU'D LIKE\n"
           "1. ENCODE A MESSAGE\n"
           "2. EDIT CHARACTER SHIFT\n"
           "3. PRINT ENCODED MESSAGE\n"
           "4. DECIPHER MESSAGE\n"
           "5. DISPLAY HELP\n"
           "6. QUIT\n"
           ">");
    scanf("%i", &user_choice);
    printf("\n");

    if(user_choice>2 && user_choice<5 && in_message == 0)
    {
      printf("YOU CANNONT SELECT THESE OPTIONS WITHOUT ENTERING IN A MESSAGE FIRST PLEASE TRY AGAIN\n\n");
      user_choice = -1;
    }
    else if(user_choice<1 || user_choice>5)
    {
      printf("INVALID NUMERICAL VALUE DETECTED PLEASE ENTER A VALID VALUE\n\n");
      user_choice = -1;
    }
  }
  fflush(stdin);
  return user_choice;
}

//Prints information about the cipher, how it works, and proper inputs

void help()
{
  printf("THE AFFINE CIPHER IS MUCH LIKE A SUBSTITUION CIPHER WITH LESS SECURITY\n"
         "THE UNDERLYING FUNCTION IN THIS FOR ENCODING IS F(X)=[AX+B]MOD(M)\n"
         "B CAN BE ANY VALUE IT IS THE SHIFT MUCH LIKE A CAESAR CIPHER\n"
         "A HAS TO BE COPRIME TO M WHICH USING A LOWER CASE ALPHABET LEAVES VALUES AS\n"
         "1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25\n"
         "FOR M SINCE THIS PROGRAM USES ONLY LOWERCASE LETTERS THE VALUE IS THE SIZE OF THE ALPHABET: 26\n"
         "FOR THIS PROGRAM B IS BEING LIMITED TO 10 BUT IF A = 1 THEN THIS PROGRAM IS EXACTLY A CAESAR CIPHER\n\n");
}

//changes all capitalization chars to lowercase

char *lowerCase(char *source)
{
  for (size_t i = 0; i < strlen(source); i++)
  {
    if(source[i] >= 'A' && source[i] <= 'Z')
    {
      source[i] = (char)((int)source[i]+32);
    }
  }
  return source;
}

//Gets the user message to encode

char *enterMessage(char *source)
{
  printf("PLEASE ENTER A MESSAGE TO BE ENCODED >");
  scanf("%[^\n]s", source);
  printf("\n");
  return source;
}

//Use the function [ax+b]mod 26 to encript

char *encode(char *source, int a, int b)
{
  int char_val = -1;
  for (size_t i = 0; i < strlen(source); i++)
  {
    if(source[i] != ' ')
    {
      //changing char at i to a numerical value so it's easier to work with in the function
      char_val = (int)source[i]-(int)'a';
      //function used here f(x) = [ax+b]mod26
      char_val = ((a*char_val)+b)%M;
      //reversing the char to numberical value
      char_val = char_val+(int)'a';

      //finally making it back into a char value
      source[i] = (char)char_val;
    }
  }
  return source;
}

//Meaty works of the function to decode the function encyrption f(x)

char *decode(char *source, int a, int b)
{
  int char_val = -1;
  for (size_t i = 0; i < strlen(source); i++)
  {
    if(source[i] != ' ')
    {
      //changing char at i to a numerical value so it's easier to work with in the function
      char_val = (int)source[i]-(int)'a';
      //function used here d(x) = [a^-1(x-b)]mod26
      char_val = a*(char_val-b);
      //extra line to mod for negative numbers
      char_val = ((char_val%M)+M)%M;
      //reversing the char to numberical value
      char_val = char_val+(int)'a';

      //finally making it back into a char value
      source[i] = (char)char_val;
    }
  }
  return source;
}

//Function to decode it uses the inverse of the encode

char *decipher(char *source, char *check)
{
  //a_inv is calculated by 26-a
  int a_inv = 0, shift;
  char source_copy[200], *first;
  for (size_t i = 0; i < sizeof(coprime); i++)
  {
    a_inv = M - coprime[i];

    for(size_t j = 1; j <= 10; j++)
    {
      strncpy(source_copy, source, strlen(source));

      decode(source_copy, a_inv, shift);

      first = strtok(source_copy, " ");
      //printf("%s\n", first); TEST VALUE

      if(strcmp(first, check) == 0)
      {
        shift = j;

        //values to exit out of the loops when the message has been deciphered
        j=50;
        i=50;
      }
    }
  }
  strncpy(source_copy, source, strlen(source));
  decode(source_copy, a_inv, shift);

  printf("PRINTING DECODED MESSAGE\n\n%s\n\n", source_copy);

  return source;
}

int main(int argc, char const *argv[])
{
  /* message_entered is used to make sure print and decode can't be used.
  *  shift is the b value
  */
  int menu_choice = 0, message_entered = 0, shift = 1, valid, aff_val = 3;
  char message[200], message_copy[200], *first;


  printf("WELCOME TO AFFINE CIPHER\n\n");
  help();

  while(menu_choice != 6)
  {
    menu_choice = cipherMenu(message_entered);
    switch (menu_choice)
    {
      case 1:
        //ENTER MESSAGE TO ENCODE
        enterMessage(message);
        lowerCase(message);

        //Creates a key for the decode
        strncpy(message_copy, message, strlen(message));
        first = strtok(message_copy, " ");

        //printf("%s\n", first); TEST VALUE
        encode(message, aff_val, shift);
        message_entered = 1;
        break;
      case 2:
        //EDIT CIPHER
        valid = 0;
        while(valid == 0)
        {
          valid = 1;
          printf("PLEASE ENTER THE B AMOUNT FROM 1 TO 10(DEFAULT IS 1) > ");
          scanf("%i", &shift);
          printf("\n");
          if(shift>10 || shift<1)
          {
            printf("INVALID NUMERICAL VALUE DETECTED PLEASE ENTER A VALID VALUE\n\n");
            valid = 0;
          }
        }
        valid = 0;
        while(valid == 0)
        {
          printf("PLEASE ENTER THE A AMOUNT(DEFAULT IS 3) > ");
          scanf("%i", &aff_val);
          printf("\n");
          for (size_t i = 0; i < sizeof(coprime); i++)
          {
            if(aff_val == coprime[i])
            {
              valid = 1;
            }
          }
          if(valid == 0)
          {
            printf("INVALID NUMERICAL VALUE DETECTED PLEASE ENTER A VALID VALUE\n\n");
          }
        }
        break;
      case 3:
        //PRINT MESSAGE
        printf("PRINTING ENCODED MESSAGE\n\n%s\n\n", message);
        break;
      case 4:
        //DECODE MESSAGE
        decipher(message, first);
        break;
      case 5:
        //HELP MENU TO EXPLAIN THE CIPHER MORE
        help();
        break;
    }
  }
  printf("GOODBYE AND THANK YOU FOR USING AFFINE.C\n\n");

  return 0;
}
