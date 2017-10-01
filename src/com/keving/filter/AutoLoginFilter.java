package com.keving.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keving.model.vo.ResultInfo;
import com.keving.util.StringUtil;

@WebFilter("/*")
public class AutoLoginFilter implements Filter {

    public AutoLoginFilter() {
    }
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
	/*	1.静态资源放行
		action login 放
		2.login.jsp
		3.登录成功的放*/
		
		//静态资源
		String url = req.getRequestURI();
		if(url.contains("/statics")){
			chain.doFilter(req, resp);
			return;
		}
		
		//请求 login
		String action = req.getParameter("action");
			if(!StringUtil.isEmpty(action)){
				
				if(action.equals("login")){
					chain.doFilter(req, resp);
					return;
				}
			}
		
			//判断session  userInfo  空不空 code是否1
			ResultInfo resultInfo  = (ResultInfo) req.getSession().getAttribute("userInfo");
			if(null!=resultInfo && resultInfo.getResultCode()==1){
				chain.doFilter(req, resp);
				return;
			}
			
			
			//cookie judge
			Cookie[] cookies = req.getCookies();
			if(null!=cookies&&cookies.length>0){
				for (Cookie cookie : cookies) {
					String name = cookie.getName();
					if(name.equals("userInfo")){
						
						String value = cookie.getValue();   //    email + "-" + password;
						
						if(StringUtil.isEmpty(value)){
							resp.sendRedirect("login.jsp");
							return;
						}
						
						//自动登陆后停留在当期那页面
						String currentUrl = req.getRequestURL()+"";
						String currentParams =  req.getQueryString();
						if(!StringUtil.isEmpty(currentParams)){
							currentParams = currentParams.replaceAll("&", "-");
						}
						
						String email = value.split("-")[0];
						String password = value.split("-")[1];
						
						//将当前的url和参数作为两个值转发给自动登录
						String dispathUrl = "userServlet?action=autoLogin&email="+email+"&password="+
								password+"&currentUrl="+currentUrl+"&currentParams="+currentParams; 
						req.getRequestDispatcher(dispathUrl).forward(req, resp);
						return;
					}
					
					
				}
			}
			
		
		
		chain.doFilter(request, response);
	}
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
