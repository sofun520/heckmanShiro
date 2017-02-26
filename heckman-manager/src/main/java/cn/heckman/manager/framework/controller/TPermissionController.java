package cn.heckman.manager.framework.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.heckman.manager.framework.common.Constants;
import cn.heckman.manager.framework.common.ResponseData;
import cn.heckman.manager.framework.common.ShiroSessionUtil;
import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TUser;
import cn.heckman.module.framework.service.TPermissionService;
import cn.heckman.module.framework.service.TUserService;

@Controller
public class TPermissionController {

	@Autowired
	private TUserService service;

	@Autowired
	private TPermissionService perService;

	@RequestMapping(value = "/permission", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData queryUserPermissionMenu(
			@RequestBody TPermission permission) {
		ResponseData responseData = new ResponseData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			TUser user = (TUser) ShiroSessionUtil.getSession("userinfo");
			map.put("uUsername", user.getuUsername());
			map.put("pType", permission.getpType());
			map.put("pParent", permission.getpParent());
			List<TPermission> list = service.getPermissions(map);
			responseData.setData(list);
			responseData.setCode(Constants.SUCCESS);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return responseData;
	}

	@RequestMapping("/test")
	public ModelAndView test() {
		return new ModelAndView("test");
	}

	@RequestMapping(value = "/api/permission/query", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData queryPermissionMenu(@RequestBody TPermission permission) {
		ResponseData responseData = new ResponseData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<TPermission> list = perService.query(map);
			responseData.setData(list);
			responseData.setCode(Constants.SUCCESS);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return responseData;
	}

	@RequestMapping("/main/permission")
	public ModelAndView showPage() {
		return new ModelAndView("admin/permission");
	}

}
