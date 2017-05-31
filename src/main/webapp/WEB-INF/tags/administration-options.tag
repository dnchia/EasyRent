<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ attribute name="location" required="true" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<ul class="nav nav-tabs nav-justified" id="administration-options">
    <li role="presentation" class="${location.equals("users") ? 'active' : ''}"><a href="${pageContext.request.contextPath}/administration/users.html#administration-options"><fmt:message key="administration.users" bundle="${lang}"/></a></li>
    <li role="presentation" class="${location.equals("properties") ? 'active' : ''}"><a href="${pageContext.request.contextPath}/administration/properties.html#administration-options"><fmt:message key="administration.properties" bundle="${lang}"/></a></li>
    <li role="presentation" class="${location.equals("booking_proposals") ? 'active' : ''}"><a href="${pageContext.request.contextPath}/administration/booking_proposals.html#administration-options"><fmt:message key="administration.booking-proposals" bundle="${lang}"/></a></li>
    <li role="presentation" class="${location.equals("invoices") ? 'active' : ''}"><a href="${pageContext.request.contextPath}/administration/invoices.html#administration-options"><fmt:message key="administration.invoices" bundle="${lang}"/></a></li>
    <li role="presentation" class="${location.equals("services") ? 'active' : ''}"><a href="${pageContext.request.contextPath}/administration/services.html#administration-options"><fmt:message key="administration.services" bundle="${lang}"/> <span class="badge">${numberOfServicesNotActive}</span></a></li>
</ul>
<br>
