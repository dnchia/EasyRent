<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="input" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tag" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:url value="/login.html" var="loginUrl"/>
<fmt:message key="login.title" var="title" bundle="${lang}"/>
<t:paginabasica title="${title}" >

    <c:if test="${not empty param.success && param.success eq 'ac'}">
        <div class="alert alert-success alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong><fmt:message key="general.success" bundle="${lang}"/> </strong>
            <fmt:message key="activation.success" bundle="${lang}" />
        </div>
    </c:if>

    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/> </a></li>
        <li class="active">${title}</li>
    </ol>
    <div class="page-header">
        <h1>${title}</h1>
    </div>
    <form:form method="post" action="${loginUrl}" cssClass="form-horizontal">
        <c:if test="${param.error != null}">
            <p class="alert alert-danger">
                <span class="glyphicon glyphicon-exclamation-sign"></span> <fmt:message key="login.${SPRING_SECURITY_LAST_EXCEPTION.message}" bundle="${lang}"/>
            </p>
        </c:if>

        <c:if test="${param.logout != null}">
            <p class="alert alert-success">
                <span class="glyphicon glyphicon-check"></span> <fmt:message key="login.successful-logout" bundle="${lang}"/>
            </p>
        </c:if>

        <div class="form-group">
            <fmt:message key="user.username" bundle="${lang}" var="username"/>
            <label for="username" class="col-sm-2 control-label">${username}</label>
            <div class="col-sm-10">
                <input class="form-control" id="username" name="username" autofocus placeholder="${username}">
            </div>
        </div>
        <div class="form-group">
            <fmt:message key="user.password" bundle="${lang}" var="password"/>
            <label for="password" class="col-sm-2 control-label">${password}</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="password" name="password" placeholder="${password}">
            </div>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-log-in"></span> <fmt:message key="login.title" bundle="${lang}"/></button>
                <span style="margin-left: 3px;"><fmt:message key="index.new-user" bundle="${lang}"/> <a href="${pageContext.request.contextPath}/signup.html"><fmt:message key="index.create-account" bundle="${lang}"/> </a> </span>
            </div>
        </div>
    </form:form>
</t:paginabasica>
