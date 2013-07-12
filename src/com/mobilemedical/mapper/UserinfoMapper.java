package com.mobilemedical.mapper;

import com.mobilemedical.model.Userinfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserinfoMapper {
    int deleteByPrimaryKey(Integer userinfoId);

    int insert(Userinfo record);

    int insertSelective(Userinfo record);

    Userinfo selectByPrimaryKey(Integer userinfoId);

    int updateByPrimaryKeySelective(Userinfo record);

    int updateByPrimaryKey(Userinfo record);

    Userinfo findByIdCode(@Param("idcode") String idcode);

    int selectTotal();

    List selectList(@Param("start") int start,@Param("rows") int rows);

    void updateStatus(@Param("id") int id,@Param("status") int status);

    List<Userinfo> getByGroupid(@Param("usergroupId") Integer usergroupId);
}