$(document).ready(function() {

  getLinks();

  link_list = $('.links-box');
  link_list.html('');

  link_list.delegate('.status-button', 'click', function() {
    var linkID = $(this).attr('id').substr(5);
    switchStatus(linkID);
  });

  link_list.delegate('.edit-button', 'click', function() {
    this.parentElement.contentEditable='true';
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
  link_div.html("<span class='" + linkStyle + "'><div id='title_" + link.id + "'>" + link.title + "</div><div id='url_" + link.id + "'>" + link.url + "</div></span><button class='edit-button'>Edit</button><button class='status-button' id='stat-" + link.id + "'>" + buttonText + "</button>");
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
  link_list.prepend("<div class='link-card " + linkStyle + "' id='link-" + link.id + "'><span class='" + linkStyle + "'><div id='title_" + link.id + "'>" + link.title + "</div><div id='url_" + link.id + "'>" + link.url + "</div></span><button class='edit-button'>Edit</button><button class='status-button' id='stat-" + link.id + "'>" + buttonText + "</button></div>");
}

document.addEventListener('keydown', function (event) {
  var esc = event.which == 27,
  nl = event.which == 13,
  el = event.target,
  input = el.nodeName != 'INPUT' && el.nodeName != 'TEXTAREA',
  data = {};

  if (input) {
    if (esc) {
      document.execCommand('undo');
      el.blur();
    } else if (nl) {
      data['contents'] = el.innerText;
      data['id'] = el.id;
      $.ajax({
        type: 'get',
        url: '/api/v1/save/' + el.id,
        data: data,
        error: function (request, status, error) {
        $('#flash').html('Invalid URL. Try again.')
        }
      });
      el.blur();
      event.preventDefault();
    }
  }
}, true);




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
