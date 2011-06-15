// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  /* Login modal window */
  $("#login a").click(function(e){
    e.preventDefault(); 
    TINY.box.show({url:"/login.js", width: 400});
  });

  /* Initialize the CodeMirror text editor */
  if ($('#text-editor-form').length){
    var textEditor = CodeMirror.fromTextArea(document.getElementById('text-editor'),
        {mode: "clike",
         lineNumbers: true,
         matchBrackets: true,
         indentUnit: 2,
         tabMode: "indent"});

    /* When grading a solution, hide the exercise and text editor */
    $('input[value="Submit Solution"]').click(function(){
      $('#text-editor-form').hide();
      $('#timer').hide();
      $('#exercise-problem-text').hide();
      $('#grade-sheet-wrapper').html("Grading...");
    });

    /* Hide/show the spinner gif when checking syntax or checking solution*/
    $('#text-editor-form').bind('ajax:beforeSend', function(evt, xhr, settings){
      $('#message').html("");
      $('#spinner').show();
    })
    .bind('ajax:complete', function(){
      $('#spinner').hide();
    });
  }
});

