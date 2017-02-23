package cn.heckman.manager.framework.common;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

import cn.heckman.module.framework.pojo.TPermission;
import cn.heckman.module.framework.pojo.TRole;
import cn.heckman.module.framework.pojo.TUser;
import cn.heckman.module.framework.service.TUserService;

import com.alibaba.fastjson.JSONObject;

public class MyRealm extends AuthorizingRealm {

	@Autowired
	private TUserService userService;

	// 这里因为没有调用后台，直接默认只有一个用户("luoguohui"，"123456")
	// private static final String USER_NAME = "admin";
	// private static final String PASSWORD = "123456";

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		// 获取当前登录的用户名,等价于(String)principals.fromRealm(this.getName()).iterator().next()
		String loginName = (String) principals.fromRealm(getName()).iterator()
				.next();

		TUser user = userService.getRolesByUsername(loginName);
		List<TPermission> pers = userService
				.getPermissionsByUsername(loginName);

		Set<String> roleNames = new HashSet<String>();
		Set<String> permissions = new HashSet<String>();
		List<TRole> roles = user.getRoles();
		for (TRole role : roles) {
			roleNames.add(role.getrName());// 添加角色
		}
		for (TPermission per : pers) {
			permissions.add(per.getpToken()); // 添加权限
		}
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roleNames);
		info.setStringPermissions(permissions);
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uUsername", token.getUsername());
		List<TUser> list = userService.query(map);
		if (list.size() > 0) {
			TUser user = list.get(0);
			System.out.println("==========" + JSONObject.toJSONString(user));
			System.out.println("==========token"
					+ JSONObject.toJSONString(token));

			if (token.getUsername().equals(user.getuUsername())) {
				setSession("userinfo", user);
				return new SimpleAuthenticationInfo(user.getuUsername(),
						user.getuPassword(), getName());
			} else {
				throw new AuthenticationException();
			}
		} else {
			throw new UnknownAccountException();
		}
	}

	/**
	 * 
	 * 将一些数据放到ShiroSession中,以便于其它地方使用
	 * 
	 * @see 比如Controller,使用时直接用HttpSession.getAttribute(key)就可以取到
	 */
	private void setSession(Object key, Object value) {
		Subject currentUser = SecurityUtils.getSubject();
		if (null != currentUser) {
			Session session = currentUser.getSession();
			System.out
					.println("Session默认超时时间为[" + session.getTimeout() + "]毫秒");
			if (null != session) {
				session.setAttribute(key, value);
			}
		}
	}

}
