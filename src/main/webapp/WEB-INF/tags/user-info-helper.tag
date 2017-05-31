<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>


<div class="panel panel-info">
    <c:choose>
        <c:when test="${not empty loggedUser.dni}">
            <div class="panel-heading">
                <fmt:message key="personal.review-info" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="personal.review-info-msg" bundle="${lang}"/></p>
                <p><fmt:message key="personal.edit-from-profile" bundle="${lang}"/></p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="panel-heading">
                <fmt:message key="personal.introduce-info" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="personal.introduce-info-msg" bundle="${lang}"/></p>
                <p><fmt:message key="personal.edit-from-profile" bundle="${lang}"/></p>
            </div>
        </c:otherwise>
    </c:choose>
</div>