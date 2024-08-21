package kr.co.ubcn.multivm.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import kr.co.ubcn.multivm.service.ProductService;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * @author 			S.C.Heo
 * @ModifyDate		2022. 01. 21
 * @param					: YYYYMMDD
 *
 * @description		상품내려받기 Controller
 * 					
 */
@RestController
@RequestMapping("/product")
public class ProductController {

	Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	ProductService productService ;
	@Autowired
	OrganizationMapper organizationMapper;
	@Autowired
	ProductMapper productMapper;
	@Autowired
	VendingMachineMapper vendingMachineMapper;
	@Autowired
	VendingMachineProductMapper vendingMachineProductMapper;
	@Autowired
	VendingMachineCurrProductMapper vendingMachineCurrProductMapper;

	@GetMapping("/list")
	public ModelAndView productList(//@SessionAttribute("loginUser") User login,
									HttpServletRequest request){
		return productService.setProductPage(new ModelAndView(), request,"list");
	}


	@GetMapping("/vending-machine")
	public ModelAndView productVM(HttpSession session, ModelAndView mav, HttpServletRequest request) {
		mav = productService.setProductPage(mav, request, "vm");
		return mav;
	}
	@GetMapping("/vm-slot")
	public ModelAndView productVMSlot(HttpSession session, ModelAndView mav, HttpServletRequest request) {
		mav = productService.setProductPage(mav, request, "vm-slot");
		return mav;
	}

	@GetMapping("/copy")
	public ModelAndView productCopy(HttpSession session, ModelAndView mav, HttpServletRequest request){
		mav = productService.setProductPage(mav, request, "copy");
		return mav;
	}
	@GetMapping("/download")
	public ModelAndView productDownload(HttpSession session, ModelAndView mav, HttpServletRequest request){
		return productService.setProductPage(mav, request, "download");
	}

	@PostMapping("/ajax/insertProduct.do")
	public String ajaxProductInsert(Product product
			, HttpSession session, MultipartHttpServletRequest imgUpload
	)throws Exception
	 {
		product.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
		//System.out.println("컨트롤러이상무"+product);
		return productService.modifyProductList(product,imgUpload);
	}

	@PostMapping("/ajax/updateProduct.do")
	public String ajaxProductUpdate(Product product
			,HttpSession session, MultipartHttpServletRequest imgUpload)throws Exception//, @RequestParam MultipartFile productFile)throws Exception
	{
		product.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
		//System.out.println("수정컨트롤러접근"+product);
		return productService.modifyProductList(product,imgUpload);
	}

	@PostMapping("/ajax/selectCompany.do")
	public List<Organization> ajaxselectCompany(HttpServletRequest request){
		//System.out.println("어떻게해 : "+request.getParameter("companySeq"));
		Integer companySeq = Integer.parseInt(request.getParameter("companySeq"));
		Map<String, Object> map = new HashMap<>();
		map.put("companySeq",companySeq);
		return organizationMapper.getOrganizationList(map);
	}

	@PostMapping("/ajax/selectProductList.do")
	public List<Product> ajaxSelectProductList(Product product){
		System.out.println("selectProductList : "+product);
		product.setOrderDate("1");
		return productMapper.getSearchProduct(product);
	}

	@GetMapping("/ajax/selectProduct.do")
	public Product ajaxSelectProduct(@RequestParam int productSeq){
		//System.out.println("selectProduct : "+productSeq);
		//Integer companySeq = Integer.parseInt(request.getParameter("companySeq"));
		System.out.println("selectProduct결과: "+productMapper.getSelectProduct(productSeq));
		return productMapper.getSelectProduct(productSeq);
	}

	@GetMapping("/ajax/deleteSelectedProduct.do")
	public String ajaxDeleteSelectedProduct(@RequestParam(value="deleteList[]") List<Integer> deleteList
											,HttpSession session){
		//System.out.println("deleteSelectedProduct 컨트롤러 : ");
		//System.out.println("deleteSelectedProduct : "+deleteList);
		return productService.deleteProductList(deleteList, session);
	}
	@GetMapping("/ajax/copySelectedProduct.do")
	public Map<String,Object> ajaxCopySelectedProduct(@RequestParam(value="copyList[]") List<Integer> copyList
											,HttpServletRequest request){
		//System.out.println("copySelectedProduct 컨트롤러 : "+ request.getParameter("companySeq")+"//"+request.getParameter("organizationSeq"));
		//System.out.println("copySelectedProduct : "+copyList);
		return productService.copyProductList(copyList, request);
	}
	// download
	@PostMapping("/ajax/getSelectorVMList.do")
	public Map<String,Object> ajaxGetSelectorVMList(HttpServletRequest request,Product product){
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");

		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		paramMap.put("masterProduct",productMapper.getSearchProduct(product));
		map.put("companySeq",product.getCompanySeq());
		map.put("organizationSeq",product.getOrganizationSeq());
		if(user.getAuth()==4){
			map.put("auth",4);
			map.put("userSeq",user.getSeq());
		}
		paramMap.put("vmList",vendingMachineMapper.getSearchVM2(map));
		//System.out.println("나와야지  "+paramMap);
		return paramMap;
	}
	@PostMapping("/ajax/sendSelectedProductCheck.do")
	public Map<String,Object> ajaxSendSelectedProductCheck(@RequestParam(value="sendList[]") List<String> sendList
														   ,@RequestParam(value="deleteDupList[]") List<String> deleteDupList
			,HttpServletRequest request){
		System.out.println("sendSelectedProductCheck 컨트롤러1(중복된 목록) : "+sendList);
		System.out.println("sendSelectedProductCheck 컨트롤러2(중복제거된 선택목록) : "+deleteDupList);
		return productService.sendProductListCheck(sendList, deleteDupList, request);
	}
	@PostMapping("/ajax/getSelectorVMProductList.do")
	public Map<String,Object> ajaxGetSelectorVMProductList(@RequestParam Map<String, Object> param){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("vmProductList",vendingMachineProductMapper.getVMProductList(param));
		paramMap.put("userVM",vendingMachineMapper.getUserVM(param));
		return paramMap;
	}
	@PostMapping("/ajax/saveProduct.do")
	public Map<String,Object> ajaxSaveProduct(@RequestBody List<RequestProduct> saveList,HttpServletRequest request){
		System.out.println("saveProduct.do : "+saveList);
		return productService.saveProductList(saveList, request);
	}
	@PostMapping("/ajax/selectVMProduct.do")
	public VendingMachineProduct ajaxSelectVMProduct(HttpServletRequest request){
		Map<String, Object> map = new HashMap<>();
		map.put("companySeq",request.getParameter("companySeq"));
		map.put("organizationSeq",request.getParameter("organizationSeq"));
		map.put("vmSeq",request.getParameter("vmSeq"));
		map.put("productCode",request.getParameter("productCode"));
		System.out.println("dddd: "+map);
		System.out.println("selectVMProduct 컨트롤러"+vendingMachineProductMapper.getVMProductInfo(map));
		return vendingMachineProductMapper.getVMProductInfo(map);
	}
	@PostMapping("/ajax/modifyVMProduct.do")
	public String ajaxModifyVMProduct(VendingMachineProduct vendingMachineProduct,HttpServletRequest request){
		//System.out.println("saveProduct 컨트롤러 : "+ request.getParameter("isClear")+"//");
		return productService.modifyVMproduct(vendingMachineProduct, request);
	}

	@PostMapping("/ajax/insertDBfromExcel.do")
	public Map<String,Object> ajaxInsertDBfromExcel(@RequestBody List<Product> productList
							,HttpServletRequest request){
		//System.out.println("insertDBfromExcel : "+productList);
		return productService.insertProductListFromExcel(productList,request);
	}

	/*@PostMapping("/ajax/updateDupProduct.do")
	public Map<String,Object> ajaxUpdateDupProduct(@RequestParam(value="dup_list[]") List<Integer> dupList
			,HttpServletRequest request){
		System.out.println("updateDupProduct 컨트롤러 : "+ request.getParameter("companySeq")+"//"+request.getParameter("organizationSeq"));
		System.out.println("updateDupProduct : "+dupList);
		return productService.copyProductDupList(dupList, request);
	}*/

	@PostMapping("/ajax/updateDupProduct.do")
	public String ajaxUpdateDupProduct(@RequestParam(value="copyList[]") List<Integer> copyList
			,HttpServletRequest request){
		//System.out.println("updateDupProduct 컨트롤러 : "+ request.getParameter("companySeq")+"//"+request.getParameter("organizationSeq"));
		//System.out.println("updateDupProduct : "+copyList);
		return productService.copyProductDupList(copyList,request);
	}

	@PostMapping("/ajax/getSelectorVMSlotInfoList.do")
	public Map<String,Object> ajaxGetSelectorVMSlotInfoList(@RequestParam Map<String, Object> param){
		Map<String, Object> paramMap = new HashMap<>();
		//Map<String, Object> map = new HashMap<>();
		List<VendingMachineCurrProduct> myVMProductList = vendingMachineCurrProductMapper.getVMCurrProductFloor0(Integer.parseInt(param.get("vmSeq").toString()));
		paramMap.put("myVMProductList",myVMProductList);
		paramMap.put("slotList",vendingMachineCurrProductMapper.getVMCurrProductList(param));
		paramMap.put("datetime",(myVMProductList.isEmpty())?null:myVMProductList.get(0).getModifyDate());
		paramMap.put("userVM",vendingMachineMapper.getUserVM(param));
		//System.out.println("나와야지  "+paramMap);
		return paramMap;
	}

	@PostMapping("/ajax/saveExcelProductInfoData.do")
	public Workbook ajaxSaveExcelProductInfoData(Product product, HttpServletResponse response, @RequestParam Map<String, Object> param) throws IOException {
		List<Product> result = productMapper.getSearchProduct(product);
		return productService.saveExcelProductInfoData(product, response, result);
	}







}
