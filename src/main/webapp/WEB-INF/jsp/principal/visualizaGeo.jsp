<%@include file="../template/header.jsp" %>
<div class="row-fluid" style="">

    <c:if test="${mensagemOK != null}"> 
        <div class="alert alert-success alert-block">      
            <h4>Sucesso!</h4>
            ${mensagemOK}
        </div>
    </c:if>

    <div class="bs-docs-example">
        <div class="bs-docs-text"> Analises Realizadas </div>
        <div class="table-responsive " style="overflow: auto; max-height: 300px; overflow-y: auto ">
            <table class="table table-bordered table-striped table-hover table-condensed" style="">
                <thead>
                    <tr>

                        <th>Código</th>
                        <th>Descrição</th>
                        <th>Área</th>
                        <th>Amostra</th>
                        <th>Usuário</th>
                        <th>Data</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="analise" items="${analises}">

                        <tr>
                            <td>${analise.analise_header_id}</td>
                            <td>${analise.descricao_analise}</td>
                            <td>${analise.area.nome}</td>
                            <td>${analise.amostra.descricao}</td>
                            <td>${analise.created_by}</td>
                            <td>${analise.creation_date}</td>
                            <td>${analise.status}</td>
                            <td> 
                                <form action="${linkTo[PrincipalController].visualizaGeo()}" method="post" class="btn btn-link" > 
                                    <input id="analiseId" type="hidden" name="analiseId"  value="${analise.analise_header_id}" />
                                    <button class="btn btn-mini btn-primary" type="submit">Visualizar</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${not empty analiseLines}">
        <div class="bs-docs-example">
            <div class="bs-docs-text"> Linhas da Analise </div>
            <div class="table-responsive" style="overflow: auto; max-height: 300px; overflow-y: auto ">
                <table class="table table-bordered  table-hover table-condensed">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Modelo</th>                   
                            <th>Método</th>
                            <th>Min. ICE</th>                   
                            <th>Contribuição</th>
                            <th>Alcance</th>                   
                            <th>Val. Kappa</th>
                            <!--<th>EM</th>-->
                            <!--<th>Desvio Padrão EM</th>-->
                            <th>ISI</th>
                            <th>Opções</th>

                        </tr>
                    </thead>
                    <tbody >
                        <c:forEach var="analiseLine" items="${analiseLines}" varStatus="myIndex">


                            <c:if test="${myIndex.index == 0}">  
                                <tr style="background-color: #25d366">

                                    <td class="">${analiseLine.analise_lines_id}</td>
                                    <td>${analiseLine.modelo}</td>
                                    <td>${analiseLine.metodo}</td>
                                    <td>${analiseLine.min_ice}</td>
                                    <td>${analiseLine.melhor_contrib}</td>
                                    <td>${analiseLine.melhor_alcance}</td>
                                    <td>${analiseLine.melhor_val_kappa}</td>
                                    <!--<td>${analiseLine.erro_medio}</td>-->
                                    <!--<td>${analiseLine.dp_erro_medio}</td>-->
                                    <td>${analiseLine.isi}</td>
                                    <td class="">

                                        <button class="btn btn-mini btn-primary" type="submit">Gerar Mapa</button>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${myIndex.index != 0}">   
                                <tr>
                                    <td class="">${analiseLine.analise_lines_id}</td>
                                    <td>${analiseLine.modelo}</td>
                                    <td>${analiseLine.metodo}</td>
                                    <td>${analiseLine.min_ice}</td>
                                    <td>${analiseLine.melhor_contrib}</td>
                                    <td>${analiseLine.melhor_alcance}</td>
                                    <td>${analiseLine.melhor_val_kappa}</td>
                                    <!--<td>${analiseLine.erro_medio}</td>-->
                                    <!--<td>${analiseLine.dp_erro_medio}</td>-->
                                    <td>${analiseLine.isi}</td>
                                    <td class="">
                                        <button class="btn btn-mini btn-primary" type="submit">Gerar Mapa</button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty userID}">
        <div class="row-fluid bs-docs-example" >
            <div class="row-fluid bs-docs-example">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/box_plot.png">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/grafico_pontos.png">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/histograma.png">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/plot_geral.png">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/semi_exp.png">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/semi_geral.png">
                <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/semiv_melhores.png">
            </div>
        </div>
    </c:if>
</div>
<%@include file="../template/footer.jsp" %>
