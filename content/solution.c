#include <stdio.h>
#include <string.h>

/*start_prototype*/
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
/*end_prototype*/

#define MAX_STR 255

int main(){
  char str[MAX_STR + 1];
  char rm_char; 
  memset(str, '\0', (MAX_STR + 1) * sizeof(char));

  scanf("%c %255s",&rm_char, str);

  remove_char(rm_char, str);

  str[MAX_STR] = '\0'; /*Always null terminated*/
  printf("%s", str);
  return 0;
}

