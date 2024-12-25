package vn.quocdk.laptopshop.controller.client;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.quocdk.laptopshop.domain.*;
import vn.quocdk.laptopshop.service.CartService;
import vn.quocdk.laptopshop.service.OrderService;
import vn.quocdk.laptopshop.service.ProductService;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ItemController {

    private final ProductService productService;
    private final CartService cartService;
    private final OrderService orderService;

    public ItemController(ProductService productService, CartService cartService, OrderService orderService) {
        this.productService = productService;
        this.cartService = cartService;
        this.orderService = orderService;
    }

    @GetMapping("product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    // @PostMapping("add-product-to-cart/{id}")
    // public String addProductToCart(@PathVariable long id, HttpServletRequest
    // request) {
    // HttpSession session = request.getSession(false);
    // String email = (String) session.getAttribute("email");
    // cartService.handleAddProductToCart(email, id, session, 1);
    // return "redirect:/";
    // }

    @GetMapping("cart-detail")
    public String getCartDetailPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User user = new User();
        user.setId(id);
        List<CartDetail> cartDetails = cartService.getCartDetailByUser(user);
        Cart cart = cartService.getCartByUser(user);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("cart", cart);
        model.addAttribute("totalPrice", cartService.calculateTotalPrice(cartDetails));
        return "client/cart/cartDetail";
    }

    @PostMapping("delete-cart-item/{id}")
    public String deleteCartItem(@PathVariable long id, HttpServletRequest request) {
        long cartDetailId = id;
        HttpSession session = request.getSession(false);
        cartService.handleDeleteCartItem(cartDetailId, session);
        return "redirect:/cart-detail";
    }

    @PostMapping("confirm-checkout")
    public String getCheckoutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart.getCartDetails();
        if (cartDetails == null) {
            cartDetails = new ArrayList<>();
        }
        cartService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @GetMapping("checkout")
    public String handleCheckout(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        Cart cart = cartService.getCartByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/checkout";
    }

    @PostMapping("place-order")
    public String handlePlaceOrder(HttpServletRequest request, @RequestParam("receiverName") String receiverName,
                                   @RequestParam("receiverAddress") String receiverAddress,
                                   @RequestParam("receiverPhone") String receiverPhone) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        orderService.handlePlaceOrder(currentUser, session, receiverAddress, receiverName, receiverPhone);
        return "redirect:/thankyou";
    }

    // @GetMapping("add-to-cart-with-quantity/{id}")
    // public String postMethodName(@PathVariable long id,
    // @RequestParam(name = "quantity") int quantity, HttpServletRequest request) {
    // HttpSession session = request.getSession();
    // long productId = id;
    // String email = (String) session.getAttribute("email");
    // cartService.handleAddProductToCart(email, productId, session, quantity);
    // return "redirect:/product/" + productId;
    // }

    @GetMapping("order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long userId = (Long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setId(userId);
        List<Order> orders = orderService.getOrderListByUser(currentUser);
        model.addAttribute("orders", orders);
        return "client/cart/history";
    }

}
