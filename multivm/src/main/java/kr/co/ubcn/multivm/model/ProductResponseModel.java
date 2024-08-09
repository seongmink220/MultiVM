package kr.co.ubcn.multivm.model;

import lombok.Data;

/**
 * @author 			S.C.Heo
 * @ModifyDate		2022. 01. 21
 * @param			
 * @description		자판기별 상품정보
 */

@Data
public class ProductResponseModel {
	public String productCode;		// 상품코드
	
	public String productName;		// 상품명
	
	public Integer productPrice;	// 상품금액
	
	public Integer productCount;	// 총수량
	
	public Integer slotNo;			// 슬롯번호
	
	public String productImage;		// 상품이미지 경로

	//2022-03-25. 상품설명 추가
	public String productDetail;	// 상품설명

	//2022-03-30. 파손여부 추가
	public String isGlass; 			// 파손여부

	//2022-04-04. 삭제여부 추가
	public String visible;

	//2022-04-19. 이벤트관련 추가
	public String eventType;		// 이벤트 타입
	public Integer eventData;		// 이벤트 가격
	public String eventStartTime;	// 시작일시
	public String eventEndTime;		// 종료일시

}
