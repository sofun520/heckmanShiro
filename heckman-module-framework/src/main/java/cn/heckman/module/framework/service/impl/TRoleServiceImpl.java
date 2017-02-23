package cn.heckman.module.framework.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.heckman.module.framework.dao.TRoleMapper;
import cn.heckman.module.framework.pojo.TRole;
import cn.heckman.module.framework.service.TRoleService;

@Service
public class TRoleServiceImpl implements TRoleService {

	@Autowired
	private TRoleMapper dao;

	public int insert(TRole t) {
		return dao.insert(t);
	}

	public void update(TRole t) {
		dao.update(t);
	}

	public List<TRole> query(Map<String, Object> map) {
		return dao.query(map);
	}

	public void delete(Integer id) {
		dao.delete(id);
	}

	public TRole find(Integer id) {
		return dao.find(id);
	}

	public int count(Map<String, Object> map) {
		return dao.count(map);
	}

}
