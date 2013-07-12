package com.mobilemedical.mapper;

import com.mobilemedical.model.Userpoint;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserpointMapper {
    int deleteByPrimaryKey(String pointId);

    int insert(Userpoint record);

    int insertSelective(Userpoint record);

    Userpoint selectByPrimaryKey(String pointId);

    int updateByPrimaryKeySelective(Userpoint record);

    int updateByPrimaryKey(Userpoint record);

    List<Userpoint> getTodayPoints(@Param("userid") int userid,@Param("today") String today);

    List<Userpoint> getPointsIn(@Param("userid") int userid,@Param("start") String start,@Param("timeend") String timeend);
}