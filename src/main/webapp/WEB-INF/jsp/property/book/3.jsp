<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fm" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
                <t:li-hb stringKey="proposal.start-date"><spring:eval expression="bookingProposal.startDate"/></t:li-hb>
                <t:li-hb stringKey="proposal.end-date"><spring:eval expression="bookingProposal.endDate"/></t:li-hb>
                <t:li-hb stringKey="proposal.number-of-tenants">${bookingProposal.numberOfTenants}</t:li-hb>
                <t:li-hb stringKey="proposal.number-of-days">${numberOfDays}</t:li-hb>
                <t:li-hb stringKey="proposal.amount"><t:show-price amount="${bookingProposal.totalAmount}"/></t:li-hb>
                <t:li-hb stringKey="invoice.vat">${vat}%</t:li-hb>
                <er:calculate-vat value="${bookingProposal.totalAmount}" var="priceWithVat"/>
                <t:li-hb stringKey="proposal.total-amount"><t:show-price amount="${priceWithVat}"/></t:li-hb>
            </ul>
            <div class="panel-body">
                <form class="form-horizontal" action="${pageContext.request.contextPath}/property/booking-proposal/${property.id}/3" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-10">
                            <a href="${pageContext.request.contextPath}/property/booking-proposal/${property.id}.html?step=2" class="btn btn-warning"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/></a>
                            <button type="submit" class="btn btn-warning"><fmt:message key="proposal.pay" bundle="${lang}"/> <span class="glyphicon glyphicon-forward"></span></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</t:paginabasica>