package cn.heckman.manager.framework.common;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import cn.heckman.module.framework.pojo.TRole;
import cn.heckman.module.framework.pojo.TUser;

public class PrivilegeTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String privilege; // 标签属性

	@Override
	public int doStartTag() throws JspException {

		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		TUser user = (TUser) session.getAttribute("userinfo");

		// TUser user = new TUser("admin", "admin");// 获取登录用户信息
		if (user == null)
			return SKIP_BODY;
		if (isManager(user)) {
			return EVAL_BODY_INCLUDE; // 超级管理员获取所有权限
		}

		// 根据标签属性判断用户是否有此菜单功能权限，isPermitted的调用会触发doGetAuthorizationInfo方法
		boolean bResult = SecurityUtils.getSubject().isPermitted(privilege);
		System.out.println("===============>>>" + bResult);
		if (bResult) {
			return EVAL_BODY_INCLUDE;
		}
		return SKIP_BODY;
	}

	/**
	 * 判断用户是否超级管理员
	 * 
	 * @return
	 */
	private boolean isManager(TUser user) {
		List<TRole> roles = user.getRoles();
		boolean b = false;
		for (TRole role : roles) { // 遍历是否有超级管理员角色
			if (role.getrName() == Constants.ADMIN) {
				b = true;
				break;
			}
		}
		String accountName = user.getuUsername();
		if (accountName.equals(Constants.ADMIN)
				|| accountName.equals(Constants.SYS_ADMIN) || b) {
			return true;
		}
		return false;

	}

	public String getPrivilege() {
		return privilege;
	}

	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

}
