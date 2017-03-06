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

	public static String INNER_ERROR = "10000500";

	public static String SUCCESS = "0";

	public static String FAILED = "1";

	public static String getErrMsg(String errorCode) {
		StringBuffer a = new StringBuffer("");
		switch (errorCode) {
		case "10000001":
			a = new StringBuffer("未知账户");
			break;
		case "10000002":
			a = new StringBuffer("错误的凭证");
			break;
		case "10000003":
			a = new StringBuffer("账户已锁定");
			break;
		case "10000004":
			a = new StringBuffer("错误次数过多");
			break;
		case "10000005":
			a = new StringBuffer("用户名或密码不正确");
			break;
		case "10000006":
			a = new StringBuffer("错误的验证码");
			break;
		case "10000500":
			a = new StringBuffer("系统内部错误");
			break;
		case "10100000":
			a = new StringBuffer("新增成功");
			break;
		case "10200000":
			a = new StringBuffer("更新成功");
			break;
		case "10300000":
			a = new StringBuffer("删除成功");
			break;
		default:
			a = new StringBuffer("");
			break;
		}
		return a.toString();
	}

	public static String INSERT_SUCCESS = "10001001";
	public static String UPDATE_SUCCESS = "10001002";
	public static String DELETE_SUCCESS = "10001003";
	public static String LOGOUT_SUCCESS = "10001004";

	public static String getSuccessMsg(String errorCode) {
		StringBuffer a = new StringBuffer("");
		switch (errorCode) {
		case "10001001":
			a = new StringBuffer("新增成功");
			break;
		case "10001002":
			a = new StringBuffer("更新成功");
			break;
		case "10001003":
			a = new StringBuffer("删除成功");
			break;
		case "10001004":
			a = new StringBuffer("注销成功");
			break;
		default:
			a = new StringBuffer("");
			break;
		}
		return a.toString();
	}
}
