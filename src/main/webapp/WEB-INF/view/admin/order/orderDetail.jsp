<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content="Dự án laptopshop"/>
    <meta name="author" content=""/>
    <title>Detail product</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
            crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lí sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="/admin/order">Quản lí đơn hàng</a>
                    </li>
                    <li class="breadcrumb-item active"><a href="/admin/order/info/${id}">Thông tin
                        đơn
                        nhận</a>
                    </li>
                    <li class="breadcrumb-item active">Thông tin chi tiết</li>
                </ol>
                <div class="container mt-3">
                    <table class=" table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Tổng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach varStatus="loop" var="od" items="${orderDetails}">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${od.product.name}</td>
                                <td>
                                    <fmt:formatNumber type="number" value="${od.price}"/>
                                </td>
                                <td>${od.quantity}</td>
                                <td>
                                    <fmt:formatNumber type="number"
                                                      value="${od.quantity * od.price}"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <a href="/admin/order/info/${id}" class="btn btn-primary mt-1">Quay lại</a>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>

</html>