"""파일 정보 출력하기
    
    ctime: change time
    mtime: modify time
    atime: access time
    
    $ stat smaple_file.txt
    >>
    File: sample_file.txt
    Size: 0               Blocks: 0          IO Block: 4096   regular empty file
    Device: 815h/2069d      Inode: 2097156     Links: 1
    Access: (0664/-rw-rw-r--)  Uid: ( 1000/  mentha)   Gid: ( 1000/  mentha)
    Access: 2022-03-08 22:17:58.649379096 +0900
    Modify: 2022-03-08 22:17:58.649379096 +0900
    Change: 2022-03-08 22:17:58.649379096 +0900
    Birth: -
    
    출처: https://wikidocs.net/3715
    참고자료: https://docs.python.org/3/library/os.path.html

"""

import os
import datetime

# Change time을 타임 스탬프로 출력
ctime = os.path.getctime("sample_file.txt")
# Modify time을 타임 스탬프로 출력
mtime = os.path.getmtime("sample_file.txt")
# Access time을 타임 스탬프로 출력
atime = os.path.getatime("sample_file.txt")
# 파일크기
os.path.getsize("sample_file.txt")

# 타임스탬프를 실제 시간으로 변경하기
print("ctime:", datetime.datetime.fromtimestamp(ctime))
print("mtime:", datetime.datetime.fromtimestamp(mtime))
print("atime:", datetime.datetime.fromtimestamp(atime))