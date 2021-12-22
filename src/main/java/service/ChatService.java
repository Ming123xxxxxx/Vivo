package service;

import org.apache.ibatis.annotations.Param;
import pojo.ChatPojo;

import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/21 18:32
 */
public interface ChatService {
    List<ChatPojo> getallchats();
    int getlastid();
    int addrecords(ChatPojo chatPojo);
    ChatPojo getrecordsbyid(int id);
}
