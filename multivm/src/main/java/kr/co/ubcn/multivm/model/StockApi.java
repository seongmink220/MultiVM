package kr.co.ubcn.multivm.model;

import lombok.Data;

/**
 * @author 			S.C.Heo
 * @ModifyDate		2022. 01. 21
 * @param			
 * @description		상품입출고
 */

@Data
public class StockApi {
	public String productCode;		// 상품코드
	
	public Integer productPrice;	// 상품금액
	
	public Integer count;			// 입고수량
	
	public Integer slotNo;			// 슬롯번호
	
	public Integer vmSeq;			// 자판기 seq
	
	public Integer organizationSeq;	// 조직 seq
	
	public Integer companySeq;		// 소속 seq
	
	public String releaseType;		//출고 구분 (판매 : S, 단순출고 : R)

	public String date;

	public String time;
}
