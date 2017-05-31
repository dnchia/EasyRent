<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="er" uri="/WEB-INF/easy-rent.tld" %>

<tag:paginabasica title="EasyRent" resource="search">
    <jsp:body>
        <div class="row">
            <div class="col-lg-8 col-sm-12 left-search">
                <ol class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/index.html"><fmt:message key="index.home" bundle="${lang}"/></a></li>
                    <li class="active"><fmt:message key="general.search" bundle="${lang}"/></li>
                </ol>
                <div class="page-header">
                    <h1><fmt:message key="search.title" bundle="${lang}"/></h1>
                </div>
                <c:choose>
                    <c:when test="${empty properties}">
                        <div class="text-silver text-center">
                            <h3><fmt:message key="search.no-results" bundle="${lang}"/> '${param.q} <fmt:message key="general.from" bundle="${lang}"/> ${param.s} <fmt:message key="general.to" bundle="${lang}"/> ${param.e}'. <fmt:message key="search.less-keywords" bundle="${lang}"/> </h3>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="property" items="${properties}">
                            <div class="media">
                                <div class="media-left">
                                    <a href="${pageContext.request.contextPath}/property/show/${property.id}.html?q=${param.q}&s=${param.s}&e=${param.e}">
                                        <c:choose>
                                            <c:when test="${empty property.photos}">
                                                <img class="media-object" src="${pageContext.request.contextPath}/img/neighborhood1.jpg" width="128">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="media-object" src="${pageContext.request.contextPath}/uploads/property-pics/${property.photos.toArray()[0].filename}" width="128">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                                <div class="media-body">
                                    <a href="${pageContext.request.contextPath}/property/show/${property.id}.html?q=${param.q}&s=${param.s}&e=${param.e}"><h4 class="media-heading"><c:out value="${property.title}"/></h4></a>
                                    <div class="row">
                                        <div class="col-sm-8 col-md-7 col-lg-8">
                                            <p><c:out value="${property.description}"/></p>
                                        </div>
                                        <div class="col-md-5 col-lg-4 hidden-xs">
                                            <er:calculate-vat value="${property.pricePerDay}" var="priceWithVat"/>
                                            <div class="text-right">
                                                <strong><span class="h4"><t:show-price amount="${priceWithVat}"/></span></strong><br>
                                                <strong><span>(*)</span></strong>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-5 col-lg-4">
                                            <strong><span class="glyphicon glyphicon-map-marker"></span></strong> <c:out value="${property.location}"/>
                                        </div>
                                        <div class="col-lg-3">
                                            <strong><fmt:message key="property.capacity" bundle="${lang}"/></strong> <span class="glyphicon glyphicon-user"></span> <span class="badge">${property.capacity}</span>
                                        </div>
                                        <div class="col-lg-3">
                                            <strong><span class="hidden-lg"><fmt:message key="property.type" bundle="${lang}"/>:</span> ${property.type.label}</strong>
                                        </div>
                                        <div class="col-lg-3">
                                                ${property.floorSpace} <fmt:message key="property.floor-space" bundle="${lang}"/>
                                        </div>
                                    </div>
                                    <div style="padding: 10px" class="visible-xs">
                                        <er:calculate-vat value="${property.pricePerDay}" var="priceWithVat"/>
                                        <div class="text-right">
                                            <strong><span class="h4"><t:show-price amount="${priceWithVat}"/></span></strong><br>
                                            <span class="text-silver"><small><fmt:message key="property.price-per-day" bundle="${lang}"/></small></span><br>
                                            <span class="text-silver"><small><small><fmt:message key="property.includes-vat-s" bundle="${lang}"/></small></small></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <tag:paginator currentPage="${currentPage}" totalPages="${totalPages}" baseUri="search"/>
                <div class="index-box bg-concrete">
                    <div class="text-right hidden-xs">
                        <span class="text-white"><small>(*)</small></span><br>
                        <span class="text-white"><small><fmt:message key="property.price-per-day" bundle="${lang}"/></small></span><br>
                        <span class="text-white"><small><fmt:message key="property.includes-vat-s" bundle="${lang}"/></small></span>
                    </div>
                    <hr>
                    <p class="text-white text-center">
                        &copy;<er:year-tag/> - <fmt:message key="easyrent.project" bundle="${lang}"/> | <a href="${pageContext.request.contextPath}/about-us.html"><fmt:message key="about-us.title" bundle="${lang}"/></a> | <a href="${pageContext.request.contextPath}/contact-us.html"><fmt:message key="contact-us.title" bundle="${lang}"/></a>
                    </p>
                </div>
            </div>
            <div class="col-md-4 visible-lg visible-md right-search">
                <div style="height: 100%;" id="map"></div>
            </div>
        </div>
        <er:properties-map-data properties="${properties}" var="propertiesJson"/>
        <script>
            (function () {
                $(document).ready(function () {

                    var properties = JSON.parse('${propertiesJson}');

                    var map = new google.maps.Map(document.getElementById('map'), {
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    });

                    var bounds = new google.maps.LatLngBounds();
                    var infoWindow = new google.maps.InfoWindow();

                    properties.forEach(function (property) {
                        var marker = new google.maps.Marker({
                            position: new google.maps.LatLng(property.latitude, property.longitude),
                            map: map
                        });

                        bounds.extend(marker.position);

                        google.maps.event.addListener(marker, 'click', (function (marker, property) {
                            return function () {
                                var root = $('<div>');
                                var title = $('<a>').attr('href', '${pageContext.request.contextPath}/property/show/' + property.id + '.html?q=${param.q}&s=${param.s}&e=${param.e}').html($('<h4>').text(property.title));
                                var subtitle = $('<p>').text(property.address);
                                root.append(title, subtitle);
                                infoWindow.setContent(root.prop("outerHTML"));
                                infoWindow.open(map, marker);
                            }
                        })(marker, property));
                    });

                    map.fitBounds(bounds);
                });
            })();
        </script>
    </jsp:body>
</tag:paginabasica>

