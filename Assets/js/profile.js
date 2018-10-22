/**
 * 
 */

var index = 0;
     setSlides();

function  setSlides() {
    var i;
    var collection = document.getElementsByClassName("mySlides");
    for (i = 0; i < collection.length; i++) {
    	collection[i].style.display = "none";
    }
    index++;
    if (index > collection.length) {index = 1}
    collection[index-1].style.display = "block";
    setTimeout( setSlides, 3000);
}
