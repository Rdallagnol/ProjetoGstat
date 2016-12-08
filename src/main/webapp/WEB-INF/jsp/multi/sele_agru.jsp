<%@include file="../template/header.jsp" %>
<div class="row-fluid" >
    <form action="" method="post">
        <div class="row-fluid" style=""> 

            <div class="bs-docs-example">
                <div class="bs-docs-text"> Informações </div>
                <div>
                    Usuário : <b>Alan Gavioli</b>
                    <input id="user" type="hidden" name="user" value="872" class="input-mini"/>
                </div>
                <hr>
                <!-- SERÁ NECESSÁRIO UMA CONEXÃO COM O BANCO DE DADOS PARA BUSCAR ESSAS INFORMAÇÕES-->
                <div class="row-fluid">
                    <div class="">
                        <div class="span3">
                            <label for="area">Área:</label>
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
                        <label for="desc">Descrição:</label>
                        <input id="desc" type="text" name="desc" value="Propriedade de Aldo Tasca, localizada em Céu Azul - PR"class="input-xxlarge" required="true"/>
                    </div> 
                </div>
            </div>
        </div>


        <div class="row-fluid" style="">
            <div class="bs-docs-example span12" >                       
                <div class="bs-docs-text "> Etapa 1 </div>
                <div class="row-fluid">
                    <div class="span3">
                        <label for="metodo">Métodos de agrupamento de dados</label>

                        <select multiple size="12" style="width: 300px">
                            <option value="a1">Average Linkage</option>
                            <option value="a2">Bagged Clustering</option>
                            <option value="a3">Centroid Linkage</option>
                            <option value="a4">Complete Linkage</option>
                            <option value="a5">Clustering Large Applications</option>
                            <option value="a6">Fuzzy Analysis Clustering(Fanny)</option>
                            <option value="a7">Fuzzy C-means</option>
                            <option value="a8">Hard Competitive Learning</option>
                            <option value="a9">Hybrid Hierarchical Clustering</option> 
                            <option value="a10">K-means</option>  
                            <option value="a11">McQuitty's Method</option> 
                        </select>
                    </div>
                </div>
                <hr>
                <div  id="var_disp"  class="row-fluid">
                    <div class="span3"  >
                        <label for="var">Variáveis disponíveis</label>
                        <select multiple size="11" >
                            <option value="declividade">CP1</option>
                            <option value="densidade">CP2</option>
                            <option value="prodsoja">CP3</option>
                            <option value="rsp1">CP4</option>
                            <option value="rsp2">Declividade</option>
                            <option value="silte">Densidade</option>
                            <option value="silte">Produtividade de Soja</option>
                            <option value="silte">RSP 0,1 - 0,2 m</option>
                            <option value="silte">RSP 0,3 - 0,4 m</option>
                        </select> 
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-plus-sign"></i></button>

                    </div>

                    <div class="span3" >
                        <label for="var">Variáveis selecionadas</label>
                        <select multiple size="11" >
                            <option value="CPE1">CPE1</option>
                            <option value="CPE2">CPE2</option>
                            
            
                        </select>
                        <br>
                        <button class="btn btn-min" type="button"><i class="icon-minus-sign"></i></button>


                    </div>
                    <div class="span3" >
                      
                        <div id="minZn_dv">
                            <label for="minZn">Quantidade mínima de ZMs</label>
                            <input id="minZn" type="number" name="minZn" value="2"class="input-mini" />
                        </div>
                        
                         <div id="maxZn_dv">
                            <label for="maxZn">Quantidade máxima de ZMs</label>
                            <input id="maxZn" type="number" name="maxZn" value="4"class="input-mini" />
                        </div>
                    </div>
                     <div class="span3" >
                         <div id="maxIter_dv">
                            <label for="maxIter">Quantidade máxima de Iterações</label>
                            <input id="maxIter" type="number" name="maxIter" value="500"class="input-mini" />
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
            <label for="desemp"><b>Desempenho do método selecionado:</b></label>
            <table class="table table-bordered">
                <tr>
                    <th class="span1">Quantidade de classes</th>    
                    <th class="span1">ANOVA(Teste de Tukey)</th>
                    <th class="span1">VR</th>
                    <th class="span1">ASC</th>          

                </tr>
                <tr>
                  
                    <td>2</td>
                    <td>a b</td>
                    <td>33,8</td>
                    <td>0,59</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>a b a</td>
                    <td>23,8</td>
                    <td>0,46</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>a a b b</td>
                    <td>35,8</td>
                    <td>0,39</td>
                </tr>
                
            </table> 
            <hr>
             <div class="">
                    <center>
                        <button class="btn btn-large btn-primary" type="submit">Gravar Classes</button>
                    </center>
                </div>
        </div>
    </div>



</div>





<%@include file="../template/footer.jsp" %>




