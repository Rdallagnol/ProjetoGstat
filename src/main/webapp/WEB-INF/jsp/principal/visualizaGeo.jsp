<%@include file="../template/header.jsp" %>
<div class="row-fluid bs-docs-example" >
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


<div class="row-fluid bs-docs-example">
    <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/boxplot.png">
    <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/histograma.png">
    <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/postplot.png">
    <img src="${pageContext.servletContext.contextPath}/file/${userID}/${analiseDesc}/plot.png">
</div>
<%@include file="../template/footer.jsp" %>
