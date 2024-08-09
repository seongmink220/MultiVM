package kr.co.ubcn.multivm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.ubcn.multivm.model.ProductResponseModel;



/**
 * @author 			J.W.Chae, S.C.Heo
 * @ModifyDate		2020. 11. 10.
 * @param			
 * @description		Json 데이터 파싱 Util
 */
@SuppressWarnings("unchecked")
public class JsonCreate {
	
	private static JsonCreate instance = new JsonCreate();

	public static JsonCreate getInstance() {
		return instance;
	}
	
//	// 마감 데이터 DB 조회 결과 Json 파싱 메소드
//	public static Map<String,Object> closingParsing(List<ClosingModel> closingModelList, ClientModel clientModel) {
//		JSONObject json = new JSONObject();
//		Map<String, Object> closingMap = new HashMap<String, Object>();
//		closingMap.put("emptyFlag", false);
//		// 기본적으로 넣을 값 별도 세팅
//		json.put("message", "No Result");
//		json.put("type", "closing");
//		//json.put("closingDate", clientModel.getJobDate());
//		try {
//			json.put("closingDate", new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyyMMdd").parse(clientModel.getJobDate())));
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		json.put("decription", "단말기 마감일 기준으로 판매된 데이터를 추출합니다. 오늘날짜 조회의 경우, 수동 마감 이외에는 데이터가 추출되지 않습니다.");
//		// 출력 리스트 JSONArray Object에 담음.
//		JSONArray closingArray = new JSONArray();
//		if(!closingModelList.isEmpty()) {	// 조회 결과가 있는 경우 조건식
//			for(ClosingModel closingModel : closingModelList) {
//				closingArray.add(closingModel);
//			}
//			json.put("closingList", closingArray);
//			json.put("message", "Get ClosingList at "+clientModel.getJobDate());
//			closingMap.put("emptyFlag", true);
//		}
//		closingMap.put("json", json); 
//		return closingMap;
//	}
//	
//	// 품절 데이터 DB 조회 결과 Json 파싱 메소드
//	public static Map<String,Object> soldoutParsing(List<SoldoutModel> soldoutModelList) {
//		JSONObject json = new JSONObject();
//		Map<String, Object> soldoutMap = new HashMap<String, Object>();
//		soldoutMap.put("emptyFlag", false);
//		// 기본적으로 넣을 값 별도 세팅
//		json.put("message", "No Result");
//		json.put("type", "soldout");
//		json.put("soldoutDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//		json.put("decription", "당일 최근 전송된 데이터를 기준으로 추출합니다.");
//		
//		// 출력 리스트 JSONArray Object에 담음.
//		JSONArray soldoutArray = new JSONArray();
//		if(!soldoutModelList.isEmpty()) {	// 조회 결과가 있는 경우 조건식
//			for(SoldoutModel soldoutModel : soldoutModelList) {
//				soldoutArray.add(soldoutModel);
//			}
//			json.put("soldoutList", soldoutArray);
//			json.put("message", "Get SoldoutList at "+new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//			soldoutMap.put("emptyFlag", true);
//		}
//		soldoutMap.put("json", json); 
//		return soldoutMap;
//	}
//	
//	// 매출 데이터 DB 조회 결과 Json 파싱 메소드
//	public static Map<String,Object> salesParsing(List<SalesModel> salesModelList, ClientModel clientModel) {
//		JSONObject json = new JSONObject();
//		Map<String, Object> salesMap = new HashMap<String, Object>();
//		salesMap.put("emptyFlag", false);
//		// 기본적으로 넣을 값 별도 세팅
//		json.put("message", "No Result");
//		json.put("type", "sales");
//		json.put("salesDate", clientModel.getJobDate());
//		json.put("decription", "요청 일시 기준으로 매출을 추출합니다.");
//		
//		// 출력 리스트 JSONArray Object에 담음.
//		JSONArray salesArray = new JSONArray();
//		if(!salesModelList.isEmpty()) {	// 조회 결과가 있는 경우 조건식
//			for(SalesModel salesModel : salesModelList) {
//				salesArray.add(salesModel);
//			}
//			json.put("salesList", salesArray);
//			json.put("message", "Get SalesList at "+clientModel.getJobDate());
//			salesMap.put("emptyFlag", true);
//		}
//		salesMap.put("json", json); 
//		return salesMap;
//	}
//	
//	// 이상상태 조회 결과 DB JSon 파싱 메소드
//	public static Map<String,Object> controlErrorParsing(List<ControlErrorModel> controlErrorModelList, ClientModel clientModel) {
//		JSONObject json = new JSONObject();
//		Map<String, Object> controlErrorMap = new HashMap<String, Object>();
//		controlErrorMap.put("emptyFlag", false);
//		
//		// 기본 정보 Setting
//		json.put("message", "No Result");
//		json.put("type", "control_error");
//		json.put("requestDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//		json.put("description", "단말기 상태 이상인 리스트들만 추출합니다.");
//		
//		// List 형태의 데이터 세팅
//		JSONArray statusArray = new JSONArray();
//		if(!controlErrorModelList.isEmpty()) {
//			for(ControlErrorModel controlErrorModel : controlErrorModelList) {
//				statusArray.add(controlErrorModel);
//			}
//			json.put("controlErrorList", statusArray);
//			json.put("message", "Get controlErrorList at "+new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//			controlErrorMap.put("emptyFlag", true);
//		}
//		controlErrorMap.put("json", json);
//		return controlErrorMap;
//	}
//	
//	// 매입 정산 조회 결과 DB JSon 파싱 메소드
//		public static Map<String,Object> adjustParsing(List<AdjustModel> adjustModelList, ClientModel clientModel) {
//			JSONObject json = new JSONObject();
//			Map<String, Object> adjustMap = new HashMap<String, Object>();
//			adjustMap.put("emptyFlag", false);
//			
//			// 기본 정보 Setting
//			json.put("message", "No Result");
//			json.put("type", "adjust");
//			json.put("requestDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//			json.put("description", "매입 데이터 요청에 대한 응답 결과를 전달합니다.");
//			
//			// List 형태의 데이터 세팅
//			JSONArray adjustArray = new JSONArray();
//			if(!adjustModelList.isEmpty()) {
//				for(AdjustModel adjustModel : adjustModelList) {
//					adjustArray.add(adjustModel);
//				}
//				json.put("adjustList", adjustArray);
//				json.put("message", "Get adjust at "+new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
//				adjustMap.put("emptyFlag", true);
//			}
//			adjustMap.put("json", json);
//			return adjustMap;
//		}

	public static String getCurrentDateTime() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyyMMddHHmmss"; //hhmmss로 시간,분,초만 뽑기도 가능
		SimpleDateFormat formatter = new SimpleDateFormat(pattern,
				currentLocale);
		return formatter.format(today);
	}

	// 공통 에러 메시지 Json 파싱 메소드
	public static Map<String, Object> productParsing(List<ProductResponseModel> productModelList){
		JSONObject json = new JSONObject();
		Map<String, Object> productMap = new HashMap<String, Object>();
		String serverDateTime = getCurrentDateTime();

		productMap.put("emptyFlag", false);
		
		JSONArray productArray = new JSONArray();
		if(!productModelList.isEmpty()) {
			for(ProductResponseModel productModel : productModelList) {
				productArray.add(productModel);
			}
			json.put("serverDateTime",serverDateTime);
			json.put("productList", productArray);
			productMap.put("emptyFlag", true);
		}
		productMap.put("json", json);
		return productMap;
	}

	public static Map<String, Object> advParsing(List<HashMap<String, Object>> advList){
		JSONObject json = new JSONObject();
		Map<String, Object> productMap = new HashMap<String, Object>();
		String serverDateTime = getCurrentDateTime();

		productMap.put("emptyFlag", false);

		JSONArray productArray = new JSONArray();
		if(!advList.isEmpty()) {
			for(Map<String, Object> list : advList) {
				productArray.add(list);
			}
			json.put("advModifyDate",serverDateTime);
			json.put("advList", productArray);
			productMap.put("emptyFlag", true);
		}
		productMap.put("json", json);
		return productMap;
	}
	
	// 공통 에러 메시지 Json 파싱 메소드
	public static JSONObject errorParsing(String type){
		JSONObject json = new JSONObject();
		json.put("description", "유효하지 않은 요청입니다. URI 및 헤더 데이터를 다시 한 번 확인 바랍니다.");
		json.put("message", "토큰과 company가 동일하지 않습니다.");
		json.put("type", type);
		return json;
	}
	
	public static JSONObject errorParsing(String type,String msg){
		JSONObject json = new JSONObject();
		json.put("message", msg);
		json.put("type", type);
		return json;
	}
	
	public static JSONObject successParsing(String type){
		JSONObject json = new JSONObject();
		json.put("message", "Data Insert Success!");
		json.put("type", type);
		return json;
	}
	
	public static JSONObject dbInsertErrorParsing(String type){
		JSONObject json = new JSONObject();
		json.put("message", "Data Insert Error!");
		json.put("type", type);
		return json;
	}
	
	//paging정도 Json 파싱 메소드
	public static JSONObject pagingInfo(String type, long totalCnt) {
		JSONObject json = new JSONObject();
		json.put("type", type);
		json.put("totalCnt", totalCnt);
		json.put("pagingOffset", 1000);
		json.put("minRequestCnt", 1);
		json.put("maxRequestCnt", (int) Math.ceil(totalCnt/100*0.1));
		return json;
	}
	
}
