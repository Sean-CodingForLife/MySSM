package com.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class StartupBannerListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext context = event.getServletContext();
        String contextPath = context.getContextPath();
        String displayName = context.getServletContextName();

        if (displayName == null || displayName.trim().isEmpty()) {
            displayName = "MySSM";
        }

        System.out.println();
        System.out.println("============================================================");
        System.out.println("   __  __       ____ ____  __  __");
        System.out.println("  |  \\/  |_   _/ ___/ ___||  \\/  |");
        System.out.println("  | |\\/| | | | \\___ \\___ \\| |\\/| |");
        System.out.println("  | |  | | |_| |___) |__) | |  | |");
        System.out.println("  |_|  |_|\\__, |____/____/|_|  |_|");
        System.out.println("          |___/");
        System.out.println();
        System.out.println("  " + displayName + " started successfully");
        System.out.println("  Context Path : " + contextPath);
        System.out.println("  Stack        : Spring MVC + Spring + MyBatis + JSP");
        System.out.println("============================================================");
        System.out.println();
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        System.out.println();
        System.out.println("============================================================");
        System.out.println("  MySSM stopped");
        System.out.println("============================================================");
        System.out.println();
    }
}
