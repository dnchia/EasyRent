<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fm" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>

<fmt:message key="book-property.title" bundle="${lang}" var="title"/>
<fmt:message key="general.check" bundle="${lang}" var="subtitle"/>
<t:paginabasica title="${title}: ${subtitle}">
    <jsp:body>
        <t:property-book-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute(sessionMapName).step.ordinal()}" steps="${steps}" path="/property/booking-proposal/${property.id.toString()}"/>

        <div class="panel panel-warning">
            <div class="panel-heading">
                ${subtitle}
            </div>
            <ul class="list-group">
                <er:calculate-vat value="${bookingProposal.totalAmount}" var="priceWithVat"/>
                <t:li-hb stringKey="proposal.total-amount"><t:show-price amount="${priceWithVat}"/></t:li-hb>
                <t:li-hb stringKey="proposal.pay-btn">
                    <c:choose>
                        <c:when test="${not empty bookingForm.paymentReference}">
                            <span class="h2"><span class="label label-success"><span class="glyphicon glyphicon-ok-sign"></span> <fmt:message key="proposal.paid" bundle="${lang}"/></span></span>
                        </c:when>
                        <c:otherwise>
                            <form method="post" action="${pageContext.request.contextPath}/property/booking-proposal/${property.id}/pay">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" id="pay-btn" class="btn btn-primary"><fmt:message key="proposal.pay-btn" bundle="${lang}"/></button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </t:li-hb>
            </ul>
            <div class="panel-body">
                <form:form cssClass="form-horizontal" action="${pageContext.request.contextPath}/property/booking-proposal/${property.id}/4" method="post" modelAttribute="bookingForm">
                    <form:hidden path="paymentReference"/>
                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-10">
                            <form:errors cssClass="text-danger" path="startDate"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-10">
                            <a href="${pageContext.request.contextPath}/property/booking-proposal/${property.id}.html?step=2" class="btn btn-warning"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/></a>
                            <button type="submit" class="btn btn-warning"><fmt:message key="general.finish" bundle="${lang}"/> <span class="glyphicon glyphicon-forward"></span></button>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </jsp:body>
</t:paginabasica>