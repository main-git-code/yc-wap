package com.yc.wap.pay;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.slp.balance.api.deduct.interfaces.IDeductSV;
import com.ai.slp.balance.api.deduct.param.DeductParam;
import com.ai.slp.balance.api.deduct.param.DeductResponse;
import com.ai.slp.balance.api.deposit.interfaces.IDepositSV;
import com.ai.slp.balance.api.deposit.param.DepositParam;
import com.ai.slp.balance.api.deposit.param.TransSummary;
import com.ai.yc.order.api.orderpay.interfaces.IOrderPayProcessedResultSV;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultBaseInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultFeeInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultProdInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultRequest;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.PaymentUtil;
import com.yc.wap.system.utils.VerifyUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Nozomi on 11/14/2016.
 */
@Controller
@RequestMapping(value = "pay")
public class PayController extends BaseController {
    private Log log = LogFactory.getLog(PayController.class);
    private IDepositSV iDepositSV = DubboConsumerFactory.getService(IDepositSV.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
    private IDeductSV iDeductSV = DubboConsumerFactory.getService(IDeductSV.class);
    private IOrderPayProcessedResultSV iOrderPayProcessedResultSV = DubboConsumerFactory.getService(IOrderPayProcessedResultSV.class);

    private String TENANTID = ConfigUtil.getProperty("TENANT_ID");

    //买家账号
    //hhmxwt9319@sandbox.com
    //登录密码
    //111111
    //支付密码
    //111111

    @RequestMapping(value = "/gotoPay")
    public void gotoPayByOrg(String orderId, String orderAmount, String currencyUnit, String merchantUrl, String payOrgCode,
                             HttpServletRequest request, HttpServletResponse response) throws Exception {

        String notifyUrl = ConfigUtil.getProperty("NOTIFY_URL");//+"/"+orderType+"/"+ UserUtil.getUserId();
        String returnUrl = ConfigUtil.getProperty("RETURN_URL");

        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", TENANTID);
        map.put("orderId", orderId);
        map.put("returnUrl", returnUrl);
        map.put("notifyUrl", notifyUrl);
        map.put("merchantUrl", merchantUrl);
        map.put("requestSource", "2");
        map.put("orderAmount", orderAmount);
        map.put("currencyUnit", currencyUnit);
        map.put("subject", "orderPay");
        map.put("payOrgCode", payOrgCode);
        // 加密
        String infoStr = orderId + VerifyUtil.SEPARATOR + orderAmount + VerifyUtil.SEPARATOR + notifyUrl + VerifyUtil.SEPARATOR + TENANTID;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        map.put("infoMd5", infoMd5);
        log.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        log.info("发起支付申请:" + htmlStr);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    @RequestMapping(value = "payResult")
    public void payResult() {
        log.info("PayResult-NOTIFY_URL-Callback");
        String orderId = request.getParameter("orderId");
        String payStates = request.getParameter("payStates");
        String orderAmount = request.getParameter("orderAmount");
        String payOrgCode = request.getParameter("payOrgCode");
        log.info("orderId" + orderId + ",payStates" + payStates + ",orderAmount: " + orderAmount);
        if (payStates.equals("00")) {
            String orderIndex = orderId.substring(0, 3);
            if (orderIndex.equals("901")) {
                BalanceRecharge(orderId, orderAmount, payOrgCode);
            } else {
                OrderPayFinished(orderId);
            }
        }
    }

    @RequestMapping(value = "payResultView")
    public String payResultView() {
        log.info("PayResult-RETURN_URL-Callback");
        String orderId = request.getParameter("orderId");
        String payStates = request.getParameter("payStates");
        log.info("orderId" + orderId + ",payStates" + payStates);
        if (payStates.equals("00")) {
            request.setAttribute("result", "success");
        } else if (payStates.equals("01")) {
            request.setAttribute("result", "fail");
        }
        request.setAttribute("OrderId", orderId);
        return "written/payresult";
    }

    private boolean BalanceRecharge(String orderId, String Amount, String payOrgCode) {
        char[] Order = orderId.toCharArray();
        String UID = "";
        for (int i = 3; i < orderId.length() - 13; i++) {
            UID += Order[i];
        }

        Double _Amount = Double.valueOf(Amount) * 1000;

        SearchYCUserRequest req = new SearchYCUserRequest();
        req.setUserId(UID);
        YCUserInfoResponse resp = iycUserServiceSV.searchYCUserInfo(req);
        Long AccountId = resp.getAccountId();

        log.info("----------BalanceRecharge----------");
        log.info("UID: " + UID);
        log.info("AccountId: " + AccountId);
        log.info("OrderId: " + orderId);
        log.info("Amount: " + _Amount.longValue());
        log.info("PayOrgCode: " + payOrgCode);
        log.info("----------BalanceRecharge----------");

        DepositParam param = new DepositParam();
        param.setAccountId(AccountId);  //	账户ID
        param.setBusiDesc("余额");    //业务描述
        param.setBusiSerialNo(orderId);

        TransSummary summary = new TransSummary();  //交易摘要
        summary.setAmount(_Amount.longValue());
//        summary.setAmount(test);
        summary.setSubjectId(100000);

        List<TransSummary> transSummaryList = new ArrayList<TransSummary>();
        transSummaryList.add(summary);
        param.setTransSummary(transSummaryList);

        param.setCurrencyUnit("RMB");   //币种,RMB:人民币  USD：美元
        param.setBusiOperCode("300000");    //固定值
        if (payOrgCode.equals("ZFB")) {
            param.setPayStyle(Constants.PayType.ZFB);
        } else if (payOrgCode.equals("YL")) {
            param.setPayStyle(Constants.PayType.YL);
        }
        param.setTenantId(Constants.TENANTID);
        param.setSystemId("Cloud-UAC_WEB"); //固定值

        log.info("BalanceRechargeParam: " + com.alibaba.fastjson.JSONArray.toJSONString(param));

        try {
            String serialCode = iDepositSV.depositFund(param);
            log.info("BalanceRecharge SerialCode: " + serialCode);
            return true;
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("BalanceRechargeFail");
        }
    }

    @RequestMapping(value = "BalancePayment")
    public void BalancePayment() {
        String OrderId = request.getParameter("orderId");
        String Amount = request.getParameter("orderAmount");
        log.info("-----BalancePayment-----");
        log.info("OrderId: " + OrderId + ", Amount: " + Amount);

        String UID = (String) session.getAttribute("UID");

        SearchYCUserRequest req = new SearchYCUserRequest();
        req.setUserId(UID);
        YCUserInfoResponse resp = iycUserServiceSV.searchYCUserInfo(req);
        Long AccountId = resp.getAccountId();

        com.ai.slp.balance.api.deduct.param.TransSummary Summary = new com.ai.slp.balance.api.deduct.param.TransSummary();
        Summary.setSubjectId(Constants.SubjectID);
        List<com.ai.slp.balance.api.deduct.param.TransSummary> TransSummary = new ArrayList<com.ai.slp.balance.api.deduct.param.TransSummary>();
        TransSummary.add(Summary);

        DeductParam Param = new DeductParam();
        Param.setTenantId(TENANTID);
        Param.setSystemId("Cloud-UAC_WEB");
        Param.setExternalId(OrderId);
        Param.setBusinessCode(Constants.BusinessCode);
        Param.setAccountId(AccountId);
        Param.setCheckPwd(0);
        Param.setTotalAmount(Long.parseLong(Amount) * 1000);
        Param.setCurrencyUnit("1"); //1-RMB 2-USD
        Param.setChannel(Constants.COMPANY);
        Param.setTransSummary(TransSummary);

        log.info("BalancePaymentParam: " + com.alibaba.fastjson.JSONArray.toJSONString(Param));
        try {
            DeductResponse response = iDeductSV.deductFund(Param);
            if (response.getResponseHeader().getResultCode().equals(ConstantsResultCode.FUNDSUCCESS1)) {
                String serialNo = response.getSerialNo();
                log.info("BalancePaySuccess: " + serialNo);
                OrderPayFinished(OrderId);
            } else {
                log.info("BalancePayFail: " + response.getResponseHeader().getResultCode() + response.getResponseHeader().getResultMessage());
                throw new RuntimeException("BalancePaymentFail");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("BalancePaymentFail");
        }
    }

    @RequestMapping(value = "OrderPay")
    public String OrderPay() {
        log.info("-----pay-OrderPay-----");
        String OrderId = request.getParameter("OrderId");
        String Amount = request.getParameter("OrderAmount");
        log.info("OrderId: " + OrderId + ", Amount: " + Amount);

        request.setAttribute("OrderId", OrderId);
        request.setAttribute("PriceDisplay", Amount);

        return "written/payment";
    }


    private void OrderPayFinished(String OrderId) {
        //支付成功以后 订单状态20 显示状态23
        //开始时间 支付时间取支付宝回调

        OrderPayProcessedResultRequest req = new OrderPayProcessedResultRequest();
        OrderPayProcessedResultBaseInfo BaseInfo = new OrderPayProcessedResultBaseInfo();
        OrderPayProcessedResultFeeInfo FeeInfo = new OrderPayProcessedResultFeeInfo();
        OrderPayProcessedResultProdInfo ProdInfo = new OrderPayProcessedResultProdInfo();


    }
}
