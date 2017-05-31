<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="coreActions" uri="http://java.sun.com/jsp/jstl/core"%>

<tag:paginabasica title="List booking proposals">
    <jsp:body>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Property ID</th>
                    <th>Tenant ID</th>
                    <th>Start date</th>
                    <th>End date</th>
                    <th>Status</th>
                    <th>Payment reference</th>
                    <th>Total amount</th>
                    <th>Number of tenants</th>
                    <th>Date of creation</th>
                    <th>Date of acceptation</th>
                    <th>Invoice</th>
                </tr>
                <coreActions:forEach var="bookingProposal" items="${bookingProposals}">
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
                        <td><a href="${pageContext.request.contextPath}/bookingProposal/delete/${bookingProposal.id}.html" class="btn btn-primary"><span class="glyphicon glyphicon-remove"></span></a></td>
                    </tr>
                </coreActions:forEach>
            </table>
        </div>
    </jsp:body>
</tag:paginabasica>