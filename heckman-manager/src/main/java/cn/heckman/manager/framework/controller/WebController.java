package cn.heckman.manager.framework.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;

import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TRole;
import cn.heckman.module.framework.service.TPermissionService;
import cn.heckman.module.framework.service.TRoleService;

@Controller
public class WebController {

	@Autowired
	private TPermissionService permissionService;

	@Autowired
	private TRoleService roleService;

	@RequestMapping("/home")
	public ModelAndView home() {
		return new ModelAndView("home/home");
	}

	@RequestMapping("/admin/permission")
	public ModelAndView permission() {
		return new ModelAndView("admin/permission");
	}

	@RequestMapping("/admin/editPermission")
	public ModelAndView editPermission(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = request.getParameter("id");
		String pId = request.getParameter("pId");
		try {
			if (!StringUtils.isEmpty(id)) {
				map.put("id", request.getParameter("id"));
				TPermission per = permissionService.find(Integer
						.parseInt(request.getParameter("id")));
				map.put("permission", per);
				map.put("p_Parent", per.getpParent());
			}
			if (!StringUtils.isEmpty(pId)) {
				map.put("p_Parent", pId);
			}

			map.put("pType", "1");
			map.put("flag", "1");
			List<TPermission> list = permissionService.query(map);

			map.put("parentPermissions", list);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return new ModelAndView("admin/editPermission", map);
	}

	@RequestMapping("/admin/role")
	public ModelAndView role() {
		return new ModelAndView("admin/role");
	}

	@RequestMapping("/admin/editRole")
	public ModelAndView editRole(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (!StringUtils.isEmpty(request.getParameter("id"))) {
				int id = Integer.parseInt(request.getParameter("id"));
				TRole role = roleService.find(id);
				map.put("id", id);
				map.put("role", role);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return new ModelAndView("admin/editRole", map);
	}

	@RequestMapping("/admin/user")
	public ModelAndView user() {
		return new ModelAndView("admin/user");
	}
}
