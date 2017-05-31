<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:message key="add-property.title" bundle="${lang}" var="title"/>
<fmt:message key="property.availability-dates" bundle="${lang}" var="subtitle"/>
<t:paginabasica title="${title}: subtitle">
    <jsp:body>
        <t:property-add-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute('addPropertyMap').step.ordinal()}" steps="${steps}" path="/property/add"/>

        <div class="panel panel-warning">
            <div class="panel-heading">
                ${subtitle}
            </div>
            <div class="panel-body">
                <c:if test="${not empty availabilityPeriods}">
                    <c:forEach var="availabilityPeriod" items="${availabilityPeriods}" varStatus="status">
                        <form style="margin: 3px;" class="form-inline" method="post" action="${pageContext.request.contextPath}/property/availability-period/update/${status.index}">
                            <div class="form-group datepicker-container">
                                <label><fmt:message key="property.availability-period" bundle="${lang}"/> #${status.index+1}</label>
                                <div class="input-daterange input-group" id="range-${status.index}">
                                    <input value="<spring:eval expression="availabilityPeriod.startDate"/>" name="startDate" class="input-sm form-control" required/>
                                    <span class="input-group-addon"><fmt:message key="general.to" bundle="${lang}"/></span>
                                    <input value="<spring:eval expression="availabilityPeriod.endDate"/>" name="endDate" class="input-sm form-control" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><fmt:message key="general.henceforth" bundle="${lang}"/></label>
                                <input type="checkbox" name="endless" ${availabilityPeriod.endless ? 'checked' : ''}/>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button>
                                <a href="${pageContext.request.contextPath}/property/availability-period/delete/${status.index}?type=session" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span></a>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="type" value="session">
                        </form>
                    </c:forEach>
                    <hr>
                </c:if>
                <form:form cssClass="form-inline" method="post" modelAttribute="availabilityForm" action="${pageContext.request.contextPath}/property/availability-period/0/add">
                    <div class="form-group datepicker-container">
                        <label><fmt:message key="property.availability-period" bundle="${lang}"/></label>
                        <div class="input-daterange input-group" id="new-range">
                            <form:input path="startDate" required="true" cssClass="input-sm form-control"/>
                            <span class="input-group-addon"><fmt:message key="general.to" bundle="${lang}"/></span>
                            <form:input path="endDate" required="true" cssClass="input-sm form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label><fmt:message key="general.henceforth" bundle="${lang}"/></label>
                        <input type="checkbox" name="endless"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-plus"></span> <fmt:message key="general.add" bundle="${lang}"/></button>
                    </div>
                    <input type="hidden" name="type" value="session">
                </form:form>
                <br>
                <form id="step-submit-form" method="post" class="form-horizontal" action="${pageContext.request.contextPath}/property/add/3">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="row">
                        <div class="col-sm-offset-1 col-sm-10">
                            <a class="btn btn-warning" href="${pageContext.request.contextPath}/property/add?step=2"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/></a>
                            <button type="submit" class="btn btn-warning"><fmt:message key="general.next" bundle="${lang}"/> <span class="glyphicon glyphicon-forward"></span> </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <%-- Availability period modal --%>
        <div class="modal fade" id="confirm-no-availability-modal" tabindex="-1" role="dialog" aria-labelledby="confirmNoAvailabilityLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="confirmNoAvailabilityLabel"><fmt:message key="add-property.confirm-no-availability" bundle="${lang}"/> </h4>
                    </div>
                    <div class="modal-body">
                        <fmt:message key="add-property.confirm-no-availability-msg" bundle="${lang}"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="general.cancel" bundle="${lang}"/> </button>
                        <button type="button" id="confirm-no-availability" class="btn btn-warning"><fmt:message key="general.continue-anyway" bundle="${lang}"/> </button>
                    </div>
                </div>
            </div>
        </div>

        <er:time-config type="datepicker" var="datepickerFormat"/>
        <script>
            (function () {
                <er:object-to-json object="${availabilityPeriods}" var="jsonPeriods"/>
                var availabilityPeriods = JSON.parse('${jsonPeriods}');

                $('.datepicker-container').find('.input-daterange').each(function (_, el) {
                    var $el = $(el);
                    var id = $el.attr("id");
                    var idParts = id.split('-');
                    id = idParts[idParts.length-1];

                    $el.datepicker({
                        format: '${datepickerFormat}',
                        beforeShowDay: function (date) {
                            var momentDate = moment(date);
                            if (momentDate.isBefore(moment())) {
                                return false;
                            }
                            var enabled = true;
                            availabilityPeriods.forEach(function (period, index) {
                                if (id === String(index)) {
                                    return;
                                }
                                var startDate = moment(period.startDate).subtract(12, 'h');
                                if (period.endless) {
                                    if (momentDate.isAfter(startDate) || momentDate.isSame(startDate, 'day')) {
                                        enabled = false;
                                        return;
                                    }
                                } else {
                                    var endDate = moment(period.endDate);
                                    var range = moment().range(startDate, endDate);
                                    if (range.contains(momentDate)) {
                                        enabled = false;
                                        return;
                                    }
                                }
                            });
                            return enabled;
                        }
                    });
                });

                var triggeredOnce = false;
                $('#confirm-no-availability').unbind('click').on('click', function () {
                    $('#step-submit-form').submit();
                });

                var noAvailabilities = ${fn:length(availabilityPeriods) eq 0 ? 'true' : 'false'};

                $('#step-submit-form').submit(function (e) {
                    if (noAvailabilities && !triggeredOnce) {
                        e.preventDefault();
                        triggeredOnce = true;
                        $('#confirm-no-availability-modal').modal('show');
                    }
                })
            })();
        </script>
    </jsp:body>
</t:paginabasica>