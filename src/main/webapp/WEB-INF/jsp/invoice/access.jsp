<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:message key="administration.title" var="title" bundle="${lang}"/>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<t:paginabasica title="${title}">
    <jsp:body>
        <div class="page-header">
            <span class="h1">${title}</span>
        </div>
        <div class="container">
            <hr>
            <t:administration-options location="users"/>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-warning top-padding30px">
                        <div class="panel-heading">
                            <fmt:message key="invoice.header" bundle="${lang}"/>
                        </div>
                        <div class="panel-body">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:paginabasica>
