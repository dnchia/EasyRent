<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:message key="general.edit" var="edit" bundle="${lang}"/>
<fmt:message key="profile.account-info" var="title" bundle="${lang}"/>
<sec:authentication var="loggedUser" property="principal" />
<t:paginabasica title="${edit} ${title.toLowerCase()}">
    <jsp:body>
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/user/profile/${loggedUser.id}.html#main-account-info"><fmt:message key="profile.title" bundle="${lang}"/></a></li>
            <li class="active">${title}</li>
        </ol>
        <div class="page-header">
            <h1>${edit} ${title.toLowerCase()}</h1>
        </div>
        <form:form cssClass="form-horizontal" method="post" modelAttribute="accountInfoForm">
            <fmt:message key="user.username" var="username" bundle="${lang}"/>
            <t:input path="username" label="${username}"/>
            <fmt:message key="user.email" var="email" bundle="${lang}"/>
            <t:input path="email" type="email" label="${email}"/>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-save"></span> <fmt:message key="general.save" bundle="${lang}"/></button>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/user/profile/${loggedUser.id}.html"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/> </a>
                </div>
            </div>
        </form:form>
    </jsp:body>
</t:paginabasica>