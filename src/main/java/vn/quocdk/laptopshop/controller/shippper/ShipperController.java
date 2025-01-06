package vn.quocdk.laptopshop.controller.shippper;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@RequestMapping("/shipper")
public class ShipperController {
    @GetMapping("")
    public String getShipperHomepage() {
        return "shipper/show";
    }
    
}
