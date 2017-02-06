<%@include file="../template/header.jsp" %>
<div class="row-fluid" style="">

    <div class="bs-docs-example">
        <div class="bs-docs-text"> Analises Realizadas </div>
        <table class="table table-bordered">
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
                <form action="visualizaGeo" method="post">     

                    <input id="analiseId" type="hidden" name="analiseId"  value="${analise.analise_header_id}" />
                    <td>${analise.analise_header_id}</td>
                    <td>${analise.descricao_analise}</td>
                    <td>${analise.area.nome}</td>
                    <td>${analise.amostra_id}</td>
                    <td>${analise.created_by}</td>
                    <td>${analise.creation_date}</td>
                    <td>${analise.status}</td>
                    <td><button class="btn btn-mini btn-primary" type="submit">Visualizar</button></td>
                </form>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>
<div class="row-fluid bs-docs-example" >
    <c:if test="${not empty userID}">
        <div class="row-fluid bs-docs-example">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/box_plot.png">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/grafico_pontos.png">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/histograma.png">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/plot_geral.png">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/semi_exp.png">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/semi_geral.png">
            <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/semiv_melhores.png">
        </div>
    </c:if>
</div>
<%@include file="../template/footer.jsp" %>
