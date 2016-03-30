<%@include file="../template/header.jsp" %>
<form action="passaParametros" method="post">
    <fieldset>
        <legend>Passar parametros</legend>
        <label for="x1">x1:</label>
        <input id="x1" type="text" name="x1"/>
        <label for="x2">x2</label>
        <input id="x2" type="text" name="x2"/>
        <br>
        <button class="btn" type="submit">Enviar</button>
    </fieldset>
</form>

<c:if test="${not empty retorno}">
<div class="row-fluid" style="border: 0.5px solid silver">
<c:forEach items="${retorno}" var="linha">
    ${linha}<br>
</c:forEach>
</div>
</c:if>
<%@include file="../template/footer.jsp" %>