package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Event {
   public Integer seq;
   public Integer companySeq;
   public String companyName;
   public Integer organizationSeq;
   public String organizationName;
   public String eventTitle;
   public String eventContent;
   public String eventContent2;
   public String eventType;
   public Integer eventData;
   public String eventStartTime;
   public String eventEndTime;
   public String createDate;
   public Integer createUserSeq;
   public String modifyDate;
   public Integer modifyUserSeq;

}
