package vn.quocdk.laptopshop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import vn.quocdk.laptopshop.domain.Product;
import vn.quocdk.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.quocdk.laptopshop.repository.ProductRepository;
import vn.quocdk.laptopshop.service.specification.ProductSpecs;

import java.util.List;

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

    public Specification<Product> buildPriceSpecification(List<String> priceRangeList) {
        Specification<Product> combinedSpec = (root, query, criteriaBuilder) -> criteriaBuilder.disjunction();
        for (String p : priceRangeList) {
            double min = 0;
            double max = 0;
            // Set the appropriate min and max based on the price range string
            switch (p) {
                case "duoi-10-trieu":
                    min = 0;
                    max = 10000000;
                    break;
                case "10-toi-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-toi-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "20-toi-30-trieu":
                    min = 20000000;
                    max = 30000000;
                    break;
                case "tren-30-trieu":
                    min = 30000000;
                    max = Integer.MAX_VALUE;
                    break;
            }
            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.priceRange(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }
        return combinedSpec;
    }

    public Page<Product> getProductWithSpecification(Pageable pageable, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPurpose() == null
                && productCriteriaDTO.getPrice() == null) {
            return productRepository.findAll(pageable);
        }
        Specification<Product> combinedSpec = Specification.where(null);
        if (productCriteriaDTO.getFactory() != null && !productCriteriaDTO.getFactory().isEmpty()) {
            combinedSpec = combinedSpec.and(ProductSpecs.manufacturedBy(productCriteriaDTO.getFactory()));
        }
        if (productCriteriaDTO.getPurpose() != null && !productCriteriaDTO.getPurpose().isEmpty()) {
            combinedSpec = combinedSpec.and(ProductSpecs.byPurpose(productCriteriaDTO.getPurpose()));
        }
        if (productCriteriaDTO.getPrice() != null && !productCriteriaDTO.getPrice().isEmpty()) {
            combinedSpec = combinedSpec.and(buildPriceSpecification(productCriteriaDTO.getPrice()));
        }
        return productRepository.findAll(combinedSpec, pageable);
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
