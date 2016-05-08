<%@include file="../template/header.jsp" %>
<div class="row-fluid" >
    <form action="template" method="post">
        <div class="row-fluid" style="">

            <div class="bs-docs-example form-inline">
                <div class="bs-docs-text"> Informações </div>
                <div>
                    Usuário : <b>Rodrigo</b>
                </div>
                <hr>
                <div class="row-fluid">
                    <label for="area">Área:</label>
                    <select name="area">
                        <option value="1">A</option>
                        <option value="2">B</option>
                        <option value="3">C</option>
                    </select> 
                    <label for="amostra">Amostra:</label>
                    <select name="amostra">
                        <option value="1">Cálcio</option>
                        <option value="2">Produção</option>
                        <option value="3">PH</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row-fluid" style="">

            <div class="bs-docs-example span12" >

                <div class="bs-docs-text "> Paramêtros </div>
                <div class=" form-inline">
                    <label for="desc">Descrição:</label>
                    <input id="desc" type="text" name="desc"/>
                    <label for="interpolador">Interpolador:</label>
                    <select name="interpolador">
                        <option value="KO">Krigagem Ordinaria</option>
                        <option value="IDP">Inverso da Distancia</option>              
                    </select> 
                </div>
                <hr>

                <div class="bs-docs-example span4" style="margin-left: 0px">
                    <div class="bs-docs-text">Pixel</div>
                    <div class=" form-inline">
                        <label for="tamx">Tam. X</label>
                        <input id="tamx" type="text" name="tamx" class="input-mini" value="5"/>

                        <label for="tamy">Tam. Y</label>
                        <input id="tamy" type="text" name="tamy" class="input-mini" value="5"/>
                    </div>
                </div>
                <div class="bs-docs-example span8"  style="margin-left: 0px">
                    <div class="bs-docs-text">Variaveis</div>
                    <div class=" form-inline">
                        <label for="expoente">Expoente</label>
                        <input id="expoente" type="text" name="expoente" class="input-mini" value="2"/>

                        <label for="vizinhos">N° Vizinhos</label>

                        <input id="vizinhos" type="text" name="vizinhos" class="input-mini" value="10"/>
                    </div>
                </div>
            </div>  
            <div class="bs-docs-example span12" style="margin-left: 0px">

                <div class="bs-docs-text">Semivariograma</div>
                <div class="bs-docs-example">
                    <div class="bs-docs-text">Geral</div>
                    <div class=" form-inline">
                        <label for="estimador">Estimador:</label>
                        <select name="estimador" class="input-small">
                            <option value="classical">Classical</option>                  
                        </select>
                        <label for="nlags">N° Lags</label>
                        <input id="nlags" type="text" name="nlags" class="input-mini" value="11"/>
                        <label for="npares">N° Pares</label>
                        <input id="npares" type="text" name="npares" class="input-mini" value="30"/>
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




