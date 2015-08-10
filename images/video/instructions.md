# Instructions on how to prepare video
1. Make mp4 file *without audio* with resolution of at least 1440.
2. Convert mp4 file to webm with following command `ffmpeg -i in.mp4 -c:v libvpx -b:v 1M -c:a libvorbis out.webm`

The webm version requires libvpx and ffmpeg to be installed ( `brew install libvpx; brew install ffmpeg --with-libvpx` )
