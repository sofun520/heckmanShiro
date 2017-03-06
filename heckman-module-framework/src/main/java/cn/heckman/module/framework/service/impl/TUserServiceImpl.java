package cn.heckman.module.framework.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.heckman.module.framework.dao.TUserMapper;
import cn.heckman.module.framework.dao.TUserRoleMapper;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;
import cn.heckman.module.framework.pojo.UserRoleTree;
import cn.heckman.module.framework.service.TUserService;

@Service
public class TUserServiceImpl implements TUserService {

	@Autowired
	private TUserMapper dao;

	@Autowired
	private TUserRoleMapper urDao;

	public int insert(TUser t) {
		return dao.insert(t);
	}

	public void update(TUser t) {
		dao.update(t);
	}

	public List<TUser> query(Map<String, Object> map) {
		return dao.query(map);
	}

	public void delete(Integer id) {
		dao.delete(id);
	}

	public TUser find(Integer id) {
		return dao.find(id);
	}

	public int count(Map<String, Object> map) {
		return dao.count(map);
	}

	public TUser getRolesByUsername(String username) {
		return dao.getRolesByUsername(username);
	}

	public List<TPermission> getPermissions(Map<String, Object> map) {
		return dao.getPermissions(map);
	}

	public List<TUser> queryPage(Map<String, Object> map) {
		return dao.queryPage(map);
	}

	public List<UserRoleTree> userRoleTree(Map<String, Object> map) {
		return dao.userRoleTree(map);
	}

	public void saveUserRole(Map<String, Object> map) {
		urDao.deleteUserRole(map);
		if ("1" == map.get("flag")) {
			urDao.saveUserRole(map);
		}
	}
}
