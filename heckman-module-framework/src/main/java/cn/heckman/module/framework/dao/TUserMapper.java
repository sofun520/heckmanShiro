package cn.heckman.module.framework.dao;

import java.util.List;

import cn.heckman.common.interfaces.BaseMapper;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;

public interface TUserMapper extends BaseMapper<TUser> {

	TUser getRolesByUsername(String username);

	List<TPermission> getPermissionsByUsername(String string);

}