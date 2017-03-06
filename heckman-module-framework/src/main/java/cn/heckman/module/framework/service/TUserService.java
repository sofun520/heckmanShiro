package cn.heckman.module.framework.service;

import java.util.List;
import java.util.Map;

import cn.heckman.common.interfaces.BaseService;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;
import cn.heckman.module.framework.pojo.UserRoleTree;

public interface TUserService extends BaseService<TUser> {

	TUser getRolesByUsername(String username);

	List<TPermission> getPermissions(Map<String, Object> map);

	List<TUser> queryPage(Map<String, Object> map);

	List<UserRoleTree> userRoleTree(Map<String, Object> map);

	void saveUserRole(Map<String, Object> map);

}
