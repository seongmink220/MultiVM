package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Event;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EventMapper {
    public Event getEventInfo(int seq);
    public Event getEventInfo2(int seq);
    public List<Event> searchEventList(Map<String, Object> map);
    public int insertEvent(Event event);
    public int modifyEvent(Event event);
    public boolean updateVMProductEvent(Map<String, Object> map);
    public void deleteEvent(Map<String, Object> map);
    public boolean updateVMProductEvent_v2(Map<String, Object> map);
}
