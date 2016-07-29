#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>        
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/socket.h> /* for socketpair */
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h> /* for wait */
#include <signal.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/un.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <setjmp.h>
#include <stdio.h>
#include <errno.h>

/* netbd.h es necesitada por la estructura hostent ;-) */

#define MAXDATASIZE 1000
/* El número máximo de datos en bytes */

int main(int argc, char *argv[])
{
   int fd, numbytes;       
   /* ficheros descriptores */

   char buf[MAXDATASIZE];  
   /* en donde es almacenará el texto recibido */

   struct hostent *he;         
   /* estructura que recibirá información sobre el nodo remoto */

   struct sockaddr_un server;  
   /* información sobre la dirección del servidor */

   if ((fd=socket(AF_UNIX, SOCK_STREAM, 0))==-1){  
      /* llamada a socket() */
      printf("socket() error\n");
      return -1;
   }

   server.sun_family = AF_UNIX;
   strcpy(server.sun_path,"/var/run/bbackupd.sock"); 
   /*he->h_addr pasa la información de ``*he'' a "h_addr" */

   if(connect(fd, (struct sockaddr *)&server, sizeof(server))==-1){ 
      /* llamada a connect() */
      printf("connect() error\n");
      return -1;
   }

   if ((numbytes=recv(fd,buf,MAXDATASIZE,0)) == -1){  
      /* llamada a recv() */
      printf("Error en recv() \n");
      return -1;
   }

   buf[numbytes]='\0';

   printf("Mensaje del Servidor: %s\n",buf); 
   /* muestra el mensaje de bienvenida del servidor =) */
   if ((numbytes=recv(fd,buf,MAXDATASIZE,0)) == -1){  
      /* llamada a recv() */
      printf("Error en recv() \n");
      return -1;
   }

   buf[numbytes]='\0';

   printf("Mensaje del Servidor: %s\n",buf); 
   /* muestra el mensaje de bienvenida del servidor =) */
   if ((numbytes=recv(fd,buf,MAXDATASIZE,0)) == -1){  
      /* llamada a recv() */
      printf("Error en recv() \n");
      return -1;
   }

   buf[numbytes]='\0';

   printf("Mensaje del Servidor: %s\n",buf); 
   /* muestra el mensaje de bienvenida del servidor =) */



   close(fd);   /* cerramos fd =) */

}
