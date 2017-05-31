<%@ tag description="EasyRent boilerplate"
        pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="resource"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${title}"/></title>

    <!-- Bootstrap -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    <!-- Custom styles -->
    <link
            href="${pageContext.request.contextPath}/css/easyrent.css"
            rel="stylesheet">
    <link
            href="${pageContext.request.contextPath}/css/wizard.css"
            rel="stylesheet">

    <!-- Third-party libraries -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jasny-bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jasny-bootstrap.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datepicker.min.css">
    <script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/moment-range.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dropzone.min.css">
    <script src="${pageContext.request.contextPath}/js/dropzone.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">

    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOjLkqYfh1-dvWvdcNXOtg6zN0ajK_x60&libraries=places"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>

</head>
<body>
<c:set var="locale" value="en"/>
<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
    <%-- TODO Set user prefered languaje --%>
    <c:set var="locale" value="en"/>
</sec:authorize>
<fmt:setLocale value="${locale}"/>
<fmt:setBundle basename="locale" var="lang" scope="application"/>

<t:navigation resource="${resource}"/>
<header class="jumbotron ${resource eq 'index' ? 'text-center' : ''}">
    <div class="${resource eq 'index' ? '' : 'container'}">
        <c:if test="${resource eq 'index'}">
            <h1>EasyRent</h1>
            <p><fmt:message key="easyrent.slogan" bundle="${lang}" /></p>
        </c:if>
        <form id="search-form" class="form-inline" method="get" action="${pageContext.request.contextPath}/search.html">
            <div class="form-group">
                <fmt:message key="home.search" bundle="${lang}" var="search"/>
                <input class="form-control" name="q" placeholder="${search}" value="${param.q != null ? param.q : ''}" size="40">
            </div>
            <fmt:message key="general.enter-date" bundle="${lang}" var="enterDate"/>
            <div class="input-group input-daterange" id="search-date-range">
                <span class="input-group-addon"><fmt:message key="general.from" bundle="${lang}"/> </span>
                <input name="s" required class="form-control" placeholder="${enterDate}" value="${param.s != null ? param.s : ''}" size="10"/>
                <span class="input-group-addon"><fmt:message key="general.to" bundle="${lang}"/> </span>
                <input name="e" required class="form-control" placeholder="${enterDate}" value="${param.e != null ? param.e : ''}" size="10"/>
                <div class="input-group-btn">
                    <button type="submit" class="btn btn-default"><fmt:message key="home.search-btn" bundle="${lang}"/> </button>
                </div>
            </div>
        </form>
    </div>
</header>
<div class="container ${resource ne 'index' ? 'container-padded' : ''}">
    <jsp:doBody />
</div>
<c:if test="${resource ne 'search'}">
    <footer class="container-fluid container-padded bg-concrete">
        <hr>
        <p class="text-white text-center">
            &copy;<er:year-tag/> - <fmt:message key="easyrent.project" bundle="${lang}"/> | <a href="${pageContext.request.contextPath}/about-us.html"><fmt:message key="about-us.title" bundle="${lang}"/></a> | <a href="${pageContext.request.contextPath}/contact-us.html"><fmt:message key="contact-us.title" bundle="${lang}"/></a>
        </p>
    </footer>
</c:if>
<er:time-config type="datepicker" var="datepickerFormat"/>
<er:time-config type="moment" var="momentFormat"/>
<script>
    $('#search-form').find('.input-daterange').datepicker({
        format: '${datepickerFormat}',
        startDate: moment().format('${momentFormat}')
    });
</script>
</body>
</html>
