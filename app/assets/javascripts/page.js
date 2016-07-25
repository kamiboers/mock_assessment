$(document).ready(function() {

  // getLinks();

  link_list = $('.links-box');

  link_list.delegate('.status-button', 'click', function() {
    var linkID = $(this).attr('id').substr(5);
    switchStatus(linkID);
  });

function switchStatus(linkId){
  $.ajax({
    type: 'PATCH',
    url: '/api/v1/links/' + linkId,
    contentType: 'application/json',
    success: function(link) {
      debugger;
      replaceDivContents(link);
    }
  });
}

function replaceDivContents(link){
  var link_div = $("div#link-" + link.id);
  link_div.html("");
  link_div.html("<h4>" + link.title + "</h4>" + link.url + "<br>" + link.status + "<button class='status-button' id='stat-" + link.id + "'>ChangeStatus</button>");
}



function getIdeas(){
  $.ajax({
    type: 'GET',
    url: '/api/v1/ideas',
    success: function(ideas) {
      ideas.forEach(function(idea){
        prependFullRow(idea);
      });
    }
  });
}


function deleteIdea(ideaId){
  $.ajax({
    type: 'DELETE',
    url: '/api/v1/ideas/' + ideaId,
    success: function(idea) {
      $("tr#idea_" + idea.id).remove();
    }
  });
}




function prependFullRow(idea){
  idea_list.prepend("<tr id='idea_" + idea.id + "'><td contentEditable='true' class='editable' id='title_" + idea.id + "'>" + idea.title + "</td><td contentEditable='true' class='editable' id='body_" + idea.id + "'>"  + idea.body.trimToLength(99) + "</td><td><div class='btn btn-primary get_tags' id='tags_" + idea.id + "'>show tags</div></td><td><div class='btn btn-primary q-butt'>" + idea.quality + "</div></td><td><button id='up_" + idea.id + "' class='btn btn-success upButton'><i class='fa fa-thumbs-o-up fa-2x'></i></button></td><td><button id='down_" + idea.id + "' class='btn btn-success downButton'><i class='fa fa-thumbs-o-down fa-2x'></i></button></td><td><button id='dele_" + idea.id + "' class='btn btn-success deleteButton'><i class='fa fa-times-circle-o fa-2x'></i></button></td></tr>");
}


function clearInputFields(title, body, tags){
  url.val("");
  title.val("");
}

});
