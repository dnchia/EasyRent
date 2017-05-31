<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="coreActions" uri="http://java.sun.com/jsp/jstl/core"%>

<tag:paginabasica title="List properties">
    <jsp:body>
        <h1>List of properties</h1>
        <hr>
        <a class="btn btn-warning" href="${pageContext.request.contextPath}/property/add.html">
            <span class="glyphicon glyphicon-plus"></span> Add property
        </a>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Owner id</th>
                    <th>Title</th>
                    <th>Location</th>
                    <th>Rooms</th>
                    <th>Capacity</th>
                    <th>Beds</th>
                    <th>Bathrooms</th>
                    <th>Floor space</th>
                    <th>Price per day</th>
                    <th>Creation date</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <coreActions:forEach var="property" items="${properties}">
                    <tr>
                        <td>${property.id}</td>
                        <td>${property.owner.id}</td>
                        <td>${property.title}</td>
                        <td>${property.location}</td>
                        <td>${property.rooms}</td>
                        <td>${property.capacity}</td>
                        <td>${property.beds}</td>
                        <td>${property.bathrooms}</td>
                        <td>${property.floorSpace}</td>
                        <td>${property.pricePerDay}</td>
                        <td>${property.creationDate}</td>
                        <td>${property.type.label}</td>
                        <td>${property.description}</td>
                        <td><a href="${pageContext.request.contextPath}/property/update/${property.id}.html" class="btn btn-warning"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a href="${pageContext.request.contextPath}/property/delete/${property.id}.html" class="btn btn-warning"><span class="glyphicon glyphicon-remove"></span></a></td>
                    </tr>
                </coreActions:forEach>
            </table>
        </div>
        <a href="../index.jsp">Go back to the index page</a>
    </jsp:body>
</tag:paginabasica>