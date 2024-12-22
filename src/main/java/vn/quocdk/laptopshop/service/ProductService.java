package vn.quocdk.laptopshop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import vn.quocdk.laptopshop.domain.Product;
import vn.quocdk.laptopshop.repository.ProductRepository;
import vn.quocdk.laptopshop.service.specification.ProductSpecs;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product handleSaveProduct(Product product) {
        return productRepository.save(product);
    }

    public Page<Product> getAllProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    public Page<Product> getProductWithPriceRange(Pageable pageable, Optional<String> priceRangeOptional) {
        String priceRange = priceRangeOptional.isPresent() ? priceRangeOptional.get() : "";
        switch (priceRange) {
            case "duoi-10-trieu":
                return productRepository.findAll(ProductSpecs.maximumPrice(10000000), pageable);
            case "10-den-15-trieu":
                return productRepository.findAll(ProductSpecs.priceRange(10000000, 15000000), pageable);
            case "15-den-20-trieu":
                return productRepository.findAll(ProductSpecs.priceRange(15000000, 20000000), pageable);
            case "20-den-30-trieu":
                return productRepository.findAll(ProductSpecs.priceRange(20000000, 30000000), pageable);
            case "tren-30-trieu":
                return productRepository.findAll(ProductSpecs.maximumPrice(30000000), pageable);
            default:
                return productRepository.findAll(pageable);
        }
    }

    public Page<Product> getProductWithBrandList(Pageable pageable, Optional<String> factories) {
        if (factories.isPresent()) {
            List<String> factoryList = List.of(factories.get().split(","));
            return productRepository.findAll(ProductSpecs.manufacturedBy(factoryList), pageable);
        } else {
            return productRepository.findAll(pageable);
        }
    }

    public void deleteProductById(long id) {
        productRepository.deleteById(id);
    }

    public Product getProductById(long id) {
        return productRepository.findById(id);
    }

    public List<Product> getTop4OfficeLaptop() {
        return productRepository.findTop4ByPurpose("Văn phòng");
    }

    public List<Product> getTop4GamingLaptop() {
        return productRepository.findTop4ByPurpose("Gaming");
    }

    public List<Product> getTop4ThinLaptop() {
        return productRepository.findTop4ByPurpose("Mỏng nhẹ");
    }

    public List<Product> getTop4BusinessLaptop() {
        return productRepository.findTop4ByPurpose("Doanh nhân");
    }
}
