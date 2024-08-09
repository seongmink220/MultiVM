package kr.co.ubcn.multivm.model;

import lombok.Data;

import java.util.List;

@Data
public class RequestProduct {
    public String id;
    public Integer amount;
    public Integer companySeq;
    public Integer organizationSeq;
    public Integer vmSeq;
    public String deleteType;

    public RequestProduct(){

    }


    public List<RequestProduct> saveList;
}
