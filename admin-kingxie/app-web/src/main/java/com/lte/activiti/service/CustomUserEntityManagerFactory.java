package com.lte.activiti.service;

import com.lte.activiti.CustomUserEntityManager;
import org.activiti.engine.impl.interceptor.Session;
import org.activiti.engine.impl.interceptor.SessionFactory;
import org.activiti.engine.impl.persistence.entity.UserIdentityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 * Created by think on 2016/12/16.
 */
@Service
public class CustomUserEntityManagerFactory implements SessionFactory {

    private CustomUserEntityManager customUserEntityManager;
    @Override
    public Class<?> getSessionType() {
        //注意此处也必须为Activiti原生类
        return UserIdentityManager.class;
    }

    @Override
    public Session openSession() {
        return customUserEntityManager;
    }
    @Autowired
    public void setCustomUserEntityManager(CustomUserEntityManager customUserEntityManager) {
        this.customUserEntityManager = customUserEntityManager;
    }
}
