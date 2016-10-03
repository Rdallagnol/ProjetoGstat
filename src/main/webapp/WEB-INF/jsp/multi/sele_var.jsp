<%@include file="../template/header.jsp" %>
<div class="row-fluid" >
    <form action="" method="post">
        <div class="row-fluid" style="">

            <div class="bs-docs-example">
                <div class="bs-docs-text"> Informa��es </div>
                <div>
                    Usu�rio : <b>Alan</b>
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
                <div class="bs-docs-text "> Etapa 1 </div>
                <div class="row-fluid">
                    <div class="span3">
                        <label for="metodo">M�todos de sele��o de vari�veis</label>
                        <select name="metodo">
                            <option value="null" selected="true">Selecione o m�todo</option>
                            <option value="pca">PCA</option>
                            <option value="mult_pca">MULTISPATI-PCA</option>
                            <option value="matriz">Matriz de Correla��o Espacial</option>
                        </select>
                    </div>
                </div>
                <div  id="var_disp" style="display: none;" class="row-fluid">
                    <div class="span3"  >
                        <label for="var">Vari�veis dispon�veis</label>
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
                        <label for="var">Vari�veis selecionadas</label>
                        <select multiple size="10" >
                            <option value="argila">Argila</option>
                            <option value="rsp">RSP 0-10</option>
                            <option value="SPC3">SPC 3</option>
                        </select>
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-minus-sign"></i></button>


                    </div>
                    <div class="span3" >
                        <div>
                            <label for="perc">Percentual m�nimo da vari�ncia</label>
                            <input id="perc" type="number" name="perc" value="5"class="input-mini" required="true"/>
                        </div>
                        <div id="raio_dv">
                            <label for="raio">Raio de vizinhan�a (<span class="label label-info">Metros</span>)</label>
                            <input id="raio" type="number" name="raio" value="5"class="input-mini" />
                        </div>
                    </div>


                </div>
                <div class="">
                    <center>
                        <button class="btn btn-large btn-primary" type="submit">Enviar</button>
                    </center>
                </div>
            </div>


        </div>

        


    </form>

</div>    




<!-- Segunda tela --> 
<div class="row-fluid" >
    <div class="row-fluid" style="">
        <div class="bs-docs-example span12" >                       
            <div class="bs-docs-text "> Etapa 2 </div>


            <form action="" method="post">
                <table class="table table-bordered">
                    <tr>
                        <th></th>
                        <th>Comp. Principal</th>
                        <th>Perc. Vari�ncia</th>
                        <th>Perc. Acumulado</th>
                    </tr>
                    <tr>
                        <td><input  id="" name="" type="checkbox" /></td>
                        <td>CP 3</td>
                        <td>11,0%</td>
                        <td>11,0%</td>
                    </tr>
                    <tr>
                        <td><input id="" name="" type="checkbox" /></td>
                        <td>CP 4</td>
                        <td>3,0%</td>
                        <td>14,0%</td>
                    </tr>
                    <tr>
                        <td><input id="" name="" type="checkbox" /></td>
                        <td>CP 5</td>
                        <td>14,0%</td>
                        <td>15,0%</td>
                    </tr>
                </table> 
                <hr>
                <div class="">
                    <center>
                        <button class="btn btn-large btn-primary" type="submit">Interpolar CPs</button>
                    </center>
                </div>
            </form>
        </div>
    </div>



</div>





<%@include file="../template/footer.jsp" %>




