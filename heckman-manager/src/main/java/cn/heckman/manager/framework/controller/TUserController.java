package cn.heckman.manager.framework.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.service.TUserService;

import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/user")
public class TUserController {

	@Autowired
	private TUserService service;

	@RequestMapping("/query")
	@ResponseBody
	public Map<String, Object> query() {
		// JSONObject re = new JSONObject();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// List<TUser> list = service.query(new HashMap<String, Object>());
			// map.put("data", list);
			/*
			 * TUser user = service.getRolesByUsername("admin"); map.put("data",
			 * user); System.out.println(JSONObject.toJSONString(user));
			 */
			map.put("uUsername", "admin");
			List<TPermission> permissions = service.getPermissions(map);
			map.put("data", permissions);
			System.out.println(JSONObject.toJSONString(permissions));

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return map;
	}

	@RequestMapping("/query2")
	@ResponseBody
	public Map<String, Object> hashRole() {
		Map<String, Object> map = new HashMap<String, Object>();
		try {

			Subject sub = SecurityUtils.getSubject();
			System.out.println("===================>" + sub.hasRole("admin"));

			System.out.println(">>>>>>>>>>>>>>>>>>>>"
					+ sub.isPermitted("system.admin"));

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return map;
	}

}
