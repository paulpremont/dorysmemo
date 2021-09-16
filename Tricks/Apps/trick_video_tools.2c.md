Modifier ses vidéos et images :

https://trac.ffmpeg.org/wiki/Scaling%20(resizing)%20with%20ffmpeg
https://ffmpeg.org/ffmpeg.html#Video-and-Audio-file-format-conversion

> apt-get install ffmpeg

Resize une vidéo :

> ffmpeg -i input.avi -vf scale=1280:720 output.avi

Changer de format :

> ffmpeg -i /tmp/a.wav -ar 22050 /tmp/a.mp2

Couper une vidéo :

> ffmpeg -ss [start:time:xx] -i in.file -t [dur:a:tion] -c copy out.file
