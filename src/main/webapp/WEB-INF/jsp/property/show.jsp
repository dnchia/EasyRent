<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags/models" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<fmt:message key="general.by" bundle="${lang}" var="by"/>
<t:paginabasica title="${property.title}">
    <jsp:body>

        <c:if test="${not empty param.success && param.success eq 'ms'}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong><fmt:message key="general.success" bundle="${lang}"/> </strong>
                <fmt:message key="show-property.success" bundle="${lang}" />
            </div>
        </c:if>

        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <c:if test="${not empty param.q}">
                <li><a href="${pageContext.request.contextPath}/search.html?q=${param.q}&s=${param.s}&e=${param.e}"><fmt:message key="general.search" bundle="${lang}"/></a></li>
            </c:if>
            <c:if test="${property.owner.equals(loggedUser)}">
                <li><a href="${pageContext.request.contextPath}/index.html#owner-properties"><fmt:message key="home.my-properties" bundle="${lang}"/></a></li>
            </c:if>
            <li class="active"><c:out value="${property.title}"/></li>
        </ol>
        <div class="page-header">
            <div class="row">
                <div class="col-md-10">
                    <span class="h1"><c:out value="${property.title}"/>  <small>${by} <a href="${pageContext.request.contextPath}/user/profile/${property.owner.id}.html">${property.owner.username}</a></small></span>
                </div>
                <br class="hidden-md hidden-lg">
                <div class="col-md-2 text-right">
                    <c:choose>
                        <c:when test="${property.owner.equals(loggedUser)}">
                            <a class="btn btn-warning" href="${pageContext.request.contextPath}/property/edit/${property.id}.html"><span class="glyphicon glyphicon-edit"></span> <fmt:message key="general.edit" bundle="${lang}"/></a>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${empty property.availabilityPeriods}">
                                    <a class="btn btn-lg btn-danger disabled" href="#"><span class="glyphicon glyphicon-ok"></span> <fmt:message key="proposal.book" bundle="${lang}"/> </a>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${not empty param.q}">
                                            <a class="btn btn-lg btn-danger btn-warning" href="${pageContext.request.contextPath}/property/booking-proposal/${property.id}.html?q=${param.q}&s=${param.s}&e=${param.e}"><span class="glyphicon glyphicon-ok"></span> <fmt:message key="proposal.book" bundle="${lang}"/> </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-lg btn-danger btn-warning" href="${pageContext.request.contextPath}/property/booking-proposal/${property.id}.html"><span class="glyphicon glyphicon-ok"></span> <fmt:message key="proposal.book" bundle="${lang}"/> </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <m:property property="${property}"/>
    </jsp:body>
</t:paginabasica>