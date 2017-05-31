<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:message key="general.edit" var="edit" bundle="${lang}"/>
<fmt:message key="profile.change-password" var="title" bundle="${lang}"/>
<sec:authentication var="loggedUser" property="principal" />
<t:paginabasica title="${title}">
    <jsp:body>
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/user/profile/${loggedUser.id}.html#main-account-info"><fmt:message key="profile.title" bundle="${lang}"/></a></li>
            <li class="active">${title}</li>
        </ol>
        <div class="page-header">
            <h1>${title}</h1>
        </div>
        <form:form cssClass="form-horizontal" method="post" modelAttribute="changePasswordForm">
            <fmt:message key="user.old-password" var="oldPassword" bundle="${lang}"/>
            <t:input path="oldPassword" type="password" label="${oldPassword}"/>
            <fmt:message key="user.new-password" var="newPassword" bundle="${lang}"/>
            <t:input path="newPassword" type="password" label="${newPassword}"/>
            <fmt:message key="signup.repeat-password" var="rPassword" bundle="${lang}"/>
            <t:input path="repeatPassword" type="password" label="${rPassword}"/>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-save"></span> <fmt:message key="general.save" bundle="${lang}"/></button>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/user/profile/${loggedUser.id}.html"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/> </a>
                </div>
            </div>
        </form:form>
    </jsp:body>
</t:paginabasica>