<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:message key="add-user.title" var="title" bundle="${lang}"/>
<t:paginabasica title="${title}">
    <jsp:body>
        <div class="page-header">
            <h1>${title}</h1>
        </div>
        <form:form cssClass="form-horizontal" method="post" modelAttribute="user">
            <fmt:message key="user.username" var="username" bundle="${lang}"/>
            <t:input path="username" required="true" label="${username}"/>
            <fmt:message key="user.dni" var="dni" bundle="${lang}"/>
            <t:input path="dni" label="${dni}"/>
            <fmt:message key="user.password" var="password" bundle="${lang}"/>
            <t:input path="password" type="password" required="true" label="${password}"/>
            <fmt:message key="user.name" var="name" bundle="${lang}"/>
            <t:input path="name" required="true" label="${name}"/>
            <fmt:message key="user.surnames" var="surnames" bundle="${lang}"/>
            <t:input path="surnames" required="true" label="${surnames}"/>
            <fmt:message key="user.email" var="email" bundle="${lang}"/>
            <t:input path="email" type="email" required="true" label="${email}"/>
            <fmt:message key="user.phone-number" var="phoneNumber" bundle="${lang}"/>
            <t:input path="phoneNumber" label="${phoneNumber}"/>
            <fmt:message key="user.address" var="addres" bundle="${lang}"/>
            <t:input path="postalAddress" label="${addres}"/>
            <fmt:message key="user.country" var="country" bundle="${lang}"/>
            <t:input path="country" label="${country}" />
            <fmt:message key="user.post-code" var="postCode" bundle="${lang}"/>
            <t:input path="postCode" label="${postCode}"/>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-plus"></span> <fmt:message key="general.add" bundle="${lang}"/></button>
                </div>
            </div>
        </form:form>
    </jsp:body>
</t:paginabasica>