"""
    sorted함수의 key를 활용한 정렬
    참고자료: https://www.inflearn.com/course/%EC%A4%91%EA%B8%89%EC%9E%90-%EC%8A%A4%EB%82%B5-%ED%8C%8C%EC%9D%B4%EC%8D%AC/lecture/81966?tab=curriculum

"""
test = [10, 2, 1, 2, 111, 9, 3, 0, 5, 5, 11, 22]
priority_group = [0, 1, 11, 111]


def priority_chk(value_):
    if value_ in priority_group:
        return (False, value_)
    return (True, value_)


sorted(test, key=priority_chk)
sorted(test, key=lambda x: False if x in priority_group else True)  # 우선 순위 값이 정렬되지 않음
sorted(
    test, key=lambda x: (False, x) if x in priority_group else (True, x)
)  # 우선 순위 값이 정렬됨

sorted({1: "D", 2: "B", 3: "B"})

sorted("This is a test string from Andrew".split(), key=str.lower)
sorted("This is a test string from Andrew".split(), key=len)

student_tuples = [("john", "A", 15), ("jane", "B", 12), ("dave", "B", 10)]

sorted(student_tuples, key=lambda x: x[2])
sorted(student_tuples, key=lambda x: x[2], reverse=True)


class Student:
    def __init__(self, name, grade, age):
        self.name = name
        self.grade = grade
        self.age = age

    def __repr__(self):
        return repr((self.name, self.grade, self.age))


student_objects = [
    Student("john", "A", 15),
    Student("jane", "B", 12),
    Student("dave", "B", 10),
]

sorted(student_objects, key=lambda x: x.grade, reverse=True)

from operator import itemgetter, attrgetter

sorted(student_tuples, key=itemgetter(2), reverse=True)
sorted(student_tuples, key=itemgetter(1, 2), reverse=False)

sorted(student_objects, key=attrgetter("age"))
sorted(student_objects, key=attrgetter("grade", "age"))

# itemgetter 참고자료: https://www.kite.com/python/docs/operator.itemgetter
getter = itemgetter(1)
getter(student_tuples[0])

test = [(30, 20, 10), (10, 100, 90), (90, 90, 90), (50, 20, 30), (10, 20, 10)]

sorted(test)
sorted(test, key=lambda x: x[0])
sorted(test, key=lambda x: sum(x), reverse=True)
