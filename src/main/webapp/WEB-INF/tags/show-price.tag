<%@ tag description="Price tag" pageEncoding="UTF-8"%>
<%@ attribute name="amount" required="true" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:formatNumber currencySymbol="€" type="currency" value="${amount}" pattern="####.00 ¤"/>