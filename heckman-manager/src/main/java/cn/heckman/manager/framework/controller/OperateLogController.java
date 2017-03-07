package cn.heckman.manager.framework.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.heckman.manager.framework.common.Constants;
import cn.heckman.manager.framework.common.ResponseData;
import cn.heckman.module.framework.pojo.TOperateLog;
import cn.heckman.module.framework.service.TOperateLogService;

@Controller
@RequestMapping("/api/operateLog")
public class OperateLogController {

	@Autowired
	private TOperateLogService service;

	private Logger logger = Logger.getLogger(OperateLogController.class);

	@RequestMapping(value = "/query", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData queryPermissionMenu(@RequestBody TOperateLog operateLog) {
		ResponseData responseData = new ResponseData();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("oBusCode", operateLog.getoBusCode());
		map.put("oUserName", operateLog.getoUserName());
		try {
			List<TOperateLog> list = service.query(map);
			responseData.setData(list);
			responseData.setCode(Constants.SUCCESS);
		} catch (Exception ex) {
			// ex.printStackTrace();
			logger.error(ex);
			responseData.setCode(Constants.INNER_ERROR);
			responseData.setMsg(Constants.getErrMsg(Constants.INNER_ERROR));
		}
		return responseData;
	}
}
