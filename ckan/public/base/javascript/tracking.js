
function bindSubmitTracking(){
  $("#user_tracker").on("submit", function(event){
    event.preventDefault();
    var gender = $(event.target).find('select[name=gender]').val();
    var usertype = $(event.target).find('select[name=usertype]').val();
    $.ajax({
      url: $('body').data('site-root') + 'user/track',
      data: {
        usertype: usertype,
        gender: gender
      }
    }).done(function(resp){
      console.log(resp);
      $("#modal_tracking").modal('show');
      window.location = '';
    });
  });
}

$(function (){

  bindSubmitTracking();
  if(!$('body').data('usertype') || !$('body').data('gender')){
    $("#modal_tracking").modal('show');
  }
  // Tracking
  var url = location.pathname;
  // remove any site root from url
  url = url.substring($('body').data('locale-root'), url.length);
  // trim any trailing /
  url = url.replace(/\/*$/, '');


  $.ajax({url : $('body').data('site-root') + '_tracking',
          type : 'POST',
          data : {
            url:url,
            type:'page',
            usertype: $('body').data('usertype'),
            gender: $('body').data('gender'),
          },
          timeout : 500 });
  $('a.resource-url-analytics').click(function (e){
    var url = $(e.target).closest('a').attr('href');
    $.ajax({url : $('body').data('site-root') + '_tracking',
            data : {
              url:url,
              type:'resource',
              usertype: $('body').data('usertype'),
              gender: $('body').data('gender'),
            },
            type : 'POST',
            complete : function () {location.href = url;},
            timeout : 1500});
    e.preventDefault();
  });
});
