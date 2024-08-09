package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class SalesApi {

    public String productCode;		// 상품코드(수량1개일땐 한개넣고, 2개이상일땐 첫번째값만 지정->sales에 넣을때)

    public Integer productPrice;	// 상품금액

    public Integer count;		    // 거래수량

    public Integer slotNo;			// 슬롯번호

    public Integer vmSeq;			// 자판기 seq

    public Integer organizationSeq;	// 조직 seq

    public Integer companySeq;		// 소속 seq

    public String transactionNo;    // 거래번호(내가지정)

    public String transactionTime;    // 거래시간

    public Integer amount;		    // 총거래금액

    public Integer itemCount;		// 총거래수량

    public String salesState;		// 거래 상태 (추후)

    public String shipResult;       // 추출여부(미투출일땐 F)

    public String transactionDate;

}
