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
            <t:administration-options location="booking_proposals"/>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-warning top-padding30px">
                        <div class="panel-heading"><fmt:message key="administration-bookingProposals.searchForBookingProposals" bundle="${lang}"/></div>
                        <div class="panel-body">

                            <form class="form-inline" method="get" action="/administration/booking_proposals/searchFor">

                                <div class="form-group">
                                    <label for="selectedBookingProposalsAttribute">
                                        <fmt:message key="search.by-attribute" bundle="${lang}"/>
                                    </label>

                                    <select id="selectedBookingProposalsAttribute" onchange="changedSelectValue()" name="selectedBookingProposalsAttribute" class="form-control">
                                        <option value="propertyTitle"><fmt:message key="administration-bookingProposals.propertyTitle" bundle="${lang}"/></option>
                                        <option value="tenantUsername"><fmt:message key="administration-bookingProposals.tenantUsername" bundle="${lang}"/></option>
                                        <option value="startDate"><fmt:message key="administration-bookingProposals.startDate" bundle="${lang}"/></option>
                                        <option value="endDate"><fmt:message key="administration-bookingProposals.endDate" bundle="${lang}"/></option>
                                        <option value="status"><fmt:message key="administration-bookingProposals.status" bundle="${lang}"/></option>
                                        <option value="paymentReference"><fmt:message key="administration-bookingProposals.paymentReference" bundle="${lang}"/></option>
                                        <option value="totalAmount"><fmt:message key="administration-bookingProposals.totalAmount" bundle="${lang}"/></option>
                                        <option value="numberOfTenants"><fmt:message key="administration-bookingProposals.numberOfTenants" bundle="${lang}"/></option>
                                        <option value="dateOfCreation"><fmt:message key="administration-bookingProposals.dateOfCreation" bundle="${lang}"/></option>
                                        <option value="dateOfAcceptance"><fmt:message key="administration-bookingProposals.dateOfAcceptance" bundle="${lang}"/></option>
                                        <option value="invoiceNumber"><fmt:message key="administration-bookingProposals.invoiceNumber" bundle="${lang}"/></option>
                                    </select>
                                </div>

                                <div class="input-group" id="input">
                                    <input type="text" class="form-control" id="searchedFor" name="searchedFor" placeholder="Search for booking proposals" value="" size="80">
                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-warning"><fmt:message key="administration.search" bundle="${lang}"/></button>
                                    </div>
                                </div>
                                
                                <script type="text/javascript">
                                    function changedSelectValue() {
                                        var select = document.getElementById("selectedBookingProposalsAttribute");
                                        var selectedOption = select.options[select.selectedIndex].value;

                                        var inputDiv = document.getElementById("input");

                                        if (selectedOption == "startDate" || selectedOption == "endDate" || selectedOption == "dateOfCreation" || selectedOption == "dateOfAcceptance") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin',
                                                    "<input type='date' id='searchedFor' name='searchedFor' class='form-control administrationInputField'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button>" +
                                                    "</div>");
                                        }
                                        else if (selectedOption == "status") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<select id='searchedFor' name='searchedFor' class='form-control administrationInputField'>" +
                                                    "<option value='PENDING'>Pending</option>" +
                                                    "<option value='ACCEPTED'>Accepted</option>" +
                                                    "<option value='REJECTED'>Rejected</option>" +
                                                    "</select>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>"
                                            );
                                        }
                                        else if (selectedOption == "totalAmount") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control administrationInputField' id='searchedFor' name='searchedFor' placeholder='Search for booking proposals' min='0' step='0.1' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else if (selectedOption == "numberOfTenants" || selectedOption == "invoiceNumber") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control administrationInputField' id='searchedFor' name='searchedFor' placeholder='Search for booking proposals' min='0' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='text' class='form-control administrationInputField' id='searchedFor' name='searchedFor' placeholder='Search for booking proposals' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                    }
                                </script>

                            </form>

                        </div>

                        <div class="panel-heading"><fmt:message key="administration-bookingProposals.listOfSearchedBookingProposals" bundle="${lang}"/></div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th><fmt:message key="administration-bookingProposals.propertyTitle" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.tenantUsername" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.startDate" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.endDate" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.status" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.paymentReference" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.totalAmount" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.numberOfTenants" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.dateOfCreation" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.dateOfAcceptance" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.invoiceNumber" bundle="${lang}"/></th>
                                        <th><fmt:message key="administration-bookingProposals.delete?" bundle="${lang}"/></th>
                                    </tr>
                                    <c:forEach var="bookingProposal" items="${bookingProposals}">
                                        <tr>
                                            <td>${bookingProposal.id}</td>
                                            <td>${bookingProposal.property.id}</td>
                                            <td>${bookingProposal.tenant.id}</td>
                                            <td>${bookingProposal.startDate}</td>
                                            <td>${bookingProposal.endDate}</td>
                                            <td>${bookingProposal.status.toString()}</td>
                                            <td>${bookingProposal.paymentReference}</td>
                                            <td>${bookingProposal.totalAmount}</td>
                                            <td>${bookingProposal.numberOfTenants}</td>
                                            <td>${bookingProposal.dateOfCreation}</td>
                                            <td>${bookingProposal.dateOfUpdate}</td>
                                            <td>${bookingProposal.invoice.number}</td>
                                            <td><a href="${pageContext.request.contextPath}/administration/booking_proposals/delete/${bookingProposal.id}.html" class="btn btn-primary"><span class="glyphicon glyphicon-remove"></span></a></td>
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