<%@include file="../template/header.jsp" %>
<div class="row-fluid" >
    <form action="funcaoGeo" method="post">
        <div class="row-fluid" style="">

            <div class="bs-docs-example">
                <div class="bs-docs-text"> Informa��es </div>
                <div>
                    Usu�rio : <b>Rodrigo</b>
                    <input id="user" type="hidden" name="user" value="872" class="input-mini"/>
                </div>
                <hr>
                <!-- SER� NECESS�RIO UMA CONEX�O COM O BANCO DE DADOS PARA BUSCAR ESSAS INFORMA��ES-->
                <div class="row-fluid">
                    <div class="">
                        <div class="span3">
                            <label for="area">�rea:</label>
                            <select name="area">
                                <option value="1">A</option>
                                <option value="2">B</option>
                                <option value="3">C</option>
                            </select> 
                        </div>
                        <div class="span3">
                            <label for="amostra">Amostra:</label>
                            <select name="amostra">
                                <option value="1">C�lcio</option>
                                <option value="2">Produ��o</option>
                                <option value="3">PH</option>
                            </select>
                        </div>
                    </div>               
                </div>

                <div class="row-fluid">
                    <div class="span3">
                        <label for="desc">Descri��o:</label>
                        <input id="desc" type="text" name="desc" class="input-xxlarge" required="true"/>
                    </div> 
                </div>
            </div>
        </div>


        <div class="row-fluid" style="">
            <div class="bs-docs-example span12" >                       
                <div class="bs-docs-text "> Configura��es </div>
                <div class="">
                    <div class="bs-docs-example span4" id="defaultdiv" name="defaultdiv" style="margin-left: 0px;">
                        <div class="bs-docs-text">Pixel</div>
                        <div class=" form-inline">
                            <label for="tamx">Tam. X</label>
                            <input id="tamx" type="text" name="tamx" class="input-mini" value="5"/>

                            <label for="tamy">Tam. Y</label>
                            <input id="tamy" type="text" name="tamy" class="input-mini" value="5"/>
                        </div>
                    </div>                 
                </div>

                <div class="">
                    <div class="bs-docs-example span12" style="margin-left: 0px;">
                        <div class="bs-docs-text">Avan�ado</div>

                        <div class="row-fluid" style="">
                            <div class="span3">
                                <label for="auto_lags">ISI</label>
                                <select id="isi" name="isi" class="input-mini">
                                    <option value="true" selected="selected">Sim</option>
                                    <option value="false">N�o</option>                                 
                                </select>

                                <label for="v_lambda">Valor Lambda</label>
                                <input id="v_lambda" type="text" name="v_lambda" class="input-mini" value="1"/>
                            </div>
                            <div class="span3">
                                <label for="auto_lags">Lags Autom�ticos</label>
                                <select id="auto_lags" name="auto_lags" class="input-mini">
                                    <option value="true" selected="selected">Sim</option>
                                    <option value="false">N�o</option>                                 
                                </select>

                                <label for="nro_lags">N� De Lags</label>
                                <input id="nro_lags" type="text" name="nro_lags" class="input-mini" value="11"/>

                            </div>
                            <div class="span3">
                                <label for="estimador">Estimador</label>
                                <select id="estimador" name="estimador" class="input-large">
                                    <option value="classical" selected="selected">Matheron - Classical</option>
                                    <option value="modulus">Cressie - Modulus</option>                                 
                                </select>

                                <label for="cutoff">Cutoff</label>
                                <input id="cutoff" type="text" name="cutoff" class="input-mini" value="50"/>
                            </div>
                            
                            
                            <div class="span3">
                                <label for="nro_intervalos_alc">N� Intervalo Alcance</label>
                                <input id="nro_intervalos_alc" type="text" name="nro_intervalos_alc" class="input-mini" value="5"/>

                                <label for="nro_intervalos_contr">N� Intervalo Contribui��o</label>
                                <input id="nro_intervalos_contr" type="text" name="nro_intervalos_contr" class="input-mini" value="5"/>

                            </div>
                        </div>
                    </div>                 
                </div>
            </div>
        </div>


        <div class="btn span11" style="visibility: hidden"></div>
        <div class="navbar navbar-fixed-bottom">
            <center>
                <button class="btn btn-large btn-primary" type="submit">Enviar</button>
            </center>
        </div>

    </form>


</div>

<%@include file="../template/footer.jsp" %>




