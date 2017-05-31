<%@ tag description="Property info model" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="row">
    <div class="col-md-6">
        <fmt:message key="property.title" bundle="${lang}" var="name"/>
        <tag:input path="title" label="${name}"/>
    </div>
    <div class="col-md-6">
        <fmt:message key="property.location" bundle="${lang}" var="location"/>
        <tag:input id="location" path="location" label="${location}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <fmt:message key="property.type" bundle="${lang}" var="type"/>
        <div class="form-group">
            <form:label path="type" cssClass="control-label col-sm-2">${type}</form:label>
            <div class="col-sm-10">
                <form:select path="type" cssClass="form-control">
                    <form:options items="${propertyTypes}" itemValue="value" itemLabel="label"/>
                </form:select>
                <form:errors path="type" cssClass="text-danger"/>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <fmt:message key="property.price-per-day-wo-vat" bundle="${lang}" var="pricePerDay"/>
        <tag:input path="pricePerDay" type="number" step=".01" label="${pricePerDay}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <fmt:message key="property.capacity" bundle="${lang}" var="capacity"/>
        <tag:input path="capacity" type="number" label="${capacity} &nbsp;(<span class='glyphicon glyphicon-user'></span>)"/>
    </div>
    <div class="col-md-6">
        <fmt:message key="property.rooms" bundle="${lang}" var="rooms"/>
        <tag:input path="rooms" type="number" label="${rooms}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <fmt:message key="property.bathrooms" bundle="${lang}" var="bathrooms"/>
        <tag:input path="bathrooms" type="number" label="${bathrooms}"/>
    </div>
    <div class="col-md-6">
        <fmt:message key="property.beds" bundle="${lang}" var="beds"/>
        <tag:input path="beds" type="number" label="${beds}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <fmt:message key="property.floor-space" bundle="${lang}" var="floorSpace"/>
        <tag:input path="floorSpace" type="number" label="${floorSpace}"/>
    </div>
    <div class="col-md-6">
        <fmt:message key="property.description" bundle="${lang}" var="description"/>
        <tag:input path="description" label="${description}" type="textarea"/>
    </div>
</div>
<script>
    (function () {
        var input = document.getElementById('location');
        var options = { types: ['geocode'] };
        var autocomplete = new google.maps.places.Autocomplete(input, options);
        $(input).attr('placeholder', '');
        $(input).keydown(function (e) {
            if (e.which == 13 && $('.pac-container:visible').length) return false;
        });
    })();
</script>