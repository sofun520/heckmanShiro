package cn.heckman.module.framework.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.heckman.module.framework.dao.TUserMapper;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;
import cn.heckman.module.framework.service.TUserService;

@Service
public class TUserServiceImpl implements TUserService {

	@Autowired
	private TUserMapper dao;

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

	public List<TPermission> getPermissionsByUsername(String string) {
		return dao.getPermissionsByUsername(string);
	}
}