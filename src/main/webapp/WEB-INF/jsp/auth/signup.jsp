<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:message key="signup.title" var="title" bundle="${lang}"/>
<t:paginabasica title="${title}">
    <jsp:body>
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/> </a></li>
            <li class="active">${title}</li>
        </ol>
        <div class="page-header">
            <h1>${title}</h1>
        </div>
        <form:form cssClass="form-horizontal" method="post" modelAttribute="form">
            <fmt:message key="user.username" var="username" bundle="${lang}"/>
            <t:input path="username" label="${username}"/>
            <fmt:message key="user.password" var="password" bundle="${lang}"/>
            <t:input path="password" type="password" label="${password}"/>
            <fmt:message key="signup.repeat-password" var="repeatPassword" bundle="${lang}"/>
            <t:input path="repeatPassword" type="password" label="${repeatPassword}"/>
            <fmt:message key="user.email" var="email" bundle="${lang}"/>
            <t:input path="email" type="email" label="${email}"/>
            <fmt:message key="signup.repeat-email" var="repeatEmail" bundle="${lang}"/>
            <t:input path="repeatEmail" type="email" label="${repeatEmail}"/>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-warning"><fmt:message key="signup.title" bundle="${lang}"/></button>
                    <span style="margin-left: 3px;"><fmt:message key="index.owns-account" bundle="${lang}"/> <a href="${pageContext.request.contextPath}/login.html"><fmt:message key="login.title" bundle="${lang}"/> </a> </span>
                </div>
            </div>
        </form:form>
    </jsp:body>
</t:paginabasica>