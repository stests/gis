package com.mobilemedical.mapper;

import com.mobilemedical.model.Usergroup;

import java.util.List;

public interface UsergroupMapper {
    int deleteByPrimaryKey(Integer usergroupId);

    int insert(Usergroup record);

    int insertSelective(Usergroup record);

    Usergroup selectByPrimaryKey(Integer usergroupId);

    int updateByPrimaryKeySelective(Usergroup record);

    int updateByPrimaryKey(Usergroup record);

    List<Usergroup> getAll();
}