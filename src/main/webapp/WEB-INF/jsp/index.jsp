<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<tag:paginabasica title="EasyRent" resource="${empty loggedUser ? 'index' : ''}">
    <jsp:body>
        <c:choose>
            <c:when test="${empty loggedUser}">

                <c:if test="${not empty param.success && param.success eq 'su'}">
                    <div class="alert alert-success alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong><fmt:message key="general.success" bundle="${lang}"/> </strong>
                        <fmt:message key="signup.success" bundle="${lang}" />
                    </div>
                </c:if>

                <div class="index-image-1 index-box corporate-text spare-box">
                    <h1><fmt:message key="index.need-some-rest" bundle="${lang}"/> </h1>
                    <h3><fmt:message key="index.relax-slogan" bundle="${lang}"/> </h3>
                </div>

                <div class="bg-silver index-box text-center text-white spare-box">
                    <h2><fmt:message key="index.what-we-do" bundle="${lang}"/> </h2>
                </div>

                <div class="index-image-2 index-box text-right text-white spare-box">
                    <h1><fmt:message key="index.no-worries" bundle="${lang}"/></h1>
                    <h3><fmt:message key="index.as-a-tenant" bundle="${lang}"/> </h3>
                    <h3><fmt:message key="index.as-an-owner" bundle="${lang}"/> </h3>
                </div>

                <div class="index-box text-center corporate-text">
                    <h1><fmt:message key="index.convinced" bundle="${lang}"/> <a href="${pageContext.request.contextPath}/signup.html" class="btn btn-warning btn-lg"><fmt:message key="index.start-now" bundle="${lang}"/> </a></h1>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong><fmt:message key="general.success" bundle="${lang}"/> </strong>
                        <c:if test="${param.success eq 'p'}">
                            <fmt:message key="add-property.success" bundle="${lang}" />
                        </c:if>
                        <c:if test="${param.success eq 'pd'}">
                            <fmt:message key="property.delete-success" bundle="${lang}"/>
                        </c:if>
                        <c:if test="${param.success eq 'bp'}">
                            <fmt:message key="book-property.success" bundle="${lang}"/>
                        </c:if>
                        <c:if test="${param.success eq 'bpa'}">
                            <fmt:message key="proposal.accept-success" bundle="${lang}"/>
                        </c:if>
                        <c:if test="${param.success eq 'bpr'}">
                            <fmt:message key="proposal.reject-success" bundle="${lang}"/>
                        </c:if>
                    </div>
                </c:if>

                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <span class="glyphicon glyphicon-exclamation-sign"></span><strong><fmt:message key="general.error" bundle="${lang}"/> </strong> <fmt:message key="property.delete-error" bundle="${lang}" />
                    </div>
                </c:if>
                <div class="page-header">
                    <span class="h1"><fmt:message key="index.home" bundle="${lang}"/> : <c:out value="${user.username}"/></span>
                </div>

                    <ul class="nav nav-tabs nav-justified" id="user-options">
                        <li role="presentation" class="active"><a data-toggle="tab" href="#tenant"><strong><fmt:message key="home.my-booking-proposals" bundle="${lang}"/></strong></a></li>
                        <c:if test="${user.role eq 'OWNER' or user.role eq 'ADMINISTRATOR'}">
                            <li role="presentation"><a data-toggle="tab" href="#owner"><strong><fmt:message key="home.my-properties" bundle="${lang}"/></strong></a></li>
                        </c:if>
                        <li role="presentation"><a data-toggle="tab" href="#conversations"><strong><fmt:message key="home.conversations" bundle="${lang}"/></strong></a></li>
                    </ul>
                    <br>
                <div class="tab-content">
                    <div id="tenant" class="tab-pane fade in active">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="panel panel-warning">
                                    <div class="panel-heading">
                                        <fmt:message key="tenant.sections" bundle="${lang}"/>
                                    </div>
                                    <div class="list-group">
                                        <a class="list-group-item active" data-toggle="tab" href="#tenant-proposals">
                                            <fmt:message key="tenant.emited-proposals" bundle="${lang}"/> <span class="badge">${fn:length(user.bookingProposals)}</span>
                                        </a>
                                        <a class="list-group-item" data-toggle="tab" href="#tenant-invoices">
                                            <fmt:message key="tenant.invoices" bundle="${lang}"/> <span class="badge">${fn:length(invoices)}</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="tab-content">
                                    <div id="tenant-proposals" class="panel panel-warning tab-pane fade in active">
                                        <div class="panel-heading">
                                            <fmt:message key="tenant.emited-proposals" bundle="${lang}"/>
                                        </div>
                                        <div class="table-responsive">
                                            <c:choose>
                                                <c:when test="${fn:length(user.bookingProposals) eq 0}">
                                                    <div class="text-silver text-center">
                                                        <h3><fmt:message key="home.no-bookings" bundle="${lang}"/></h3>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                        <tr>
                                                            <th><fmt:message key="general.number" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="proposal.property" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="proposal.start-date" bundle="${lang}"/></th>
                                                            <th><fmt:message key="proposal.end-date" bundle="${lang}"/></th>
                                                            <th><fmt:message key="proposal.status" bundle="${lang}"/></th>
                                                            <th><fmt:message key="proposal.created-at" bundle="${lang}"/></th>
                                                            <th><fmt:message key="proposal.last-updated" bundle="${lang}"/></th>
                                                            <th><fmt:message key="general.edit" bundle="${lang}"/></th>
                                                        </tr>
                                                        </thead>
                                                        <tbody data-link="row" class="rowlink">
                                                        <c:forEach var="bookingProposal" items="${user.bookingProposals}" varStatus="loop">
                                                            <tr>
                                                                <td><a href="${pageContext.request.contextPath}/booking-proposal/show/${bookingProposal.id}.html">${loop.index+1}</a></td>
                                                                <td class="rowlink-skip"><a href="${pageContext.request.contextPath}/property/show/${bookingProposal.property.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span> </a></td>
                                                                <td><spring:eval expression="bookingProposal.startDate"/></td>
                                                                <td><spring:eval expression="bookingProposal.endDate"/></td>
                                                                <td>${bookingProposal.status.label}</td>
                                                                <td><spring:eval expression="bookingProposal.dateOfCreation"/></td>
                                                                <td><spring:eval expression="bookingProposal.dateOfUpdate"/></td>
                                                                <td class="rowlink-skip"><a class="btn btn-warning ${bookingProposal.status ne 'PENDING' ? 'disabled' : ''}" ${bookingProposal.status ne 'PENDING' ? 'disabled' : ''} href="${pageContext.request.contextPath}/booking-proposal/edit/${bookingProposal.id}.html"><span class="glyphicon glyphicon-edit"></span></a></td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div id="tenant-invoices" class="panel panel-warning tab-pane fade">
                                        <div class="panel-heading">
                                            <fmt:message key="tenant.invoices" bundle="${lang}"/>
                                        </div>
                                        <div class="table-responsive">
                                            <c:choose>
                                                <c:when test="${fn:length(invoices) eq 0}">
                                                    <div class="text-silver text-center">
                                                        <h3><fmt:message key="home.no-invoices" bundle="${lang}"/></h3>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                        <tr>
                                                            <th><fmt:message key="general.number" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="invoice.booking" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="invoice.expedition-date" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="invoice.total-amount" bundle="${lang}"/></th>
                                                            <th><fmt:message key="invoice.pdf" bundle="${lang}"/></th>
                                                        </tr>
                                                        </thead>
                                                        <tbody data-link="row" class="rowlink">
                                                        <c:forEach var="invoice" items="${invoices}">
                                                            <tr>
                                                                <td><a target="_blank" href="${pageContext.request.contextPath}/invoice/show/${invoice.id}.pdf"><fmt:formatNumber pattern="00000" value="${invoice.number}"/></a></td>
                                                                <td class="rowlink-skip"><a href="${pageContext.request.contextPath}/booking-proposal/show/${invoice.proposal.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span> </a></td>
                                                                <td><spring:eval expression="invoice.expeditionDate"/></td>
                                                                <td><tag:show-price amount="${(invoice.vat+1)*invoice.proposal.totalAmount}"/></td>
                                                                <td class="rowlink-skip"><a class="btn btn-warning" target="_blank" href="${pageContext.request.contextPath}/invoice/show/${invoice.id}.pdf"><span class="glyphicon glyphicon-file"></span></a></td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <c:if test="${user.role eq 'OWNER' or user.role eq 'ADMINISTRATOR'}">
                        <div id="owner" class="tab-pane fade">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <fmt:message key="owner.sections" bundle="${lang}"/>
                                        </div>
                                        <div class="list-group">
                                            <a class="list-group-item active" data-toggle="tab" href="#owner-properties">
                                                <fmt:message key="owner.properties" bundle="${lang}"/> <span class="badge">${user.properties.size()}</span>
                                            </a>
                                            <a class="list-group-item" data-toggle="tab" href="#owner-proposals">
                                                <fmt:message key="owner.received-proposals" bundle="${lang}"/> <span class="badge">${bookingProposals.size()}</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-9">
                                    <div class="tab-content">
                                        <div id="owner-properties" class="panel panel-warning tab-pane fade in active">
                                            <div class="panel-heading">
                                                <fmt:message key="owner.properties" bundle="${lang}"/>
                                            </div>
                                            <div class="panel-body">
                                                <div class="alert alert-info">
                                                    <strong><fmt:message key="general.info" bundle="${lang}"/> </strong><fmt:message key="property.delete-info" bundle="${lang}"/>
                                                </div>
                                            </div>
                                            <div class="table-responsive">
                                                <c:choose>
                                                    <c:when test="${fn:length(user.properties) eq 0}">
                                                        <div class="text-silver text-center">
                                                            <h3><fmt:message key="home.no-properties" bundle="${lang}"/></h3>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <table class="table table-striped table-hover">
                                                            <thead>
                                                            <tr>
                                                                <th><fmt:message key="general.number" bundle="${lang}"/> </th>
                                                                <th><fmt:message key="property.title" bundle="${lang}"/> </th>
                                                                <th><fmt:message key="property.price-per-day" bundle="${lang}"/></th>
                                                                <th><fmt:message key="property.type" bundle="${lang}"/></th>
                                                                <th><fmt:message key="property.creation-date" bundle="${lang}"/></th>
                                                                <th><fmt:message key="general.edit" bundle="${lang}"/></th>
                                                                <th><fmt:message key="general.delete" bundle="${lang}"/></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody data-link="row" class="rowlink">
                                                            <c:forEach var="property" items="${user.properties}" varStatus="loop">
                                                                <tr>
                                                                    <td><a href="${pageContext.request.contextPath}/property/show/${property.id}.html">${loop.index+1}</a></td>
                                                                    <td><c:out value="${property.title}"/></td>
                                                                    <er:calculate-vat value="${property.pricePerDay}" var="priceWithVat"/>
                                                                    <td><tag:show-price amount="${priceWithVat}"/></td>
                                                                    <td>${property.type.label}</td>
                                                                    <td><spring:eval expression="property.creationDate"/></td>
                                                                    <td class="rowlink-skip"><a class="btn btn-warning" href="${pageContext.request.contextPath}/property/edit/${property.id}.html"><span class="glyphicon glyphicon-edit"></span></a></td>
                                                                    <td class="rowlink-skip"><button id="delete-${property.id}" data-toggle="modal" data-target="#property-delete-modal" class="btn btn-danger ${fn:length(property.bookingProposals) gt 0 ? 'disabled' : ''}" ${fn:length(property.bookingProposals) gt 0 ? 'disabled' : ''}><span class="glyphicon glyphicon-remove"></span></button></td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="panel-footer">
                                                <td><a class="btn btn-warning" href="${pageContext.request.contextPath}/property/add.html"><span class="glyphicon glyphicon-plus"></span> <fmt:message key="add-property.add" bundle="${lang}"/></a></td>
                                            </div>
                                        </div>
                                        <div id="owner-proposals" class="panel panel-warning tab-pane fade">
                                            <div class="panel-heading">
                                                <fmt:message key="owner.received-proposals" bundle="${lang}"/>
                                            </div>

                                            <div class="table-responsive">
                                                <c:choose>
                                                    <c:when test="${fn:length(bookingProposals) eq 0}">
                                                        <div class="text-silver text-center">
                                                            <h3><fmt:message key="home.no-received-proposals" bundle="${lang}"/></h3>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <table class="table table-striped table-hover">
                                                            <thead>
                                                            <tr>
                                                                <th><fmt:message key="general.number" bundle="${lang}"/> </th>
                                                                <th><fmt:message key="proposal.property" bundle="${lang}"/> </th>
                                                                <th><fmt:message key="proposal.tenant" bundle="${lang}"/> </th>
                                                                <th><fmt:message key="proposal.start-date" bundle="${lang}"/></th>
                                                                <th><fmt:message key="proposal.end-date" bundle="${lang}"/></th>
                                                                <th><fmt:message key="proposal.status" bundle="${lang}"/></th>
                                                                <th><fmt:message key="proposal.created-at" bundle="${lang}"/></th>
                                                                <th><fmt:message key="proposal.last-updated" bundle="${lang}"/></th>
                                                                <th><fmt:message key="proposal.accept" bundle="${lang}"/></th>
                                                                <th><fmt:message key="proposal.reject" bundle="${lang}"/></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody data-link="row" class="rowlink">
                                                            <c:forEach var="bookingProposal" items="${bookingProposals}" varStatus="loop">
                                                                <tr>
                                                                    <td><a href="${pageContext.request.contextPath}/booking-proposal/show/${bookingProposal.id}.html">${loop.index+1}</a></td>
                                                                    <td class="rowlink-skip"><a href="${pageContext.request.contextPath}/property/show/${bookingProposal.property.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span></a></td>
                                                                    <td class="rowlink-skip"><a href="${pageContext.request.contextPath}/user/profile/${bookingProposal.tenant.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span></a></td>
                                                                    <td><spring:eval expression="bookingProposal.startDate"/></td>
                                                                    <td><spring:eval expression="bookingProposal.endDate"/></td>
                                                                    <td>${bookingProposal.status.label}</td>
                                                                    <td><spring:eval expression="bookingProposal.dateOfCreation"/></td>
                                                                    <td><spring:eval expression="bookingProposal.dateOfUpdate"/></td>
                                                                    <td class="rowlink-skip"><button id="accept-${bookingProposal.id}" data-toggle="modal" data-target="#proposal-acceptation-modal" class="btn btn-success ${bookingProposal.status != 'PENDING' ? 'disabled' : ''}" ${bookingProposal.status != 'PENDING' ? 'disabled' : ''}><span class="glyphicon glyphicon-ok"></span></button></td>
                                                                    <td class="rowlink-skip"><button id="reject-${bookingProposal.id}" data-toggle="modal" data-target="#proposal-rejection-modal" class="btn btn-danger ${bookingProposal.status != 'PENDING' ? 'disabled' : ''}" ${bookingProposal.status != 'PENDING' ? 'disabled' : ''}><span class="glyphicon glyphicon-remove"></span></button></td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <div id="conversations" class="tab-pane fade">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="panel panel-warning">
                                    <div class="panel-heading">
                                        <fmt:message key="conversation.sections" bundle="${lang}"/>
                                    </div>
                                    <div class="list-group">
                                        <a class="list-group-item active" data-toggle="tab" href="#conversations-all">
                                            <fmt:message key="conversations.all" bundle="${lang}"/> <span class="badge">${fn:length(conversations)}</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="tab-content">
                                    <div id="conversations-all" class="panel panel-warning tab-pane fade in active">
                                        <div class="panel-heading">
                                            <fmt:message key="conversations.all" bundle="${lang}"/>
                                        </div>
                                        <div class="table-responsive">
                                            <c:choose>
                                                <c:when test="${fn:length(conversations) eq 0}">
                                                    <div class="text-silver text-center">
                                                        <h3><fmt:message key="home.no-conversations" bundle="${lang}"/></h3>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                        <tr>
                                                            <th><fmt:message key="general.number" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="conversation.started-by" bundle="${lang}"/> </th>
                                                            <th><fmt:message key="property.page-title" bundle="${lang}"/></th>
                                                            <th><fmt:message key="conversation.begun-in" bundle="${lang}"/></th>
                                                            <th><fmt:message key="proposal.last-updated" bundle="${lang}"/></th>
                                                        </tr>
                                                        </thead>
                                                        <tbody data-link="row" class="rowlink">
                                                        <c:forEach var="conversation" items="${conversations}" varStatus="loop">
                                                            <tr>
                                                                <td><a href="${pageContext.request.contextPath}/conversation/show/${conversation.id}.html">${loop.index+1}</a></td>
                                                                <td class="rowlink-skip"><a href="${pageContext.request.contextPath}/user/profile/${conversation.tenant.id}.html"><c:out value="${conversation.tenant.username}"/> <span class="glyphicon glyphicon-new-window"></span> </a></td>
                                                                <td class="rowlink-skip"><a href="${pageContext.request.contextPath}/property/show/${conversation.property.id}.html"><fmt:message key="general.link" bundle="${lang}"/> <span class="glyphicon glyphicon-new-window"></span> </a></td>
                                                                <td><spring:eval expression="conversation.creationDate"/></td>
                                                                <td><spring:eval expression="conversation.updateDate"/></td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- Property delete modal --%>
                <div class="modal fade" id="property-delete-modal" tabindex="-1" role="dialog" aria-labelledby="propertyDeleteLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="propertyDeleteLabel"><fmt:message key="property.delete-confirmation" bundle="${lang}"/> </h4>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="general.cancel" bundle="${lang}"/> </button>
                                <button type="button" id="confirm-delete-property" class="btn btn-danger"><fmt:message key="general.delete" bundle="${lang}"/> </button>
                            </div>
                        </div>
                    </div>
                </div>
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
                        $(document).ready(function () {
                            var fragment = document.location.hash;
                            if (fragment != "") {
                                var tab = fragment.split('-')[0];

                                $('a[href="' + tab + '"]').tab('show');
                                $('a[href="' + fragment + '"]').tab('show');
                            }
                        });

                        $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                            var $toBeShown = $(e.target);
                            $toBeShown.parent().find('.active').removeClass('active');
                            $toBeShown.addClass('active');
                        });

                        $('#property-delete-modal').on('show.bs.modal', function (e) {
                            var button = $(e.relatedTarget);
                            var id = extractId(button);
                            $('#confirm-delete-property').unbind('click').on('click', function () {
                                window.location.replace('${pageContext.request.contextPath}/property/delete/'+ id +'.html');
                            });
                        });

                        $('#proposal-acceptation-modal').on('show.bs.modal', function (e) {
                            var button = $(e.relatedTarget);
                            var id = extractId(button);
                            $('#confirm-accept-proposal').unbind('click').on('click', function () {
                                window.location.replace('${pageContext.request.contextPath}/booking-proposal/accept/'+ id +'.html');
                            });
                        });

                        $('#proposal-rejection-modal').on('show.bs.modal', function (e) {
                            var button = $(e.relatedTarget);
                            var id = extractId(button);
                            console.log(id);
                            $('#confirm-reject-proposal').unbind('click').on('click', function () {
                                window.location.replace('${pageContext.request.contextPath}/booking-proposal/reject/'+ id +'.html');
                            });
                        });

                        function extractId(button) {
                            var idParts = button.attr('id').split('-');
                            idParts.shift();
                            return idParts.join('-');
                        }
                    })();
                </script>
            </c:otherwise>
        </c:choose>
    </jsp:body>
</tag:paginabasica>
