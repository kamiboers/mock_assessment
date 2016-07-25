$(document).ready(function() {

  getLinks();

  link_list = $('.links-box');
  link_list.html('');

  link_list.delegate('.status-button', 'click', function() {
    var linkID = $(this).attr('id').substr(5);
    switchStatus(linkID);
  });

  $('.search').delegate('#active', 'click', function() {
    $('.act-link').show();
    $('.inact-link').hide();
  });

  $('.search').delegate('#inactive', 'click', function() {
    $('.act-link').hide();
    $('.inact-link').show();
  });

  $('.search').delegate('#all', 'click', function() {
    $('.act-link').show();
    $('.inact-link').show();
  });

  $('.search').delegate('#alpha', 'click', function() {
    var divs = $('.links-box > div')
    var alphabetical = divs.sort(function (a, b) {
        return $(a).find("span").text() > $(b).find("span").text();
    });
    link_list.html('');
    link_list.html(alphabetical);
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

function clearInputFields(title, body, tags){
  url.val("");
  title.val("");
}

});
