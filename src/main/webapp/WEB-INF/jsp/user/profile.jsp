<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:message key="profile.title" var="title" bundle="${lang}"/>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<t:paginabasica title="${title}: ${user.username}">
    <jsp:body>
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li class="active">${title}</li>
        </ol>
        <div class="page-header">
            <span class="h1">${title}: <c:out value="${user.username}"/></span>
        </div>

        <c:if test="${user.equals(loggedUser)}">
            <ul class="nav nav-tabs nav-justified" role="tablist">
                <li role="presentation" class="active"><a data-toggle="tab" href="#main"><strong>${title}</strong></a></li>
                <li role="presentation"><a data-toggle="tab" href="#notifications"><strong><fmt:message key="notifications.title" bundle="${lang}"/></strong> <span class="badge">${fn:length(user.notifications)}</span></a></li>
            </ul>
            <br>
        </c:if>
        
        <div class="tab-content">
            <div id="main" class="tab-pane fade in active">
                <div class="row">
                    <div class="col-md-3">
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <fmt:message key="profile.sections" bundle="${lang}"/>
                            </div>
                            <div class="list-group">
                                <a class="list-group-item active" data-toggle="tab" href="#main-account-info">
                                    <fmt:message key="profile.account-info" bundle="${lang}"/>
                                </a>
                                <c:if test="${user.equals(loggedUser)}">
                                    <a class="list-group-item" data-toggle="tab" href="#main-personal-data">
                                        <fmt:message key="profile.personal-data" bundle="${lang}"/>
                                    </a>
                                    <a class="list-group-item" data-toggle="tab" href="#main-address-info">
                                        <fmt:message key="profile.address-info" bundle="${lang}"/>
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div id="main-account-info" class="panel panel-warning tab-pane fade in active">
                                <div class="panel-heading">
                                    <fmt:message key="profile.account-info" bundle="${lang}"/>
                                </div>
                                <ul class="list-group">
                                    <t:li-hb stringKey="user.picture">
                                        <c:choose>
                                            <c:when test="${user.photo == null}">
                                                <c:set var="photoUrl" value="${pageContext.request.contextPath}/img/profile-pic.png"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="photoUrl" value="${pageContext.request.contextPath}/uploads/profile-pics/${user.photo.filename}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="md-size">
                                                    <img class="img-circle img-responsive img-border" src="${photoUrl}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <c:if test="${user.equals(loggedUser)}">
                                                    <form class="form-horizontal" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/user/edit/${user.id}/upload-picture">
                                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                                            <label><fmt:message key="profile.upload-picture" bundle="${lang}"/></label>
                                                            <div class="form-group" style="margin: 0">
                                                                <div class="fileinput-preview thumbnail fileinput-exists" data-trigger="fileinput" style="width: 200px; height: 150px;"></div>
                                                            </div>
                                                            <div class="form-group" style="margin: 0">
                                                                <span class="btn btn-default btn-file">
                                                                    <span class="fileinput-new"><fmt:message key="general.select-image" bundle="${lang}"/></span>
                                                                    <span class="fileinput-exists"><fmt:message key="general.change" bundle="${lang}"/></span>
                                                                    <input type="file" name="file" accept="image/**" id="file">
                                                                </span>
                                                                <a href="#" class="btn btn-danger fileinput-exists" data-dismiss="fileinput"><span class="glyphicon glyphicon-remove"></span> <fmt:message key="general.remove" bundle="${lang}"/></a>
                                                                <button type="submit" class="btn btn-warning fileinput-exists"><span class="glyphicon glyphicon-upload"></span> <fmt:message key="general.upload" bundle="${lang}"/></button>
                                                            </div>
                                                        </div>
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </div>
                                    </t:li-hb>
                                    <t:li-hb stringKey="user.username"><c:out value="${user.username}"/></t:li-hb>
                                    <c:if test="${not empty loggedUser and user.role ne 'ADMINISTRATOR'}">
                                        <t:li-hb stringKey="user.email"><c:out value="${user.email}"/></t:li-hb>
                                    </c:if>
                                    <t:li-hb stringKey="user.user-type">${user.role.toString().substring(0,1).toUpperCase()}${user.role.toString().substring(1)}</t:li-hb>
                                    <t:li-hb stringKey="user.signup-date"><spring:eval expression="user.signUpDate"/></t:li-hb>
                                </ul>
                                <c:if test="${user.equals(loggedUser)}">
                                    <div class="panel-footer">
                                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/user/edit/${user.id}/account-info">
                                            <span class="glyphicon glyphicon-edit"></span> <fmt:message key="general.edit" bundle="${lang}"/>
                                        </a>
                                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/user/edit/${user.id}/change-password">
                                            <fmt:message key="profile.change-password" bundle="${lang}"/>
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                            <c:if test="${user.equals(loggedUser)}">
                                <div id="main-personal-data" class="panel panel-warning tab-pane fade">
                                    <div class="panel-heading">
                                        <fmt:message key="profile.personal-data" bundle="${lang}"/>
                                    </div>
                                    <ul class="list-group">
                                        <t:li-hb stringKey="user.name"><c:out value="${user.name}"/></t:li-hb>
                                        <t:li-hb stringKey="user.surnames"><c:out value="${user.surnames}"/></t:li-hb>
                                        <t:li-hb stringKey="user.dni">${user.dni}</t:li-hb>
                                        <t:li-hb stringKey="user.phone-number">${user.phoneNumber}</t:li-hb>
                                    </ul>
                                    <div class="panel-footer">
                                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/user/edit/${user.id}/personal-data">
                                            <span class="glyphicon glyphicon-edit"></span> <fmt:message key="general.edit" bundle="${lang}"/>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${user.equals(loggedUser)}">
                                <div id="main-address-info" class="panel panel-warning tab-pane fade">
                                    <div class="panel-heading">
                                        <fmt:message key="profile.address-info" bundle="${lang}"/>
                                    </div>
                                    <ul class="list-group">
                                        <t:li-hb stringKey="user.address"><c:out value="${user.postalAddress}"/></t:li-hb>
                                        <t:li-hb stringKey="user.country"><c:out value="${user.country}"/></t:li-hb>
                                        <t:li-hb stringKey="user.post-code">${user.postCode}</t:li-hb>
                                    </ul>
                                    <div class="panel-footer">
                                        <a class="btn btn-warning" href="${pageContext.request.contextPath}/user/edit/${user.id}/address-info">
                                            <span class="glyphicon glyphicon-edit"></span> <fmt:message key="general.edit" bundle="${lang}"/>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div id="notifications" class="tab-pane fade">
                <c:choose>
                    <c:when test="${fn:length(user.notifications) eq 0}">
                        <div class="text-center text-silver well well-lg">
                            <h1><fmt:message key="notifications.none" bundle="${lang}"/> </h1>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <hr>
                        <div class="text-right">
                            <form method="post" action="${pageContext.request.contextPath}/notification/clear-all">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <button type="submit" id="clear-btn" class="btn btn-danger"><fmt:message key="notifications.clear-all" bundle="${lang}"/></button>
                            </form>
                        </div>
                        <hr>
                        <div id="notification-container">
                            <c:forEach var="notification" items="${user.notifications}">
                                <div id="notification-${notification.id}">
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="${pageContext.request.contextPath}/notification/show/${notification.id}.html">
                                                <c:choose>
                                                    <c:when test="${empty notification.thumbnail}">
                                                        <c:set var="photoUrl" value="${pageContext.request.contextPath}/img/profile-pic.png"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="photoUrl" value="${pageContext.request.contextPath}/uploads/profile-pics/${notification.thumbnail}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <img class="media-object img-thumbnail" src="${photoUrl}" width="100">
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <c:if test="${notification.type eq 'BOOKING_RECEIVED'}">
                                                <fmt:message key="proposal.received" bundle="${lang}" var="heading"/>
                                                <fmt:message key="proposal.received-msg" bundle="${lang}" var="description"/>
                                                <c:set value="${notification.source} ${description} ${notification.destination}" var="description"/>
                                            </c:if>
                                            <c:if test="${notification.type eq 'BOOKING_ACCEPTED'}">
                                                <fmt:message key="proposal.accepted" bundle="${lang}" var="heading"/>
                                                <fmt:message key="proposal.answered-msg" bundle="${lang}" var="answer"/>
                                                <fmt:message key="proposal.accepted-msg" bundle="${lang}" var="description"/>
                                                <c:set value="${answer} ${notification.destination} ${description}" var="description"/>
                                            </c:if>
                                            <c:if test="${notification.type eq 'BOOKING_REJECTED'}">
                                                <fmt:message key="proposal.rejected" bundle="${lang}" var="heading"/>
                                                <fmt:message key="proposal.answered-msg" bundle="${lang}" var="answer"/>
                                                <fmt:message key="proposal.rejected-msg" bundle="${lang}" var="description"/>
                                                <c:set value="${answer} ${notification.destination} ${description}" var="description"/>
                                            </c:if>
                                            <c:if test="${notification.type eq 'BOOKING_EXPIRED'}">
                                                <fmt:message key="proposal.expired" bundle="${lang}" var="heading"/>
                                                <fmt:message key="proposal.expired-msg-a" bundle="${lang}" var="start"/>
                                                <fmt:message key="proposal.expired-msg-b" bundle="${lang}" var="ending"/>
                                                <c:set value="${start} ${notification.destination} ${ending}" var="description"/>
                                            </c:if>
                                            <c:if test="${notification.type eq 'CONVERSATION_STARTED'}">
                                                <fmt:message key="conversation.started" bundle="${lang}" var="heading"/>
                                                <fmt:message key="conversation.started-msg" bundle="${lang}" var="description"/>
                                                <c:set value="${notification.source} ${description} ${notification.destination}" var="description"/>
                                            </c:if>
                                            <c:if test="${notification.type eq 'MESSAGE_RECEIVED'}">
                                                <fmt:message key="message.received" bundle="${lang}" var="heading"/>
                                                <fmt:message key="message.received-msg" bundle="${lang}" var="description"/>
                                                <c:set value="${notification.source} ${description}" var="description"/>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/notification/show/${notification.id}.html"><h4 class="media-heading">${heading}</h4></a>
                                            <div class="row">
                                                <div class="col-sm-8 col-md-10">
                                                    <c:out value="${description}"/>
                                                </div>
                                                <div class="col-sm-4 col-md-2 text-right">
                                                    <button style="margin: 10px;" id="remove-${notification.id}" class="btn btn-default remove-btn" aria-label="Close">
                                                        <span aria-hidden="true"><strong><span class="visible-xs"><fmt:message key="general.dismiss" bundle="${lang}"/></span> <span class="hidden-xs">X</span></strong></span>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </div>
                            </c:forEach>
                        </div>
                        <script>
                            (function () {
                                var options = {};
                                options['${_csrf.parameterName}'] = '${_csrf.token}';

                                var url = '${pageContext.request.contextPath}/user/profile/${user.id}.html#notifications';

                                $('.remove-btn').click(function () {
                                    var btn = $(this);
                                    var idParts = btn.attr('id').split('-');
                                    idParts.shift();
                                    var id = idParts.join('-');

                                    $.post('${pageContext.request.contextPath}/notification/dismiss/'+id, options)
                                            .done(function () {
                                                if ($('#notification-container').children().length === 1) {
                                                    return window.location.reload(true);
                                                }
                                                var notification = $('#notification-'+id);
                                                notification.fadeOut(function () {
                                                    notification.remove();
                                                });
                                            });
                                });
                            })();
                        </script>
                    </c:otherwise>
                </c:choose>
                
            </div>
        </div>
        <script>
            (function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    var $toBeShown = $(e.target);
                    $toBeShown.parent().find('.active').removeClass('active');
                    $toBeShown.addClass('active');
                });

                $(document).ready(function () {
                    var fragment = document.location.hash;
                    if (fragment != "") {
                        $('a[href="' + fragment + '"]').tab('show');
                    }
                });
            })();
        </script>
    </jsp:body>
</t:paginabasica>