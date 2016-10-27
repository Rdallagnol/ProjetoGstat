<%@include file="../template/header.jsp" %>
<div class="row-fluid" >
    <form action="" method="post">
        <div class="row-fluid" style="">

            <div class="bs-docs-example">
                <div class="bs-docs-text"> Informa��es </div>
                <div>
                    Usu�rio : <b>Alan Gavioli</b>
                    <input id="user" type="hidden" name="user" value="872" class="input-mini"/>
                </div>
                <hr>
                <!-- SER� NECESS�RIO UMA CONEX�O COM O BANCO DE DADOS PARA BUSCAR ESSAS INFORMA��ES-->
                <div class="row-fluid">
                    <div class="">
                        <div class="span3">
                            <label for="area">�rea:</label>
                            <select name="area">
                                <option value="1">Tasca - A</option>
                                <option value="2">B</option>
                                <option value="3">C</option>
                            </select> 
                        </div>                      
                    </div>               
                </div>

                <div class="row-fluid">
                    <div class="span3">
                        <label for="desc">Descri��o:</label>
                        <input id="desc" type="text" name="desc" value="Propriedade de Aldo Tasca, localizada em C�u Azul - PR"class="input-xxlarge" required="true"/>
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

                        <input type="checkbox" name="m1" value="m1" checked="true"> An�lise de Correla��o Espacial<br>
                        <input type="checkbox" name="m2" value="m2" checked="true"> MPCA-All<br>
                        <input type="checkbox" name="m3" value="m3" checked="true"> MPCA-SC<br>
                        <input type="checkbox" name="m4" value="m4" checked="true"> PCA-All<br>
                        <input type="checkbox" name="m5" value="m5" checked="true"> PCA-SC<br>
                    </div>
                </div>
                <hr>
                <div  id="var_disp"  class="row-fluid">
                    <div class="span3"  >
                        <label for="var">Vari�veis dispon�veis</label>
                        <select multiple size="10" >
                            
                        </select> 
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-plus-sign"></i></button>

                    </div>

                    <div class="span3" >
                        <label for="var">Vari�veis selecionadas</label>
                        <select multiple size="10" >
                            <option value="areia">Areia</option>
                            <option value="argila">Argila</option>
                            <option value="elevacao">Eleva��o</option>
                            <option value="rsp">RSP 0 - 0,1 m</option>
                            <option value="declividade">Declividade</option>
                            <option value="densidade">Densidade</option>
                            <option value="prodsoja">Produtividade de soja</option>
                            <option value="rsp1">RSP 0,1 - 0,2 m</option>
                            <option value="rsp2">RSP 0,2 - 0,3 m</option>
                            <option value="silte">Silte</option>
                        </select>
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-minus-sign"></i></button>


                    </div>
                    <div class="span3" >
                  <!--  
                        <div>
                            <label for="perc">Percentual m�nimo da vari�ncia</label>
                            <input id="perc" type="number" name="perc" value="70"class="input-mini" required="true"/>
                        </div>
                  -->
                        <div id="raio_dv">
                            <label for="raio">Raio de vizinhan�a (<span class="label label-info">Metros</span>)</label>
                            <input id="raio" type="number" name="raio" value="240"class="input-mini" />
                        </div>
                    </div>


                </div>
                <div class="">
                    <center>
                        <button class="btn btn-large btn-primary" type="submit">Executar</button>
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

            <table class="table table-bordered">
                <tr>
                    <th class="span1"></th>    
                    <th class="span1">Classifica��o</th>
                    <th>M�todo</th>           

                </tr>
                <tr>
                    <td><input type="checkbox" checked="true" name="c1" value="c1"></td>
                    <td>1�</td>
                    <td>MPCA-SC</td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="c2" value="c2"></td>
                    <td>2�</td>
                    <td>MPCA-All</td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="c3" value="c3"></td>
                    <td>3�</td>
                    <td>PCA-SC</td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="c4" value="c4"></td>
                    <td>4�</td>
                    <td>PCA-All</td>
                </tr>
            </table> 
            <hr>
            <div id="linha" >
                <form action="" method="post">
                    <table class="table table-bordered">
                        <tr>
                            <th><span class="badge badge-success">MPCA-SC</span></th>
                            <th>Componente Principal</th>
                            <th>Percentual da Vari�ncia Original</th>
                            <th>Percentual Acumulado da Vari�ncia</th>
                        </tr>
                        <tr>
                            <td><input  id="" name="" type="checkbox" /></td>
                            <td>CPE1</td>
                            <td>71</td>  
                            <td>71</td>  
                        </tr>
                        <tr>
                            <td><input id="" name="" type="checkbox" /></td>
                            <td>CPE2</td>    
                            <td>29</td>  
                            <td>100</td> 
                        </tr>

                    </table> 
                    <hr>
                    <div class="">
                        <center>
                            <button class="btn btn-large btn-primary" type="submit">Gravar CPs</button>
                        </center>
                    </div>
                </form>
            </div>
        </div>
    </div>



</div>





<%@include file="../template/footer.jsp" %>




