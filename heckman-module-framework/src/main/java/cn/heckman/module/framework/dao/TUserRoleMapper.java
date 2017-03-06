package cn.heckman.module.framework.dao;

import java.util.Map;

import cn.heckman.common.interfaces.BaseMapper;
import cn.heckman.module.framework.pojo.TUserRole;

public interface TUserRoleMapper extends BaseMapper<TUserRole> {

	void deleteUserRole(Map<String, Object> map);

	void saveUserRole(Map<String, Object> map);
}