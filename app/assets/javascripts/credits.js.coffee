# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#role').autocomplete
    source: $('#role').data('autocomplete-source')
	
jQuery ->
  $('#product_id').autocomplete
    source: $('#product_id').data('autocomplete-source')	