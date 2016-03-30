$(document).on('click', '.toggleBtn', function() {
    $(this).children().toggleClass("icon-minus icon-plus");
});
$('#motivRej').modal({
    show: 'true'
});

jQuery(document).ready(function($) {
    $("#cpf").mask("999.999.999-99");
    $("#cnpj").mask("99.999.999/9999-99");
    $("#diasChamado").mask("99999999999");
    $("#numChamadobusca").mask("99999999999");
    $("#rg").mask("9.999.999-9");
    $("#horas").mask("99:99");
    $("#horain").mask("99:99");
    $("#horaout").mask("99:99");
    $("#dataInicio").mask("99/99/9999");
    $("#cep").mask("99999-999");
    $("#dataFim").mask("99/99/9999");
    $("#dataNormal").mask("99/99/9999");
    $("#dataNascimento").mask("99/99/9999");
    $("#valorRec").maskMoney({showSymbol: true, symbol: "R$", decimal: ",", thousands: "."});
    $("#ddd").mask("99");
    $("#horas").mask("99");
  
    $("#sal_base").mask("9999.99");

});

function somente_numero(campo) {
    var digits = "-0123456789"
    var campo_temp
    for (var i = 0; i < campo.value.length; i++) {
        campo_temp = campo.value.substring(i, i + 1)
        if (digits.indexOf(campo_temp) == -1) {
            campo.value = campo.value.substring(0, i);
        }
    }
}
function moveElementoDaLista(objFrom, objTo) {
    try {
        for (i = 0; i < objFrom.options.length; i++) {
            if (objFrom.options[i].selected == true) {
                no = new Option();
                no.value = objFrom.options[i].value;
                no.text = objFrom.options[i].text;
                objTo.options[objTo.options.length] = no;
                for (j = i + 1; j < objFrom.options.length; j++) {
                    objFrom.options[j - 1].value = objFrom.options[j].value;
                    objFrom.options[j - 1].text = objFrom.options[j].text;
                    objFrom.options[j - 1].selected = objFrom.options[j].selected;
                }
                objFrom.options[objFrom.options.length - 1] = null;
                i--;
            }
        }
    } catch (e) {
        alert("Problemas verifique o javascript do documnento, Metodo,nomeclatura e a decleração'." +
                "\nCausa:\n" + e);
    }
}
//Metodo que verifica todas as opções do listbox
function seleciona(Form, Campo) {
    document.forms['Form'].Campo.options
    for (i = 0; i < document.forms['Form'].Campo.options.length; i++) {
        document.forms['Form'].Campo.options[i].selected = true;

    }
}


function limpaCamposFormAddRas(ChamadoNomeSistema, ChamadoTituloRas) {
    var chamadoNomeSistema = document.getElementById("ChamadoNomeSistema");
    var chamadoTitulo = document.getElementById("ChamadoTituloRas");

    chamadoNomeSistema.value = '';
    chamadoTitulo.value = '';
}

function addParticipantes(idUsuario, idTipoUsuario) {
    var idUsuario = idUsuario;
    var idTipoUsuario = idTipoUsuario;
    var idteste = document.getElementById("teste");
    idteste.value =
            [idTipoUsuario.options[idTipoUsuario.selectedIndex].text + ' - ' +
                        idUsuario.options[idUsuario.selectedIndex].text];
    var p = document.getElementById("testep");

    p.innerText = p.innerText + idteste.value + "\n";
    idTipoUsuario.value = null;
    idUsuario.value = null;


}

function conclusaoChamado()
{
    var e = document.getElementById("DespesaIdTipoDespesa");
    var strTipoDespesa = e.options[e.selectedIndex].value;
    if (strTipoDespesa != 1) {
        $("#combustivels").attr("disabled", true);
        $("#combustivels").attr("required", false);
    } else {
        $("#combustivels").attr("disabled", false);
        $("#combustivels").attr("required", true);
    }
}


function tipoCliente()
{
    var e = document.getElementById("tiposCliente");
    var valor = e.options[e.selectedIndex].value;

    if (valor == 1) {
        document.getElementById("cnpj").disabled = true;
        document.getElementById("ie").disabled = true;
        document.getElementById("cpf").disabled = false;
        document.getElementById("dataNascimento").disabled = false;
        document.getElementById("rg").disabled = false;
    }
    if (valor == 2) {
        document.getElementById("cnpj").disabled = false;
        document.getElementById("ie").disabled = false;
        document.getElementById("dataNascimento").disabled = true;
        document.getElementById("cpf").disabled = true;
        document.getElementById("rg").disabled = true;
    }
}




function conclusaoChamadoCategoria()
{
    var e = document.getElementById("situacoes");
    var c = document.getElementById("categorias");

    var strCat = c.options[c.selectedIndex].value;
    var strUser = e.options[e.selectedIndex].value;


    if (strCat == 1 || strCat == 2) {
        $("#plataformas").attr("required", "required");
        if (strUser == 2) {
            $("#causas").attr("required", "required");
        }
        $("#horasChamado").attr("required", "required");
    } else {
        $("#modulos").attr("required", false);
        $("#plataformas").attr("required", false);
        $("#causas").attr("required", false);
        $("#horasChamado").attr("required", false);
    }
}



function rejeitaChamado()
{
    alert('Preencher o motivo da reijição');
    $("#modulos").attr("required", "required");


}

function verificaNota()
{
    var e = document.getElementById("nota");
    var strUser = e.options[e.selectedIndex].value;
    if (strUser < 70) {
        alert('Deixe sua opinião:');
        $("#obs").attr("required", "required");

    } else {
        $("#obs").attr("required", false);
    }
}


function procuraListBox()
{
    var l = document.getElementById('ChamadoTodosEspec');
    var tb = document.getElementById('ChamadoBusca');
    if (tb.value == "") {
        ClearSelection(l);
    }
    else {
        for (var i = 0; i < l.options.length; i++) {
            if (l.options[i].text.toLowerCase().match(tb.value.toLowerCase()))
            {
                l.options[i].selected = true;
                return false;
            }
            else
            {
                ClearSelection(l);
            }
        }
    }
}


function ClearSelection(lb) {
    lb.selectedIndex = -1;
}


//Organizar metodo - feito Rdallagnol
$(document).ready(function() {
    var activeSystemClass = $('.list-group-item.active');

    $('#system-search').keyup(function() {
        var that = this;
        var tableBody = $('.table-list-search tbody');
        var tableRowsClass = $('.table-list-search tbody tr');
        $('.search-sf').remove();
        tableRowsClass.each(function(i, val) {
            var rowText = $(val).text().toLowerCase();
            var inputText = $(that).val().toLowerCase();
            if (inputText != '')
            {
                $('.search-query-sf').remove();
                tableBody.prepend('<tr class="search-query-sf"><td colspan="6"><strong>Procurando por: "'
                        + $(that).val()
                        + '"</strong></td></tr>');
            }
            else
            {
                $('.search-query-sf').remove();
            }
            if (rowText.indexOf(inputText) == -1)
            {
                //hide rows
                tableRowsClass.eq(i).hide();
            }
            else
            {
                $('.search-sf').remove();
                tableRowsClass.eq(i).show();
            }
        });
        if (tableRowsClass.children(':visible').length == 0)
        {
            tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6">Não encontrado.</td></tr>');
        }
    });
});


var data = new Array();
var dados = new Array();

function add_element() {
    var idUsuario = document.getElementById("idUsuario");
    var idTipoParticipante = document.getElementById("idTipoParticipante")
    if (idUsuario.value > null && idTipoParticipante.value > null) {
        document.getElementById("idUsuario").value;

        data.push(idTipoParticipante.options[idTipoParticipante.selectedIndex].text
                + ' - ' + idUsuario.options[idUsuario.selectedIndex].text);

        dados.push([idUsuario.value, idTipoParticipante.value]);

        document.getElementById('t1').value = '';
        disp();
    } else {
        alert('Selecione os dois campos')
    }
}

function disp() {
    var str = '';

    str = '<b>Numero de participantes : ' + data.length + ' </b><br>';
    for (i = 0; i < data.length; i++)
    {

        str += "<tr>" + data[i] + "<button class='btn-link' onclick='removeElemento(" + i + ")'><i class='icon-remove-circle'></i></button></tr><br>";
    }
    document.getElementById('disp').innerHTML = str;
    $('#ChamadoConjuntoParticipante').val(JSON.stringify(dados));
}

function removeElemento(i) {
    data.splice(i, 1);
    dados.splice(i, 1);

    var str = '';

    str = '<b>Numero de participantes : ' + data.length + ' </b><br>';
    for (i = 0; i < data.length; i++)
    {
        str += "<tr>" + data[i] + "<button class='btn-link' onclick='removeElemento(" + i + ")'><i class='icon-remove-circle'></i></button></tr><br>";
    }
    document.getElementById('disp').innerHTML = str;

    $('#ChamadoConjuntoParticipante').val(JSON.stringify(dados));

}