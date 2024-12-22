package vn.quocdk.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import vn.quocdk.laptopshop.domain.Order;
import vn.quocdk.laptopshop.domain.User;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Page<Order> findAll(Pageable pageable);

    List<Order> findByUser(User user);

    @Modifying
    @Transactional
    @Query("UPDATE Order o SET o.status = ?1 WHERE o.id = ?2")
    void updateOrderStatus(String status, Long id);
}
