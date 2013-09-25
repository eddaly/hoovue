// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require jquery.ui.autocomplete
//= require jquery.ui.tooltip
//= require jquery.slides
//= require rails.validations
//= require select2
//= require jquery.show_hide
//= require jquery.ui.datepicker
//= require jquery.placeholder
//= require jquery.nested-fields
//= require best_in_place
//= require_tree .


$('input, textarea').placeholder();
  
 $("#products_list_search input").keyup(function() {
    $.get($("#products_list_search").attr("action"), $("#products_list_search").serialize(), null, "script");
    return false;
  });
  
  
  $(document).ready(function() {
    $("#content div").hide(); // Initially hide all content
    $("#tabs li:first").attr("id","current"); // Activate first tab
    $("#content div:first").fadeIn(); // Show first tab content
    
    $('#tabs a').click(function(e) {
        e.preventDefault();
        if ($(this).closest("li").attr("id") == "current"){ //detection for current tab
         return       
        }
        else{             
        $("#content div").hide(); //Hide all content
        $("#tabs li").attr("id",""); //Reset id's
        $(this).parent().attr("id","current"); // Activate this
        $('#' + $(this).attr('name')).fadeIn(); // Show content for current tab
        }
    });
});


// Tabs
  
$(document).ready(function() {
    $("#content div").hide(); // Initially hide all content
    $("#tabs li:first").attr("id","current"); // Activate first tab
    $("#content div:first").fadeIn(); // Show first tab content
    
    $('#tabs a').click(function(e) {
        e.preventDefault();
        if ($(this).closest("li").attr("id") == "current"){ //detection for current tab
         return       
        }
        else{             
        $("#content div").hide(); //Hide all content
        $("#tabs li").attr("id",""); //Reset id's
        $(this).parent().attr("id","current"); // Activate this
        $('#' + $(this).attr('name')).fadeIn(); // Show content for current tab
        }
    });
});

$('input:text').focus(
    function(){
        $(this).val('');
    });

  $(document).ready(function() {
maxCharacters = 298;

$('#count').text(maxCharacters);

$('textarea').bind('keyup keydown', function() {
    var count = $('#count');
    var characters = $(this).val().length;

    if (characters > maxCharacters) {
        count.addClass('over');
    } else {
        count.removeClass('over');
    }

    count.text(maxCharacters - characters);
});

});


$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});
