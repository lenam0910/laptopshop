package vn.quocdk.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.quocdk.laptopshop.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;

    public DashboardController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        model.addAttribute("orderCount", userService.countOrders());
        model.addAttribute("userCount", userService.countUsers());
        model.addAttribute("productCount", userService.countProducts());
        return "admin/dashboard/show";
    }

}
