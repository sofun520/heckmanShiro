package cn.heckman.manager.framework.common;

public class Constants {

	public static String ADMIN = "admin";
	public static String SYS_ADMIN = "sys_admin";

	/* 权限菜单标识 */
	public static String PERMISSION_MENU_TYPE = "1";
	/* 权限操作标识 */
	public static String PERMISSION_OPERATE_TYPE = "2";

	/* 未知账户 */
	public static String UNKOWN_ACCOUNT = "10000001";
	/* 错误的凭证 */
	public static String INCORRECT_CREDENTIALS = "10000002";
	/* 账户已锁定 */
	public static String LOCKED_ACCOUNT = "10000003";
	/* 错误次数过多 */
	public static String EXCESSIVE_ATTEMPS = "10000004";
	/* 用户名或密码不正确 */
	public static String AUTHENTICATION = "10000005";
	/* 错误的验证码 */
	public static String INCORRECT_VERIFYCODE = "10000006";

	public static String SUCCESS = "0";

	public static String getErrMsg(String errorCode) {
		String a = null;
		switch (errorCode) {
		case "10000001":
			a = "未知账户";
			break;
		case "10000002":
			a = "错误的凭证";
			break;
		case "10000003":
			a = "账户已锁定";
			break;
		case "10000004":
			a = "错误次数过多";
			break;
		case "10000005":
			a = "用户名或密码不正确";
			break;
		case "10000006":
			a = "错误的验证码";
			break;
		}
		return a;
	}
}
