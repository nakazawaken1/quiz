# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#answer_form')
    .on 'ajax:complete', (event) ->
      response = event.detail[0].response
      $('#result').html(response)