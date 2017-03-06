package cn.heckman.manager.framework.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;

import cn.heckman.manager.framework.common.Constants;
import cn.heckman.manager.framework.common.ResponseData;
import cn.heckman.module.framework.pojo.TRole;
import cn.heckman.module.framework.service.TRoleService;

@Controller
@RequestMapping("/api/role")
public class TRoleController {

	@Autowired
	private TRoleService service;

	@RequestMapping("/query")
	@ResponseBody
	public ResponseData query(@RequestBody TRole role) {
		ResponseData rd = new ResponseData();
		Map<String, Object> map = new HashMap<String, Object>();
		if (role != null) {
			map.put("rDescription", role.getrDescription());
		}
		try {
			List<TRole> list = service.query(map);
			rd.setData(list);
			rd.setCode(Constants.SUCCESS);
		} catch (Exception ex) {
			ex.printStackTrace();
			rd.setCode(Constants.FAILED);
			rd.setMsg(Constants.getErrMsg(Constants.INNER_ERROR));
		}
		return rd;
	}

	@RequestMapping("/save")
	@ResponseBody
	public ResponseData save(@RequestBody TRole role) {
		ResponseData rd = new ResponseData();
		try {
			role.setrAddTime(new Date());
			if (role.getrId() != null) {
				service.update(role);
				rd.setMsg(Constants.getSuccessMsg(Constants.UPDATE_SUCCESS));
			} else {
				service.insert(role);
				rd.setMsg(Constants.getSuccessMsg(Constants.INSERT_SUCCESS));
			}
			rd.setCode(Constants.SUCCESS);
		} catch (Exception ex) {
			ex.printStackTrace();
			rd.setCode(Constants.FAILED);
			rd.setMsg(Constants.getErrMsg(Constants.INNER_ERROR));
		}
		return rd;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public ResponseData delete(@RequestBody TRole role) {
		ResponseData rd = new ResponseData();
		try {
			if (role.getrId() != null) {
				service.delete(role.getrId());
				rd.setMsg(Constants.getSuccessMsg(Constants.DELETE_SUCCESS));
			}
			rd.setCode(Constants.SUCCESS);
		} catch (Exception ex) {
			ex.printStackTrace();
			rd.setCode(Constants.FAILED);
			rd.setMsg(Constants.getErrMsg(Constants.INNER_ERROR));
		}
		return rd;
	}

}
