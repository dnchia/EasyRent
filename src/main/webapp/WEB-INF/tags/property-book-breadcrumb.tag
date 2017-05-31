<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="subtitle" required="true" %>

<fmt:message key="book-property.title" bundle="${lang}" var="title"/>
<ol class="breadcrumb">
    <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
    <c:choose>
        <c:when test="${not empty param.q}">
            <li><a href="${pageContext.request.contextPath}/search.html?q=${param.q}&s=${param.s}&e=${param.e}"><fmt:message key="general.search" bundle="${lang}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/property/show/${property.id}.html?q=${param.q}&s=${param.s}&e=${param.e}"><c:out value="${property.title}"/></a></li>
        </c:when>
        <c:otherwise>
            <li><a href="${pageContext.request.contextPath}/property/show/${property.id}.html"><c:out value="${property.title}"/></a></li>
        </c:otherwise>
    </c:choose>
    <li class="active">${title}: ${subtitle}</li>
</ol>