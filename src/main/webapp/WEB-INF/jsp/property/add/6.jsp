<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags/models" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:message key="add-property.title" bundle="${lang}" var="title"/>
<fmt:message key="general.check" bundle="${lang}" var="subtitle"/>
<t:paginabasica title="${title}: subtitle">
    <jsp:body>
        <t:property-add-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute('addPropertyMap').step.ordinal()}" steps="${steps}" path="/property/add"/>

        <div class="panel panel-warning">
            <div class="panel-heading">
                    ${subtitle}
            </div>
            <div class="panel-body">
                <h1><c:out value="${property.title}"/></h1>
                <m:property property="${property}" availabilityPeriods="${availabilityPeriods}" photos="${photos}" services="${services}"/>
                <form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/property/add/6">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="row">
                        <div class="col-sm-offset-1 col-sm-10">
                            <a class="btn btn-warning" href="${pageContext.request.contextPath}/property/add?step=5"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/></a>
                            <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-save"></span> <fmt:message key="general.save" bundle="${lang}"/></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </jsp:body>
</t:paginabasica>