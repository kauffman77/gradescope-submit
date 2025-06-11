#!/bin/bash

# minimal example, removed what appears to be unneeded cookies, uses
# plain text body for content of the post
curl 'https://www.gradescope.com/courses/618117/assignments/5522418/submissions' \
  --compressed \
  -X POST \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: https://www.gradescope.com/courses/618117/assignments/5522418/submissions/336337797' \
  -H 'Cache-Control: no-cache' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Content-Type: multipart/form-data; boundary=----geckoformboundary195a902ef768c3f68ad76e7c158a00bf' \
  -H 'Origin: https://www.gradescope.com' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: _gradescope_session=QlZXeG9EM3ZlZUp3dHJqaUhlZkZLWEtVSmZjdFl3bjNZV01ISElTdlJzOEhScGMwQnozOGIwbFVVamFzSjZXeGsvclpoY2tVQjZsSGRVa240Tjc1WkozSGNSZklsZHNTYWIvQnhWcmZ4TUxiRUtwcmZhVkx2MG5qeWh0bmpFbUdveDJhQ3FQdE9FOEtudnJpL2xVbnFKZElkbVdsaVhuSjRMemplRmxxSXArSHF5czc4SW9KR1NWMk5DWjluTUtudzB4VzZqMHd5ejJ5MHp0QXZ1UVNadlpGd3JFODNDZ1JxYWd5MmhER1p5ZkQxYVFwbTdZdlVrdnlsdVRqdmxIdWRlbEhvUndQMWU2Z0xRY1MwYS9mdU9NU015b1hLbWpiS0xpaHNaUDdDa1VpZ0x0Q1hNNG9NMUk2b0UzMXNod0Fuc2cwVCtrV3lJVFFEMWYvQndMc3c2Q3NRVVNnZVdVMmRvcWM2bEQ4dlYxTFpRYm1GUkpkNzkzeHFQdFdvazBCQlp0WEZHb2JCZGpsWFZDWGRXd09hQT09LS0yZXNVZFcrUjh3TDJ6MnpPTG1YdXFnPT0%3D--f204acd914b7af2f243ce5b92f7d893dfe561bd1;  signed_token=cXR3d2VqUWFzaDR0TTN4QTR0L0FrNlcrYTZ1Y08vK1JFWVRHZUV4STU5QT0tLWd5bEZOTG9VOWNBOVZpMnZrNGVvUFE9PQ%3D%3D--ce0328aa7ee8f71406e9eb1cb16bc1b4b0d9b982;' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=0' \
  -H 'Pragma: no-cache' \
  --data-binary '@body-original.txt'


# simplifying the boundary string: careful with this as its likely
# problematic when the string appears in the body; note
# - Boundary is ########################################
# - in body must start with two dashes so --########################################
# - end boundary will have dashes front and back so --########################################--
curl 'https://www.gradescope.com/courses/618117/assignments/5522418/submissions' \
  --compressed \
  -X POST \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: https://www.gradescope.com/courses/618117/assignments/5522418/submissions/336337797' \
  -H 'Cache-Control: no-cache' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Content-Type: multipart/form-data; boundary=########################################' \
  -H 'Origin: https://www.gradescope.com' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: _gradescope_session=QlZXeG9EM3ZlZUp3dHJqaUhlZkZLWEtVSmZjdFl3bjNZV01ISElTdlJzOEhScGMwQnozOGIwbFVVamFzSjZXeGsvclpoY2tVQjZsSGRVa240Tjc1WkozSGNSZklsZHNTYWIvQnhWcmZ4TUxiRUtwcmZhVkx2MG5qeWh0bmpFbUdveDJhQ3FQdE9FOEtudnJpL2xVbnFKZElkbVdsaVhuSjRMemplRmxxSXArSHF5czc4SW9KR1NWMk5DWjluTUtudzB4VzZqMHd5ejJ5MHp0QXZ1UVNadlpGd3JFODNDZ1JxYWd5MmhER1p5ZkQxYVFwbTdZdlVrdnlsdVRqdmxIdWRlbEhvUndQMWU2Z0xRY1MwYS9mdU9NU015b1hLbWpiS0xpaHNaUDdDa1VpZ0x0Q1hNNG9NMUk2b0UzMXNod0Fuc2cwVCtrV3lJVFFEMWYvQndMc3c2Q3NRVVNnZVdVMmRvcWM2bEQ4dlYxTFpRYm1GUkpkNzkzeHFQdFdvazBCQlp0WEZHb2JCZGpsWFZDWGRXd09hQT09LS0yZXNVZFcrUjh3TDJ6MnpPTG1YdXFnPT0%3D--f204acd914b7af2f243ce5b92f7d893dfe561bd1;  signed_token=cXR3d2VqUWFzaDR0TTN4QTR0L0FrNlcrYTZ1Y08vK1JFWVRHZUV4STU5QT0tLWd5bEZOTG9VOWNBOVZpMnZrNGVvUFE9PQ%3D%3D--ce0328aa7ee8f71406e9eb1cb16bc1b4b0d9b982;' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=0' \
  -H 'Pragma: no-cache' \
  --data-binary '@body-short.txt'


# example of constructiong a POST for a PDF file; tricky binary
# encoding required but cat is up to the task
cat pdf-begin.txt and.pdf end.txt > x.txt

curl 'https://www.gradescope.com/courses/618117/assignments/5522418/submissions' \
  --compressed \
  -X POST \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: https://www.gradescope.com/courses/618117/assignments/5522418/submissions/336337797' \
  -H 'Cache-Control: no-cache' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Content-Type: multipart/form-data; boundary=----geckoformboundary195a902ef768c3f68ad76e7c158a00bf' \
  -H 'Origin: https://www.gradescope.com' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: _gradescope_session=QlZXeG9EM3ZlZUp3dHJqaUhlZkZLWEtVSmZjdFl3bjNZV01ISElTdlJzOEhScGMwQnozOGIwbFVVamFzSjZXeGsvclpoY2tVQjZsSGRVa240Tjc1WkozSGNSZklsZHNTYWIvQnhWcmZ4TUxiRUtwcmZhVkx2MG5qeWh0bmpFbUdveDJhQ3FQdE9FOEtudnJpL2xVbnFKZElkbVdsaVhuSjRMemplRmxxSXArSHF5czc4SW9KR1NWMk5DWjluTUtudzB4VzZqMHd5ejJ5MHp0QXZ1UVNadlpGd3JFODNDZ1JxYWd5MmhER1p5ZkQxYVFwbTdZdlVrdnlsdVRqdmxIdWRlbEhvUndQMWU2Z0xRY1MwYS9mdU9NU015b1hLbWpiS0xpaHNaUDdDa1VpZ0x0Q1hNNG9NMUk2b0UzMXNod0Fuc2cwVCtrV3lJVFFEMWYvQndMc3c2Q3NRVVNnZVdVMmRvcWM2bEQ4dlYxTFpRYm1GUkpkNzkzeHFQdFdvazBCQlp0WEZHb2JCZGpsWFZDWGRXd09hQT09LS0yZXNVZFcrUjh3TDJ6MnpPTG1YdXFnPT0%3D--f204acd914b7af2f243ce5b92f7d893dfe561bd1; _ga=GA1.2.564817065.1749352691; _gid=GA1.2.1072695731.1749352691; signed_token=cXR3d2VqUWFzaDR0TTN4QTR0L0FrNlcrYTZ1Y08vK1JFWVRHZUV4STU5QT0tLWd5bEZOTG9VOWNBOVZpMnZrNGVvUFE9PQ%3D%3D--ce0328aa7ee8f71406e9eb1cb16bc1b4b0d9b982; remember_me=ajA2cWtoYW02MExqMkNGQmhwSFRZdz09LS1HSzIySjJYUFFtUHRpVUkzOFIzc1pBPT0%3D--43b7693f7179aacce569260be78871e1b7cea306; apt.uid=AP-1BQVLBSZC216-2-1749352853307-96718679.0.2.35d57c33-5a95-4589-81a1-a9600e866571; apt.sid=AP-1BQVLBSZC216-2-1749352853307-39811872' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=0' \
  -H 'Pragma: no-cache' \
  --data-binary '@x.txt'

# example of constructiong a POST for a zip file; tricky binary
# encoding required but cat is up to the task; Gradescope doesn't do
# anything with the zip, just stores it as a binary; client side is
# responsible for sending individual files broken into the multipart
# format
cat body.bin single-cells.el.zip end.txt > x.txt

curl 'https://www.gradescope.com/courses/618117/assignments/5522418/submissions' \
  --compressed \
  -X POST \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: https://www.gradescope.com/courses/618117/assignments/5522418/submissions/336337797' \
  -H 'Cache-Control: no-cache' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Content-Type: multipart/form-data; boundary=----geckoformboundary195a902ef768c3f68ad76e7c158a00bf' \
  -H 'Origin: https://www.gradescope.com' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: _gradescope_session=QlZXeG9EM3ZlZUp3dHJqaUhlZkZLWEtVSmZjdFl3bjNZV01ISElTdlJzOEhScGMwQnozOGIwbFVVamFzSjZXeGsvclpoY2tVQjZsSGRVa240Tjc1WkozSGNSZklsZHNTYWIvQnhWcmZ4TUxiRUtwcmZhVkx2MG5qeWh0bmpFbUdveDJhQ3FQdE9FOEtudnJpL2xVbnFKZElkbVdsaVhuSjRMemplRmxxSXArSHF5czc4SW9KR1NWMk5DWjluTUtudzB4VzZqMHd5ejJ5MHp0QXZ1UVNadlpGd3JFODNDZ1JxYWd5MmhER1p5ZkQxYVFwbTdZdlVrdnlsdVRqdmxIdWRlbEhvUndQMWU2Z0xRY1MwYS9mdU9NU015b1hLbWpiS0xpaHNaUDdDa1VpZ0x0Q1hNNG9NMUk2b0UzMXNod0Fuc2cwVCtrV3lJVFFEMWYvQndMc3c2Q3NRVVNnZVdVMmRvcWM2bEQ4dlYxTFpRYm1GUkpkNzkzeHFQdFdvazBCQlp0WEZHb2JCZGpsWFZDWGRXd09hQT09LS0yZXNVZFcrUjh3TDJ6MnpPTG1YdXFnPT0%3D--f204acd914b7af2f243ce5b92f7d893dfe561bd1; _ga=GA1.2.564817065.1749352691; _gid=GA1.2.1072695731.1749352691; signed_token=cXR3d2VqUWFzaDR0TTN4QTR0L0FrNlcrYTZ1Y08vK1JFWVRHZUV4STU5QT0tLWd5bEZOTG9VOWNBOVZpMnZrNGVvUFE9PQ%3D%3D--ce0328aa7ee8f71406e9eb1cb16bc1b4b0d9b982; remember_me=ajA2cWtoYW02MExqMkNGQmhwSFRZdz09LS1HSzIySjJYUFFtUHRpVUkzOFIzc1pBPT0%3D--43b7693f7179aacce569260be78871e1b7cea306; apt.uid=AP-1BQVLBSZC216-2-1749352853307-96718679.0.2.35d57c33-5a95-4589-81a1-a9600e866571; apt.sid=AP-1BQVLBSZC216-2-1749352853307-39811872' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=0' \
  -H 'Pragma: no-cache' \
  --data-binary '@x.txt'

# extract the cookies for chrome; value doesn't seem to print likely due to encryption
# https://gist.github.com/hupili/9825148
sqlite3 -separator '	' /home/kauffman/.config/google-chrome/Default/Cookies 'select host_key, path, expires_utc, name, value from cookies'|grep gradescope
