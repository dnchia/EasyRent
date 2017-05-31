<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="coreActions" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="input" tagdir="/WEB-INF/tags" %>

<tag:paginabasica title="EasyRent - Add a photo">

    <jsp:body>

        <h1>Add a photo to the property with id ${property.id}</h1>
        <hr>
        <form:form method="post" modelAttribute="property" cssClass="form-group">

            <form:label path="photo">Upload the photo</form:label>
            <form:input path="photo" type="photo"/>

            <input type="submit" value="Add the photo" class="btn btn-default"/>
        </form:form>

    </jsp:body>
</tag:paginabasica>
