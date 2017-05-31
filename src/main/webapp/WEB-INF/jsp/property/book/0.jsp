<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fm" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>

<fmt:message key="book-property.title" bundle="${lang}" var="title"/>
<fmt:message key="profile.personal-data" bundle="${lang}" var="subtitle"/>
<t:paginabasica title="${title}: ${subtitle}">
    <jsp:body>
        <t:property-book-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute(sessionMapName).step.ordinal()}" steps="${steps}" path="/property/booking-proposal/${property.id.toString()}"/>

        <t:user-info-helper/>

        <div class="panel panel-warning">
            <div class="panel-heading">
                ${subtitle}
            </div>
            <div class="panel-body">
                <form:form cssClass="form-horizontal" action="${pageContext.request.contextPath}/property/booking-proposal/${property.id}/0" method="post" modelAttribute="personalDataForm">
                    <fm:personal-data/>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-warning"><fmt:message key="general.next" bundle="${lang}"/> <span class="glyphicon glyphicon-forward"></span></button>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </jsp:body>
</t:paginabasica>