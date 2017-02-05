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
      </tr>
    </thead>
    <tbody>
        <c:forEach var="analise" items="${analises}">
            <tr>
                <td>${analise.analise_header_id}</td>
                <td>${analise.descricao_analise}</td>
                <td>${analise.area_id}</td>
                <td>${analise.amostra_id}</td>
                <td>${analise.created_by}</td>
                <td>${analise.creation_date}</td>
                <td>${analise.status}</td>
            </tr>
        </c:forEach>
      
    </tbody>
  </table>

    </div>
</div>
<div class="row-fluid bs-docs-example" >



 



    <hr>
    <form action="visualizaGeo" method="post">

        <div>  
            <label for="userID">Cod. Usuário: </label>
            <input id="userID" type="text" name="userID"  value="872" class="input-mini"/>
            <label for="analiseDesc">Descrição:</label>
            <input id="analiseDesc" type="text" name="analiseDesc" class="input-xxlarge" required="true"/>
        </div> 

        <div class="btn span11" style="visibility: hidden"></div>
        <div class="navbar navbar-fixed-bottom">
            <center>
                <button class="btn btn-large btn-primary" type="submit">Buscar</button>
            </center>
        </div>
    </form>

</div>
<c:if test="${not empty userID}">
    <div class="row-fluid bs-docs-example">
        <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/boxplot.png">
        <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/histograma.png">
        <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/postplot.png">
        <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/plot.png">
    </div>
</c:if>
<%@include file="../template/footer.jsp" %>
