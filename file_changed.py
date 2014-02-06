#!/usr/bin/python

FILENAME='/path/to/file'

def atime(file, checktime):
    """Checks if file has been accesed in time secs"""
    import os
    statinfo = os.stat(file)
    tiempo = statinfo.st_atime
    import time
    if time.time()-tiempo < checktime:
        return True
    return False

mensaje = ""
#fichero de kopete
if atime(FILENAME,60):
    mensaje += "[K]"
print mensaje

