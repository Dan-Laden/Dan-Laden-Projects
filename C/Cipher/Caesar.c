/*
 * By: Daniel Laden @dthomasladen@gmail.com
 * Simple Caesar Cipher
 * Started:  5/9/2017
 * Finished: 5/9/2017
 */

//Optional TODO remove punctuation

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
           "5. QUIT\n"
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

//Used to shift letters right or left depending on the shift value

char *encode(char *source, int shift)
{
  int overflow = 0;
  for (size_t i = 0; i < strlen(source); i++)
  {
    if(source[i] != ' ')
    {
      source[i] = (char)((int)source[i]+shift);

      //following conditionals are to check to make sure there isn't run off and if so will readjust
      if(source[i] < 'a')
      {
        overflow = (int)'a' - (int)source[i]-1;
        source[i] = (char)((int)'z'-overflow);
      }
      else if(source[i] > 'z')
      {
        overflow = (int)source[i]-(int)'z'-1;
        source[i] = (char)((int)'a'+overflow);
      }
    }
  }
  return source;
}

//Function to decode the message it cycles through 26 times to be 100% sure it decodes the message.
char *decode(char *source, char *check)
{
  int overflow = 0, shift, decipher = 0;
  char source_copy[200], *first;

  for (shift = 1; shift < 26; shift++)
  {
    strncpy(source_copy, source, strlen(source));

    encode(source_copy, -shift); //Encode is great for shifting letters

    first = strtok(source_copy, " ");
    //printf("%s\n", first); TEST VALUE

    if(strcmp(first, check) == 0)
    {
      decipher = -shift;
      shift = 50;
    }
  }
  encode(source, decipher);
  printf("PRINTING DECODED MESSAGE\n\n%s\n\n", source);

  encode(source, -decipher); //used to reassemble the cipher

  return source;
}

int main(int argc, char const *argv[])
{

  /* test code
  char test1 = 'a';
  char test2 = 'Z';

  printf("%c : %d\n", test1, lowerCStrt);
  printf("%c : %d\n", test2, (int)test2);

  test1 = (char)((int)test1+25);
  test2 = (char)((int)test2+1);

  printf("%c : %d\n", test1, (int)test1);
  printf("%c : %d\n", test2, (int)test2);
  */


  /* message_entered is used to make sure print and decode can't be used.
  *  shift is the caesar shift value 
  */
  int menu_choice = 0, message_entered = 0, shift = 1, valid;
  char message[200], message_copy[200], *first;


  printf("WELCOME TO CAESAR CIPHER\n\n");

  while(menu_choice != 5)
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
        encode(message, shift);
        message_entered = 1;
        break;
      case 2:
        //EDIT CIPHER
        valid = 0;
        while(valid == 0)
        {
          valid = 1;
          printf("PLEASE ENTER THE SHIFT AMOUNT FROM 1 TO 10 USE NEGATIVE FOR A LEFT SHIFT (DEFAULT IS 1) > ");
          scanf("%i", &shift);
          printf("\n");
          if(shift>10 || shift==0 || shift<-10)
          {
            printf("INVALID NUMERICAL VALUE DETECTED PLEASE ENTER A VALID VALUE\n\n");
            valid = 0;
          }
        }
        break;
      case 3:
        //PRINT MESSAGE
        printf("PRINTING ENCODED MESSAGE\n\n%s\n\n", message);
        break;
      case 4:
        //DECODE MESSAGE
        decode(message, first);
        break;
    }
  }
  printf("GOODBYE AND THANK YOU FOR USING CAESAR.C\n\n");

  return 0;
}
