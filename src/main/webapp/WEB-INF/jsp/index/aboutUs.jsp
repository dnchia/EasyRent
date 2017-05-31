<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<fmt:message key="about-us.title" bundle="${lang}" var="title"/>
<tag:paginabasica title="EasyRent" resource="${empty loggedUser ? 'index' : ''}">
    <jsp:body>

        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li class="active">${title}</li>
        </ol>

        <div class="page-header">
            <h1>${title}</h1>
        </div>

        <div class="index-box spare-box">
            <h3 class="corporate-text"><fmt:message key="about-us.experience" bundle="${lang}"/> </h3>
            <p><fmt:message key="about-us.experience-msg" bundle="${lang}"/> </p>
        </div>

        <div class="bg-silver index-box text-center text-white spare-box">
            <h2><fmt:message key="about-us.variety" bundle="${lang}"/> </h2>
        </div>

        <div class="index-box spare-box">
            <h3 class="corporate-text"><fmt:message key="about-us.useful-tools" bundle="${lang}"/> </h3>
            <p><fmt:message key="about-us.economic-travelling" bundle="${lang}"/></p>
            <p><fmt:message key="about-us.availability" bundle="${lang}"/></p>
            <p><fmt:message key="about-us.tool" bundle="${lang}"/></p>
        </div>
    </jsp:body>
</tag:paginabasica>
