<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="coreActions" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="input" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="fm" tagdir="/WEB-INF/tags/forms" %>


<fmt:message key="add-property.title" bundle="${lang}" var="title"/>
<fmt:message key="property.property-info" bundle="${lang}" var="subtitle"/>
<tag:paginabasica title="${title}: ${subtitle}">
    <jsp:body>
        <tag:property-add-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute('addPropertyMap').step.ordinal()}" steps="${steps}" path="/property/add"/>

        <div class="panel panel-warning">
            <div class="panel-heading">
                ${subtitle}
            </div>
            <div class="panel-body">
                <form:form method="post" modelAttribute="propertyForm" cssClass="form-horizontal" action="${pageContext.request.contextPath}/property/add/2">
                    <fm:property-info/>
                    <div class="row">
                        <div class="col-sm-offset-1 col-sm-10">
                            <a href="${pageContext.request.contextPath}/property/add?step=1" class="btn btn-warning"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/> </a>
                            <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-forward"></span> <fmt:message key="general.next" bundle="${lang}"/> </button>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>

    </jsp:body>
</tag:paginabasica>