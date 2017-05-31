<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="navs" tagdir="/WEB-INF/tags/navs" %>
<%@ taglib prefix="f" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:message key="add-property.title" bundle="${lang}" var="title"/>
<fmt:message key="property.photos" bundle="${lang}" var="subtitle"/>
<tag:paginabasica title="${title}: subtitle">
    <jsp:body>
        <tag:property-add-breadcrumb subtitle="${subtitle}"/>
        <div class="page-header">
            <h1>${title} <small>${subtitle}</small></h1>
        </div>

        <navs:stepper step="${pageContext.session.getAttribute('addPropertyMap').step.ordinal()}" steps="${steps}" path="/property/add"/>

        <div class="panel panel-warning">
            <div class="panel-heading">
                    ${subtitle}
            </div>
            <div class="panel-body">
                <f:photo-uploader photos="${propertyPhotos}" type="session" propertyId="0"/>
                <form id="step-submit-form" method="post" class="form-horizontal" action="${pageContext.request.contextPath}/property/add/5">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="row">
                        <div class="col-sm-offset-1 col-sm-10">
                            <a class="btn btn-warning" href="${pageContext.request.contextPath}/property/add?step=4"><span class="glyphicon glyphicon-backward"></span> <fmt:message key="general.back" bundle="${lang}"/></a>
                            <button type="submit" class="btn btn-warning"><fmt:message key="general.next" bundle="${lang}"/> <span class="glyphicon glyphicon-forward"></span> </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <%-- Photos modal --%>
        <div class="modal fade" id="confirm-no-photos-modal" tabindex="-1" role="dialog" aria-labelledby="confirmNoPhotosLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="confirmNoPhotosLabel"><fmt:message key="add-property.confirm-no-photos" bundle="${lang}"/> </h4>
                    </div>
                    <div class="modal-body">
                        <fmt:message key="add-property.confirm-no-photos-msg" bundle="${lang}"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="general.cancel" bundle="${lang}"/> </button>
                        <button type="button" id="confirm-no-photos" class="btn btn-warning"><fmt:message key="general.continue-anyway" bundle="${lang}"/> </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            (function () {
                $('#confirm-no-photos').unbind('click').on('click', function () {
                    $('#step-submit-form').submit();
                });

                var triggeredOnce = false;

                $('#step-submit-form').submit(function (e) {
                    if (!triggeredOnce && $('#photo-list').html().trim() == '') {
                        e.preventDefault();
                        triggeredOnce = true;
                        $('#confirm-no-photos-modal').modal('show');
                    }
                });
            })();
        </script>
    </jsp:body>
</tag:paginabasica>