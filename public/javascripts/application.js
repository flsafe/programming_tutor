// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Initialize the CodeMirror text editor */

if ($('#text_editor_form').length){
  var textEditor = CodeMirror.fromTextArea(document.getElementById('text_editor'),
      {mode: "clike",
       lineNumbers: true,
       matchBrackets: true,
       indentUnit: 2,
       tabMode: "indent"});

  /* When grading a solution, hide the exercise, text editor, etc..*/
  $('input[value="Submit Solution"]').click(function(){
    $('#text_editor_form').hide();
    $('#timer').hide();
    $('#exercise_problem_text').hide();
    $('#grade_sheet_wrapper').html("Grading...");
  });

  /* Hide/show the spinner gif when checking syntax or checking solution*/
  $('#text_editor_form').bind('ajax:beforeSend', function(evt, xhr, settings){
    $('#message').html("");
    $('#spinner').show();
  })
  .bind('ajax:complete', function(){
    $('#spinner').hide();
  });
}
