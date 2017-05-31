<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="step" type="java.lang.Integer" required="true" %>
<%@ attribute name="current" type="java.lang.Integer" required="true" %>
<%@ attribute name="var" type="java.lang.String" %>

<c:set value="${current == step ? 'active' : ''}${current < step ? 'disabled' : ''}${current > step ? 'complete' : ''}" var="out"/>
<c:choose>
    <c:when test="${not empty var}">
        ${pageContext.request.setAttribute(var, out)}
    </c:when>
    <c:otherwise>
        ${out}
    </c:otherwise>
</c:choose>