package kr.co.ubcn.multivm.controller;

import kr.co.ubcn.multivm.mapper.SalesMapper;
import kr.co.ubcn.multivm.mapper.SalesProductMapper;
import kr.co.ubcn.multivm.model.Sales;
import kr.co.ubcn.multivm.model.SalesProduct;
import kr.co.ubcn.multivm.model.User;
import kr.co.ubcn.multivm.model.VendingMachine;
import kr.co.ubcn.multivm.service.SalesService;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/sales")
public class SalesController {
    @Autowired
    SalesService salesService;
    @Autowired
    SalesMapper salesMapper;
    @Autowired
    SalesProductMapper salesProductMapper;
    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @GetMapping("/transaction")

    public ModelAndView salesTransac(ModelAndView mav, HttpServletRequest request){
        //return new ModelAndView("sales/transaction");
        return salesService.setSalesPage(mav, request, "transaction");
    }
    @GetMapping("/salesReport")
    public ModelAndView salesDailySales(ModelAndView mav, HttpServletRequest request){
        //return new ModelAndView("sales/salesReport");
        return salesService.setSalesPage(mav, request, "salesReport");
    }

    @PostMapping("/ajax/getSearchSalesList.do")
    public List<Sales> ajaxGetSearchSalesList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        param.put("auth",loginUser.getAuth());
        param.put("userSeq",loginUser.getSeq());
        return salesMapper.getSalesList(param);
    }
    @PostMapping("/ajax/getDetailSalesInfo.do")
    public List<SalesProduct> ajaxGetDetailSalesInfo(SalesProduct salesProduct){

        //System.out.println("getDetailSalesInfo 컨트롤러 : "+salesProduct.getTransactionNo());
        //System.out.println("getDetailSalesInfo 컨트롤러222 : "+salesProductMapper.getSalesDetail(salesProduct));
        return salesProductMapper.getSalesDetail(salesProduct);
    }
    @PostMapping("/ajax/getSearchDailySalesList.do")
    public List<Sales> ajaxGetSearchDailySalesList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        param.put("auth",loginUser.getAuth());
        param.put("userSeq",loginUser.getSeq());
        System.out.println("getSearchDailySalesList param: "+param);
        if(param.get("searchType")!=null&&param.get("searchType").equals("toProduct")) {
            if (!param.get("productName").equals("")) {
                /*String[] arr = param.get("productName").toString().split("&");
                System.out.println("arr: " + Arrays.toString(arr));
                List<String> list = new ArrayList<>();
                for (int i = 0; i < arr.length; i++) {
                    list.add(arr[i]);
                }
                param.put("productNameList", list);*/
                param.put("productNameList", param.get("productName"));
            }
            return salesMapper.getDailySalesProductList(param);
        }
        else{
            return salesMapper.getDailySalesList(param);
        }

        //System.out.println("getSearchDailySalesList 컨트롤러 : "+sales);
        //System.out.println("getSearchDailySalesList 컨트롤러222 : "+salesMapper.getDailySalesList(sales));
    }

    @PostMapping("/ajax/getDeadlineSalesData.do")
    public Workbook ajaxGetDeadlineSalesData(Sales sales, HttpServletResponse response, @RequestParam Map<String, Object> param) throws IOException {
        List<SalesProduct> result = salesProductMapper.getDeadlineSalesData(sales);
        return salesService.downExcel_deadLineSalesData(sales, response, result);
    }
    @PostMapping("/ajax/getExcelSalesData.do")
    public Workbook ajaxGetDeadlineSalesProductData(HttpServletResponse response, @RequestParam Map<String, Object> param, HttpSession session) throws IOException {
        User loginUser = (User)session.getAttribute("loginUser");
        param.put("auth",loginUser.getAuth());
        param.put("userSeq",loginUser.getSeq());
        return salesService.downExcel_DailySalesData(response, param);
    }

}
