<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="input" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tag" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:message key="contact-us.title" var="title" bundle="${lang}"/>
<t:paginabasica title="${title}" >

    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong><fmt:message key="general.success" bundle="${lang}"/> </strong>
            <fmt:message key="contact-us.success" bundle="${lang}" />
        </div>
    </c:if>

    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/> </a></li>
        <li class="active">${title}</li>
    </ol>
    <div class="page-header">
        <h1>${title}</h1>
    </div>
    <form:form method="post" cssClass="form-horizontal" modelAttribute="contactForm">
        <t:input path="name" required="true"/>
        <t:input path="email" type="email" required="true"/>
        <t:input path="subject" required="true"/>
        <t:input path="message" type="textarea" required="true"/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="g-recaptcha" data-sitekey="6Le5NCQTAAAAAFcC9qKiAvV1VxbZx93M1Q2FrT3i"></div>
                <form:errors path="captcha" cssClass="text-danger"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-send"></span> <fmt:message key="contact-us.title" bundle="${lang}"/></button>
            </div>
        </div>
    </form:form>
</t:paginabasica>
