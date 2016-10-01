<%@include file="../template/header.jsp" %>
<div class="row-fluid" >
    <form action="funcaoGeo" method="post">
        <div class="row-fluid" style="">

            <div class="bs-docs-example">
                <div class="bs-docs-text"> Informações </div>
                <div>
                    Usuário : <b>Alan</b>
                    <input id="user" type="hidden" name="user" value="872" class="input-mini"/>
                </div>
                <hr>
                <!-- SERÁ NECESSÁRIO UMA CONEXÃO COM O BANCO DE DADOS PARA BUSCAR ESSAS INFORMAÇÕES-->
                <div class="row-fluid">
                    <div class="">
                        <div class="span3">
                            <label for="area">Área:</label>
                            <select name="area">
                                <option value="1">A</option>
                                <option value="2">B</option>
                                <option value="3">C</option>
                            </select> 
                        </div>                      
                    </div>               
                </div>

                <div class="row-fluid">
                    <div class="span3">
                        <label for="desc">Descrição:</label>
                        <input id="desc" type="text" name="desc" class="input-xxlarge" required="true"/>
                    </div> 
                </div>
            </div>
        </div>


        <div class="row-fluid" style="">
            <div class="bs-docs-example span12" >                       
                <div class="bs-docs-text "> Configurações </div>
                <div class="row-fluid">
                    <div class="span3">
                        <label for="metodo">Métodos de seleção de variáveis</label>
                        <select name="metodo">
                            <option value="null" selected="true">Selecione o método</option>
                            <option value="pca">PCA</option>
                            <option value="mult_pca">MULTISPATI-PCA</option>
                            <option value="matriz">Matriz de Correlação Espacial</option>
                        </select>
                    </div>
                </div>
                <div  id="var_disp" style="display: none;" class="row-fluid">
                    <div class="span3"  >
                        <label for="var">Variáveis disponíveis</label>
                        <select multiple size="10" >
                            <option value="altitude">Altitude</option>
                            <option value="areia">Areia</option>
                            <option value="argila">Argila</option>
                            <option value="cp1">CP1</option>
                            <option value="cp2">CP2</option>
                            <option value="cp3">CP3</option>
                            <option value="...">...</option>
                            <option value="rsp">RSP 0-10</option>
                            <option value="SPC3">SPC 3</option>
                        </select> 
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-plus-sign"></i></button>

                    </div>

                    <div class="span3" >
                        <label for="var">Variáveis selecionadas</label>
                        <select multiple size="10" >
                            <option value="argila">Argila</option>
                            <option value="rsp">RSP 0-10</option>
                            <option value="SPC3">SPC 3</option>
                        </select>
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-minus-sign"></i></button>


                    </div>
                    <div class="span3" >
                        <label for="desc">Percentual mínimo da variância</label>
                        <input id="perc" type="number" name="perc" value="5"class="input-mini" required="true"/>
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




