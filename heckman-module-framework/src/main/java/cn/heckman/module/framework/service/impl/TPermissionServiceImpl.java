package cn.heckman.module.framework.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.heckman.common.utils.ShiroSessionUtil;
import cn.heckman.module.framework.common.OperateLogConstants;
import cn.heckman.module.framework.dao.TOperateLogMapper;
import cn.heckman.module.framework.dao.TPermissionMapper;
import cn.heckman.module.framework.pojo.RolePermissionTree;
import cn.heckman.module.framework.pojo.TOperateLog;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;
import cn.heckman.module.framework.service.TPermissionService;

@Service
public class TPermissionServiceImpl implements TPermissionService {

	@Autowired
	private TPermissionMapper dao;

	@Autowired
	private TOperateLogMapper logDao;

	public int insert(TPermission t) {
		logDao.insert(new TOperateLog(
				OperateLogConstants.PERMISSION_INSERT_OPTION,
				OperateLogConstants
						.getOperateLogDes(OperateLogConstants.PERMISSION_INSERT_OPTION)
						+ ":token=" + t.getpToken(), ((TUser) ShiroSessionUtil
						.getSession(ShiroSessionUtil.USER_SESSION_NAME))
						.getuId(), ((TUser) ShiroSessionUtil
						.getSession(ShiroSessionUtil.USER_SESSION_NAME))
						.getuUsername()));
		return dao.insert(t);
	}

	public void update(TPermission t) {
		logDao.insert(new TOperateLog(
				OperateLogConstants.PERMISSION_UPDATE_OPTION,
				OperateLogConstants
						.getOperateLogDes(OperateLogConstants.PERMISSION_UPDATE_OPTION)
						+ ":id=" + t.getpId(), ((TUser) ShiroSessionUtil
						.getSession(ShiroSessionUtil.USER_SESSION_NAME))
						.getuId(), ((TUser) ShiroSessionUtil
						.getSession(ShiroSessionUtil.USER_SESSION_NAME))
						.getuUsername()));
		dao.update(t);
	}

	public List<TPermission> query(Map<String, Object> map) {
		return dao.query(map);
	}

	public void delete(Integer id) {
		logDao.insert(new TOperateLog(
				OperateLogConstants.PERMISSION_DELETE_OPTION,
				OperateLogConstants
						.getOperateLogDes(OperateLogConstants.PERMISSION_DELETE_OPTION)
						+ ":id=" + id, ((TUser) ShiroSessionUtil
						.getSession(ShiroSessionUtil.USER_SESSION_NAME))
						.getuId(), ((TUser) ShiroSessionUtil
						.getSession(ShiroSessionUtil.USER_SESSION_NAME))
						.getuUsername()));
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
