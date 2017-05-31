<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="coreActions" uri="http://java.sun.com/jsp/jstl/core"%>

<tag:paginabasica title="List services">
    <jsp:body>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Value</th>
                    <th>User ID</th>
                    <th>Active</th>
                    <th>Creation date</th>
                    <th>Active since</th>
                    <th>Service proposals</th>
                </tr>
                <coreActions:forEach var="service" items="${services}">
                    <tr>
                        <td>${service.id}</td>
                        <td>${service.name}</td>
                        <td>${service.value}</td>
                        <td>${service.user.id}</td>
                        <td>${service.active}</td>
                        <td>${service.creationDate}</td>
                        <td>${service.activeSince}</td>
                        <td>${service.serviceProposals}</td>
                        <td><a href="${pageContext.request.contextPath}/service/changeState/${service.id}.html" class="btn btn-primary"><span class="glyphicon glyphicon-plus-sign"></span></a> </td>
                        <td><a href="${pageContext.request.contextPath}/service/update/${service.id}.html" class="btn btn-primary"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a href="${pageContext.request.contextPath}/service/delete/${service.id}.html" class="btn btn-primary"><span class="glyphicon glyphicon-remove"></span></a></td>
                    </tr>
                </coreActions:forEach>
            </table>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/service/add.html">
            <span class="glyphicon glyphicon-plus"></span> Add new service
        </a>
    </jsp:body>
</tag:paginabasica>