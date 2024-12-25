<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title> Sản Phẩm - Laptopshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">
    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
          rel="stylesheet">
    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
          rel="stylesheet">
</head>

<body>
<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->
<jsp:include page="../layout/header.jsp"/>
<!-- Single Product Start -->
<div class="container-fluid py-5 mt-5">
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Danh Sách Sản Phẩm
                        </li>
                    </ol>
                </nav>
            </div>
            <div class="row g-4 fruite">
                <div class="col-12 col-md-4">
                    <div class="row g-4">
                        <form:form method="get" action="products" modelAttribute="criteria">
                            <div class="col-12" id="factoryFilter">
                                <div class="mb-2"><b>Hãng sản xuất</b></div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="factory"
                                                   value="Apple" id="factory-1"/>
                                    <label class="form-check-label" for="factory-1">Apple</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="factory"
                                                   value="Asus" id="factory-2"/>
                                    <label class="form-check-label" for="factory-2">Asus</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="factory"
                                                   value="Lenovo" id="factory-3"/>
                                    <label class="form-check-label" for="factory-3">Lenovo</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="factory"
                                                   value="Dell" id="factory-4"/>
                                    <label class="form-check-label" for="factory-4">Dell</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="factory"
                                                   value="LG" id="factory-5"/>
                                    <label class="form-check-label" for="factory-5">LG</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="factory"
                                                   value="Acer" id="factory-6"/>
                                    <label class="form-check-label" for="factory-6">Acer</label>
                                </div>
                            </div>
                            <div class="col-12" id="purposeFilter">
                                <div class="mb-2"><b>Mục đích sử dụng</b></div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="purpose"
                                                   value="Gaming" id="purpose-1"/>
                                    <label class="form-check-label" for="purpose-1">Gaming</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="purpose"
                                                   value="Văn phòng" id="purpose-2"/>
                                    <label class="form-check-label" for="purpose-2">Sinh viên - văn
                                        phòng</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="purpose"
                                                   value="Thiết kế đồ họa" id="purpose-3"/>
                                    <label class="form-check-label" for="purpose-3">Thiết kế đồ
                                        họa</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="purpose"
                                                   value="Mỏng nhẹ" id="purpose-4"/>
                                    <label class="form-check-label" for="purpose-4">Mỏng nhẹ</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="purpose"
                                                   value="Doanh nhân" id="purpose-5"/>
                                    <label class="form-check-label" for="purpose-5">Doanh
                                        nhân</label>
                                </div>
                            </div>
                            <div class="col-12" id="priceFilter">
                                <div class="mb-2"><b>Mức giá</b></div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="price"
                                                   value="duoi-10-trieu" id="price-2"/>
                                    <label class="form-check-label" for="price-2">Dưới 10
                                        triệu</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="price"
                                                   value="10-toi-15-trieu" id="price-3"/>
                                    <label class="form-check-label" for="price-3">Từ 10 - 15
                                        triệu</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="price"
                                                   value="15-toi-20-trieu" id="price-4"/>
                                    <label class="form-check-label" for="price-4">Từ 15 - 20
                                        triệu</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="price"
                                                   value="20-toi-30-trieu" id="price-4"/>
                                    <label class="form-check-label" for="price-4">Từ 20 - 30
                                        triệu</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:checkbox cssClass="form-check-input" path="price"
                                                   value="tren-30-trieu" id="price-5"/>
                                    <label class="form-check-label" for="price-5">Trên 30
                                        triệu</label>
                                </div>

                            </div>
                            <div class="col-12">
                                <div class="mb-2"><b>Sắp xếp</b></div>
                                <div class="form-check form-check-inline">
                                    <form:radiobutton cssClass="form-check-input" path="sort"
                                                      value="gia-tang-dan" id="sort-1"/>
                                    <label class="form-check-label" for="sort-1">Giá tăng
                                        dần</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:radiobutton cssClass="form-check-input" path="sort"
                                                      value="gia-giam-dan" id="sort-2"/>
                                    <label class="form-check-label" for="sort-2">Giá giảm
                                        dần</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:radiobutton cssClass="form-check-input" path="sort"
                                                      value="khong-sap-xep" id="sort-3"
                                                      checked="${criteria.sort == null ? 'checked' : ''}"/>
                                    <label class="form-check-label" for="sort-3">Không sắp
                                        xếp</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <button type="submit"
                                        class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4">
                                    Lọc Sản Phẩm
                                </button>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                        </form:form>
                    </div>
                </div>
                <div class="col-12 col-md-8 text-center">
                    <div class="row g-4">
                        <c:forEach var="p" items="${products}">
                            <div class="col-md-6 col-lg-4">
                                <div
                                        class="border border-primary rounded position-relative vesitable-item">
                                    <div class="vesitable-img">
                                        <img src="images/product/${p.image}"
                                             class="img-fluid w-100 rounded-top" alt="">
                                    </div>
                                    <div class="p-4 rounded-bottom">
                                        <h5><a href="/product/${p.id}">${p.name}</a></h5>
                                        <p>${p.shortDesc}</p>
                                        <div class="d-flex justify-content-center flex-lg-wrap">
                                            <p class="text-dark fs-5 fw-bold mb-0">
                                                <fmt:formatNumber type="number"
                                                                  value="${p.price}"/> đ
                                            </p>
                                            <button data-product-id="${p.id}"
                                                    class="btnAddToCartHomepage btn border border-secondary rounded-pill px-3 text-primary">
                                                <i class="fa fa-shopping-bag me-2 text-primary"></i>
                                                Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${totalPages == 0}">
                            <h3>Không tìm thấy sản phẩm nào</h3>
                        </c:if>
                        <c:if test="${totalPages != 0}">
                            <ul class="pagination d-flex justify-content-center mt-5">
                                <li
                                        class="${1 eq currentPage ? 'disabled page-item' : 'page-item'}">
                                    <a class="page-link"
                                       href="/products?page=${currentPage - 1}&${queryString}"
                                       aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                    <li class="page-item">
                                        <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                           href="/products?page=${loop.index + 1}&${queryString}">
                                                ${loop.index + 1}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li
                                        class="${totalPages eq currentPage ? 'disabled page-item' : 'page-item'}">
                                    <a class="page-link"
                                       href="/products?page=${currentPage + 1}&${queryString}"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Single Product End -->
<jsp:include page="../layout/footer.jsp"/>
<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>
<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<!-- Template Javascript -->
<script src="/client/js/main.js"></script>

</body>

</html>