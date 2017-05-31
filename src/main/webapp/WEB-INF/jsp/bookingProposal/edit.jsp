<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<fmt:message key="edit-proposal.title" bundle="${lang}" var="title"/>
<t:paginabasica title="${title}">
    <jsp:body>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong><fmt:message key="general.success" bundle="${lang}"/> </strong> <fmt:message key="edit-proposal.success" bundle="${lang}" />
            </div>
        </c:if>

        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/index.html#tenant"><fmt:message key="home.my-booking-proposals" bundle="${lang}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/booking-proposal/show/${bookingProposal.id}.html"><fmt:message key="proposal.title" bundle="${lang}"/></a></li>
            <li class="active">${title}</li>
        </ol>

        <div class="page-header">
            <div class="row">
                <div class="col-md-9">
                    <span class="h1">${title} <fmt:message key="general.for" bundle="${lang}"/>: <a href="${pageContext.request.contextPath}/property/show/${bookingProposal.property.id}.html">${bookingProposal.property.title}</a></span>
                </div>
            </div>
        </div>

        <div class="panel panel-info">
            <div class="panel-heading">
                <fmt:message key="proposal.edit-info" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <fmt:message key="proposal.edit-info-msg" bundle="${lang}"/>
            </div>
        </div>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <fmt:message key="proposal.general-info" bundle="${lang}"/>
            </div>
            <form class="form-horizontal" method="post">
                <ul class="list-group">
                    <c:if test="${bookingProposal.property.owner.equals(loggedUser)}">
                        <t:li-hb stringKey="proposal.tenant"><a href="${pageContext.request.contextPath}/user/profile/${bookingProposal.tenant.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span></a></t:li-hb>
                    </c:if>
                    <t:li-hb stringKey="proposal.property"><a href="${pageContext.request.contextPath}/property/show/${bookingProposal.property.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span></a></t:li-hb>
                    <t:li-hb stringKey="proposal.start-date"><spring:eval expression="bookingProposal.startDate"/></t:li-hb>
                    <t:li-hb stringKey="proposal.end-date"><spring:eval expression="bookingProposal.endDate"/></t:li-hb>
                    <t:li-hb stringKey="proposal.number-of-tenants">
                        <div class="row">
                            <div class="col-sm-4">
                                <select class="form-control" name="numberOfTenants">
                                    <c:forEach begin="1" end="${bookingProposal.property.capacity}" var="i">
                                        <option value="${i}" ${bookingProposal.numberOfTenants eq i ? 'selected' : ''}>${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </t:li-hb>
                    <er:calculate-vat value="${bookingProposal.totalAmount}" var="priceWithVat"/>
                    <t:li-hb stringKey="proposal.amount"><t:show-price amount="${priceWithVat}"/></t:li-hb>
                </ul>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-10">
                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/booking-proposal/show/${bookingProposal.id}.html"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="edit-proposal.back" bundle="${lang}"/> </a>
                        <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-save"></span> <fmt:message key="general.save" bundle="${lang}"/> </button>
                    </div>
                </div>
            </form>
        </div>
    </jsp:body>
</t:paginabasica>