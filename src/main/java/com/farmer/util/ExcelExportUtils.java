package com.farmer.util;

import com.farmer.entity.OrderInfo;
import com.farmer.entity.OrderItem;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ExcelExportUtils {

    private static final SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    private ExcelExportUtils() {
    }

    public static void exportOrders(String fileName,
                                    List<OrderInfo> orderList,
                                    boolean includeSeller,
                                    HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodeFileName(fileName) + ".xls");

        PrintWriter writer = response.getWriter();
        writer.println("<html>");
        writer.println("<head>");
        writer.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />");
        writer.println("</head>");
        writer.println("<body>");
        writer.println("<table border='1' cellspacing='0' cellpadding='6'>");
        writer.println("<tr>");
        writer.println("<th>编号</th>");
        writer.println("<th>订单号</th>");
        writer.println("<th>买家</th>");
        if (includeSeller) {
            writer.println("<th>卖家</th>");
        }
        writer.println("<th>订单状态</th>");
        writer.println("<th>收货人</th>");
        writer.println("<th>联系电话</th>");
        writer.println("<th>收货地址</th>");
        writer.println("<th>商品明细</th>");
        writer.println("<th>订单金额</th>");
        writer.println("<th>下单时间</th>");
        writer.println("<th>支付时间</th>");
        writer.println("</tr>");

        for (int i = 0; i < orderList.size(); i++) {
            OrderInfo order = orderList.get(i);
            writer.println("<tr>");
            writer.println("<td>" + (i + 1) + "</td>");
            writer.println("<td>" + safe(order.getOrderNo()) + "</td>");
            writer.println("<td>" + safe(order.getUserName()) + "</td>");
            if (includeSeller) {
                writer.println("<td>" + safe(order.getSellerName()) + "</td>");
            }
            writer.println("<td>" + safe(formatOrderStatus(order.getOrderStatus())) + "</td>");
            writer.println("<td>" + safe(order.getReceiverName()) + "</td>");
            writer.println("<td>" + safe(order.getReceiverPhone()) + "</td>");
            writer.println("<td>" + safe(order.getReceiverAddress()) + "</td>");
            writer.println("<td>" + formatOrderItems(order.getItemList()) + "</td>");
            writer.println("<td>" + safe(formatAmount(order.getTotalAmount())) + "</td>");
            writer.println("<td>" + safe(formatDate(order.getCreateTime())) + "</td>");
            writer.println("<td>" + safe(formatDate(order.getPayTime())) + "</td>");
            writer.println("</tr>");
        }

        writer.println("</table>");
        writer.println("</body>");
        writer.println("</html>");
        writer.flush();
    }

    private static String encodeFileName(String fileName) throws IOException {
        return URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");
    }

    private static String formatOrderItems(List<OrderItem> itemList) {
        if (itemList == null || itemList.isEmpty()) {
            return "";
        }
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < itemList.size(); i++) {
            OrderItem item = itemList.get(i);
            if (i > 0) {
                builder.append("<br/>");
            }
            builder.append(safe(item.getProductName()))
                    .append(" × ")
                    .append(item.getQuantity() == null ? 0 : item.getQuantity())
                    .append(" / 小计：")
                    .append(safe(formatAmount(item.getAmount())));
        }
        return builder.toString();
    }

    private static String formatOrderStatus(String status) {
        if ("PENDING_SHIP".equals(status)) {
            return "待发货";
        }
        if ("PENDING_RECEIVE".equals(status)) {
            return "待收货";
        }
        if ("FINISHED".equals(status)) {
            return "已完成";
        }
        if ("CANCELLED".equals(status)) {
            return "已取消";
        }
        return status == null ? "" : status;
    }

    private static String formatAmount(BigDecimal amount) {
        return amount == null ? "0.00" : amount.stripTrailingZeros().toPlainString();
    }

    private static String formatDate(Date date) {
        return date == null ? "" : DATE_TIME_FORMAT.format(date);
    }

    private static String safe(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
