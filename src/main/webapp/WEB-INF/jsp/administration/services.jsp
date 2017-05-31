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
            <t:administration-options location="services"/>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-warning top-padding30px">
                        <div class="panel-heading"><fmt:message key="administration-services.alertsForMostDemanded" bundle="${lang}"/></div>
                        <div class="panel-body">

                            <div class="table-responsive">
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th><fmt:message key="service.name" bundle="${lang}"/></th>
                                        <th><fmt:message key="service.value" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.proposedBy" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.active" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.creationDate" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.activeSince" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.serviceProposals" bundle="${lang}"/></th>
                                        <th><fmt:message key="service.changeState" bundle="${lang}"/></th>
                                        <th><fmt:message key="service.delete" bundle="${lang}"/></th>
                                    </tr>
                                    <c:forEach var="service" items="${mostDemandedServices}">
                                        <tr>
                                            <td>${service.id}</td>
                                            <td><c:out value="${service.name}"/></td>
                                            <td><c:out value="${service.value}"/></td>
                                            <td>${service.user.username}</td>
                                            <td>${service.active}</td>
                                            <td>${service.creationDate}</td>
                                            <td>${service.activeSince}</td>
                                            <td>${service.serviceProposals}</td>
                                            <td><a href="${pageContext.request.contextPath}/administration/services/changeState/${service.id}.html" class="btn btn-primary">
                                                <c:choose>
                                                    <c:when test="${service.active == true}">
                                                        <span class="glyphicon glyphicon-off"> OFF</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="glyphicon glyphicon-off"> ON</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a> </td>
                                            <td><a href="${pageContext.request.contextPath}/administration/services/delete/${service.id}.html" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span></a></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>

                        <div class="panel-heading"><fmt:message key="administration-services.searchForServices" bundle="${lang}"/> </div>
                        <div class="panel-body">

                            <form class="form-inline" method="get" action="/administration/services/searchFor">

                                <div class="form-group">
                                    <label for="selectedServiceAttribute">
                                        <fmt:message key="search.by-attribute" bundle="${lang}"/>
                                    </label>
                                    <select id="selectedServiceAttribute" onchange="changedSelectValue()" name="selectedServiceAttribute" class="form-control">
                                        <option value="name"><fmt:message key="service.name" bundle="${lang}"/></option>
                                        <option value="proposedByUser"><fmt:message key="service.proposedBy" bundle="${lang}"/></option>
                                        <option value="active"><fmt:message key="service.active" bundle="${lang}"/></option>
                                        <option value="creationDate"><fmt:message key="service.creationDate" bundle="${lang}"/></option>
                                        <option value="activeSince"><fmt:message key="service.activeSince" bundle="${lang}"/></option>
                                        <option value="serviceProposals"><fmt:message key="service.serviceProposals" bundle="${lang}"/></option>
                                    </select>
                                </div>

                                <div class="input-group" id="input">
                                    <input type="text" class="form-control" id="searchedFor" name="searchedFor" placeholder="Search for services" value="" size="80">
                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-warning"><fmt:message key="administration.search" bundle="${lang}"/></button>
                                    </div>
                                </div>

                                <script type="text/javascript">
                                    function changedSelectValue() {
                                        var select = document.getElementById("selectedServiceAttribute");
                                        var selectedOption = select.options[select.selectedIndex].value;

                                        var inputDiv = document.getElementById("input");

                                        if (selectedOption == "active") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', " Yes: <input type='radio' name='searchedFor' value='true' id='searchFor'>" +
                                                    " No: <input type='radio' name='searchedFor' value='false' id='searchedFor'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button>" +
                                                    "</div>"
                                            );
                                        }
                                        else if (selectedOption == "creationDate" || selectedOption == "activeSince") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin',
                                                    "<input type='date' id='searchedFor' name='searchedFor' class='form-control'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button>" +
                                                    "</div>");
                                        }
                                        else if (selectedOption == "serviceProposals") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for services' min='0' size=80>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='text' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for services' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                    }
                                </script>
                            </form>

                        </div>

                        <div class="panel-heading"><fmt:message key="administration-services.listOfSearchedServices" bundle="${lang}"/> </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th><fmt:message key="service.name" bundle="${lang}"/></th>
                                        <th><fmt:message key="service.value" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.proposedBy" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.active" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.creationDate" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.activeSince" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.serviceProposals" bundle="${lang}"/> </th>
                                        <th><fmt:message key="service.changeState" bundle="${lang}"/></th>
                                        <th><fmt:message key="service.delete" bundle="${lang}"/></th>
                                    </tr>
                                    <c:forEach var="service" items="${services}">
                                        <tr>
                                            <td>${service.id}</td>
                                            <td>${service.name}</td>
                                            <td>${service.value}</td>
                                            <td>${service.user.username}</td>
                                            <td>${service.active}</td>
                                            <td>${service.creationDate}</td>
                                            <td>${service.activeSince}</td>
                                            <td>${service.serviceProposals}</td>
                                            <td><a href="${pageContext.request.contextPath}/administration/services/changeState/${service.id}.html" class="btn btn-primary">
                                                <c:choose>
                                                    <c:when test="${service.active == true}">
                                                        <span class="glyphicon glyphicon-off"> OFF</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="glyphicon glyphicon-off"> ON</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a> </td>
                                            <td><a href="${pageContext.request.contextPath}/administration/services/delete/${service.id}.html" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span></a></td>
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