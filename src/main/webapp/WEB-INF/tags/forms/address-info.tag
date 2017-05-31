<%@ tag description="Personal data model" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:message key="user.address" var="address" bundle="${lang}"/>
<t:input path="address" required="true" label="${address}"/>
<fmt:message key="user.country" var="country" bundle="${lang}"/>
<t:input path="country" required="true" label="${country}"/>
<fmt:message key="user.post-code" var="postCode" bundle="${lang}"/>
<t:input path="postCode" type="number" required="true" label="${postCode}"/>