/**
 * Landing.js v0.1.0
 * https://github.com/vah7id/landing.js
 * MIT licensed
 *
 * Copyright (C) 2014 Vahid Taghizadeh (@vah7id)
 */

function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function fade(element, url) {
    var op = 1;  // initial opacity
    var timer = setInterval(function () {
        element.style.opacity = op;
        element.style.filter = 'alpha(opacity=' + op * 100 + ")";
        op -= op * 0.1;
        if (op <= 0.01){
            clearInterval(timer);
            // element.style.display = 'none';
            element.style.opacity = 1;
            element.style.backgroundImage = 'url("'+url+'")';
            element.style.backgroundSize= 'cover'
        }
    }, 30);
}

var LandingJs = {
    
    option: {
      _slide: false,
      _CountDown: false,
      _CountDownDate: null,
      _brand: 'Untitled',
      _images: [],
    },

    currentSlider: 0,

    start: function(config){
        LandingJs._bingRequest()
      LandingJs._setOptions(config);
      LandingJs._setContents();
    },

    _setOptions: function(config){
      console.log(config.slideCount)
      LandingJs.option[0] = config.slide;
      LandingJs.option[1] = config.brand;
    },

    _setContents: function(){
      var container = document.getElementById('container');

      container.getElementsByTagName('h1')[0].innerHTML = LandingJs.option[1];

      if(LandingJs.option[0]){
        var slidertimer = setInterval(function(){
            var index = getRandomInt(0, LandingJs.option._images.length-1);
          var url = LandingJs.option._images[index].getElementsByTagName('url')[0].innerHTML;
          var body = document.getElementById('no-blur');
            body.style.background = 'url("'+url+'") no-repeat center center fixed';
            body.style.backgroundSize = 'cover'
            body.style.mozBackgroundSize = 'cover'
            body.style.webkitBackgroundSize = 'cover'
            body.style.oBackgroundSize = 'cover'
            body.style.transition = 'background 1s linear'
          // fade(body, url);

        },8000);
      }

    },

    _bingRequest: function(){
    	var _url = LandingJs._urlGenerator();
    	LandingJs._loadXMLDoc(_url);
    },

    _urlGenerator: function(){
    	return 'data/zhaolin.xml';
    },

    _loadXMLDoc: function(url){
  		var xmlhttp;
  		if (window.XMLHttpRequest)
  		  xmlhttp=new XMLHttpRequest();
  		else
  		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		  xmlhttp.onreadystatechange=function() {
    		  if (xmlhttp.readyState==4 && xmlhttp.status==200) {

            var images = xmlhttp.responseXML.getElementsByTagName('images');

            var j = 0;
            for(var i = 0 ; i<images[0].childNodes.length ; i++){
                if (images[0].childNodes[i].nodeName == "image") {
                    LandingJs.option._images[j] = images[0].childNodes[i];
                    j++;
                }
            }

            var index = getRandomInt(0, LandingJs.option._images.length-1);
                  console.log(index);
            var url = LandingJs.option._images[index].getElementsByTagName('url')[0].innerHTML;
            var body = document.getElementById('no-blur');
            document.getElementById('container').style.minHeight = window.innerHeight-70+'px';
            body.style.background = 'url("'+url+'") no-repeat center center fixed';
            body.style.backgroundSize = 'cover'
            body.style.mozBackgroundSize = 'cover'
            body.style.webkitBackgroundSize = 'cover'
            body.style.oBackgroundSize = 'cover'
            body.style.transition = 'background 1s linear'
    	    }
  	  	}
  		xmlhttp.open("GET",url,true);
  		xmlhttp.send();
  	}
};
