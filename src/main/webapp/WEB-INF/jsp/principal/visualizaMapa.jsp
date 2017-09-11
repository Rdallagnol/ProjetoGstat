<%@include file="../template/header.jsp" %>
<div class="row-fluid" style="">
    <h1>${lineId}</h1>
    <c:if test="${not empty lineId}">
        <div class="row-fluid bs-docs-example" >
            <div class="row-fluid bs-docs-example">
                <img src="${pageContext.servletContext.contextPath}/mapa/${userID}/mapa_${lineId}/mapa.png">                
            </div>
        </div>
    </c:if>
</div>
<%@include file="../template/footer.jsp" %>
