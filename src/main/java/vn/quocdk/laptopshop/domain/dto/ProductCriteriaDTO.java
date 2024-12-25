package vn.quocdk.laptopshop.domain.dto;

import java.util.List;

public class ProductCriteriaDTO {
    private String page;
    private List<String> factory;
    private List<String> purpose;
    private List<String> price;
    private String sort;

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public List<String> getFactory() {
        return factory;
    }

    public void setFactory(List<String> factory) {
        this.factory = factory;
    }

    public List<String> getPurpose() {
        return purpose;
    }

    public void setPurpose(List<String> purpose) {
        this.purpose = purpose;
    }

    public List<String> getPrice() {
        return price;
    }

    public void setPrice(List<String> price) {
        this.price = price;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

}
