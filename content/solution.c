#include <stdio.h>
#include <string.h>

void remove_char(char c, char str[]){
  int read = 0, write = 0;
  char curr;

  do{
    curr = str[read];
    if (curr != c)
      str[write++] = str[read];
    read++;
  } while (curr);
}
