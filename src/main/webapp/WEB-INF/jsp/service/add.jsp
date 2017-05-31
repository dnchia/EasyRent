<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="coreActions" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="input" tagdir="/WEB-INF/tags" %>

<tag:paginabasica title="Add a new service">
    <jsp:body>
        <form:form method="post" modelAttribute="service" cssClass="form-group">

            <tag:input path="name" label="Name of the service"/>

            <tag:input path="value" label="Value of the service"/>

            <tag:input path="active" type="checkbox" label="Service active"/>

            <input type="submit" value="Add the service" class="btn btn-default"/>
        </form:form>
    </jsp:body>
</tag:paginabasica>