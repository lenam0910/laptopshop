package vn.quocdk.laptopshop.service;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;
import vn.quocdk.laptopshop.domain.Cart;
import vn.quocdk.laptopshop.domain.CartDetail;
import vn.quocdk.laptopshop.domain.Product;
import vn.quocdk.laptopshop.domain.User;
import vn.quocdk.laptopshop.repository.CartDetailRepository;
import vn.quocdk.laptopshop.repository.CartRepository;
import vn.quocdk.laptopshop.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CartService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public CartService(CartRepository cartRepository, CartDetailRepository cartDetailRepository,
                       UserService userService, ProductRepository productRepository) {
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.userService = userService;
        this.productRepository = productRepository;
    }

    public Cart getCartByUser(User user) {
        return cartRepository.findByUser(user);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, int quantity) {
        // check if user has had cart or not
        User user = userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = cartRepository.findByUser(user);
            if (cart == null) {
                // Create a new cart
                cart = new Cart();
                cart.setUser(user);
                cart.setSum(0);
                cartRepository.save(cart);
            }
            // Save cart detail
            Product product = productRepository.findById(productId);
            // Check whether the product is in cart or not
            CartDetail existedCartDetail = cartDetailRepository.findByCartAndProduct(cart, product);
            if (existedCartDetail != null) {
                existedCartDetail.setQuantity(existedCartDetail.getQuantity() + quantity);
                cartDetailRepository.save(existedCartDetail);
                return;
            }

            CartDetail cartDetail = new CartDetail();
            cartDetail.setCart(cart);
            cartDetail.setProduct(product);
            cartDetail.setPrice(product.getPrice());
            cartDetail.setQuantity(quantity);
            cart.setSum(cart.getSum() + 1);
            session.setAttribute("cartSum", cart.getSum());
            cartRepository.save(cart);
            cartDetailRepository.save(cartDetail);
        }
    }

    public List<CartDetail> getCartDetailByUser(User user) {
        Cart cart = cartRepository.findByUser(user);
        if (cart == null) {
            return new ArrayList<CartDetail>();
        }
        return cart.getCartDetails();
    }

    public Long calculateTotalPrice(List<CartDetail> cartDetails) {
        long totalPrice = 0;
        for (CartDetail item : cartDetails) {
            totalPrice += item.getQuantity() * item.getPrice();
        }
        return totalPrice;
    }

    public void handleDeleteCartItem(Long cartDetailId, HttpSession session) {
        Optional<CartDetail> item = cartDetailRepository.findById(cartDetailId);
        if (item.isPresent()) {
            CartDetail cartDetail = item.get();
            cartDetailRepository.deleteById(cartDetail.getId());
            Cart cart = cartDetail.getCart();
            if (cart.getSum() == 1) {
                cartRepository.deleteById(cart.getId());
                session.setAttribute("cartSum", 0);
                return;
            }
            cart.setSum(cart.getSum() - 1);
            session.setAttribute("cartSum", cart.getSum());
            cartRepository.save(cart);
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        cartDetails.forEach((cartDetail) -> {
            Optional<CartDetail> cdOptional = cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        });
    }

}
