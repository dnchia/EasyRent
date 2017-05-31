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
            <t:administration-options location="invoices"/>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-warning top-padding30px">
                        <div class="panel-heading"><fmt:message key="administration-invoices.searchForInvoices" bundle="${lang}"/></div>
                        <div class="panel-body">

                            <form class="form-inline" method="get" action="/administration/invoices/searchFor">

                                <div class="form-group">
                                    <label for="selectedInvoiceAttribute">
                                        <fmt:message key="search.by-attribute" bundle="${lang}"/>
                                    </label>

                                    <select id="selectedInvoiceAttribute" onchange="changedSelectValue()" name="selectedInvoiceAttribute" class="form-control">
                                        <option value="number"><fmt:message key="invoice.number" bundle="${lang}"/></option>
                                        <option value="vat"><fmt:message key="invoice.vat" bundle="${lang}"/></option>
                                        <option value="address"><fmt:message key="invoice.address" bundle="${lang}"/></option>
                                        <option value="expeditionDate"><fmt:message key="invoice.expedition-date" bundle="${lang}"/></option>
                                        <option value="totalAmount"><fmt:message key="invoice.total-amount" bundle="${lang}"/></option>
                                    </select>
                                </div>

                                <div class="input-group" id="input">
                                    <input type="number" class="form-control" id="searchedFor" name="searchedFor" placeholder="Search for invoices" value="" size="80">
                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-warning"><fmt:message key="administration.search" bundle="${lang}"/></button>
                                    </div>
                                </div>

                                <script type="text/javascript">
                                    function changedSelectValue() {
                                        var select = document.getElementById("selectedInvoiceAttribute");
                                        var selectedOption = select.options[select.selectedIndex].value;

                                        var inputDiv = document.getElementById("input");

                                        if (selectedOption == "number") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for invoices' min='0' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else if (selectedOption == "vat" || selectedOption == "totalAmount") {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='number' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for invoices' min='0' step='0.1' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                        else if (selectedOption == "expeditionDate") {
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
                                        else {
                                            inputDiv.innerHTML = "";
                                            inputDiv.className = "input-group";

                                            inputDiv.insertAdjacentHTML('afterbegin', "<input type='text' class='form-control' id='searchedFor' name='searchedFor' placeholder='Search for invoices' size='80'>" +
                                                    "<div class='input-group-btn'>" +
                                                    "<button type='submit' class='btn btn-warning'>" +
                                                    "<fmt:message key='administration.search' bundle='${lang}'/>" +
                                                    "</button></div>");
                                        }
                                    }
                                </script>

                            </form>

                        </div>

                        <div class="panel-heading"><fmt:message key="administration-invoices.listOfSearchedInvoices" bundle="${lang}"/></div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th><fmt:message key="invoice.booking" bundle="${lang}"/></th>
                                        <th><fmt:message key="invoice.number" bundle="${lang}"/></th>
                                        <th><fmt:message key="invoice.vat" bundle="${lang}"/></th>
                                        <th><fmt:message key="invoice.address" bundle="${lang}"/></th>
                                        <th><fmt:message key="user.country" bundle="${lang}"/></th>
                                        <th><fmt:message key="user.post-code" bundle="${lang}"/></th>
                                        <th><fmt:message key="invoice.expedition-date" bundle="${lang}"/></th>
                                        <th><fmt:message key="invoice.total-amount" bundle="${lang}"/></th>
                                    </tr>
                                    <c:forEach var="invoice" items="${invoices}">
                                        <tr>
                                            <td>${invoice.id}</td>
                                            <td>${invoice.proposal.id}</td>
                                            <td>${invoice.number}</td>
                                            <td>${invoice.vat}</td>
                                            <td><c:out value="${invoice.address}"/></td>
                                            <td><c:out value="${invoice.country}"/></td>
                                            <td>${invoice.postCode}</td>
                                            <td>${invoice.expeditionDate}</td>
                                            <td>${invoice.proposal.totalAmount}</td>
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