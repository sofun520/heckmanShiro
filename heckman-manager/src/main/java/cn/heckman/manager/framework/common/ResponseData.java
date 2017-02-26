package cn.heckman.manager.framework.common;

public class ResponseData {

	/* 返回代码 */
	private String code;
	/* 返回信息 */
	private String msg;
	/* 返回数据 */
	private Object data;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
