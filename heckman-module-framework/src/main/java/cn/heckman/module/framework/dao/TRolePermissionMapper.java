package cn.heckman.module.framework.dao;

import java.util.Map;

import cn.heckman.common.interfaces.BaseMapper;
import cn.heckman.module.framework.pojo.TRolePermission;

public interface TRolePermissionMapper extends BaseMapper<TRolePermission> {
	
	void saveRolePermissions(Map<String, Object> map);

	void deleteRolePermissions(Map<String, Object> map);
	
}