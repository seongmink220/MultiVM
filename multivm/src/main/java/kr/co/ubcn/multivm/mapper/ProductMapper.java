package kr.co.ubcn.multivm.mapper;

import java.util.List;
import java.util.Map;

import kr.co.ubcn.multivm.model.Product;
import kr.co.ubcn.multivm.model.User;
import org.apache.ibatis.annotations.Mapper;

import kr.co.ubcn.multivm.model.ProductResponseModel;

/**
 * @author 			S.C.Heo
 * @ModifyDate		2022. 01. 21
 * @param			
 * @description		멀티자판기 상품 다운로드 위한 mapper 클래스
 */

@Mapper
public interface ProductMapper {

	public List<Product> getSearchProduct(Product product);//이것도 보류

	public List<Product> getUserProduct(Map<String, Object> map); //이거 나중에 맨 아래꺼랑 합치자 getUserProduct_v1
	public List<Product> getUserProduct_v1(User user);
	public void deleteProduct(Map<String, Object> map);

	public Product getSelectProduct(int productSeq);

	public void modifyProduct(Product product);
	public int getProductCode();
	public int insertProduct(Product product);

	public void clearProduct(Product product);
	public int isHasCodeProduct(Product product);
	public List<Product> isHasCodeProductImg(Product product);
	//public List<String> isHasCodeProductName(Map<String, Object> map);
	public List<String> isHasCodeProductCode(Map<String, Object> map);

	public Product getMasterProduct(Map<String, Object> map);
	public void deleteProduct_v2(Product product);
	public void deletedProduct_up_v2(Product product);

	public List<Product> getProductImageList(Product product);

}
