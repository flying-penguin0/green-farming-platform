package com.farmer.config;

import com.farmer.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());

        if (isPublicPath(path)) {
            return true;
        }

        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect(contextPath + "/auth/login");
            return false;
        }

        String roleType = user.getRoleType();
        if (path.startsWith("/admin") && !"ADMIN".equals(roleType)) {
            response.sendRedirect(contextPath + "/common/forbidden");
            return false;
        }
        if (path.startsWith("/farmer") && !("PLANTER".equals(roleType) || "BREEDER".equals(roleType))) {
            response.sendRedirect(contextPath + "/common/forbidden");
            return false;
        }
        if (path.startsWith("/user") && !"USER".equals(roleType)) {
            response.sendRedirect(contextPath + "/common/forbidden");
            return false;
        }
        return true;
    }

    private boolean isPublicPath(String path) {
        return path.equals("/")
                || path.startsWith("/portal")
                || path.startsWith("/auth")
                || path.startsWith("/static")
                || path.startsWith("/common/forbidden");
    }
}
