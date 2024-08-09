package kr.co.ubcn.multivm.model;

import lombok.Data;

import java.util.List;

@Data
public class Product {
    public int productSeq;
	public Integer companySeq;
	public Integer organizationSeq;
	public String productCode;
	public String productName;
	public Integer productPrice;
	public String productDetail;
	public Integer productCount;
	public String useYN;
	public String createDate;
	public Integer createUserSeq;
	public String modifyDate;
	public Integer modifyUserSeq;
	public String productImage;
	public String isGlass;
	public String visible;

	public Integer isClear;
	public String productImage_bf;

	public Integer eventSeq;
	public String eventTitle;
	public String eventContent;
	public String eventType;
	public Integer eventData;
	public String eventStartTime;
	public String eventEndTime;
	public Integer discount;
	public String imgCode;
	public Integer prePrice;
	public String orderDate;

	public List<RequestProduct> saveList;



}
