$(document).ready(function() {
    //toggle `popup` / `inline` mode
    $.fn.editable.defaults.mode = 'popup';     
    
    //make username editable
    $('#username').editable();    
    $('#password').editable();    
    $('#date').editable();    
    $('#class').editable();

    $('#firstname').editable();    
    $('#lastname').editable();    
    $('#address').editable();    
    $('#email').editable();    
    $('#phone').editable();  

    $('#doctorid').editable();    
    $('#patientid').editable();    


});
