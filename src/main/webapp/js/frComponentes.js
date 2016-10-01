$(document).ready(function () {
    $('select').change(function () {
        var val = $(this).val(); 
        if (val == 'pca') {
            document.getElementById("var_disp").style.display = "block";
            document.getElementById("raio_dv").style.display = "none";
        }
        if (val == 'mult_pca') {
             document.getElementById("var_disp").style.display = "block";
             document.getElementById("raio_dv").style.display = "block";
             
        }
        if (val == 'matriz') {
             document.getElementById("var_disp").style.display = "none";
             document.getElementById("raio_dv").style.display = "none";
        }
        
    });
});