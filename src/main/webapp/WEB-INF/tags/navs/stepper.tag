<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ attribute name="step" type="java.lang.Integer" required="true" %>
<%@ attribute name="path" type="java.lang.String" required="true" %>
<%@ attribute name="steps" type="java.util.List" required="true" %>

<div class="row bs-wizard" style="border-bottom:0;">
    <c:set value="${12 div fn:length(steps)}" var="colSize"/>
    <c:if test="${fn:length(steps) eq 7}">
        <c:set value="${1}" var="colSize"/>
    </c:if>
    <c:set value="${12 mod fn:length(steps) div 2}" var="offset"/>
    <c:if test="${fn:length(steps) eq 7}">
        <c:set value="${3}" var="offset"/>
    </c:if>
    <fmt:formatNumber value="${colSize}" maxFractionDigits="0" var="colSize"/>
    <fmt:formatNumber value="${offset}" maxFractionDigits="0" var="offset"/>
    <c:forEach var="stepPoint" items="${steps}" varStatus="status">
        <navs:step-classes current="${step}" step="${status.index}" var="classes"/>
        <div class="${status.index == 0 && offset != 0 ? 'col-xs-offset-' : ''}${status.index == 0 && offset != 0 ? offset : ''} col-xs-${colSize} bs-wizard-step ${classes}">
            <div class="text-center bs-wizard-stepnum"><span class="glyphicon glyphicon-${stepPoint[0]}"></span></div>
            <div class="progress"><div class="progress-bar"></div></div>
            <a href="${pageContext.request.contextPath}${path}.html?step=${status.index}" class="bs-wizard-dot"></a>
            <div class="bs-wizard-info text-center hidden-xs">
                <fmt:message key="${stepPoint[1]}" bundle="${lang}"/>
            </div>
        </div>
    </c:forEach>
</div>