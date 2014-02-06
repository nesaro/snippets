/* summary displayed on changing directory (bash)
 * based in some old @ayosec code
 */

#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <dirent.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* getdir()
{
    int n;
    static char buf[256];

    buf[0] = 0;
    getcwd(buf, sizeof(buf));

    if ((n = strlen(buf)) > 60) {
        buf[20] = buf[21] = buf[22] = '.';
        memmove(buf+23, buf+n-40, 41);
    }

    return buf;
}

const char* human_size(double n)
{
    static char buf[128];

    if (n > 1073741824)
        snprintf(buf, sizeof(buf), "%.1fG", n / 1073741824.);
    else if (n > 1048576)
        snprintf(buf, sizeof(buf), "%.1fM", n / 1048576.);
    else if (n > 1024)
        snprintf(buf, sizeof(buf), "%.1fk", n / 1024.);
    else
        snprintf(buf, sizeof(buf), "%gb", n);

    return buf;
}

int main()
{
    int num_files, num_dirs, show_files, n;
    double tot_bytes;
    struct dirent* ent;
    struct winsize win;
    struct stat st;
    char buf[200];
    DIR* d;
	int mensaje=0;
	int proceso=0;
    
    num_dirs = -2; /* Ignora . y .. */
    num_files = 0;
    tot_bytes = 0;
    show_files = 0;
    d = opendir(".");

    while ((ent = readdir(d))) {
        if (ent->d_name[0] != '.')
            show_files++;

		if (!strcmp(ent->d_name,".d.txt"))
			mensaje=1;

        if (!stat(ent->d_name, &st)) {
            if (S_ISDIR(st.st_mode))
                num_dirs++;
            else {
                tot_bytes += st.st_size;
                num_files++;
            }
        }
    }
    closedir(d);

    // Mostrar los datos leídos

    n = snprintf(buf, sizeof(buf),
            "[\033[4;33m%s\033[m: %d dirs, %s in %d files (%d hidden)]",
                getdir(),
                num_dirs, 
                human_size(tot_bytes), num_files, 
                num_files + num_dirs - show_files);

    if (n < 0)
        exit(1);

    ioctl(1, TIOCGWINSZ, &win);
    n = win.ws_col - n;
    while (n-- > -5)
        putc(' ', stdout);
    puts(buf);

    if (show_files < 40)
		execl("/bin/ls", "ls", "--color=always", NULL);
	if (mensaje>0)
		execl("/bin/cat","cat",".descripciondir.txt",NULL);


    return 0;
}
