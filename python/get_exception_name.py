# Python 예외 케이스 체크
# 참고자료: https://stackoverflow.com/questions/18176602/how-to-get-the-name-of-an-exception-that-was-caught-in-python

try:
    print(10 / 0)
except Exception as e:
    print(e)
    print(type(e))
    print(type(e).__name__)

try:
    print(df)
except Exception as e:
    print(e)
    print(type(e))
    print(type(e).__name__)
