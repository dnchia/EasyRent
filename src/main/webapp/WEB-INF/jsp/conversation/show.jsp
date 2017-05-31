<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:message key="conversation.title" var="title" bundle="${lang}"/>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<c:set value="${title}: ${conversation.tenant eq loggedUser ? conversation.property.owner.username : conversation.tenant.username}" var="title"/>
<t:paginabasica title="${title}">
    <jsp:body>
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/index.html#conversations"><fmt:message key="home.conversations" bundle="${lang}"/></a></li>
            <li class="active"><c:out value="${title}"/></li>
        </ol>
        <div class="page-header">
            <span class="h1"><c:out value="${title}"/></span>
        </div>

        <div>
            <p class="text-right">
                <strong>
                    <fmt:message key="conversation.talking-about" bundle="${lang}"/>
                    <a href="${pageContext.request.contextPath}/property/show/${conversation.property.id}.html"><c:out value="${conversation.property.title}"/></a>
                </strong>
            </p>
            <hr>
        </div>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <fmt:message key="conversation.subtitle" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <c:forEach var="message" items="${conversation.messages}">
                    <c:choose>
                        <c:when test="${empty message.user.photo}">
                            <c:set var="photoUrl" value="${pageContext.request.contextPath}/img/profile-pic.png"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="photoUrl" value="${pageContext.request.contextPath}/uploads/profile-pics/${message.user.photo.filename}"/>
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <div class="media">
                            <c:choose>
                                <c:when test="${loggedUser eq message.user}">
                                    <div class="media-body text-right">
                                        <h4 class="media-heading">
                                            <small><fmt:formatDate value="${message.sendDate}" pattern="dd/MM/yyyy HH:mm"/> </small>
                                            <a href="${pageContext.request.contextPath}/user/profile/${message.user.id}.html"><c:out value="${message.user.username}"/></a>
                                        </h4>
                                        <p><c:out value="${message.message}"/></p>
                                    </div>
                                    <div class="media-right">
                                        <a href="${pageContext.request.contextPath}/user/profile/${message.user.id}.html">
                                            <img class="media-object img-thumbnail" src="${photoUrl}" width="100">
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="media-left">
                                        <a href="${pageContext.request.contextPath}/user/profile/${message.user.id}.html">
                                            <img class="media-object img-thumbnail" src="${photoUrl}" width="100">
                                        </a>
                                    </div>
                                    <div class="media-body">
                                        <h4 class="media-heading">
                                            <a href="${pageContext.request.contextPath}/user/profile/${message.user.id}.html"><c:out value="${message.user.username}"/></a>
                                            <small><fmt:formatDate value="${message.sendDate}" pattern="dd/MM/yyyy HH:mm"/> </small>
                                        </h4>
                                        <p><c:out value="${message.message}"/></p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <hr>
                    </div>
                </c:forEach>
            </div>
            <div class="panel-footer">
                <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/conversation/${conversation.id}/publish-message">
                    <div class="form-group">
                        <fmt:message key="property.message" bundle="${lang}" var="message"/>
                        <fmt:message key="property.write-message" bundle="${lang}" var="writeMessage"/>
                        <label for="message" class="col-sm-2 control-label">${message}</label>
                        <div class="col-sm-10">
                            <textarea id="message" class="form-control" name="message" placeholder="${writeMessage}" maxlength="250"></textarea>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-send"></span> <fmt:message key="general.send" bundle="${lang}"/></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</t:paginabasica>