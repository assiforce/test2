
function openLeaderboard() {



var base = '<div class="home-container">'+
'    <div class="home-main">'+
'      <span class="home-text">EGG HUNT</span>'+

'      <span class="home-text02">EASTER EVENT</span>'+
'      <div class="home-leaderboard">'+


'      </div>'+

'    </div>';




$('body').append(base);
}

function updateLeaderboard(place, name, score) {

name = name.replace(/\s/g, '')



if ($('#' + name).length > 0) {

$('#' + name).parent().remove();

}

if (place <= 6) {


var base = '        <div class="home-entry" id="place-'+place+'">'+
'          <div class="home-container1"><span class="home-text03">'+place+'</span></div>'+
'          <span class="home-text04" id="'+name+'">'+name.toUpperCase()+'</span>'+
'<div class="fa-solid fa-egg home-icon08"></div>' + 
'          <span class="home-text05">'+score+'</span>'+
'        </div>';


if ((place - 1) == 0) {
    $('.home-leaderboard').prepend(base);
}
else if ($("#place-" + (place - 1)).length > 0 ) {
        $("#place-" + (place - 1)).after(base);
} else {
    $('.home-leaderboard').append(base);
}



$('.home-leaderboard').children().each( (index, element) => {
  

    $(element).find(".home-text03").text(index + 1);
    $(element).attr("id", 'place-' + (index + 1));
 });




}

}

window.addEventListener('message', function (event) {


    var edata = event.data;

    if (edata.type == 'open') {
     
         openLeaderboard();
    }
    if (edata.type == 'update') {
     
         updateLeaderboard(edata.place, edata.name, edata.score);
    }

   
  

});