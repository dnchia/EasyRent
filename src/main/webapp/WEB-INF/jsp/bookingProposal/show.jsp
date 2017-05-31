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

<fmt:message key="proposal.title" bundle="${lang}" var="title"/>
<t:paginabasica title="${title}">
    <jsp:body>
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <c:choose>
                <c:when test="${bookingProposal.tenant.equals(loggedUser)}">
                    <li><a href="${pageContext.request.contextPath}/index.html#tenant"><fmt:message key="home.my-booking-proposals" bundle="${lang}"/></a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/index.html#owner-proposals"><fmt:message key="owner.received-proposals" bundle="${lang}"/></a></li>
                </c:otherwise>
            </c:choose>
            <li class="active">${title}</li>
        </ol>

        <div class="page-header">
            <div class="row">
                <div class="col-md-9">
                    <span class="h1">${title} <fmt:message key="general.for" bundle="${lang}"/>: <a href="${pageContext.request.contextPath}/property/show/${bookingProposal.property.id}.html">${bookingProposal.property.title}</a></span>
                </div>
                <br class="hidden-md hidden-lg">
                <c:choose>
                    <c:when test="${bookingProposal.tenant.equals(loggedUser)}">
                        <div class="col-md-offset-2 col-md-1">
                            <a class="btn btn-warning ${bookingProposal.status ne 'PENDING' ? 'disabled' : ''}" ${bookingProposal.status ne 'PENDING' ? 'disabled' : ''} href="${pageContext.request.contextPath}/booking-proposal/edit/${bookingProposal.id}.html"><span class="glyphicon glyphicon-edit"></span> <fmt:message key="general.edit" bundle="${lang}"/></a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-md-3">
                            <c:if test="${bookingProposal.status == 'PENDING'}">
                                <%--<a class="btn btn-warning" href="${pageContext.request.contextPath}/booking-proposal/accept/${bookingProposal.id}.html"><span class="glyphicon glyphicon-ok"></span> <fmt:message key="proposal.accept" bundle="${lang}"/></a>
                                <a class="btn btn-warning" href="${pageContext.request.contextPath}/booking-proposal/reject/${bookingProposal.id}.html"><span class="glyphicon glyphicon-remove"></span> <fmt:message key="proposal.reject" bundle="${lang}"/></a>--%>
                                <button class="btn btn-success" data-toggle="modal" data-target="#proposal-acceptation-modal"><span class="glyphicon glyphicon-ok"></span> <fmt:message key="proposal.accept" bundle="${lang}"/></button>
                                <button class="btn btn-danger" data-toggle="modal" data-target="#proposal-rejection-modal"><span class="glyphicon glyphicon-remove"></span> <fmt:message key="proposal.reject" bundle="${lang}"/></button>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        <fmt:message key="proposal.general-info" bundle="${lang}"/>
                    </div>
                    <ul class="list-group">
                        <c:if test="${bookingProposal.property.owner.equals(loggedUser)}">
                            <t:li-hb stringKey="proposal.tenant"><a href="${pageContext.request.contextPath}/user/profile/${bookingProposal.tenant.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span></a></t:li-hb>
                        </c:if>
                        <t:li-hb stringKey="proposal.property"><a href="${pageContext.request.contextPath}/property/show/${bookingProposal.property.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span></a></t:li-hb>
                        <t:li-hb stringKey="proposal.start-date"><spring:eval expression="bookingProposal.startDate"/></t:li-hb>
                        <t:li-hb stringKey="proposal.end-date"><spring:eval expression="bookingProposal.endDate"/></t:li-hb>
                        <t:li-hb stringKey="proposal.number-of-tenants">${bookingProposal.numberOfTenants}</t:li-hb>
                        <er:calculate-vat value="${bookingProposal.totalAmount}" var="priceWithVat"/>
                        <t:li-hb stringKey="proposal.amount"><t:show-price amount="${priceWithVat}"/></t:li-hb>
                    </ul>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        <fmt:message key="proposal.status-info" bundle="${lang}"/>
                    </div>
                    <ul class="list-group">
                        <t:li-hb stringKey="proposal.status">${bookingProposal.status.label}</t:li-hb>
                        <t:li-hb stringKey="proposal.created-at"><spring:eval expression="bookingProposal.dateOfCreation"/></t:li-hb>
                        <t:li-hb stringKey="proposal.last-updated"><spring:eval expression="bookingProposal.dateOfUpdate"/></t:li-hb>
                    </ul>
                </div>
            </div>
        </div>
        <c:if test="${bookingProposal.property.owner.equals(loggedUser)}">
            <%-- Proposal acceptation modal --%>
            <div class="modal fade" id="proposal-acceptation-modal" tabindex="-1" role="dialog" aria-labelledby="proposalAcceptationLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="proposalAcceptationLabel"><fmt:message key="proposal.acceptation-confirmation" bundle="${lang}"/> </h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="general.cancel" bundle="${lang}"/> </button>
                            <button type="button" id="confirm-accept-proposal" class="btn btn-success"><fmt:message key="proposal.accept" bundle="${lang}"/> </button>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Proposal rejection modal --%>
            <div class="modal fade" id="proposal-rejection-modal" tabindex="-1" role="dialog" aria-labelledby="proposalRejectionLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="proposalRejectionLabel"><fmt:message key="proposal.rejection-confirmation" bundle="${lang}"/> </h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="general.cancel" bundle="${lang}"/> </button>
                            <button type="button" id="confirm-reject-proposal" class="btn btn-danger"><fmt:message key="proposal.reject" bundle="${lang}"/> </button>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                (function () {
                    $('#confirm-accept-proposal').on('click', function () {
                        window.location.assign('${pageContext.request.contextPath}/booking-proposal/accept/${bookingProposal.id}.html');
                    });

                    $('#confirm-reject-proposal').on('click', function () {
                        window.location.assign('${pageContext.request.contextPath}/booking-proposal/reject/${bookingProposal.id}.html');
                    });
                })();
            </script>
        </c:if>
    </jsp:body>
</t:paginabasica>