// 버튼에 마우스 오버하는 것에 따라서 텍스트 색깔 제목바꾸기
// 1. 버튼을 마우스 오버 할 때
// 1-1. 버튼을 찾는다(className, color-btn)
var buttons = document.getElementsByClassName('color-btn');
console.log(buttons);
// 각 버튼에 각각 다른 이벤트 핸들러를 설정한다.
buttons[0].onmouseover = function() {
  setTableAttribute('table table-hover text-danger text-center');
}
buttons[1].onmouseover = function() {
  setTableAttribute('table table-hover text-primary text-center');
}
buttons[2].onmouseover = function() {
  setTableAttribute('table table-hover text-success text-center');
}

// 자바스크립트 함수 표현식
// var setTableAttribute = function(classList) {
//   var table = document.getElementsByTagName('table')[0];
//   table.setAttribute('class', classList);
// }
// 자바스크립트 함수 선언식
function setTableAttribute(classList) {
  var table = document.getElementsByTagName('table')[0];
  table.setAttribute('class', classList);
}






// 1-2. 버튼을 순회하면서 이벤트 리스너를 달아준다.
// for(var i=0; i<buttons.length; i++) {
//   var btn = buttons[i];
//   btn.onmouseover = function() {
//     // 2. table에 해당하는 HTML element를 찾아서
//     var table = document.getElementsByTagName('table');
//     table[0].classList.add('text-success');
//     console.log(this.classList.contains('btn-danger'));
//     console.log("클래스 냠냠");
//   }
// }
// 3. color: red/blue/green의 속성을 부여한다.

// 해결방법
// 1. 각 버튼에 있는 클래스에 따라서 다른 클래스를 부여한다.(조건문)
// 2.
