#!/usr/bin/python2

if __name__ == "__main__":
    from PIL import Image, ImageSequence
    import sys, os
    filename = sys.argv[1]
    im = Image.open(filename)
    original_duration = im.info['duration']
    frames = [frame.copy() for frame in ImageSequence.Iterator(im)]    
    frames.reverse()

    from GifReverse.images2gif import writeGif
    writeGif(sys.argv[2], frames, duration=original_duration/1000.0, dither=0)

