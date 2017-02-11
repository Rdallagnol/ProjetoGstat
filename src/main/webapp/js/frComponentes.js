$('.area').change(function () {
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: "buscaAmostrasDaArea?idArea=" + this.value,
        dataType: "json",
        success: function (data) {
            if (data.length > 0) {
                var appenddata = '<option>Selecione uma amostra</option>';
                $.each(data, function (key, value) {
                    appenddata += "<option value=\"" + value.codigo + "\">" + value.descricao + " </option>";
                });
                $('#amostra').html(appenddata);
            } else {
                $('#amostra').html(null);
            }
        }
    });
});
