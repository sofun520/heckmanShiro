package cn.heckman.module.framework.service;

import java.util.List;
import java.util.Map;

import cn.heckman.common.interfaces.BaseService;
import cn.heckman.module.framework.pojo.RolePermissionTree;
import cn.heckman.module.framework.pojo.TPermission;

public interface TPermissionService extends BaseService<TPermission> {
	List<RolePermissionTree> userPermissionsTree(Map<String, Object> map);

	
}
