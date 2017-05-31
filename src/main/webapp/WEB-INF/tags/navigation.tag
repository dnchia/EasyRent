<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="resource"%>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <span class="corporate-text">
                    <span class="glyphicon glyphicon-home"></span>
                    <c:if test="${resource ne 'index'}">
                        <span>EasyRent</span>
                    </c:if>
                </span>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${loggedUser == null || loggedUser.id == null}">
                        <li>
                            <fmt:message key="index.invite-signup" bundle="${lang}" var="addPropertyBtn"/>
                            <a href="${pageContext.request.contextPath}/become-a-host.html" title="${addPropertyBtn}">
                                <span class="glyphicon glyphicon-plus"><span class="glyphicon glyphicon-home"></span></span> ${addPropertyBtn.toUpperCase()}
                            </a>
                        </li>
                        <li class="divider-vertical hidden-xs"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/login.html">
                                <span class="glyphicon glyphicon-log-in"></span> <fmt:message key="navigation.login" bundle="${lang}"/>
                            </a>
                        </li>
                        <li id="signup-nav-btn" class="bg-concrete text-white">
                            <a class="text-white" href="${pageContext.request.contextPath}/signup.html">
                                <fmt:message key="navigation.signup" bundle="${lang}"/>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${loggedUser.role eq 'ADMINISTRATOR'}">
                            <li>
                                <fmt:message key="administration.title" bundle="${lang}" var="administrationBtn"/>
                                <a href="${pageContext.request.contextPath}/administration.html" title="${administrationBtn}">
                                    <span class="glyphicon glyphicon-cog"></span> <span>${administrationBtn.toUpperCase()}</span>
                                </a>
                            </li>
                        </c:if>
                        <li>
                            <fmt:message key="add-property.add" bundle="${lang}" var="addPropertyBtn"/>
                            <a href="${pageContext.request.contextPath}/property/add.html" title="${addPropertyBtn}">
                                <span class="glyphicon glyphicon-plus"><span class="glyphicon glyphicon-home"></span></span> <span class="visible-xs-inline">${addPropertyBtn.toUpperCase()}</span>
                            </a>
                        </li>
                        <li>
                            <fmt:message key="notifications.title" bundle="${lang}" var="notificationsBtn"/>
                            <a ${fn:length(sessionScope.notifications) gt 0 ? 'class="animated infinite rubberBand"' : ''} href="${pageContext.request.contextPath}/user/profile/${loggedUser.id}.html#notifications" title="${notificationsBtn}">
                                <span class="glyphicon glyphicon-bell"></span> <span class="visible-xs-inline">${notificationsBtn.toUpperCase()}</span> <span class="badge">${fn:length(sessionScope.notifications)}</span>
                            </a>
                        </li>
                        <li class="divider-vertical hidden-xs"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/user/profile/${loggedUser.id}.html">
                                <span class="glyphicon glyphicon-user"></span> ${sessionScope.username.toUpperCase()}
                            </a>
                        </li>
                        <li id="logout-nav-btn" class="bg-concrete text-white">
                            <a href="#" id="logout-btn" class="bg-concrete text-white">
                                <span class="glyphicon glyphicon-log-out"></span> <fmt:message key="navigation.logout" bundle="${lang}"/>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<script>
    (function () {
        $('#logout-btn').click(function (evt) {
            evt.stopPropagation();
            var options = {};
            options['${_csrf.parameterName}'] = '${_csrf.token}'
            $.post('${pageContext.request.contextPath}/logout', options).done(function () {
                window.location.reload();
            });
        })
    })()
</script>