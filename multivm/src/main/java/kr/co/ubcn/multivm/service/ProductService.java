package kr.co.ubcn.multivm.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import java.text.SimpleDateFormat;
import java.util.*;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import kr.co.ubcn.multivm.util.SFTPUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * @author 			S.C.Heo
 * @ModifyDate		2022. 01. 24.
 * @description		멀티자판기 상품다운로드 Service Class
 */
@Slf4j
@Service
public class ProductService  {

	// 로그 남기기 위한 용도.
	Logger logger = LoggerFactory.getLogger(ProductService.class);
	
	@Autowired 
	ProductMapper productMapper;
	@Autowired
	CompanyMapper companyMapper;
	@Autowired
	OrganizationMapper organizationMapper;
	@Autowired
	VendingMachineMapper vendingMachineMapper;
	@Autowired
	VendingMachineProductMapper vendingMachineProductMapper;
	@Autowired
	VendingMachineCurrProductMapper vendingMachineCurrProductMapper;
	@Autowired
	ReleaseMapper releaseMapper;
	@Autowired
	StockMapper stockMapper;
	@Autowired
	StoreMapper storeMapper;
	@Autowired
	SFTPUtil sftpUtil;

	@Value("${server.img.default.path}")
	private String imgPath;

	@Value("${server.img.default.url}")
	private String imgUrl;

	@Transactional
	public ModelAndView setProductPage(ModelAndView mav, HttpServletRequest request, String page){
		// 0: 시스템관리자
		// 1: 소속관리자(2와동일)
		// 2: 조직관리자(등록수정삭제/복제권한O)
		// 3: 조직관리자(권한X)
		// 4: 자판기운영자(내려받은 정보수정)

		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		if(user==null) return new ModelAndView("redirect:login");

		SimpleDateFormat format = new SimpleDateFormat ( "yyyy. MM. dd.  HH:mm:ss");
		Calendar time = Calendar.getInstance();
		String datetime = format.format(time.getTime());
		Map<String, Object> map3 = new HashMap<>();

		if(user.getAuth()!=0){
			map3.put("companySeq",user.getCompanySeq());
		}
		if(user.getAuth()==3) {
			map3.put("organizationSeq", user.getOrganizationSeq());
		}
		if(user.getAuth()==4){
			map3.put("auth",4);
			map3.put("userSeq",user.getSeq());
		}

		List<Organization> orgList = organizationMapper.getOrganizationList(map3);
		mav.addObject("companyList",companyMapper.getAllCompanyList())
				.addObject("orgList",orgList);

		switch (page){
			case "list":
				if(user.getAuth()!=0 && user.getAuth()!=3){ //정렬 첫번째기준으로 조직의 상품리스트 불러오기 위함
					user.setOrganizationSeq(orgList.get(0).getSeq());
					user.setOrganizationName(orgList.get(0).getName());
				}
				List<Product> productList = productMapper.getUserProduct_v1(user);
				mav.addObject("productList",productList)
						.addObject("totCnt",productList.size())
						.addObject("datetime",datetime)
						.setViewName("product/list"); break;

			case "vm":
				List<VendingMachineProduct> myVMProductList = new ArrayList<>();
				if(user.getAuth()==4){
					map3.put("organizationSeq",orgList.get(0).getSeq());
				}
				List<VendingMachine> userVM2 = vendingMachineMapper.getSearchVM2(map3);//조직이름 순

				if(userVM2.size()>0){//하나있으면 무조건 하나 띄우게
					map3.put("vmSeq",userVM2.get(0).getSeq());
					myVMProductList = vendingMachineProductMapper.getVMProductList(map3);
				}

				mav.addObject("datetime",datetime)
						.addObject("myVMProductList", user.getAuth()!=0?myVMProductList:null)
						.addObject("totCnt",user.getAuth()!=0?myVMProductList.size():0)
						.addObject("vmList", userVM2) //문제X
						.addObject("vmModel", !userVM2.isEmpty()?userVM2.get(0).getVmModel():null) //문제X
						.addObject("vmListSize", userVM2.size())
						.addObject("selectOrgSeq", !userVM2.isEmpty()? userVM2.get(0).getOrganizationSeq():user.getOrganizationSeq())
						.setViewName("product/vending-machine"); break;

			case "copy": //상품마스터 복제
				int selectOrgSeq = 0;
				map3.put("organizationSeq",orgList.get(0).getSeq());
				if(user.getAuth()==3){
					map3.put("notIn",3);
				}

				List<Organization> defaultOrig = organizationMapper.getDefaultOrig2(map3); //조직전체 or 내조직제외전체
				List<Product> defaultOrigProductList = new ArrayList<>();
				if(!defaultOrig.isEmpty()){ //전체 조직이 있을때 (없을땐 null)
					Map<String, Object> map2 = new HashMap<>();
					if(orgList.get(0).getSeq() == defaultOrig.get(0).getSeq()&&defaultOrig.size()>1){
						map2.put("organizationSeq",defaultOrig.get(1).getSeq());
						map2.put("companySeq",defaultOrig.get(1).getCompanySeq());
						selectOrgSeq = defaultOrig.get(1).getSeq();
					}else{
						map2.put("organizationSeq",defaultOrig.get(0).getSeq());
						map2.put("companySeq",defaultOrig.get(0).getCompanySeq());
					}
					System.out.println("map2:"+map2);
					defaultOrigProductList = productMapper.getUserProduct(map2);
				}
				mav.addObject("defaultOrig",defaultOrig)
						.addObject("productList",productMapper.getUserProduct(map3))
						.addObject("selectOrgSeq", selectOrgSeq)
						.addObject("defaultOrigProductList",defaultOrigProductList)
						.setViewName("product/copy");
				break;

			case "download": //상품정보업데이트
				try {
					if(user.getAuth()==4){
						map3.put("organizationSeq",orgList.get(0).getSeq());
					}
					map3.put("orderDate","Y");
					List<VendingMachine> userVM = vendingMachineMapper.getSearchVM2(map3);
					List<VendingMachineProduct> myVMProductList2 = new ArrayList<>();
					if(!userVM.isEmpty()){
						map3.put("vmSeq",userVM.get(0).getSeq());
						System.out.println("map3:"+map3);
						myVMProductList2 = vendingMachineProductMapper.getVMProductList(map3);
					}
					System.out.println("myVMProductList2:"+myVMProductList2);
					mav.addObject("myVMProductList", myVMProductList2)
							.addObject("vmList", userVM)
							.addObject("masterProductList", productMapper.getUserProduct(map3))
							.setViewName("product/download");

				}
				catch (Exception e){
					System.out.println("error : " + e);
				}
				break;
			case "vm-slot":
				if(user.getAuth()==4){
					map3.put("organizationSeq",orgList.get(0).getSeq());
				}
				List<VendingMachine> userVM = vendingMachineMapper.getSearchVM2(map3);
				List<VendingMachineCurrProduct> myVMProductList2 = new ArrayList<>();
				if(!userVM.isEmpty()){
					myVMProductList2 = (user.getAuth()==0)?null:vendingMachineCurrProductMapper.getVMCurrProductFloor0(userVM.get(0).getSeq());
					if(user.getAuth()!=0){
						map3.put("vmSeq",userVM.get(0).getSeq());
					}
				}
				List<VendingMachineCurrProduct> slotList = (user.getAuth()==0||userVM.isEmpty())?null:vendingMachineCurrProductMapper.getVMCurrProductList(map3);

				mav.addObject("datetime",(user.getAuth()==0||myVMProductList2.isEmpty())?null:myVMProductList2.get(0).getModifyDate())
						.addObject("myVMProductList", myVMProductList2)
						.addObject("vmList", userVM) //문제X
						.addObject("slotList", slotList)
						.setViewName("product/vm-slot");

				break;
			default :
		}

		return mav;
	}

	public String deleteProductList(List<Integer> deleteList, HttpSession session){
		for(int list : deleteList) {
			try {

				//2022-03-31. 재고입고출고 삭제 취소
				//releaseMapper.deleteReleaseList(list);
				//stockMapper.deleteStockList(list);
				//storeMapper.deleteStoreList(list);

				//2022-03-31. 마스터상품 삭제시 상태값(visible : N) 변경
				Product dp = new Product();
				dp.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
				dp.setProductSeq(list);
				productMapper.deleteProduct_v2(dp);

			}
			catch (Exception e){
				System.out.println("error : "+e);
				return "에러발생";
			}
		}
		return "삭제되었습니다.";
	}

	public Map<String,Object> copyProductList(List<Integer> copyList, HttpServletRequest request){
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		map.put("companySeq", request.getParameter("companySeq"));
		map.put("organizationSeq", request.getParameter("organizationSeq"));
		map.put("productSeqArray",copyList);
		map.put("visible","Y");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		try {
			//List<String> dup = productMapper.isHasCodeProductName(map);
			//코드로 변경
			List<String> dup = productMapper.isHasCodeProductCode(map);
			if(!dup.isEmpty()){
				paramMap.put("message","중복된 상품이 있습니다. "+dup);
				paramMap.put("dupList",dup);
				return paramMap;
				//여기에서 사용자에게 덮어쓰기 하시겠습니까? 로
			}
			else{
				//Y중에서는 없음 > N에서 찾아서 update or insert
				map.put("visible","N");
				List<String> deleted_dup = productMapper.isHasCodeProductCode(map);
				for(int list : copyList) { //list는 productSeq
					//select -> update
					Product temp = productMapper.getSelectProduct(list);
					temp.setModifyUserSeq(user.getSeq());
					temp.setCompanySeq(Integer.parseInt(request.getParameter("companySeq")));
					temp.setOrganizationSeq(Integer.parseInt(request.getParameter("organizationSeq")));
					temp.setCreateUserSeq(user.getSeq());

					//System.out.println("상품정보복제)추가할 마스터상품: "+ list);
					if(!deleted_dup.isEmpty()){
						//System.out.println("deleted_dup 체크: "+deleted_dup); //코드 list
						if(deleted_dup.contains(temp.getProductCode())){
							//System.out.println("1. N에서 업데이트: "+temp );
							productMapper.deletedProduct_up_v2(temp);
						}
						else{
							//System.out.println("2. 없을때 추가");
							temp.setProductSeq(productMapper.getProductCode());
							productMapper.insertProduct(temp);
						}
					}
					else {
						//System.out.println("2. 없을때 추가: "+temp);
						temp.setProductSeq(productMapper.getProductCode());
						productMapper.insertProduct(temp);
					}
				}

				paramMap.put("message","상품이 복제되었습니다.");
			}

			//확인 후 복사해줄거임
		}
		catch (Exception e){
			System.out.println("error : "+e);
			paramMap.put("message","에러발생");
			return paramMap;
			}
		return paramMap;
	}

	public String copyProductDupList(List<Integer> copyList, HttpServletRequest request){
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		map.put("companySeq", request.getParameter("companySeq"));
		map.put("organizationSeq", request.getParameter("organizationSeq"));
		map.put("productSeqArray",copyList);

		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("loginUser");
		try {
			//System.out.println("ggggggggggggg "+map);
			map.put("visible","Y");
			List<String> dup = productMapper.isHasCodeProductCode(map);
			if(dup.isEmpty()) return "에러 발생";
			else {
				map.put("visible","N");
				List<String> deleted_dup = productMapper.isHasCodeProductCode(map);
				for (int list : copyList) {
					Product temp = productMapper.getSelectProduct(list);
					temp.setModifyUserSeq(user.getSeq());
					temp.setCompanySeq(Integer.parseInt(request.getParameter("companySeq")));
					temp.setOrganizationSeq(Integer.parseInt(request.getParameter("organizationSeq")));
					temp.setCreateUserSeq(user.getSeq());
					if (dup.contains(temp.getProductCode()) && request.getParameter("type") != null) {
						//System.out.println("11");
						productMapper.deletedProduct_up_v2(temp);
					} else if (dup.contains(temp.getProductCode()) && request.getParameter("type") == null) {
						//System.out.println("22");
						continue;
					} else {
						//System.out.println("33");
						if(!deleted_dup.isEmpty()){
							//System.out.println("deleted_dup 체크: "+deleted_dup); //코드 list
							if(deleted_dup.contains(temp.getProductCode())) {
								productMapper.deletedProduct_up_v2(temp);
							}
						}
						else {
							temp.setProductSeq(productMapper.getProductCode());
							productMapper.insertProduct(temp);
						}
					}
				}
			}

		}
		catch (Exception e){
			System.out.println("error : "+e);
			return "에러 발생";
		}
		return "상품이 복제되었습니다.";
	}

	@Transactional
	public String modifyProductList(Product product, MultipartHttpServletRequest file){
		Map<String, Object> map = new HashMap<>();
		String fileName = "";
		MultipartFile upload = file.getFile("productImage_up");
		try {
			if(product.getIsClear()!=null){
				//System.out.println("클리어 : "+product);
				productMapper.clearProduct(product);
				return "적용되었습니다.";
			}
			else { // 추가와 수정일 때
				map.put("productCode", product.getProductCode());
				if (!product.getProductCode().equals("") && productMapper.isHasCodeProduct(product) > 0) {
					return "중복된 상품코드가 존재합니다.";
				}
				if (upload != null) {
					String uploadFileName = upload.getOriginalFilename();
					if(upload.getOriginalFilename().length()>16){
						uploadFileName = uploadFileName.substring(uploadFileName.length()-16,uploadFileName.length());
					}
					//System.out.println("경로 "+session.getServletContext().getRealPath("/"));
					fileName = System.currentTimeMillis() + "_" + uploadFileName;
					log.info("modifyProductList -- fileName= {}",fileName);
					sftpUtil.init();
					//기존 이미지 삭제
					if(product.getProductSeq()!=0&&product.getProductImage_bf()!=null&&!product.getProductImage_bf().contains("/default.png")&&!product.getProductImage_bf().contains("기본이미지_")){
						log.info("modifyProductList -- delete file= {}",product.getProductImage_bf().replace(imgUrl, ""));
						sftpUtil.delete("", product.getProductImage_bf().replace(imgUrl, ""));

						// 이전
						//File img_bf = new File(imgPath+product.getProductImage_bf());
						//img_bf.delete();
					}

					product.setProductImage(imgUrl + fileName);
					//upload.transferTo(new File(imgPath + fileName));
					sftpUtil.upload("", upload, fileName);
					sftpUtil.disconnection();

				}
				if (product.getProductSeq() == 0) {
					product.setProductSeq(productMapper.getProductCode());
					productMapper.insertProduct(product);
				}
				else{
					//System.out.println("수정수정수정"+product);
					productMapper.modifyProduct(product);//수정일때
					//2022-06-16. 해당 마스터상품 수정시 자판기 상품 modifyDate 업데이트해주기
					vendingMachineProductMapper.updateVMProductModifyDate(product);

				}
			}
			
		}
		catch (Exception e){
			System.out.println("error : "+e);
			return "에러발생";
		}
		return "성공적으로 완료되었습니다.";
	}

	@Transactional
	public Map<String,Object> sendProductListCheck(List<String> sendList,List<String> deleteDupList, HttpServletRequest request){
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		String vmPrice = request.getParameter("vmPrice");
		map.put("companySeq",request.getParameter("companySeq"));
		map.put("organizationSeq",request.getParameter("organizationSeq"));
		map.put("vmSeq",request.getParameter("vmSeq"));
		map.put("vmPrice",vmPrice);
		map.put("productCodeArray",sendList);
		List<Product> res = new ArrayList<>();
		List<Product> res2 = new ArrayList<>();
		Map<String, Object> map2 = new HashMap<>();
		map2.putAll(map);

		System.out.println(map);

		try {
			map.put("check","Y");
			/*List<String> dup = vendingMachineProductMapper.isHasCodeVMProductCode(map);
			if(!dup.isEmpty()){*/
			if(sendList.indexOf("NO") == -1){
				System.out.println("============= 중복O =============");
				for(String list : sendList) {
					map.put("productCode",list);
					Product temp = productMapper.getMasterProduct(map);
					res.add(temp);
				}
				paramMap.put("message",sendList);
				paramMap.put("status","duplicate");
				paramMap.put("dup_productList",res);
				System.out.println(res);
			}
			else{
				System.out.println("============= 중복X =============");
				paramMap.put("status", "success");

			}
			if(deleteDupList.indexOf("NO") == -1) {
				for (String list : deleteDupList) {
					map2.put("productCode", list);
					Product temp = productMapper.getMasterProduct(map2);
					res2.add(temp);
				}
			}
			paramMap.put("productList",res2);

		}
		catch (Exception e){
			System.out.println("error : "+e);
			paramMap.put("message","에러발생");
			paramMap.put("status","error");
			return paramMap;
		}
		return paramMap;
	}

	@Transactional
	public Map<String,Object> saveProductList(List<RequestProduct> requestProducts, HttpServletRequest request){
		HttpSession session = request.getSession();
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map2 = new HashMap<>();
		map.put("companySeq",requestProducts.get(0).getCompanySeq());
		map.put("organizationSeq",requestProducts.get(0).getOrganizationSeq());
		map.put("vmSeq",requestProducts.get(0).getVmSeq());
		map.put("userSeq", (Integer)session.getAttribute("userSeq"));
		String deleteType = requestProducts.get(0).getDeleteType();
		map2.putAll(map);
		requestProducts.remove(0);
		List<String> saveList = new ArrayList<>();
		for(RequestProduct list : requestProducts){
			if(list.getId()==null){
				continue;
			}
			if(list.getId().contains("UBsave_")){
				saveList.add(list.getId().substring(7));
			}else{
				saveList.add(list.getId());
			}
		}
		/*if(!newList.isEmpty()){
			System.out.println("newList: "+newList);
			for(String list : newList){

				map2.put("productCode",list);
				map2.put("modifyUserSeq",(Integer) session.getAttribute("userSeq"));
				vendingMachineProductMapper.deleteVMProduct_v2_deleted(map2);
			}
		}*/
		try {
			if(deleteType.equals("1")){
				//visible N으로 만듬
				for(String list : saveList) {
					map.put("productCode2",list);
					vendingMachineProductMapper.deleteVMProduct_v1(map);
					//2022-03-31. 입고,출고,재고 데이터 삭제 취소
					//storeMapper.deleteStoreList_v1(map);
					//tockMapper.deleteStockList_v1(map);
					//releaseMapper.deleteReleaseList_v1(map);
					//System.out.println(map+"list : "+list);
				}
				paramMap.put("status","success");
				return paramMap;
			}
			// download save
			//savsList엔 없지만 vmp엔 있을때 -> delete된것임(update)
			List<String> vmpList = vendingMachineProductMapper.isHasCodeVMProductCode(map);
			if(!vmpList.isEmpty()){
				vmpList.removeAll(saveList);
				System.out.println("삭제 :: "+vmpList);
				for(String list : vmpList){
					map.put("productCode2",list);
					vendingMachineProductMapper.deleteVMProduct_v1(map);
					//2022-03-31. 입고,출고,재고 데이터 삭제 취소
					//storeMapper.deleteStoreList_v1(map);
					//stockMapper.deleteStockList_v1(map);
					//releaseMapper.deleteReleaseList_v1(map);
					//System.out.println(" 삭제된 map : "+map);
				}
			}

			System.out.println(requestProducts);
			for(RequestProduct list : requestProducts) {
				if(list.getId()==null){
					continue;
				}
				map.put("productCode",list.getId()!=null&&list.getId().contains("UBsave_")?list.getId().substring(7):list.getId());
				map.put("productPrice",list.getAmount());
				VendingMachineProduct vmp = vendingMachineProductMapper.isHasCodeVMProductCode_v1(map);
				if(vmp==null){ //없으면 추가
					VendingMachineProduct temp = vendingMachineProductMapper.getVMProduct(map);
					temp.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
					System.out.println("추가 :: "+temp);
					vendingMachineProductMapper.insertVMProduct(temp);

					// 2022-03-04.재고테이블에도 추가 (삭제하는건 보류->기록을 남겨둬야할 것 같음, 입고출고 등에도 영향이 감)
					//map.put("createUserSeq",(Integer) session.getAttribute("userSeq"));
					//stockMapper.insertStock(map);
					// ---------------------
				}
				else if(!vmp.getProductPrice().equals(list.getAmount())){
					vmp.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
					vmp.setProductPrice(list.getAmount());
					System.out.println("금액변경 :: "+vmp);
					vendingMachineProductMapper.modifyVMProduct(vmp);
				}
				else if(vmp.getVisible().equals("N")){//삭제된 상품 -> visible Update
					map.put("modifyUserSeq",(Integer) session.getAttribute("userSeq"));
					map.put("visible",1);
					System.out.println("삭제후추가 :: "+vmp);
					vendingMachineProductMapper.deleteVMProduct_v2_deleted(map);

					//map.put("createUserSeq",(Integer) session.getAttribute("userSeq"));
					//stockMapper.insertStock(map);
				}
			}

			//System.out.println(" :: "+paramMap);
			paramMap.put("status","success");

		}
		catch (Exception e){
			e.printStackTrace();
			paramMap.put("message","에러발생");
			paramMap.put("status","error");
			return paramMap;
		}

		return paramMap;
	}

	public String modifyVMproduct(VendingMachineProduct vendingMachineProduct,HttpServletRequest request){
		HttpSession session = request.getSession();
		if(request.getParameter("isClear").equals("1")){
			vendingMachineProduct.setProductCount(0);
		}
		vendingMachineProduct.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
		try{
			vendingMachineProductMapper.modifyVMProduct(vendingMachineProduct);
			//2022-03-24. 수정시, 자판기 테이블 modifyDate 업데이트
			//vendingMachineMapper.updateVMModifyDate(vendingMachineProduct.getVmSeq());

		}catch (Exception e){
			System.out.println("error"+e);
			return "에러발생";
		}

		return "성공적으로 적용되었습니다.";

	}

	@Transactional
	public Map<String,Object> insertProductListFromExcel(List<Product> productList,HttpServletRequest request){
		HttpSession session = request.getSession();
		Map<String,Object> resultMap = new HashMap<>();

		int companySeq = productList.get(productList.size()-1).getCompanySeq();
		int organizationSeq = productList.get(productList.size()-1).getOrganizationSeq();
		int i =0;
		try {
			System.out.println("엑셀 온: "+productList.size());
			System.out.println("엑셀 온2: "+productList);
			System.out.println("엑셀 온3: "+productList.get(0).getIsGlass());


			for (Product list : productList) {

				if(list.getProductName().equals("ubcn11111")) break;
				//전체 삭제후에 리스트 전부 insert? 아니면 추가
				//추가면 productCode 중복인지 체크<<이걸로
				list.setCompanySeq(companySeq);
				list.setOrganizationSeq(organizationSeq);
				list.setCreateUserSeq((Integer) session.getAttribute("userSeq"));

				if(list.getProductCode()==null){
					list.setProductCode("");
					/*resultMap.put("status","fail");
					resultMap.put("message","상품코드를 모두 입력해주세요.");
					return resultMap;*/
				}
				if (productMapper.isHasCodeProduct(list) > 0) {
					resultMap.put("status","fail");
					resultMap.put("message","중복된 상품코드가 있어 실패하였습니다.");
					return resultMap;
				}
				if(list.getProductName()==null){
					continue;
					/*resultMap.put("status","fail");
					resultMap.put("message","상품명을 모두 입력해주세요.");
					return resultMap;*/
				}
				if(list.getProductName().length()>20){
					resultMap.put("status","fail");
					resultMap.put("message","상품명의 길이는 최대 20자입니다.");
					return resultMap;
				}
				if(list.getIsGlass()==null){
					list.setIsGlass("F");
				}
				if(!list.getIsGlass().equals("Y")&&!list.getIsGlass().equals("N")){
					resultMap.put("status","fail");
					resultMap.put("message","파손여부 값은 'Y', 'N' 값 중 입력해주세요.");
					return resultMap;
				}
				if(list.getIsGlass().equals("Y")){ list.setIsGlass("T"); }else list.setIsGlass("F");
				/*if(!list.getProductCode().matches("^[a-zA-Z0-9]*$")){
					resultMap.put("status","fail");
					resultMap.put("message","상품코드에 한글 또는 특수문자는 포함될 수 없습니다.");
					return resultMap;
				}*/
				if(list.getImgCode()!=null && !list.getImgCode().matches("^[0-9]{0,4}")){
					resultMap.put("status","fail");
					resultMap.put("message","상품이미지 파일명은 '숫자' '4자릿수' 이내로 지정해주세요.");
					return resultMap;
				}
				if(list.getProductName().equals("ubcn11111")){ break;
				} else {
					list.setProductSeq(productMapper.getProductCode());
					System.out.println("저장전 LIst "+list);
					i +=productMapper.insertProduct(list);
				}
			}
		}catch (Exception e){
			logger.info("엑셀 상품업로드 error : {} ", e);
			resultMap.put("status","fail");
			resultMap.put("message","에러발생");
			return resultMap;
		}
		resultMap.put("status","success");
		resultMap.put("message","성공적으로 추가되었습니다. ("+i+")");
		return resultMap;

	}

	public List<Product> getProductImageList(Product product){
		return productMapper.getProductImageList(product);
	}

	public Workbook saveExcelProductInfoData(Product product, HttpServletResponse response, List<Product> result) throws IOException {
		//List<SalesProduct> result = salesProductMapper.getDeadlineSalesData(sales);
		//System.out.println("sa;es일단 학이: "+sales);
		DecimalFormat decFormat = new DecimalFormat("###,###");
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("상품마스터정보");
		Row row = null;
		Cell cell = null;
		int rowNum = 1;
		int count = 1;

		sheet.setColumnWidth(0,1500); //No
		sheet.setColumnWidth(1,20000); //상품명
		sheet.setColumnWidth(2,2500); //상품금액
		sheet.setColumnWidth(3,3000); //상품설명
		sheet.setColumnWidth(4,2500); //적재수량
		sheet.setColumnWidth(5,3500); //파손여부(Y/N)
		sheet.setColumnWidth(6,3500); //상품코드
		sheet.setColumnWidth(7,5000);//상품이미지코드

		Font headerFont = wb.createFont();
		headerFont.setBold(true);

		CellStyle headStyle = wb.createCellStyle();
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		headStyle.setFont(headerFont);

		CellStyle numberStyle = wb.createCellStyle();
		numberStyle.setBorderBottom(BorderStyle.THIN);
		numberStyle.setBorderLeft(BorderStyle.THIN);
		numberStyle.setBorderRight(BorderStyle.THIN);
		numberStyle.setBorderTop(BorderStyle.THIN);
		numberStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));

		CellStyle centerStyle = wb.createCellStyle();
		centerStyle.setBorderBottom(BorderStyle.THIN);
		centerStyle.setBorderLeft(BorderStyle.THIN);
		centerStyle.setBorderRight(BorderStyle.THIN);
		centerStyle.setBorderTop(BorderStyle.THIN);
		centerStyle.setAlignment(HorizontalAlignment.CENTER);

		CellStyle defaultStyle = wb.createCellStyle();
		defaultStyle.setBorderBottom(BorderStyle.THIN);
		defaultStyle.setBorderLeft(BorderStyle.THIN);
		defaultStyle.setBorderRight(BorderStyle.THIN);
		defaultStyle.setBorderTop(BorderStyle.THIN);


		// Header
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue("No.");
		cell.setCellStyle(headStyle);
		cell = row.createCell(1);
		cell.setCellValue("상품명");
		cell.setCellStyle(headStyle);
		cell = row.createCell(2);
		cell.setCellValue("상품금액");
		cell.setCellStyle(headStyle);
		cell = row.createCell(3);
		cell.setCellValue("상품설명");
		cell.setCellStyle(headStyle);
		cell = row.createCell(4);
		cell.setCellValue("적재수량");
		cell.setCellStyle(headStyle);
		cell = row.createCell(5);
		cell.setCellValue("파손여부(Y/N)");
		cell.setCellStyle(headStyle);
		cell = row.createCell(6);
		cell.setCellValue("상품코드");
		cell.setCellStyle(headStyle);
		cell = row.createCell(7);
		cell.setCellValue("상품이미지 파일명");
		cell.setCellStyle(headStyle);

		// Body
		if(!result.isEmpty()) {
			for (Product sp : result) {
				row = sheet.createRow(rowNum++);
				cell = row.createCell(0);
				cell.setCellStyle(centerStyle);
				cell.setCellValue(count++);
				cell = row.createCell(1);
				cell.setCellStyle(defaultStyle);
				cell.setCellValue(sp.getProductName());
				cell = row.createCell(2);
				cell.setCellStyle(numberStyle);
				cell.setCellValue(sp.getProductPrice());
				cell = row.createCell(3);
				cell.setCellStyle(defaultStyle);
				cell.setCellValue(sp.getProductDetail());
				cell = row.createCell(4);
				cell.setCellStyle(numberStyle);
				cell.setCellValue(sp.getProductCount());
				cell = row.createCell(5);
				cell.setCellStyle(centerStyle);
				if(sp.getIsGlass().equals("T")){
					cell.setCellValue("Y");
				}else  cell.setCellValue("N");

				cell = row.createCell(6);
				cell.setCellStyle(centerStyle);
				cell.setCellValue(sp.getProductCode());
				cell = row.createCell(7);
				cell.setCellStyle(centerStyle);
				cell.setCellValue(sp.getImgCode());
			}
		}

		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("멀티자판기")+".xlsx");

		// Excel File Output
		ServletOutputStream outputStream = response.getOutputStream();
		wb.write(outputStream);
		outputStream.close();
		return wb;

	}




	
	
}
