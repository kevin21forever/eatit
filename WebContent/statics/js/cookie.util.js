function setCookie (name, value, expiredTime, domain) {
	if (expiredTime == null || expiredTime == '') {
		expiredTime = 3600000 * 24 * 7;
	}
	if (domain == null || domain == '') {
		domain = '.bonapp.cn';
	}
	
	var cookies = name + "=" + encodeURI(value)+";expires="+expiredTime.toString()+";path=/;domain=" + domain;
	document.cookie = cookies;
}

function getCookie(name) { 
	var value = '';
	var cookieStr = document.cookie;
	if (cookieStr != null && cookieStr.length > 0) {
		var cookies = document.cookie.split(";");
		for ( var i = 0; i < cookies.length; i++) {
			var cookie = cookies[i];
			var cookieName = cookie.substring(0, cookie.indexOf("="));
			if (cookieName.trim() == name) {
				value = cookie.substring(cookie.indexOf("=") + 1, cookie.length);
			}
		}
	}
	return decodeURI(value);
}

function deleteCookie(name){
	document.cookie = name + "=;expires="+(new Date(0)).toGMTString()+";path=/;domain=.bonapp.cn";
}