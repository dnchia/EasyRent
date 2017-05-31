<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fm" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:message key="book-property.title" bundle="${lang}" var="title"/>
<fmt:message key="proposal.title" bundle="${lang}" var="subtitle"/>
<t:paginabasica title="${title}: ${subtitle}">
    <jsp:body>
        <t:property-book-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute(sessionMapName).step.ordinal()}" steps="${steps}" path="/property/booking-proposal/${property.id.toString()}"/>

        <div class="panel panel-info">
            <div class="panel-heading">
                <fmt:message key="proposal.help-title" bundle="${lang}"/>
            </div>
            <div class="panel-body">
                <p><fmt:message key="proposal.help-title-message" bundle="${lang}"/></p>
                <p><fmt:message key="proposal.advice" bundle="${lang}"/></p>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                            ${title}
                    </div>
                    <div class="panel-body">
                        <form:form cssClass="form-horizontal" method="post" action="${pageContext.request.contextPath}/property/booking-proposal/${property.id}/2" modelAttribute="bookingForm">
                            <div class="form-group" id="datepicker-container">
                                <label class="control-label col-sm-3"><fmt:message key="proposal.date-range" bundle="${lang}"/></label>
                                <div class="col-sm-9">
                                    <div class="input-daterange input-group" id="datepicker">
                                        <form:input path="startDate" required="true" cssClass="input-sm form-control"/>
                                        <span class="input-group-addon"><fmt:message key="general.to" bundle="${lang}"/></span>
                                        <form:input path="endDate" required="true" cssClass="input-sm form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <form:errors cssClass="text-danger" path="startDate"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <form:label cssClass="control-label col-sm-3" path="numberOfTenants"><fmt:message key="proposal.number-of-tenants" bundle="${lang}"/> </form:label>
                                <div class="col-sm-4">
                                    <form:select path="numberOfTenants" cssClass="form-control">
                                        <c:forEach begin="1" end="${property.capacity}" var="count">
                                            <form:option value="${count}" label="${count}"/>
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <a href="${pageContext.request.contextPath}/property/booking-proposal/${property.id}.html?step=1" class="btn btn-warning"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/></a>
                                    <button type="submit" class="btn btn-warning"><fmt:message key="general.next" bundle="${lang}"/> <span class="glyphicon glyphicon-forward"></span></button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="row">
                    <div class="col-md-5">
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <fmt:message key="property.availability-dates" bundle="${lang}"/>
                            </div>
                            <div class="panel-body">
                                <div id="availability-calendar"></div>
                            </div>
                        </div>
                        <div class="well">
                            <div class="row">
                                <div class="col-lg-6">
                                    <strong><fmt:message key="property.price-per-day" bundle="${lang}"/> &nbsp;&nbsp;(<span class="glyphicon glyphicon-calendar"></span>)</strong>
                                </div>
                                <div class="col-lg-6 text-right">
                                    <er:calculate-vat value="${property.pricePerDay}" var="priceWithVat"/>
                                    <strong><span class="h2"><t:show-price amount="${priceWithVat}"/></span></strong>
                                </div>
                            </div>
                        </div>
                        <div class="text-right">
                            <small><fmt:message key="property.includes-vat" bundle="${lang}"/></small>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-sm-6">
                                <span class="glyphicon glyphicon-map-marker"></span> <c:out value="${property.location}"/>
                            </div>
                            <div class="col-sm-6">
                                <strong><fmt:message key="general.max" bundle="${lang}"/></strong> <span class="glyphicon glyphicon-user"></span> <span class="badge">${property.capacity}</span>
                            </div>
                        </div>
                        <br>
                        <c:choose>
                            <c:when test="${empty property.photos}">
                                <img class="img-responsive" src="${pageContext.request.contextPath}/img/neighborhood1.jpg" width="720" height="480">
                            </c:when>
                            <c:otherwise>
                                <img class="img-responsive" src="${pageContext.request.contextPath}/uploads/property-pics/${property.photos.toArray()[0].filename}" width="720" height="480">
                            </c:otherwise>
                        </c:choose>
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <fmt:message key="property.description" bundle="${lang}"/>
                            </div>
                            <div class="panel-body">
                                <c:out value="${property.description}"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <er:time-config type="datepicker" var="datepickerFormat"/>
        <er:time-config type="moment" var="momentFormat"/>
        <er:availabilities-to-json periods="${property.availabilityPeriods}" var="jsonPeriods"/>
        <script>
            (function () {
                var availabilityPeriods = JSON.parse('${jsonPeriods}');

                $('#datepicker-container').find('.input-daterange').datepicker({
                    format: '${datepickerFormat}',
                    beforeShowDay: function (date) {
                        return beforeShowDay(date, "")
                    }
                });

                $('#availability-calendar').datepicker({
                    format: '${datepickerFormat}',
                    beforeShowDay: function (date) {
                        return beforeShowDay(date, "active disabled");
                    }
                });

                function beforeShowDay(date, classes) {
                    var momentDate = moment(date);
                    var options = {
                        enabled: false,
                        classes: ""
                    };
                    if (momentDate.isBefore(moment())) {
                        return options;
                    }
                    availabilityPeriods.forEach(function (period) {
                        var startDate = moment(period.startDate).subtract(12, 'h');
                        if (period.endless) {
                            if (momentDate.isAfter(startDate) || momentDate.isSame(startDate, 'day')) {
                                options.enabled = true;
                                options.classes = classes;
                                return;
                            }
                        } else {
                            var endDate = moment(period.endDate);
                            var range = moment().range(startDate, endDate);
                            if (range.contains(momentDate)) {
                                options.enabled = true;
                                options.classes = classes;
                                return;
                            }
                        }
                    });
                    return options;
                }
            })();
        </script>
    </jsp:body>
</t:paginabasica>