$(document).ready(function () {
    $('select').change(function () {
        var val = $(this).val(); 
        if (val == 'KO') {
            document.getElementById("ivdiv").style.display = "none";
            document.getElementById("mmdiv").style.display = "none";
            document.getElementById("vmpdiv").style.display = "none";
            document.getElementById("krigdiv").style.display = "block";
            document.getElementById("defaultdiv").style.display = "block";
        }
        if (val == 'ID') {
            document.getElementById("krigdiv").style.display = "none";
            document.getElementById("mmdiv").style.display = "none";
            document.getElementById("vmpdiv").style.display = "none";
            document.getElementById("ivdiv").style.display = "block";
            document.getElementById("defaultdiv").style.display = "block";
        }
        if (val == 'MM') {
            document.getElementById("krigdiv").style.display = "none";
            document.getElementById("ivdiv").style.display = "none";
            document.getElementById("vmpdiv").style.display = "none";
            document.getElementById("mmdiv").style.display = "block";
            document.getElementById("defaultdiv").style.display = "block";
        }
         if (val == 'VMP') {
            document.getElementById("krigdiv").style.display = "none";
            document.getElementById("ivdiv").style.display = "none";
            document.getElementById("mmdiv").style.display = "none";
            document.getElementById("vmpdiv").style.display = "block";
            document.getElementById("defaultdiv").style.display = "block";
        }
        if (val == '') {
            document.getElementById("krigdiv").style.display = "none";
            document.getElementById("ivdiv").style.display = "none";
            document.getElementById("mmdiv").style.display = "none";
            document.getElementById("vmpdiv").style.display = "none";
            document.getElementById("defaultdiv").style.display = "none";
        }
    });
});