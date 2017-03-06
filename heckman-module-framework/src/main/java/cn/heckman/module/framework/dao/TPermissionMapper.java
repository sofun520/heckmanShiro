package cn.heckman.module.framework.dao;

import java.util.List;
import java.util.Map;

import cn.heckman.common.interfaces.BaseMapper;
import cn.heckman.module.framework.pojo.RolePermissionTree;
import cn.heckman.module.framework.pojo.TPermission;

public interface TPermissionMapper extends BaseMapper<TPermission> {

	List<RolePermissionTree> userPermissionsTree(Map<String, Object> map);

	

}