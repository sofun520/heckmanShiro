package cn.heckman.module.framework.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.heckman.module.framework.dao.TPermissionMapper;
import cn.heckman.module.framework.pojo.RolePermissionTree;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.service.TPermissionService;

@Service
public class TPermissionServiceImpl implements TPermissionService {

	@Autowired
	private TPermissionMapper dao;

	public int insert(TPermission t) {
		return dao.insert(t);
	}

	public void update(TPermission t) {
		dao.update(t);
	}

	public List<TPermission> query(Map<String, Object> map) {
		return dao.query(map);
	}

	public void delete(Integer id) {
		dao.delete(id);
	}

	public TPermission find(Integer id) {
		return dao.find(id);
	}

	public int count(Map<String, Object> map) {
		return dao.count(map);
	}

	public List<RolePermissionTree> userPermissionsTree(Map<String, Object> map) {
		return dao.userPermissionsTree(map);
	}

}
