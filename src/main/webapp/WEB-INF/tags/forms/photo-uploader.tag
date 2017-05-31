<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="photos" required="true" type="java.util.Set" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>
<%@ attribute name="propertyId" required="true" type="java.lang.String" %>

<div id="photo-list" class="row center-block">
    <c:forEach items="${photos}" var="photo" varStatus="status">
        <c:choose>
            <c:when test="${type eq 'session'}">
                <c:set value="${photo}" var="pictureUri"/>
            </c:when>
            <c:otherwise>
                <c:set value="${photo.filename}" var="pictureUri"/>
            </c:otherwise>
        </c:choose>
        <div id="${pictureUri}" class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="thumbnail">
                <img class="img-responsive" src="${pageContext.request.contextPath}/uploads/property-pics/${pictureUri}">
                <div class="caption text-right">
                    <p><button id="remove-${pictureUri}" class="btn btn-danger property-photo-remove">
                        <span class="glyphicon glyphicon-remove"></span> <fmt:message key="general.remove" bundle="${lang}"/>
                    </button></p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<br>

<form id="property-pictures" action="${pageContext.request.contextPath}/property/${propertyId}/upload-photos" class="dropzone">
    <div class="fallback">
        <input name="file" type="file" multiple />
    </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="type" value="${type}">
</form>
<br>
<fmt:message key="property.upload-photos" bundle="${lang}" var="uploadPlaceholder"/>
<fmt:message key="property.remove-picture" bundle="${lang}" var="removePicture"/>
<fmt:message key="property.cancel-upload" bundle="${lang}" var="cancelUpload"/>
<script>
    (function () {
        var postOptions = {
            type: '${type}'
        };
        postOptions['${_csrf.parameterName}'] = '${_csrf.token}';

        Dropzone.options.propertyPictures = {
            addRemoveLinks: true,
            dictDefaultMessage: '${uploadPlaceholder}',
            dictRemoveFile: '${removePicture}',
            dictCancelUpload: '${cancelUpload}',
            init: function () {
                var _this = this;
                _this.on('complete', function (file) {
                    if (file.xhr.status == 200){
                        var pictureId = file.xhr.response;
                        $('#photo-list').append(''+
                                '<div id="' + pictureId + '" class="col-lg-3 col-md-4 col-sm-6 col-xs-12">' +
                                '<div class="thumbnail">' +
                                '<img class="img-responsive" src="${pageContext.request.contextPath}/uploads/property-pics/' + pictureId + '">' +
                                '<div class="caption text-right">' +
                                '<p><button id="remove-' + pictureId + '" class="btn btn-danger property-photo-remove">' +
                                '<span class="glyphicon glyphicon-remove"></span> <fmt:message key="general.remove" bundle="${lang}"/>' +
                                '</button></p>' +
                                '</div>' +
                                '</div>' +
                                '</div>');
                        $('#remove-' + pictureId).on('click', removeHandler);
                        $(file.previewElement).find('.dz-remove').on('click', function () {

                            $.post('${pageContext.request.contextPath}/uploads/property-pics/' + file.xhr.response + '/remove', postOptions).done(function () {
                                $('#' + pictureId).remove();
                            });
                        });
                    }
                });
            }
        };

        function removeHandler(evt) {
            evt.stopPropagation();
            var resourceId = $(evt.currentTarget).attr('id').split('-')[1];
            $.post('${pageContext.request.contextPath}/uploads/property-pics/' + resourceId + '/remove', postOptions).done(function () {
                $('#' + resourceId).remove();
            });
        }

        $('.property-photo-remove').on('click', removeHandler);
    })();
</script>