/*
var modalBeerDB = document.querySelector(".modal_beerDB"); 
var beerButtonParent = document.querySelector("#parent");

for (var i = 0; i < beerButtonParent.children.length; i++) {
    var childElement = beerButtonParent.children[i];
    childElement.addEventListener('click', toggleModalBeerDB);

function toggleModalBeerDB() { 
	modalBeerDB.classList.toggle("show_modal_beerDB"); 
}
function windowOnClick(event) { 
if (event.target == modalBeerDB) { 
	modalBeerDB.classList.toggle("show_modal_beerDB"); 
}
}

window.addEventListener("click", windowOnClick);
*/

function onclickButton(buttonNumber){
	document.getElementById("Div_Modal"+buttonNumber).classList.toggle("show_modal_beerDB",true);
}

function onclickLoginButton(buttonNumber){
	  document.getElementById("Div_Modal"+buttonNumber).classList.toggle("show_modal_beerDB",false);
	  modalLogin.classList.toggle("show_modal_Login"); 
		}

var modalBeerDB = document.querySelectorAll(".modal_beerDB"); 

function windowOnClick(event) { 
	for(var i = 0; i < modalBeerDB.length; i++){
		if (event.target == modalBeerDB[i]) {
			modalBeerDB[i].classList.toggle("show_modal_beerDB",false); 
		}
	}
}

window.addEventListener("click", windowOnClick);

