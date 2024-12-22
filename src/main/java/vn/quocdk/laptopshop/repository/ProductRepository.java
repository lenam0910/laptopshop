package vn.quocdk.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.quocdk.laptopshop.domain.Product;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    Product save(Product product);

    Product findById(long id);

    void deleteById(long id);

    List<Product> findTop4ByPurpose(String purpose);

    Page<Product> findAll(Pageable pageable);

    Page<Product> findAll(Specification<Product> specification, Pageable pageable);
}
