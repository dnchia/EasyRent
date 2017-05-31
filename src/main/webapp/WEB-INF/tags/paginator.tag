<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="currentPage" required="true" type="java.lang.Integer" %>
<%@ attribute name="totalPages" required="true" type="java.lang.Integer" %>
<%@ attribute name="baseUri" required="true" %>

<hr>
<nav class="text-center">
    <ul class="pagination">
        <li class="${currentPage == 0 ? 'disabled' : ''}">
            <c:set var="prev" value="${pageContext.request.contextPath}/${baseUri}?q=${param.q}&s=${param.s}&e=${param.e}&page=${param.page-1}&size=${param.size != null ? param.size : 20}"/>
            <a href="${currentPage != 0 ? prev : '#'}" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
        <c:forEach begin="1" end="${totalPages}" var="page">
            <li class="${page == currentPage+1 ? 'active' : ''}"><a href="${pageContext.request.contextPath}/${baseUri}?q=${param.q}&s=${param.s}&e=${param.e}&page=${page-1}&size=${param.size != null ? param.size : 20}">${page}</a></li>
        </c:forEach>
        <li class="${totalPages == 0 or currentPage+1 == totalPages ? 'disabled' : ''}">
            <c:set var="next" value="${pageContext.request.contextPath}/${baseUri}?q=${param.q}&s=${param.s}&e=${param.e}&page=${param.page != null ? param.page+1 : 1}&size=${param.size != null ? param.size : 20}"/>
            <a href="${totalPages != 0 and currentPage+1 != totalPages ? next : '#'}" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>