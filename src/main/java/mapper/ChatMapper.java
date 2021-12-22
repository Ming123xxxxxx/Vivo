package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.ChatPojo;

import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/21 16:56
 */
public interface ChatMapper {
    List<ChatPojo> getallchats();
    int getlastid();
    int addrecords(ChatPojo chatPojo);
    ChatPojo getrecordsbyid(@Param("id") int id);
}
