package com.lte.activiti;

import com.lte.entity.SysRole;
import com.lte.service.SysUserService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.impl.GroupQueryImpl;
import org.activiti.engine.impl.Page;
import org.activiti.engine.impl.persistence.entity.GroupEntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/12/16.
 */
@Component
public class CustomGroupEntityManager extends GroupEntityManager {
    @Autowired
    private SysUserService sysUserService;

    @Override
    public List<Group> findGroupsByUser(String userId) {
        List<Group> groups = new ArrayList<Group>();
        List<SysRole> roles = sysUserService.findRoleByUser(Integer.valueOf(userId));
        for (SysRole role:roles) {
            CustomGroup customGroup = new CustomGroup(role);
            groups.add(customGroup);
        }
        return groups;
    }

}
