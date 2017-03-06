package cn.heckman.module.framework.service;

import java.util.Map;

import cn.heckman.common.interfaces.BaseService;
import cn.heckman.module.framework.pojo.TRolePermission;

public interface TRolePermissionService extends BaseService<TRolePermission> {
	
	void saveRolePermissions(Map<String, Object> map);

}
