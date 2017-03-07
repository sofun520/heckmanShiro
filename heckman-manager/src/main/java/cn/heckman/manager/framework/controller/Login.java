package cn.heckman.manager.framework.controller;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.heckman.common.utils.ShiroSessionUtil;
import cn.heckman.manager.framework.common.Constants;
import cn.heckman.manager.framework.common.MD5Util;
import cn.heckman.manager.framework.common.ResponseData;
import cn.heckman.manager.framework.common.VerifyCodeUtil;
import cn.heckman.module.framework.pojo.TUser;

import com.alibaba.druid.util.StringUtils;

@Controller
public class Login {

	private Logger logger = Logger.getLogger(Login.class);

	@RequestMapping("/getVerifyCodeImage")
	public void getVerifyCodeImage(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// 设置页面不缓存
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String verifyCode = VerifyCodeUtil.generateTextCode(
				VerifyCodeUtil.TYPE_NUM_ONLY, 4, null);
		// 将验证码放到HttpSession里面
		// request.getSession().setAttribute("verifyCode", verifyCode);

		ShiroSessionUtil.setSession("verifyCode", verifyCode);

		System.out.println("本次生成的验证码为[" + verifyCode + "],已存放到HttpSession中");
		// 设置输出的内容的类型为JPEG图像
		response.setContentType("image/jpeg");
		BufferedImage bufferedImage = VerifyCodeUtil.generateImageCode(
				verifyCode, 90, 30, 3, true, Color.WHITE, Color.BLACK, null);
		// 写给浏览器
		ImageIO.write(bufferedImage, "JPEG", response.getOutputStream());
	}

	@RequestMapping(value = "/checkLogin", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseData login2(@RequestBody TUser user) {
		ResponseData responseData = new ResponseData();
		UsernamePasswordToken token = new UsernamePasswordToken(
				user.getuUsername(), MD5Util.md5(user.getuPassword()));
		token.setRememberMe(true);
		// 获取当前的Subject
		Subject currentUser = SecurityUtils.getSubject();
		try {
			currentUser.login(token);
		} catch (UnknownAccountException uae) {
			responseData.setCode(Constants.UNKOWN_ACCOUNT);
			responseData.setMsg(Constants.getErrMsg(Constants.UNKOWN_ACCOUNT));
		} catch (IncorrectCredentialsException ice) {
			responseData.setCode(Constants.INCORRECT_CREDENTIALS);
			responseData.setMsg(Constants
					.getErrMsg(Constants.INCORRECT_CREDENTIALS));
		} catch (LockedAccountException lae) {
			responseData.setCode(Constants.LOCKED_ACCOUNT);
			responseData.setMsg(Constants.getErrMsg(Constants.LOCKED_ACCOUNT));
		} catch (ExcessiveAttemptsException eae) {
			responseData.setCode(Constants.EXCESSIVE_ATTEMPS);
			responseData.setMsg(Constants
					.getErrMsg(Constants.EXCESSIVE_ATTEMPS));
		} catch (AuthenticationException ae) {
			responseData.setCode(Constants.AUTHENTICATION);
			responseData.setMsg(Constants.getErrMsg(Constants.AUTHENTICATION));
		}

		// 验证是否登录成功
		if (currentUser.isAuthenticated()) {
			responseData.setCode(Constants.SUCCESS);
			responseData.setMsg("登录成功");
		} else {
			token.clear();
		}

		return responseData;
	}

	@RequestMapping(value = "/checkVerifyCode", method = RequestMethod.GET)
	@ResponseBody
	public ResponseData checkVerifyCode(HttpServletRequest request) {
		ResponseData responseData = new ResponseData();
		try {
			String submitCode = request.getParameter("verifyCode");
			/*
			 * String verifyCode = (String) request.getSession().getAttribute(
			 * "verifyCode");
			 */
			String verifyCode = (String) ShiroSessionUtil
					.getSession("verifyCode");
			logger.debug("submitCode===" + submitCode);
			logger.debug("verifyCode====" + verifyCode);
			if (StringUtils.isEmpty(submitCode)
					|| !StringUtils
							.equals(verifyCode, submitCode.toLowerCase())) {
				responseData.setCode(Constants.INCORRECT_VERIFYCODE);
				responseData.setMsg(Constants
						.getErrMsg(Constants.INCORRECT_VERIFYCODE));
			} else {
				responseData.setCode(Constants.SUCCESS);
				responseData.setMsg("验证码正确");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			// logger.error(ex);
		}
		return responseData;
	}

	/**
	 * 
	 * 用户登出
	 */

	@RequestMapping("/logout")
	@ResponseBody
	public ResponseData logout(HttpServletRequest request) {
		ResponseData rd = new ResponseData();
		try {
			SecurityUtils.getSubject().logout();
			rd.setCode(Constants.SUCCESS);
			rd.setMsg(Constants.getSuccessMsg(Constants.LOGOUT_SUCCESS));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return rd;
	}
}
