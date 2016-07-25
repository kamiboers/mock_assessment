$(document).ready(function() {

  getLinks();

  link_list = $('.links-box');
  link_list.html('');

  link_list.delegate('.status-button', 'click', function() {
    var linkID = $(this).attr('id').substr(5);
    switchStatus(linkID);
  });

function switchStatus(linkId){
  $.ajax({
    type: 'GET',
    url: '/api/v1/links/' + linkId,
    contentType: 'application/json',
    success: function(link) {
      replaceDivContents(link);
    }
  });
}

function replaceDivContents(link){
  var link_div = $("div#link-" + link.id);
  link_div.html("");
  (link.status == "unread") ? (buttonText = "Mark as Read") : (buttonText = "Mark as Unread");
  (link.status == "unread") ? (linkStyle="act-link") : (linkStyle="inact-link");
  link_div.html("<span class='" + linkStyle + "'>" + link.title + "<br>" +link.url + "</span><br><button class='status-button' id='stat-" + link.id + "'>" + buttonText + "</button>");
  link_div.toggleClass('act-link');
  link_div.toggleClass('inact-link');

}

function getLinks(){
  $.ajax({
    type: 'GET',
    url: '/api/v1/links',
    success: function(links) {
      links.forEach(function(link){
        prependFullDiv(link);
      });
    }
  });
}

function prependFullDiv(link){
  (link.status == "unread") ? (buttonText = "Mark as Read") : (buttonText = "Mark as Unread");
  (link.status == "unread") ? (linkStyle="act-link") : (linkStyle="inact-link");
  link_list.prepend("<div class='link-card " + linkStyle + "' id='link-" + link.id + "'><span class='" + linkStyle + "'>" + link.title + "<br>" + link.url + "</span><br><button class='status-button' id='stat-" + link.id + "'>" + buttonText + "</button></div>");
}

function filter(element) {
  var value = $(element).val();
  $('.links-box > div:not(:contains(' + value + '))').hide(); 
  $('.links-box > div:contains(' + value + ')').show(); 
}

jQuery.expr[':'].Contains = function(a, i, m) { 
  return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0; 
};
jQuery.expr[':'].contains = function(a, i, m) { 
  return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0; 
};




function deleteIdea(ideaId){
  $.ajax({
    type: 'DELETE',
    url: '/api/v1/ideas/' + ideaId,
    success: function(idea) {
      $("tr#idea_" + idea.id).remove();
    }
  });
}
function clearInputFields(title, body, tags){
  url.val("");
  title.val("");
}



});
