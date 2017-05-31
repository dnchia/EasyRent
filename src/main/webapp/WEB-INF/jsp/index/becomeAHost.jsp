<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:message key="become.title" bundle="${lang}" var="title"/>
<tag:paginabasica title="${title}" resource="${'index'}">
    <jsp:body>

        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li class="active">${title}</li>
        </ol>

        <div class="page-header">
            <h1>${title}</h1>
        </div>

        <div class="panel panel-warning">
            <div class="panel-heading">
                1# <fmt:message key="become.reason-one" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="become.reason-one-a" bundle="${lang}"/></p>
                <p><fmt:message key="become.reason-one-b" bundle="${lang}"/></p>
            </div>
            <div class="panel-heading">
                2# <fmt:message key="become.reason-two" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="become.reason-two-a" bundle="${lang}"/></p>
                <p><fmt:message key="become.reason-two-b" bundle="${lang}"/></p>
            </div>
            <div class="panel-heading">
                3# <fmt:message key="become.reason-three" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="become.reason-three-a" bundle="${lang}"/></p>
            </div>
            <div class="panel-heading">
                4# <fmt:message key="become.reason-four" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="become.reason-four-a" bundle="${lang}"/></p>
                <p><fmt:message key="become.reason-four-b" bundle="${lang}"/></p>
            </div>
        </div>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <fmt:message key="become.steps" bundle="${lang}"/>
            </div>
            <ul class="list-group">
                <tag:li-hb stringKey="signup.title">
                    <p><fmt:message key="become.steps-message" bundle="${lang}"/> </p>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/signup.html"><fmt:message key="signup.title" bundle="${lang}"/></a>
                </tag:li-hb>
                <tag:li-hb stringKey="become.add-property">
                    <p><fmt:message key="become.add-property-msg" bundle="${lang}"/></p>
                    <img class="img-thumbnail img-responsive visible-md visible-lg" src="${pageContext.request.contextPath}/img/add-prop.PNG">
                    <img class="img-thumbnail img-responsive hidden-md hidden-lg" src="${pageContext.request.contextPath}/img/add-prop-short.PNG">
                </tag:li-hb>
                <tag:li-hb stringKey="become.congrats">
                    <fmt:message key="become.congrats-msg" bundle="${lang}"/>
                </tag:li-hb>
            </ul>
        </div>
    </jsp:body>
</tag:paginabasica>
