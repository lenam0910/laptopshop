package vn.quocdk.laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import vn.quocdk.laptopshop.domain.Product;
import vn.quocdk.laptopshop.domain.Product_;

public class ProductSpecs {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    public static Specification<Product> priceRange(double minPrice, double maxPrice) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(root.get(Product_.PRICE), minPrice, maxPrice);
    }

    public static Specification<Product> minimumPrice(double minPrice) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.greaterThanOrEqualTo(root.get(Product_.PRICE),
                minPrice);
    }

    public static Specification<Product> maximumPrice(double maxPrice) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.lessThanOrEqualTo(root.get(Product_.PRICE), maxPrice);
    }

    public static Specification<Product> manufacturedBy(List<String> factoryList) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factoryList);
    }

}
