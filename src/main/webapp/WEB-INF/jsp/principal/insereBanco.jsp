<%@include file="../template/header.jsp" %>
<div style="border: 0.5px solid silver">
        <c:forEach items="${mensagem}" var="linha">
            ${linha}<br>
        </c:forEach>
</div>
<%@include file="../template/footer.jsp" %>