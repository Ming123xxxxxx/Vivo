package service;

import mapper.ChatMapper;
import org.springframework.beans.factory.annotation.Autowired;
import pojo.ChatPojo;

import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/21 18:31
 */
public class ChatServiceImpl implements ChatService {

    @Autowired
    ChatMapper chatMapper;
    public void setChatMapper(ChatMapper chatMapper){
        this.chatMapper=chatMapper;
    }

    @Override
    public List<ChatPojo> getallchats() {
        return chatMapper.getallchats();
    }

    @Override
    public int getlastid() {
        return chatMapper.getlastid();
    }

    @Override
    public int addrecords(ChatPojo chatPojo) {
        return chatMapper.addrecords(chatPojo);
    }

    @Override
    public ChatPojo getrecordsbyid(int id) {
        return chatMapper.getrecordsbyid(id);
    }

}
