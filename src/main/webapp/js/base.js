function strIsNotNull(text){
	if(text != null && text.trim() != ''){
		return true;
	}
	return false;
}
function strIsNull(text){
	return !strIsNotNull(text);
}