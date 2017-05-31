<%@ attribute name="stringKey" required="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<li   class="list-group-item">
    <h4 class="list-group-item-heading">
        <b><fmt:message key="${stringKey}" bundle="${lang}"/>:</b>
    </h4>
    <p class="list-group-item-text">
        <jsp:doBody var="body"/>
        ${(body.equals("") or body.equals("0") or body.equals("")) ? "---" : body}
    </p>
</li>