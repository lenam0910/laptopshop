package vn.quocdk.laptopshop.service;

import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import vn.quocdk.laptopshop.domain.*;
import vn.quocdk.laptopshop.repository.CartDetailRepository;
import vn.quocdk.laptopshop.repository.CartRepository;
import vn.quocdk.laptopshop.repository.OrderDetailRepository;
import vn.quocdk.laptopshop.repository.OrderRepository;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository,
                        CartRepository cartRepository, CartDetailRepository cartDetailRepository) {
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
    }

    public void handleUpdateOrder(Order order) {
        this.orderRepository.updateOrderStatus(order.getStatus(), order.getId());
    }

    public Order getOrderById(long id) {
        Optional<Order> order = orderRepository.findById(id);
        if (order.isPresent()) {
            return order.get();
        }
        return null;
    }

    public void handlePlaceOrder(User user, HttpSession session, String receiverAddress, String receiverName,
                                 String receiverPhone) {
        // Create order
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setStatus("PENDING");
        orderRepository.save(order);

        // Create order detail
        // Step 1: get cart by user, calculate total price

        Cart cart = cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            double totalPrice = 0;
            for (CartDetail cartDetail : cartDetails) {
                // Create a new order detail
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrder(order);
                orderDetail.setProduct(cartDetail.getProduct());
                orderDetail.setPrice(cartDetail.getPrice());
                orderDetail.setQuantity(cartDetail.getQuantity());

                // calculate total price
                totalPrice += (orderDetail.getPrice() * orderDetail.getQuantity());

                // delete current cart detail
                cartDetailRepository.delete(cartDetail);
                // Save current order detail
                orderDetailRepository.save(orderDetail);
            }

            cartRepository.delete(cart);
            order.setTotalPrice(totalPrice);
            orderRepository.save(order);
            // Step 3: Update session
            session.setAttribute("cartSum", 0);
        }
    }

    public Page<Order> getAllOrders(Pageable pageable) {
        return orderRepository.findAll(pageable);
    }

    public void handleDeleteOrder(Order order) {
        List<OrderDetail> orderDetails = order.getOrderDetails();
        orderDetails.forEach(orderDetail -> {
            orderDetailRepository.delete(orderDetail);
        });
        orderRepository.delete(order);
    }

    public List<Order> getOrderListByUser(User user) {
        return orderRepository.findByUser(user);
    }
}
