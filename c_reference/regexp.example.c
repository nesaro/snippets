#include <stdlib.h> 
#include <string.h>
#include <regex.h>
#include <stdio.h>

int main () 
{
    char string1[] = "matching_name.zip"; 
    char string2[] = "zip.non_matching_name"; 
    int rc; 
    regex_t * myregex = calloc(1, sizeof(regex_t)); 

    if (NULL == myregex)
    {
        return 1;
    }
    
    // Compile the regular expression 
    rc = regcomp( myregex, "^.*.zip$", REG_EXTENDED | REG_NOSUB ); 
    /* this should compile, but doesn't!
    rc = regcomp( myregex, "^.*\.zip$", REG_EXTENDED | REG_NOSUB ); 
        */
    printf("RC from regcomp() = %d\n", rc); 
    
    // Compare the entered value to the regex 
    if (0 == regexec(myregex, string1, 0 , 0 , 0 ) ) 
    {
        printf("String %s matches.\n", string1 ) ; 
    }
    else 
    { 
        printf("String %s does not match.\n", string1 ); 
    }
    if (0 == regexec(myregex, string2, 0 , 0 , 0 ) ) 
    {
        printf("String %s matches.\n", string2 ) ; 
    }
    else 
    { 
        printf("String %s does not match.\n", string2 ); 
    }

    free(myregex);
    return 0;
}
