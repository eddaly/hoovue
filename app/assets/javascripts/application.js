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
//= require jquery.show_hide
//= require jquery.ui.datepicker
//= require jquery.placeholder
//= require jquery.nested-fields
//= require best_in_place
//= require slick.min
//= require_tree .


// Sticky Header (Search)

$(window).scroll(function() {
    if ($(window).scrollTop() > 40) {
        //$('.header-container').addClass('fixed');
    } else {
        //$('.header-container').removeClass('fixed');
    }
    //console.log($(window).scrollTop());
});

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

    $('.hero-h1').cycleHeadingPhrase();
    $('.project_slider').heroSlider();

    $('.intro .btn').on('click', function() {
       $('.video').addClass('visible');
       $('.video').on('click', function() {
          $(this).removeClass('visible');
          return false;
       });
       return false;
    });


    // Add credit form

    // Check url hash
    if(window.location.hash == '#add_credit') {
      $('.addcredit_form').slideDown();
    }

    // Button slide toggle. Todo: replace with css transition.
    $('.content .add_credit').on('click', function() {
      $('.addcredit_form').slideToggle();
      window.location.hash = 'add_credit';
      return false;
    })
    
    // Button slide toggle. Todo: replace with css transition.
    $('.content .invite_team_member').on('click', function() {
      $('.invite_team_member_form').slideToggle();
      return false;
    })

});

//Phrase Cycle
$.fn.cycleHeadingPhrase = function(){
    return this.each(function(){
        var h1 = $(this),
            phrase = h1.children('.phrase'),
            phrases = [
                'made that texture',
                'designed that UI',
                'wrote that script'
            ],
            currentPhrase = 0;

        var animate = function(){
            h1.addClass('phrase_cycle');
            setTimeout(function(){
                phrase.text(phrases[currentPhrase] + '?');
                currentPhrase = (currentPhrase < phrases.length-1) ? currentPhrase + 1 : 0;
                h1.removeClass('phrase_cycle');
            },400);
        };

        setInterval(animate,2500);
        animate();
    });
};

$.fn.heroSlider = function(){
    return this.each(function(){
        var slider = $(this),
            teamMembers = $('.team li'),
            coverArt = $('.cover_art'),
            backgrounds = $('.backgrounds li'),
            projectDetails = $(".project_details");


        var afterAnimation = function() {
          var productUrl = projectDetails.eq(this.currentSlide).data("product-url");
          coverArt.addClass('visible');
          teamMembers.addClass('visible');
          backgrounds.eq(this.currentSlide).addClass('visible');
          $('#add-credit').removeClass('hidden').attr("href", productUrl);
        };

        slider.slick({
            arrows: false,
            dots: true,
            autoplay: true,
            speed: 600,
            autoplaySpeed: 5000,
            easing: 'ease',
            draggable: false,
            onBeforeChange: function() {
              coverArt.removeClass('visible');
              teamMembers.removeClass('visible');
              backgrounds.eq(this.currentSlide).removeClass('visible');
              $('.add_credit').addClass('hidden');
            },
            onAfterChange: afterAnimation
        });

        afterAnimation.call({currentSlide: 0});
    });
};


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
