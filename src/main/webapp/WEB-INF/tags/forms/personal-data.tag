<%@ tag description="Personal data model" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:message key="user.name" var="name" bundle="${lang}"/>
<t:input path="name" label="${name}" required="true"/>
<fmt:message key="user.surnames" var="surnames" bundle="${lang}"/>
<t:input path="surnames" label="${surname}" required="true"/>
<fmt:message key="user.dni" var="dni" bundle="${lang}"/>
<t:input path="dni" label="${dni}" required="true"/>
<fmt:message key="user.country-prefix" var="countryPrefix" bundle="${lang}"/>
<t:input path="countryPrefix" label="${countryPrefix}"/>
<fmt:message key="user.phone-number" var="phoneNumber" bundle="${lang}"/>
<t:input path="phoneNumber" label="${phoneNumber}"/>