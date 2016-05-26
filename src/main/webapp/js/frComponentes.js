$(document).ready(function () {
    $('select').change(function () {
        var val = $(this).val(); 
        if (val == 'KO') {
            document.getElementById("ivdiv").style.display = "none";
            document.getElementById("krigdiv").style.display = "block";
        }
        if (val == 'ID') {
            document.getElementById("krigdiv").style.display = "none";
            document.getElementById("ivdiv").style.display = "block";
        }if (val == '') {
            document.getElementById("krigdiv").style.display = "none";
            document.getElementById("ivdiv").style.display = "none";
        }
    });
});