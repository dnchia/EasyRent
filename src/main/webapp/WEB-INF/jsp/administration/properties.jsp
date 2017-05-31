<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:message key="administration.title" var="title" bundle="${lang}"/>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="loggedUser" property="principal" />
</sec:authorize>

<t:paginabasica title="${title}">
    <jsp:body>
        <div class="page-header">
            <span class="h1">${title}</span>
        </div>
        <div class="container">
            <hr>
            <t:administration-options location="properties"/>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-warning top-padding30px">
                        <div class="panel-heading"><fmt:message key="administration-properties.searchForProperties" bundle="${lang}"/></div>
                        <div class="panel-body">

                            <form class="form-inline" method="get" action="/administration/properties/searchFor">

                                <div class="form-group">
                                    <label for="selectedPropertyAttribute">
                                        <fmt:message key="search.by-attribute" bundle="${lang}"/>
                                    </label>

                                    <select id="selectedPropertyAttribute" onchange="changedSelectValue()" class="form-control" name="selectedPropertyAttribute">
                                        <option value="title"><fmt:message key="administration-properties.title" bundle="${lang}"/></option>
                                        <option value="owner"><fmt:message key="administration-properties.ownerUsername" bundle="${lang}"/></option>
                                        <option value="location"><fmt:message key="administration-properties.location" bundle="${lang}"/></option>
                                        <option value="rooms"><fmt:message key="administration-properties.rooms" bundle="${lang}"/></option>
                                        <option value="capacity"><fmt:message key="administration-properties.capacity" bundle="${lang}"/></option>
                                        <option value="beds"><fmt:message key="administration-properties.beds" bundle="${lang}"/></option>
                                        <option value="bathrooms"><fmt:message key="administration-properties.bathrooms" bundle="${lang}"/></option>
                                        <option value="floorSpace"><fmt:message key="administration-properties.floorSpace" bundle="${lang}"/></option>
                                        <option value="pricePerDay"><fmt:message key="administration-properties.pricePerDay" bundle="${lang}"/></option>
                                        <option value="creationDate"><fmt:message key="administration-properties.creationDate" bundle="${lang}"/></option>
                                        <option value="type"><fmt:message key="administration-properties.type" bundle="${lang}"/></option>
                                        <option value="description"><fmt:message key="administration-properties.description" bundle="${lang}"/></option>
                                    </select>
                                </div>

                                <div class="input-group" id="input">
                                    <input type="text" class="form-control" id="searchedFor" name="searchedFor" placeholder="Search for properties" value="" size="80">
                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-warning"><fmt:message key="administration.search" bundle="${lang}"/></button>
                                    </div>
                                </div>

                                <script type="text/javascript">
                                    function changedSelectValue() {
                                        var select = document.getElementById("selectedPropertyAttribute");
                                        var selectedOption = select.options[select.selectedIndex].value;

                                        var inputDiv = document.getElementById("input");

                                        if (selectedOption == "rooms" || selectedOption == "capacity" || selectedOption == "beds" || selectedOption == "bathroom" || selectedOption == "floorSpace") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for properties' min='0' max='999' size='80'>" +
                                            "<div class='input-group-btn'>" +
                                            "<button type='submit' class='btn btn-warning'>" +
                                            "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                            "</button></div>");
                                        }
                                        else if (selectedOption == "pricePerDay") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for properties' min='0' max='9999' step='0.1' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else if (selectedOption == "creationDate") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='date' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for properties' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='text' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for properties' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                    }
                                </script>

                            </form>

                        </div>

                        <div class="panel-heading"><fmt:message key="administration-users.listOfSearchedProperties" bundle="${lang}"/></div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th><fmt:message key="administration-properties.ownerID" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.ownerUsername" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.title" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.location" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.rooms" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.capacity" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.beds" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.bathrooms" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.floorSpace" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.pricePerDay" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.creationDate" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.type" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-properties.description" bundle="${lang}"/></th>
                                    </tr>
                                    <c:forEach var="property" items="${properties}">
                                        <tr>
                                            <td>${property.id}</td>
                                            <td>${property.owner.id}</td>
                                            <td>${property.owner.username}</td>
                                            <td><c:out value="${property.title}"/></td>
                                            <td><c:out value="${property.location}"/></td>
                                            <td>${property.rooms}</td>
                                            <td>${property.capacity}</td>
                                            <td>${property.beds}</td>
                                            <td>${property.bathrooms}</td>
                                            <td>${property.floorSpace}</td>
                                            <td>${property.pricePerDay}</td>
                                            <td>${property.creationDate}</td>
                                            <td>${property.type.label}</td>
                                            <td><c:out value="${property.description}"/></td>
                                            <td><a href="${pageContext.request.contextPath}/administration/properties/delete/${property.id}.html" class="btn btn-warning"><span class="glyphicon glyphicon-remove"></span></a></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:paginabasica>