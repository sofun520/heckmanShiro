package cn.heckman.module.framework.service;

import java.util.List;
import java.util.Map;

import cn.heckman.common.interfaces.BaseService;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;

public interface TUserService extends BaseService<TUser> {

	TUser getRolesByUsername(String username);

	List<TPermission> getPermissions(Map<String, Object> map);

}
