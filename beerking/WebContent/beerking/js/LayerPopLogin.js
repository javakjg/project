
var modalLogin = document.querySelector(".modal_Login"); 
var LoginButton = document.querySelector(".loginButton"); 
var modalJoin = document.querySelector(".modal_Join"); 
var joinButton = document.querySelector(".joinButton");
var indexJoinButton = document.querySelector(".indexJoinButton");
var modalEmailSearch = document.querySelector(".modal_EmailSearch");
var emailSearchButton = document.querySelector(".emailSearchButton");
var modalPwdSearch = document.querySelector(".modal_PwdSearch");
var pwdSearchButton = document.querySelector(".pwdSearchButton");


function toggleModalLogin() { 
	modalLogin.classList.toggle("show_modal_Login"); 
}

function toggleModalJoin() {
	modalLogin.classList.toggle("show_modal_Login"); 
	modalJoin.classList.toggle("show_modal_Join"); 
}

function toggleModalIndexJoin() {
	modalJoin.classList.toggle("show_modal_Join"); 
}

function toggleModalEmailSearch() {
	modalLogin.classList.toggle("show_modal_Login"); 
	modalEmailSearch.classList.toggle("show_modal_EmailSearch"); 
}

function toggleModalPwdSearch() {
	modalLogin.classList.toggle("show_modal_Login"); 
	modalPwdSearch.classList.toggle("show_modal_PwdSearch"); 
}

function windowOnClick(event) { 
	if (event.target == modalLogin) { 
		modalLogin.classList.toggle("show_modal_Login"); 
		document.getElementById("loginForm").reset();
	} 
	else if (event.target == modalJoin) { 
		modalJoin.classList.toggle("show_modal_Join"); 
		window.location.reload();
	} 
	else if (event.target == modalEmailSearch) { 
		modalEmailSearch.classList.toggle("show_modal_EmailSearch"); 
		document.getElementById("emailForm").reset();
	} 
	else if (event.target == modalPwdSearch) { 
		modalPwdSearch.classList.toggle("show_modal_PwdSearch"); 
		document.getElementById("pwdForm").reset();
	} 
}

LoginButton.addEventListener("click", toggleModalLogin); 
joinButton.addEventListener("click", toggleModalJoin);
indexJoinButton.addEventListener("click", toggleModalIndexJoin); 
emailSearchButton.addEventListener("click", toggleModalEmailSearch); 
pwdSearchButton.addEventListener("click", toggleModalPwdSearch); 
window.addEventListener("click", windowOnClick);






