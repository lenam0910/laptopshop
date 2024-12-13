package vn.quocdk.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import vn.quocdk.laptopshop.domain.Order;
import vn.quocdk.laptopshop.domain.OrderDetail;
import vn.quocdk.laptopshop.service.OrderService;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("admin/order")
    public String getDashboard(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("admin/order/update/{id}")
    public String getUpdateOrderPage(@PathVariable long id, Model model) {
        long orderId = id;
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "admin/order/update";
    }

    @PostMapping("admin/order/update")
    public String postUpdateOrder(@ModelAttribute("order") Order order) {
        orderService.handleUpdateOrder(order);
        return "redirect:/admin/order";
    }

    @GetMapping("admin/order/delete/{id}")
    public String getDeleteOrderPage(@PathVariable long id, Model model) {
        Order order = new Order();
        order.setId(id);
        model.addAttribute("order", order);
        return "admin/order/delete";
    }

    @PostMapping("admin/order/delete")
    public String postDeleteOrder(@ModelAttribute("order") Order order) {
        long orderId = order.getId();
        Order currentOrder = orderService.getOrderById(orderId);
        orderService.handleDeleteOrder(currentOrder);
        return "admin/order/show";
    }

    @GetMapping("admin/order/info/{id}")
    public String getOrderInfoPage(Model model, @PathVariable long id) {
        long orderId = id;
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "admin/order/orderInfo";
    }

    @GetMapping("admin/order/detail/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        long orderId = id;
        Order order = orderService.getOrderById(orderId);
        List<OrderDetail> orderDetails = order.getOrderDetails();
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("id", orderId);
        return "admin/order/orderDetail";
    }

}
