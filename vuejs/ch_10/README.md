어떤 화면에서 다른 화면으로 변경될 때를 Transition 이라고 하고,
변경될 때 애니메이셔 효과를 넣는 것을 트랜지션 애니메이션이라고 함
방법
- 나타날 / 사라질 HTML태그를 transition 태그로 감싼다.
- 어떻게 변화할지를 CSS로 준비한다.

219page
```
태그가 나타날 때
.v-enter: 나타나기 전의 상태
.v-enteh-action: 나타나고 있는 상태
.v-enter-to: 나타난 상때

태그가 사라질 때
.v-leave: 사라지기 전의 상태
.v-leave-active: 사라지고 있는 상태
.v-leave-to: 사라진 상태

태그가 이동할 때
.v-move: 이동 중인 상태
```